Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755203AbeEXFpP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:45:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38429 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755021AbeEXFpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:45:11 -0400
Date: Wed, 23 May 2018 22:44:49 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-a1a3a0624e6cd0e2c46a7400800a5e687521a504@git.kernel.org>
Cc: jolsa@redhat.com, luto@kernel.org, mingo@kernel.org, joro@8bytes.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dave.hansen@linux.intel.com
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, mingo@kernel.org, joro@8bytes.org,
        luto@kernel.org, jolsa@redhat.com, dave.hansen@linux.intel.com,
        ak@linux.intel.com, peterz@infradead.org
In-Reply-To: <1526986485-6562-17-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-17-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kcore_copy: Copy x86 PTI entry trampoline
 sections
Git-Commit-ID: a1a3a0624e6cd0e2c46a7400800a5e687521a504
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a1a3a0624e6cd0e2c46a7400800a5e687521a504
Gitweb:     https://git.kernel.org/tip/a1a3a0624e6cd0e2c46a7400800a5e687521a504
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:44 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 23 May 2018 10:26:43 -0300

perf kcore_copy: Copy x86 PTI entry trampoline sections

Identify and copy any sections for x86 PTI entry trampolines.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1526986485-6562-17-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
@@ -1806,6 +1847,7 @@ out_unlink_kallsyms:
 		kcore_copy__unlink(to_dir, "kallsyms");
 
 	kcore_copy__free_phdrs(&kci);
+	kcore_copy__free_syms(&kci);
 
 	return err;
 }
