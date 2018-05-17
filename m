Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeEQJZ2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:25:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:6649 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752451AbeEQJYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:24:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,409,1520924400";
   d="scan'208";a="41683716"
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
Subject: [PATCH V2 18/20] perf buildid-cache: kcore_copy: Get rid of kernel_map
Date: Thu, 17 May 2018 12:22:06 +0300
Message-Id: <1526548928-20790-19-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
References: <1526548928-20790-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to add more program headers, get rid of kernel_map and
modules_map by moving ->kernel_map and ->modules_map to newly allocated
entries in the ->phdrs list.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
 
@@ -1773,6 +1805,8 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	if (err)
 		kcore_copy__unlink(to_dir, "kallsyms");
 
+	kcore_copy__free_phdrs(&kci);
+
 	return err;
 }
 
-- 
1.9.1
