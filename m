Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7044CC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B7F24DF1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B7F24DF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754422AbeGCHQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:16:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932126AbeGCHQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:16:39 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 90FC9556D670C;
        Tue,  3 Jul 2018 15:16:23 +0800 (CST)
Received: from huawei.com (10.67.212.83) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Tue, 3 Jul 2018
 15:16:15 +0800
From:   Qing Xia <xiaqing17@hisilicon.com>
To:     <ulf.hansson@linaro.org>, <jh80.chung@samsung.com>
CC:     x00270170 <xiaqing17@hisilicon.com>, <Evgeniy.Didin@synopsys.com>,
        <shawn.lin@rock-chips.com>, <dianders@chromium.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: dw_mmc: fix card threshold control configuration
Date:   Tue, 3 Jul 2018 15:06:27 +0800
Message-ID: <1530601587-160436-1-git-send-email-xiaqing17@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.83]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: x00270170 <xiaqing17@hisilicon.com>

Card write threshold control is supposed to be set since controller
version 2.80a for data write in HS400 mode and data read in
HS200/HS400/SDR104 mode. However the current code returns without
configuring it in the case of data writing in HS400 mode.
Meanwhile the patch fixes that the current code goes to
'disable' when doing data reading in HS400 mode.

Fixes: 7e4bf1bc9543 ("mmc: dw_mmc: add the card write threshold for HS400 mode")
Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>
---
 drivers/mmc/host/dw_mmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 29a1afa..3ee8f57 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1065,8 +1065,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
 	 * It's used when HS400 mode is enabled.
 	 */
 	if (data->flags & MMC_DATA_WRITE &&
-		!(host->timing != MMC_TIMING_MMC_HS400))
-		return;
+		host->timing != MMC_TIMING_MMC_HS400)
+		goto disable;
 
 	if (data->flags & MMC_DATA_WRITE)
 		enable = SDMMC_CARD_WR_THR_EN;
@@ -1074,7 +1074,8 @@ static void dw_mci_ctrl_thld(struct dw_mci *host, struct mmc_data *data)
 		enable = SDMMC_CARD_RD_THR_EN;
 
 	if (host->timing != MMC_TIMING_MMC_HS200 &&
-	    host->timing != MMC_TIMING_UHS_SDR104)
+	    host->timing != MMC_TIMING_UHS_SDR104 &&
+	    host->timing != MMC_TIMING_MMC_HS400)
 		goto disable;
 
 	blksz_depth = blksz / (1 << host->data_shift);
-- 
2.8.1

