Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeEOMpq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:45:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:14385 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753334AbeEOMpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:45:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="41391258"
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
Subject: [PATCH V1 14/19] perf buildid-cache: kcore_copy: Calculate offset from phnum
Date: Tue, 15 May 2018 15:43:28 +0300
Message-Id: <1526388213-30696-15-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
References: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to add more program headers, calculate offset from the
number of phdrs.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol-elf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4e7b71e8ac0e..4aec12102e19 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1682,7 +1682,7 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	struct kcore kcore;
 	struct kcore extract;
 	int idx = 0, err = -1;
-	off_t offset = page_size, sz, modules_offset = 0;
+	off_t offset, sz, modules_offset = 0;
 	struct kcore_copy_info kci = { .stext = 0, };
 	char kcore_filename[PATH_MAX];
 	char extract_filename[PATH_MAX];
@@ -1710,6 +1710,10 @@ int kcore_copy(const char *from_dir, const char *to_dir)
 	if (kcore__copy_hdr(&kcore, &extract, kci.phnum))
 		goto out_extract_close;
 
+	offset = gelf_fsize(extract.elf, ELF_T_EHDR, 1, EV_CURRENT) +
+		 gelf_fsize(extract.elf, ELF_T_PHDR, kci.phnum, EV_CURRENT);
+	offset = round_up(offset, page_size);
+
 	if (kcore__add_phdr(&extract, idx++, offset, kci.kernel_map.addr,
 			    kci.kernel_map.len))
 		goto out_extract_close;
-- 
1.9.1
