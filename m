Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D35C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFC825353
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="kMtDEROe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFC825353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeFXWpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 18:45:05 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56250 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeFXWpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 18:45:01 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5CD8C84484;
        Mon, 25 Jun 2018 10:45:00 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529880300;
        bh=YcGj6N2LsfgM1D8lNMeviGRVWSBp/RlggU4fgqMJIbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kMtDEROebWbmSU7C2H1P1OlkRoh4f+WW0yhV0q7DTnICAS592FfSoc79FUzyCHdXz
         rDAwSUwdJzu5PbopyHWi0k9s36x1aXsV1NsfflqgTn8ZJi4I+3OYjf+zayAIxRAt42
         nfUpGFDE1pvDdQd9ygJyminJ7up1lkN6XHSZbic8=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b301ee60000>; Mon, 25 Jun 2018 10:44:59 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 99D8813EF9D;
        Mon, 25 Jun 2018 10:44:58 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 33F131E2626; Mon, 25 Jun 2018 10:44:55 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH v6 1/6] mtd: rawnand: marvell: Handle on-die ECC
Date:   Mon, 25 Jun 2018 10:44:43 +1200
Message-Id: <20180624224448.21872-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624224448.21872-1-chris.packham@alliedtelesis.co.nz>
References: <20180624224448.21872-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the controllers point of view this is the same as no or
software only ECC.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v2:
- New
Changes in v3:
- Add review from Boris
Changes in v4:
- None
Changes in v5:
- None
Changes in v6:
- None

 drivers/mtd/nand/raw/marvell_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index ebb1d141b900..ba6889bbe802 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2157,6 +2157,7 @@ static int marvell_nand_ecc_init(struct mtd_info *mtd,
 		break;
 	case NAND_ECC_NONE:
 	case NAND_ECC_SOFT:
+	case NAND_ECC_ON_DIE:
 		if (!nfc->caps->is_nfcv2 && mtd->writesize != SZ_512 &&
 		    mtd->writesize != SZ_2K) {
 			dev_err(nfc->dev, "NFCv1 cannot write %d bytes pages\n",
-- 
2.18.0

