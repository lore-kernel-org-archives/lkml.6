Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2267AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D6220891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F7uh66Rf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VdvW0VbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D6220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbeFMJCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:02:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeFMJCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:02:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4E5EC607A4; Wed, 13 Jun 2018 09:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528880566;
        bh=fl6gQW5SIy21oP3dRmfZs3JwXPRdmjmKR+fZnpIVOuY=;
        h=From:To:Cc:Subject:Date:From;
        b=F7uh66Rf4i1eWn0tAzAvlZKN4orHtggqJI1eA9amGTvBsov+w+ifhUgni9sSBmVKI
         81xQ+jbFAKdAt5sOBodRQOZXFZx2VTcHZij2R695Pw6HTQOZ+ru0UUZeoixULiQLqV
         PPYl2vYQVqP1b8ON3nJBcDP+gw3vhTuyKlHcehHs=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2EFB606DB;
        Wed, 13 Jun 2018 09:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528880564;
        bh=fl6gQW5SIy21oP3dRmfZs3JwXPRdmjmKR+fZnpIVOuY=;
        h=From:To:Cc:Subject:Date:From;
        b=VdvW0VbYD4pI6bLeUuJwiDfLy0JCGxYKT/6iFMM/+79J5pGSC/3CSd6KRwsFt3o0H
         CwOkoHQaKGGlwERH/0VOrj5SXS58b83OXyrm5s9c0gIP31Zpck1KJFm0u2Z7fYvFUu
         xfYBPn7rvUdPDNbW8eJC28Sgl1mFj3ODoYLPwj3U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2EFB606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Abhishek Sahu <absahu@codeaurora.org>, <stable@vger.kernel.org>
Subject: [PATCH] mtd: rawnand: fix return value check for bad block status
Date:   Wed, 13 Jun 2018 14:32:36 +0530
Message-Id: <1528880556-20348-1-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Positive return value from read_oob() is making false BAD
blocks. For some of the NAND controllers, OOB bytes will be
protected with ECC and read_oob() will return number of bitflips.
If there is any bitflip in ECC protected OOB bytes for BAD block
status page, then that block is getting treated as BAD.

Fixes: c120e75e0e7d ("mtd: nand: use read_oob() instead of cmdfunc() for bad block check")
Cc: <stable@vger.kernel.org>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/mtd/nand/raw/nand_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index f28c3a5..4a73f73 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -440,7 +440,7 @@ static int nand_block_bad(struct mtd_info *mtd, loff_t ofs)
 
 	for (; page < page_end; page++) {
 		res = chip->ecc.read_oob(mtd, chip, page);
-		if (res)
+		if (res < 0)
 			return res;
 
 		bad = chip->oob_poi[chip->badblockpos];
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

