Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2716CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF7B20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ugIUWtc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF7B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756224AbeFSFcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:32:53 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46059 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755779AbeFSFbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:31:41 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 498528365F;
        Tue, 19 Jun 2018 17:31:40 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529386300;
        bh=GlBmqh7Jh6Fg1u0NY9D06miHvcc73YFOLfJfzPmEaE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ugIUWtc4Y5bsWlAaDC+ZPD7fPdp0xAZbCilxJtTEP3U+VpyeEqu6IN0OHYuab4MMu
         zfYKj/rKPmPfnqwE89MFctPWAR1IuglzhUDpWIE+cXZCdXAPT8elQdzNG/KvjjpT/Q
         6dddR4BnwN5Jw/Cmtvf1cA8nLgvHTVAAA8aG2fnk=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b28953c0000>; Tue, 19 Jun 2018 17:31:41 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 2278713EEAD;
        Tue, 19 Jun 2018 17:31:43 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 08C821E2626; Tue, 19 Jun 2018 17:31:40 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [RFC PATCH v2 2/6] mtd: rawnand: add manufacturer fixup for ONFI parameter page
Date:   Tue, 19 Jun 2018 17:31:21 +1200
Message-Id: <20180619053125.16792-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
References: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is called after the ONFI parameter page checksum is verified
and allows us to override the contents of the parameter page.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- New

 drivers/mtd/nand/raw/nand_base.c | 4 ++++
 include/linux/mtd/rawnand.h      | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 0cd3e216b95c..65250308c82d 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5172,6 +5172,10 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 		}
 	}
 
+	if (chip->manufacturer.desc && chip->manufacturer.desc->ops &&
+	    chip->manufacturer.desc->ops->fixup_onfi_param_page)
+		chip->manufacturer.desc->ops->fixup_onfi_param_page(chip, p);
+
 	/* Check version */
 	val = le16_to_cpu(p->revision);
 	if (val & (1 << 5))
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 3e8ec3b8a39c..6db42091ee5e 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -783,6 +783,7 @@ struct nand_manufacturer_ops {
 	void (*detect)(struct nand_chip *chip);
 	int (*init)(struct nand_chip *chip);
 	void (*cleanup)(struct nand_chip *chip);
+	void (*fixup_onfi_param_page)(struct nand_chip *chip, struct nand_onfi_params *p);
 };
 
 /**
-- 
2.17.1

