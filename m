Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5994DC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140C12086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140C12086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbeKGLxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:53:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:35424 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388905AbeKGLxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:53:52 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2FAC89991BF83;
        Wed,  7 Nov 2018 10:25:31 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 7 Nov 2018
 10:25:22 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linux-edac@vger.kernel.org>, <ravi@jetztechnologies.com>,
        <arvino55@gmail.com>, <bp@alien8.de>, <mchehab@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] edac: i82975x: remove set but not used variable 'dtype'
Date:   Wed, 7 Nov 2018 10:22:37 +0800
Message-ID: <20181107022237.14048-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/edac/i82975x_edac.c:378:16: warning:
 variable 'dtype' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit
084a4fccef39 ("edac: move dimm properties to struct dimm_info")

Also remove function i82975x_dram_type and move the comment and the
assignment to the single called place.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove unnecessary function i82975x_dram_type
---
 drivers/edac/i82975x_edac.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
index 892815e..7f4a14c 100644
--- a/drivers/edac/i82975x_edac.c
+++ b/drivers/edac/i82975x_edac.c
@@ -358,14 +358,6 @@ static int dual_channel_active(void __iomem *mch_window)
 	return dualch;
 }
 
-static enum dev_type i82975x_dram_type(void __iomem *mch_window, int rank)
-{
-	/*
-	 * ECC is possible on i92975x ONLY with DEV_X8
-	 */
-	return DEV_X8;
-}
-
 static void i82975x_init_csrows(struct mem_ctl_info *mci,
 		struct pci_dev *pdev, void __iomem *mch_window)
 {
@@ -375,7 +367,6 @@ static void i82975x_init_csrows(struct mem_ctl_info *mci,
 	u32 cumul_size, nr_pages;
 	int index, chan;
 	struct dimm_info *dimm;
-	enum dev_type dtype;
 
 	last_cumul_size = 0;
 
@@ -413,7 +404,6 @@ static void i82975x_init_csrows(struct mem_ctl_info *mci,
 		 *   [0-7] for single-channel; i.e. csrow->nr_channels = 1
 		 *   [0-3] for dual-channel; i.e. csrow->nr_channels = 2
 		 */
-		dtype = i82975x_dram_type(mch_window, index);
 		for (chan = 0; chan < csrow->nr_channels; chan++) {
 			dimm = mci->csrows[index]->channels[chan]->dimm;
 
@@ -423,7 +413,10 @@ static void i82975x_init_csrows(struct mem_ctl_info *mci,
 				 (chan == 0) ? 'A' : 'B',
 				 index);
 			dimm->grain = 1 << 7;	/* 128Byte cache-line resolution */
-			dimm->dtype = i82975x_dram_type(mch_window, index);
+			/*
+			 * ECC is possible on i92975x ONLY with DEV_X8
+			 */
+			dimm->dtype = DEV_X8;
 			dimm->mtype = MEM_DDR2; /* I82975x supports only DDR2 */
 			dimm->edac_mode = EDAC_SECDED; /* only supported */
 		}
-- 
2.7.0


