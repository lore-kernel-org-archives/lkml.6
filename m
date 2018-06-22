Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9DAC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613C723C0B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="AH/w1BHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613C723C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934317AbeFVB3u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:29:50 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53660 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934204AbeFVB2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:28:46 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7F3948365F;
        Fri, 22 Jun 2018 13:28:44 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529630924;
        bh=wyUicxsreOHSjSXloP0g/9+JvPaBZFcWGmVZ44YxN6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AH/w1BHzLbFXC3dFq5P/mOgDyUeFU1QO/VKkpXFfs9bs5n+S4tMupMbg7JKd7T4q6
         mHNnvoRKu21hmrmOB3PYgEIl/dBMgn9gy1aw8g3ryWutiwwElmeVpNSJC/S+vaohb8
         HxMuF4ZUd5dE6S/zeMT+K5THRSIz0kBA5IibUOwI=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2c50cc0000>; Fri, 22 Jun 2018 13:28:44 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 6265113EE1C;
        Fri, 22 Jun 2018 13:28:47 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 2916C1E2626; Fri, 22 Jun 2018 13:28:44 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH v5 2/6] mtd: rawnand: add manufacturer fixup for ONFI parameter page
Date:   Fri, 22 Jun 2018 13:28:31 +1200
Message-Id: <20180622012835.17874-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622012835.17874-1-chris.packham@alliedtelesis.co.nz>
References: <20180622012835.17874-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is called after the ONFI parameter page checksum is verified
and allows us to override the contents of the parameter page.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---

Notes:
    Changes in v2:
    - New
    Changes in v3:
    - Add doc comment and review from Boris
    Changes in v4:
    - None
    Changes in v5:
    - None

 drivers/mtd/nand/raw/nand_base.c | 4 ++++
 include/linux/mtd/rawnand.h      | 3 +++
 2 files changed, 7 insertions(+)

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
index 3e8ec3b8a39c..ef7e3b4e91ea 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -778,11 +778,14 @@ nand_get_sdr_timings(const struct nand_data_interface *conf)
  *	  implementation) if any.
  * @cleanup: the ->init() function may have allocated resources, ->cleanup()
  *	     is here to let vendor specific code release those resources.
+ * @fixup_onfi_param_page: apply vendor specific fixups to the ONFI
+ *	parameter page. This is called after the checksum is verified.
  */
 struct nand_manufacturer_ops {
 	void (*detect)(struct nand_chip *chip);
 	int (*init)(struct nand_chip *chip);
 	void (*cleanup)(struct nand_chip *chip);
+	void (*fixup_onfi_param_page)(struct nand_chip *chip, struct nand_onfi_params *p);
 };
 
 /**
-- 
2.17.1

