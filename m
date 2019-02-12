Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D655C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5508A222A4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfBLCNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:13:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:26873 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbfBLCM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:12:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 18:12:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="146057859"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2019 18:12:57 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.or,
        tglx@linutronix.de, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 5/6] x86, mm: skip 1G range if the range doesn't span PUD
Date:   Tue, 12 Feb 2019 10:12:14 +0800
Message-Id: <20190212021215.13247-6-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190212021215.13247-1-richardw.yang@linux.intel.com>
References: <20190212021215.13247-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the 1G aligned pfn exceed the range, we are sure there won't be
possible 1G range. so we can just jump to split 2M range directly.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 87275238dbb0..cbb105388f24 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -394,10 +394,10 @@ static int __meminit split_mem_range(struct map_range *mr,
 	 * Range (B):
 	 * big page (2M) range
 	 */
-	start_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
 	end_pfn = round_up(pfn, PFN_DOWN(PUD_SIZE));
 	if (end_pfn > round_down(limit_pfn, PFN_DOWN(PMD_SIZE)))
-		end_pfn = round_down(limit_pfn, PFN_DOWN(PMD_SIZE));
+		goto no_1G_range;
+	start_pfn = round_up(pfn, PFN_DOWN(PMD_SIZE));
 	if (start_pfn < end_pfn) {
 		nr_range = save_mr(mr, nr_range, start_pfn, end_pfn,
 				page_size_mask & (1<<PG_LEVEL_2M));
@@ -416,6 +416,7 @@ static int __meminit split_mem_range(struct map_range *mr,
 				 ((1<<PG_LEVEL_2M)|(1<<PG_LEVEL_1G)));
 		pfn = end_pfn;
 	}
+no_1G_range:
 #endif
 
 	/*
-- 
2.19.1

