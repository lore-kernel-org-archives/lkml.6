Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CCFC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3096324098
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cxku8iuJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eaGY6ICP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3096324098
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754193AbeGFHwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:52:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753535AbeGFHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:52:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 860A9601D9; Fri,  6 Jul 2018 07:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530863542;
        bh=dJasHm6jVyPBZCK5L8nD3D+kdovnWNp1sWzzcT78yHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxku8iuJml3SUfnJrK0zIEhh3nHa62EFGl0xvQyF1BBLP8MVKOowQEwK7TPrpFjju
         Iz2Z6IxoSFNA/SkHqn8381cQ0P+tX5nwG+TC4v5CnRBjqPIn+Tx/kYbVXSjnbr5CxF
         7xXL0N8tnEcAn09MvvJgg8QQbZONqtkP2aAxapiI=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84E6F601D9;
        Fri,  6 Jul 2018 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530863541;
        bh=dJasHm6jVyPBZCK5L8nD3D+kdovnWNp1sWzzcT78yHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eaGY6ICPPHIHAbl9plkptzPA19k56xXBL3ZhyaFsfXYQyo4dmVNRyDBOp/jgcvgGc
         DkoQVIqUZj0JKL0JDP2kZ+HywEawJ9x+Xtk5RYIh1tKBlBaEBFDRC/DlZ9ta/UhIsm
         zBcan3CbtLNLt7144ioRpsonV7Hp/Fjc1CtQ38vA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84E6F601D9
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
Subject: [PATCH 4/5] mtd: rawnand: qcom: update BBT related flags
Date:   Fri,  6 Jul 2018 13:21:58 +0530
Message-Id: <1530863519-5564-5-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
References: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the NAND_SKIP_BBTSCAN to use RAM based BBT.
Flash based BBT is not used since bootloaders
doesn't have support for the same.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 9e6b383..6fb85d3 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2750,8 +2750,7 @@ static int qcom_nand_host_init(struct qcom_nand_controller *nandc,
 	chip->get_features	= nand_get_set_features_notsupp;
 
 	chip->controller = &nandc->controller;
-	chip->options |= NAND_NO_SUBPAGE_WRITE | NAND_USE_BOUNCE_BUFFER |
-			 NAND_SKIP_BBTSCAN;
+	chip->options |= NAND_NO_SUBPAGE_WRITE | NAND_USE_BOUNCE_BUFFER;
 
 	/* set up initial status value */
 	host->status = NAND_STATUS_READY | NAND_STATUS_WP;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

