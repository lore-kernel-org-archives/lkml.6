Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A81C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5C021B18
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfBLCNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:13:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:26869 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfBLCM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:12:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 18:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="146057856"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2019 18:12:54 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.or,
        tglx@linutronix.de, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 3/6] x86, mm: add comment for split_mem_range to help understanding
Date:   Tue, 12 Feb 2019 10:12:12 +0800
Message-Id: <20190212021215.13247-4-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190212021215.13247-1-richardw.yang@linux.intel.com>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describing the possible ranges in split and marking ranges with name to
help audience understand the logic.

Also this prepares to illustrate a code refine next.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/init.c | 51 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 6fb84be79c7c..2b782dcd6d71 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -328,6 +328,31 @@ static const char *page_size_string(struct map_range *mr)
 	return str_4k;
 }
 
+/*
+ * There are 3 types of ranges:
+ *
+ *    k : 4K size
+ *    m : 2M size
+ *    G : 1G size
+ *
+ * 1G size is only valid when CONFIG_X86_64 is set.
+ *
+ * So we can describe the possible ranges like below:
+ *
+ *               kkkmmmGGGmmmkkk
+ *               (A)(B)(C)(D)(E)
+ *
+ * This means there are at most:
+ *
+ *    3 ranges when CONFIG_X86_32 is set
+ *    5 ranges when CONFIG_X86_64 is set
+ *
+ * which corresponds to the definition of NR_RANGE_MR.
+ *
+ * split_mem_range() does the split from low to high. By naming these ranges
+ * to A, B, C, D, E respectively and marking the name in following comment, it
+ * may help you to understand how ranges are split.
+ */
 static int __meminit split_mem_range(struct map_range *mr,
 				     unsigned long start,
 				     unsigned long end)
@@ -338,7 +363,10 @@ static int __meminit split_mem_range(struct map_range *mr,
 
 	limit_pfn = PFN_DOWN(end);
 
-	/* head if not big page alignment ? */
+	/*
+	 * Range (A):
+	 * head if not big page alignment ?
+	 */
 	pfn = start_pfn = PFN_DOWN(start);
 #ifdef CONFIG_X86_32
 	/*
@@ -361,7 +389,10 @@ static int __meminit split_mem_range(struct map_range *mr,
 		pfn = end_pfn;
 	}
 
-	/* big page (2M) range */
+	/*
+	 * Range (B):
+	 * big page (2M) range
+	 */
 	start_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
 #ifdef CONFIG_X86_32
 	end_pfn = round_down(limit_pfn, PFN_DOWN(PMD_SIZE));
@@ -370,7 +401,6 @@ static int __meminit split_mem_range(struct map_range *mr,
 	if (end_pfn > round_down(limit_pfn, PFN_DOWN(PMD_SIZE)))
 		end_pfn = round_down(limit_pfn, PFN_DOWN(PMD_SIZE));
 #endif
-
 	if (start_pfn < end_pfn) {
 		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn,
 				page_size_mask & (1<<PG_LEVEL_2M));
@@ -378,7 +408,10 @@ static int __meminit split_mem_range(struct map_range *mr,
 	}
 
 #ifdef CONFIG_X86_64
-	/* big page (1G) range */
+	/*
+	 * Range (C):
+	 * big page (1G) range
+	 */
 	start_pfn = round_up(pfn, PFN_DOWN(PUD_SIZE));
 	end_pfn = round_down(limit_pfn, PFN_DOWN(PUD_SIZE));
 	if (start_pfn < end_pfn) {
@@ -388,7 +421,10 @@ static int __meminit split_mem_range(struct map_range *mr,
 		pfn = end_pfn;
 	}
 
-	/* tail is not big page (1G) alignment */
+	/*
+	 * Range (D):
+	 * big page (2M) range
+	 */
 	start_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
 	end_pfn = round_down(limit_pfn, PFN_DOWN(PMD_SIZE));
 	if (start_pfn < end_pfn) {
@@ -398,7 +434,10 @@ static int __meminit split_mem_range(struct map_range *mr,
 	}
 #endif
 
-	/* tail is not big page (2M) alignment */
+	/*
+	 * Range (E):
+	 * tail is not big page (2M) alignment
+	 */
 	start_pfn = pfn;
 	end_pfn = limit_pfn;
 	nr_range = save_mr(mr, nr_range, start_pfn, end_pfn, 0);
-- 
2.19.1

