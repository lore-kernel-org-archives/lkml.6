Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934772AbeEILp7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:45:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:26332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934376AbeEILpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:45:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54445980"
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
Subject: [PATCH RFC 13/19] perf buildid-cache: kcore_copy: Keep a count of phdrs
Date: Wed,  9 May 2018 14:43:42 +0300
Message-Id: <1525866228-30321-14-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to add more program headers, keep a count of phdrs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 7faca21141a2..3a177c245683 100644
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
 		list_add_tail(&kci->modules_map.list, &kci->phdrs);
 
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
1.9.1
