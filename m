Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeEOMqE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:46:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:35426 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753439AbeEOMqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:46:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="41391320"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH V1 18/19] perf buildid-cache: kcore_copy: Copy x86 PTI entry trampoline sections
Date: Tue, 15 May 2018 15:43:32 +0300
Message-Id: <1526388213-30696-19-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
References: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Identify and copy any sections for x86 PTI entry trampolines.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 37d9324c277c..584966913aeb 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1392,6 +1392,11 @@ struct phdr_data {
 	struct list_head node;
 };
 
+struct sym_data {
+	u64 addr;
+	struct list_head node;
+};
+
 struct kcore_copy_info {
 	u64 stext;
 	u64 etext;
@@ -1401,6 +1406,7 @@ struct kcore_copy_info {
 	u64 last_module_symbol;
 	size_t phnum;
 	struct list_head phdrs;
+	struct list_head syms;
 };
 
 #define kcore_copy__for_each_phdr(k, p) \
@@ -1441,6 +1447,29 @@ static void kcore_copy__free_phdrs(struct kcore_copy_info *kci)
 	}
 }
 
+static struct sym_data *kcore_copy__new_sym(struct kcore_copy_info *kci,
+					    u64 addr)
+{
+	struct sym_data *s = zalloc(sizeof(*s));
+
+	if (s) {
+		s->addr = addr;
+		list_add_tail(&s->node, &kci->syms);
+	}
+
+	return s;
+}
+
+static void kcore_copy__free_syms(struct kcore_copy_info *kci)
+{
+	struct sym_data *s, *tmp;
+
+	list_for_each_entry_safe(s, tmp, &kci->syms, node) {
+		list_del(&s->node);
+		free(s);
+	}
+}
+
 static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 					u64 start)
 {
@@ -1471,6 +1500,9 @@ static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 		return 0;
 	}
 
+	if (is_entry_trampoline(name) && !kcore_copy__new_sym(kci, start))
+		return -1;
+
 	return 0;
 }
 
@@ -1538,6 +1570,7 @@ static int kcore_copy__read_map(u64 start, u64 len, u64 pgoff, void *data)
 {
 	struct kcore_copy_info *kci = data;
 	u64 end = start + len;
+	struct sym_data *sdat;
 
 	if (kcore_copy__map(kci, start, end, pgoff, kci->stext, kci->etext))
 		return -1;
@@ -1546,6 +1579,13 @@ static int kcore_copy__read_map(u64 start, u64 len, u64 pgoff, void *data)
 			    kci->last_module_symbol))
 		return -1;
 
+	list_for_each_entry(sdat, &kci->syms, node) {
+		u64 s = round_down(sdat->addr, page_size);
+
+		if (kcore_copy__map(kci, start, end, pgoff, s, s + len))
+			return -1;
+	}
+
 	return 0;
 }
 
@@ -1740,6 +1780,7 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	struct phdr_data *p;
 
 	INIT_LIST_HEAD(&kci.phdrs);
+	INIT_LIST_HEAD(&kci.syms);
 
 	if (kcore_copy__copy_file(from_dir, to_dir, "kallsyms"))
 		return -1;
@@ -1806,6 +1847,7 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 		kcore_copy__unlink(to_dir, "kallsyms");
 
 	kcore_copy__free_phdrs(&kci);
+	kcore_copy__free_syms(&kci);
 
 	return err;
 }
-- 
1.9.1
