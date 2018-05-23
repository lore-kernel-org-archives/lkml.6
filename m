Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934463AbeEWUYF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934907AbeEWUWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:22:04 -0400
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
Subject: [PATCH 12/18] perf kcore_copy: Keep a count of phdrs
Date: Wed, 23 May 2018 17:21:00 -0300
Message-Id: <20180523202106.17286-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation to add more program headers, keep a count of phdrs.

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
Link: http://lkml.kernel.org/r/1526986485-6562-12-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index b13873a6f368..4e7b71e8ac0e 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1398,6 +1398,7 @@ struct kcore_copy_info {
 	u64 last_symbol;
 	u64 first_module;
 	u64 last_module_symbol;
+	size_t phnum;
 	struct phdr_data kernel_map;
 	struct phdr_data modules_map;
 	struct list_head phdrs;
@@ -1517,6 +1518,8 @@ static int kcore_copy__read_maps(struct kcore_copy_info *kci, Elf *elf)
 	if (kci->modules_map.len)
 		list_add_tail(&kci->modules_map.node, &kci->phdrs);
 
+	kci->phnum = !!kci->kernel_map.len + !!kci->modules_map.len;
+
 	return 0;
 }
 
@@ -1678,7 +1681,6 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 {
 	struct kcore kcore;
 	struct kcore extract;
-	size_t count = 2;
 	int idx = 0, err = -1;
 	off_t offset = page_size, sz, modules_offset = 0;
 	struct kcore_copy_info kci = { .stext = 0, };
@@ -1705,10 +1707,7 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	if (kcore__init(&extract, extract_filename, kcore.elfclass, false))
 		goto out_kcore_close;
 
-	if (!kci.modules_map.addr)
-		count -= 1;
-
-	if (kcore__copy_hdr(&kcore, &extract, count))
+	if (kcore__copy_hdr(&kcore, &extract, kci.phnum))
 		goto out_extract_close;
 
 	if (kcore__add_phdr(&extract, idx++, offset, kci.kernel_map.addr,
-- 
2.14.3
