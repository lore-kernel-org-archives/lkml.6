Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934828AbeEILqR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:46:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:26332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934376AbeEILqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:46:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54446087"
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
Subject: [PATCH RFC 18/19] perf buildid-cache: kcore_copy: Copy x86_64 entry trampoline sections
Date: Wed,  9 May 2018 14:43:47 +0300
Message-Id: <1525866228-30321-19-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Identify and copy any sections for x86_64 KPTI entry trampolines.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6c6c3481477e..152e56ae9cba 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1392,6 +1392,11 @@ struct phdr_data {
 	struct list_head list;
 };
 
+struct sym_data {
+	u64 addr;
+	struct list_head list;
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
@@ -1431,6 +1437,29 @@ static void kcore_copy__free_phdrs(struct kcore_copy_info *kci)
 	}
 }
 
+static struct sym_data *kcore_copy__new_sym(struct kcore_copy_info *kci,
+					    u64 addr)
+{
+	struct sym_data *s = zalloc(sizeof(*s));
+
+	if (s) {
+		s->addr = addr;
+		list_add_tail(&s->list, &kci->syms);
+	}
+
+	return s;
+}
+
+static void kcore_copy__free_syms(struct kcore_copy_info *kci)
+{
+	struct sym_data *s, *tmp;
+
+	list_for_each_entry_safe(s, tmp, &kci->syms, list) {
+		list_del(&s->list);
+		free(s);
+	}
+}
+
 static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 					u64 start)
 {
@@ -1461,6 +1490,9 @@ static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 		return 0;
 	}
 
+	if (is_entry_trampoline(name) && !kcore_copy__new_sym(kci, start))
+		return -1;
+
 	return 0;
 }
 
@@ -1528,6 +1560,7 @@ static int kcore_copy__read_map(u64 start, u64 len, u64 pgoff, void *data)
 {
 	struct kcore_copy_info *kci = data;
 	u64 end = start + len;
+	struct sym_data *sdat;
 
 	if (kcore_copy__map(kci, start, end, pgoff, kci->stext, kci->etext))
 		return -1;
@@ -1536,6 +1569,13 @@ static int kcore_copy__read_map(u64 start, u64 len, u64 pgoff, void *data)
 			    kci->last_module_symbol))
 		return -1;
 
+	list_for_each_entry(sdat, &kci->syms, list) {
+		u64 s = round_down(sdat->addr, page_size);
+
+		if (kcore_copy__map(kci, start, end, pgoff, s, s + len))
+			return -1;
+	}
+
 	return 0;
 }
 
@@ -1730,6 +1770,7 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	struct phdr_data *p;
 
 	INIT_LIST_HEAD(&kci.phdrs);
+	INIT_LIST_HEAD(&kci.syms);
 
 	if (kcore_copy__copy_file(from_dir, to_dir, "kallsyms"))
 		return -1;
@@ -1796,6 +1837,7 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 		kcore_copy__unlink(to_dir, "kallsyms");
 
 	kcore_copy__free_phdrs(&kci);
+	kcore_copy__free_syms(&kci);
 
 	return err;
 }
-- 
1.9.1
