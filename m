Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F82C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93147208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="EFYo4Teu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93147208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933194AbeFUKe3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:34:29 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52155 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932994AbeFUKdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:33:45 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E58138448B;
        Thu, 21 Jun 2018 22:33:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529577221;
        bh=27in9BDc+6o663iJCTmHaUlPBZJQglrLMC8IzFP6Xvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EFYo4Teu9VAUEnilOUzTdAa6/35EEk2hI4Y39XxBB55t/6tVsPz3mJHfGdkdi9I3/
         JOaaHe7Ts2Es2oMxKrCe8OAGjcS10F2yppa2m5cwxkOHa14FMiLB0Z16zZn8kdfRN+
         gQ5XikX0tpyatX5oqacHNGgGU7ItLplfzxGZYQD8=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2b7f020000>; Thu, 21 Jun 2018 22:33:42 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 752BF13EFB8;
        Thu, 21 Jun 2018 22:33:40 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4258B1E2626; Thu, 21 Jun 2018 22:33:37 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH v4 4/6] mtd: rawnand: micron: add fixup for ONFI revision
Date:   Thu, 21 Jun 2018 22:33:26 +1200
Message-Id: <20180621103328.28206-5-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621103328.28206-1-chris.packham@alliedtelesis.co.nz>
References: <20180621103328.28206-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Micron NAND chips (MT29F1G08ABAFAWP-ITE:F) report 00 00 for the
revision number field of the ONFI parameter page. Rather than rejecting
these outright assume ONFI version 1.0 if the revision number is 00 00.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
This is now qualified on vendor == MICRON. I haven't qualified this
based on specific chips the ABAFA (id=d1) and ABBFA (id=a1) variants are
documented to have this behaviour.

Changes in v2:
- use fixup_onfi_param_page
Changes in v3:
- add code comment next to workaround
Changes in v4:
- use define for ONFI_VERSION

 drivers/mtd/nand/raw/nand_micron.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index 203faba0a9c1..d30bd4df9b12 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -290,6 +290,19 @@ static int micron_nand_init(struct nand_chip *chip)
 	return 0;
 }
 
+static void micron_fixup_onfi_param_page(struct nand_chip *chip,
+					 struct nand_onfi_params *p)
+{
+	/*
+	 * MT29F1G08ABAFAWP-ITE:F and possibly others report 00 00 for the
+	 * revision number field of the ONFI parameter page. Assume ONFI
+	 * version 1.0 if the revision number is 00 00.
+	 */
+	if (le16_to_cpu(p->revision) == 0)
+		p->revision = cpu_to_le16(ONFI_VERSION_1_0);
+}
+
 const struct nand_manufacturer_ops micron_nand_manuf_ops = {
 	.init = micron_nand_init,
+	.fixup_onfi_param_page = micron_fixup_onfi_param_page,
 };
-- 
2.17.1

