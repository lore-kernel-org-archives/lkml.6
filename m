Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755172AbeEXFoq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:44:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755021AbeEXFoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:44:44 -0400
Date: Wed, 23 May 2018 22:44:20 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b4503cdb67098b2f08320c2c83df758ea72a4431@git.kernel.org>
Cc: jolsa@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, joro@8bytes.org, adrian.hunter@intel.com,
        acme@redhat.com, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, mingo@kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org
Reply-To: hpa@zytor.com, acme@redhat.com, peterz@infradead.org,
        mingo@kernel.org, alexander.shishkin@linux.intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org, jolsa@redhat.com,
        joro@8bytes.org, adrian.hunter@intel.com, ak@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <1526986485-6562-16-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-16-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf kcore_copy: Get rid of kernel_map
Git-Commit-ID: b4503cdb67098b2f08320c2c83df758ea72a4431
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

Commit-ID:  b4503cdb67098b2f08320c2c83df758ea72a4431
Gitweb:     https://git.kernel.org/tip/b4503cdb67098b2f08320c2c83df758ea72a4431
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:43 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 23 May 2018 10:26:43 -0300

perf kcore_copy: Get rid of kernel_map

In preparation to add more program headers, get rid of kernel_map and
modules_map by moving ->kernel_map and ->modules_map to newly allocated
entries in the ->phdrs list.

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
Link: http://lkml.kernel.org/r/1526986485-6562-16-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 70 ++++++++++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 91b8cfb045ec..37d9324c277c 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1400,14 +1400,47 @@ struct kcore_copy_info {
 	u64 first_module;
 	u64 last_module_symbol;
 	size_t phnum;
-	struct phdr_data kernel_map;
-	struct phdr_data modules_map;
 	struct list_head phdrs;
 };
 
 #define kcore_copy__for_each_phdr(k, p) \
 	list_for_each_entry((p), &(k)->phdrs, node)
 
+static struct phdr_data *phdr_data__new(u64 addr, u64 len, off_t offset)
+{
+	struct phdr_data *p = zalloc(sizeof(*p));
+
+	if (p) {
+		p->addr   = addr;
+		p->len    = len;
+		p->offset = offset;
+	}
+
+	return p;
+}
+
+static struct phdr_data *kcore_copy_info__addnew(struct kcore_copy_info *kci,
+						 u64 addr, u64 len,
+						 off_t offset)
+{
+	struct phdr_data *p = phdr_data__new(addr, len, offset);
+
+	if (p)
+		list_add_tail(&p->node, &kci->phdrs);
+
+	return p;
+}
+
+static void kcore_copy__free_phdrs(struct kcore_copy_info *kci)
+{
+	struct phdr_data *p, *tmp;
+
+	list_for_each_entry_safe(p, tmp, &kci->phdrs, node) {
+		list_del(&p->node);
+		free(p);
+	}
+}
+
 static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 					u64 start)
 {
@@ -1487,15 +1520,18 @@ static int kcore_copy__parse_modules(struct kcore_copy_info *kci,
 	return 0;
 }
 
-static void kcore_copy__map(struct phdr_data *p, u64 start, u64 end, u64 pgoff,
-			    u64 s, u64 e)
+static int kcore_copy__map(struct kcore_copy_info *kci, u64 start, u64 end,
+			   u64 pgoff, u64 s, u64 e)
 {
-	if (p->addr || s < start || s >= end)
-		return;
+	u64 len, offset;
+
+	if (s < start || s >= end)
+		return 0;
 
-	p->addr = s;
-	p->offset = (s - start) + pgoff;
-	p->len = e < end ? e - s : end - s;
+	offset = (s - start) + pgoff;
+	len = e < end ? e - s : end - s;
+
+	return kcore_copy_info__addnew(kci, s, len, offset) ? 0 : -1;
 }
 
 static int kcore_copy__read_map(u64 start, u64 len, u64 pgoff, void *data)
@@ -1503,11 +1539,12 @@ static int kcore_copy__read_map(u64 start, u64 len, u64 pgoff, void *data)
 	struct kcore_copy_info *kci = data;
 	u64 end = start + len;
 
-	kcore_copy__map(&kci->kernel_map, start, end, pgoff, kci->stext,
-			kci->etext);
+	if (kcore_copy__map(kci, start, end, pgoff, kci->stext, kci->etext))
+		return -1;
 
-	kcore_copy__map(&kci->modules_map, start, end, pgoff, kci->first_module,
-			kci->last_module_symbol);
+	if (kcore_copy__map(kci, start, end, pgoff, kci->first_module,
+			    kci->last_module_symbol))
+		return -1;
 
 	return 0;
 }
@@ -1517,11 +1554,6 @@ static int kcore_copy__read_maps(struct kcore_copy_info *kci, Elf *elf)
 	if (elf_read_maps(elf, true, kcore_copy__read_map, kci) < 0)
 		return -1;
 
-	if (kci->kernel_map.len)
-		list_add_tail(&kci->kernel_map.node, &kci->phdrs);
-	if (kci->modules_map.len)
-		list_add_tail(&kci->modules_map.node, &kci->phdrs);
-
 	return 0;
 }
 
@@ -1773,6 +1805,8 @@ out_unlink_kallsyms:
 	if (err)
 		kcore_copy__unlink(to_dir, "kallsyms");
 
+	kcore_copy__free_phdrs(&kci);
+
 	return err;
 }
 
