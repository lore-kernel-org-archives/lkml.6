Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADCCECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A086020864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A086020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeGPIBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:01:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeGPIBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:01:47 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 930BACA8;
        Mon, 16 Jul 2018 07:35:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qing Xia <xiaqing17@hisilicon.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.17 10/67] mmc: dw_mmc: fix card threshold control configuration
Date:   Mon, 16 Jul 2018 09:34:39 +0200
Message-Id: <20180716073444.689906772@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: x00270170 <xiaqing17@hisilicon.com>

commit 7a6b9f4d601dfce8cb68f0dcfd834270280e31e6 upstream.

Card write threshold control is supposed to be set since controller
version 2.80a for data write in HS400 mode and data read in
HS200/HS400/SDR104 mode. However the current code returns without
configuring it in the case of data writing in HS400 mode.
Meanwhile the patch fixes that the current code goes to
'disable' when doing data reading in HS400 mode.

Fixes: 7e4bf1bc9543 ("mmc: dw_mmc: add the card write threshold for HS400 mode")
Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>
Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1065,8 +1065,8 @@ static void dw_mci_ctrl_thld(struct dw_m
 	 * It's used when HS400 mode is enabled.
 	 */
 	if (data->flags & MMC_DATA_WRITE &&
-		!(host->timing != MMC_TIMING_MMC_HS400))
-		return;
+		host->timing != MMC_TIMING_MMC_HS400)
+		goto disable;
 
 	if (data->flags & MMC_DATA_WRITE)
 		enable = SDMMC_CARD_WR_THR_EN;
@@ -1074,7 +1074,8 @@ static void dw_mci_ctrl_thld(struct dw_m
 		enable = SDMMC_CARD_RD_THR_EN;
 
 	if (host->timing != MMC_TIMING_MMC_HS200 &&
-	    host->timing != MMC_TIMING_UHS_SDR104)
+	    host->timing != MMC_TIMING_UHS_SDR104 &&
+	    host->timing != MMC_TIMING_MMC_HS400)
 		goto disable;
 
 	blksz_depth = blksz / (1 << host->data_shift);


