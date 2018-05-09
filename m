Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934786AbeEILqF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:46:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:26332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934376AbeEILqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:46:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54446033"
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
Subject: [PATCH RFC 15/19] perf buildid-cache: kcore_copy: Layout sections
Date: Wed,  9 May 2018 14:43:44 +0300
Message-Id: <1525866228-30321-16-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to add more program headers, layout the relative offset of
each section.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 2e8d89d64166..9ecd83418bb5 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1386,6 +1386,7 @@ static off_t kcore__write(struct kcore *kcore)
 
 struct phdr_data {
 	off_t offset;
+	off_t rel;
 	u64 addr;
 	u64 len;
 	struct list_head list;
@@ -1404,6 +1405,9 @@ struct kcore_copy_info {
 	struct list_head phdrs;
 };
 
+#define kcore_copy__for_each_phdr(k, p) \
+	list_for_each_entry((p), &(k)->phdrs, list)
+
 static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 					u64 start)
 {
@@ -1518,11 +1522,21 @@ static int kcore_copy__read_maps(struct kcore_copy_info *kci, Elf *elf)
 	if (kci->modules_map.len)
 		list_add_tail(&kci->modules_map.list, &kci->phdrs);
 
-	kci->phnum = !!kci->kernel_map.len + !!kci->modules_map.len;
-
 	return 0;
 }
 
+static void kcore_copy__layout(struct kcore_copy_info *kci)
+{
+	struct phdr_data *p;
+	off_t rel = 0;
+
+	kcore_copy__for_each_phdr(kci, p) {
+		p->rel = rel;
+		rel += p->len;
+		kci->phnum += 1;
+	}
+}
+
 static int kcore_copy__calc_maps(struct kcore_copy_info *kci, const char *dir,
 				 Elf *elf)
 {
@@ -1558,7 +1572,12 @@ static int kcore_copy__calc_maps(struct kcore_copy_info *kci, const char *dir,
 	if (kci->first_module && !kci->last_module_symbol)
 		return -1;
 
-	return kcore_copy__read_maps(kci, elf);
+	if (kcore_copy__read_maps(kci, elf))
+		return -1;
+
+	kcore_copy__layout(kci);
+
+	return 0;
 }
 
 static int kcore_copy__copy_file(const char *from_dir, const char *to_dir,
-- 
1.9.1
