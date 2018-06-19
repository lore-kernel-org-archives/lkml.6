Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6ADC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A86E20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="WNuqdDC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A86E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756159AbeFSFcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:32:05 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46081 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755973AbeFSFbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:31:45 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C989D8448B;
        Tue, 19 Jun 2018 17:31:44 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529386304;
        bh=MV/m6wFR9NnY9R665IwxMIyueRJGF+je4rTwuO2riME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WNuqdDC0MFT+V0hT0bZTYjJ5+YLFoMfq+vGFj3LwzMRDpt+M3d3kimW2THACVb3Q/
         cAMsQW2aU0MDo47kke1siTl9+iGgAR/Pg3cPlhhoLFVXUteaw7gCMgbcEz2/656NkF
         DapzvngkRjZQknYZ1b0/AqF9Lm6vQ89qGycFTP84=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2895410000>; Tue, 19 Jun 2018 17:31:45 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id B2E9A13EEAD;
        Tue, 19 Jun 2018 17:31:47 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 994131E2626; Tue, 19 Jun 2018 17:31:44 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [RFC PATCH v2 6/6] mtd: rawnand: micron: support 8/512 on-die ECC
Date:   Tue, 19 Jun 2018 17:31:25 +1200
Message-Id: <20180619053125.16792-7-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
References: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Micron MT29F1G08ABAFAWP-ITE:F supports an on-die ECC with 8 bits
per 512 bytes. Add support for this combination.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
This seems deceptively easy so I've probably missed something. I have
tested with running some of the ubifs stress tests from mtd-utils and
things seem OK.

Changes in v2:
- New

 drivers/mtd/nand/raw/nand_micron.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index d1e8f57544a0..2164dd112f5c 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -240,9 +240,9 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
 
 	/*
 	 * Some Micron NANDs have an on-die ECC of 4/512, some other
-	 * 8/512. We only support the former.
+	 * 8/512.
 	 */
-	if (chip->ecc_strength_ds != 4)
+	if (chip->ecc_strength_ds != 4 && chip->ecc_strength_ds != 8)
 		return MICRON_ON_DIE_UNSUPPORTED;
 
 	return MICRON_ON_DIE_SUPPORTED;
@@ -274,9 +274,9 @@ static int micron_nand_init(struct nand_chip *chip)
 			return -EINVAL;
 		}
 
-		chip->ecc.bytes = 8;
+		chip->ecc.bytes = chip->ecc_strength_ds * 2;
 		chip->ecc.size = 512;
-		chip->ecc.strength = 4;
+		chip->ecc.strength = chip->ecc_strength_ds;
 		chip->ecc.algo = NAND_ECC_BCH;
 		chip->ecc.read_page = micron_nand_read_page_on_die_ecc;
 		chip->ecc.write_page = micron_nand_write_page_on_die_ecc;
-- 
2.17.1

