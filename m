Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935062AbeEWUXo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934971AbeEWUWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:22:13 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/18] perf kcore_copy: Layout sections
Date: Wed, 23 May 2018 17:21:02 -0300
Message-Id: <20180523202106.17286-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation to add more program headers, layout the relative offset
of each section.

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
Link: http://lkml.kernel.org/r/1526986485-6562-14-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4aec12102e19..3e76a0efd15c 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1386,6 +1386,7 @@ static off_t kcore__write(struct kcore *kcore)
 
 struct phdr_data {
 	off_t offset;
+	off_t rel;
 	u64 addr;
 	u64 len;
 	struct list_head node;
@@ -1404,6 +1405,9 @@ struct kcore_copy_info {
 	struct list_head phdrs;
 };
 
+#define kcore_copy__for_each_phdr(k, p) \
+	list_for_each_entry((p), &(k)->phdrs, node)
+
 static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
 					u64 start)
 {
@@ -1518,11 +1522,21 @@ static int kcore_copy__read_maps(struct kcore_copy_info *kci, Elf *elf)
 	if (kci->modules_map.len)
 		list_add_tail(&kci->modules_map.node, &kci->phdrs);
 
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
2.14.3
