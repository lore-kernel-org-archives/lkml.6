Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C7AC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4CD2409C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fC3BgUEP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GvHrZ+Ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4CD2409C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeGFHwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:52:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34182 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753467AbeGFHwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:52:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 670A460B84; Fri,  6 Jul 2018 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530863540;
        bh=r0Q0qfHL2HVUBrbGxftFmmShEafGFWihXs3+FZ8buVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fC3BgUEPK6SJJyMCbiWhZNIe+z+zpDFRqXPQJCUTQuiJQYOLgj0dYOoyvIHk/0RDW
         Ne/3sUrk18kuusYVh6CLe6aPM+27fOnMGWVGiLRwOVORnyduYUXaoPC8cFsBTaBycv
         kdpg1q4Rmatgr6M0eWy/Bv+NbLbd33u4ZHFsp8Y8=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16C8E60B71;
        Fri,  6 Jul 2018 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530863537;
        bh=r0Q0qfHL2HVUBrbGxftFmmShEafGFWihXs3+FZ8buVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GvHrZ+EdoscvKza1SJ9xwdhT9Nuxtn/tld39SYZqsG83ZGG4ZALKvilARa3f0ME+3
         zEK7bmztMWUT2lDZOHVpZRMlwYiK18SOokkcboOjs6K7x3GRYgb/MBApiMKk6/l3cn
         gkRen/DTUO9etsbKKvdqORDIEiI4h2so7e48AFWo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16C8E60B71
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH 3/5] mtd: rawnand: qcom: fix NAND register write errors
Date:   Fri,  6 Jul 2018 13:21:57 +0530
Message-Id: <1530863519-5564-4-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
References: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following NAND register write errors which will
be generated if access protection is enabled.

1. SFLASHC_BURST_CFG register is not available for supported
   NAND contollers by this driver, so this can be removed.
2. NAND_CTRL is operational register and register writes to
   operational registers should always be done through
   command descriptors if BAM_MODE is already enabled.
   With full boot chain, bootloader already enables
   BAM_MODE so read the NAND_CTRL register value and write
   only if BAM_MODE is not set.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index df12cf3..9e6b383 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2693,15 +2693,20 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
 {
 	u32 nand_ctrl;
 
-	/* kill onenand */
-	nandc_write(nandc, SFLASHC_BURST_CFG, 0);
 	nandc_write(nandc, dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD),
 		    NAND_DEV_CMD_VLD_VAL);
 
 	/* enable ADM or BAM DMA */
 	if (nandc->props->is_bam) {
 		nand_ctrl = nandc_read(nandc, NAND_CTRL);
-		nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
+		/*
+		 * Once BAM_MODE_EN bit is set then QPIC_NAND_CTRL register
+		 * should be written with BAM instead of writel.
+		 * Check if BAM_MODE_EN is already set by bootloader and write
+		 * only if this bit is not set.
+		 */
+		if (!(nand_ctrl & BAM_MODE_EN))
+			nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
 	} else {
 		nandc_write(nandc, NAND_FLASH_CHIP_SELECT, DM_EN);
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

