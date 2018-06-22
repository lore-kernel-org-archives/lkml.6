Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A586DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC0B24505
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zKHPxcNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC0B24505
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934094AbeFVQIR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:08:17 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:30584 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933047AbeFVQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:08:15 -0400
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w5MG6m5e022587;
        Sat, 23 Jun 2018 01:06:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w5MG6m5e022587
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529683613;
        bh=TY7lBRRVAqb7hx/EXgO/qzEjGYj1dbl+Ee4pESpsL2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKHPxcNUsCGGVRdBjxmTTYeF0rATg1xiIBNStCDDLBx5T/AyTn33ZLDu4N6NFDelW
         a02MNy8e++zB9dGR76QbOQIdBzyYvGNN7fkKCEc0IQ76rEWByGkPlsxbGI8j65vBdw
         98Gs9AzhPTHBeTgZB69/OdyJlR3MRGgwlf32KxyXZ+WGRmiannGXBE0WmtYxCU6rWx
         V9FH7WRe0QZTtTPpbMugg3zyR2nsFuRYRVAvtyWEh7xAiDijSuUAnF6SjNE6zRQ1E1
         vdViTJLaS4aRQ2GHPPCGhdm+eV3Y6fizF6XkuDBGMrFBjfjZcpZEcacQGqrisR3tOp
         hwQsoLewV705Q==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v4 4/5] mtd: rawnand: denali_dt: add more clocks based on IP datasheet
Date:   Sat, 23 Jun 2018 01:06:37 +0900
Message-Id: <1529683598-25783-5-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
References: <1529683598-25783-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, denali_dt.c requires a single anonymous clock, but
the Denali User's Guide requires three clocks for this IP:

 - clk: controller core clock

 - clk_x: bus interface clock

 - ecc_clk: clock at which ECC circuitry is run

This commit supports these named clocks to represent the real hardware.

For the backward compatibility, the driver still accepts a single clock
just as before.  The clk_x_rate is taken from the clock driver again if
the named clock "clk_x" is available.  This will happen only for future
DT, hence the existing DT files are not affected.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Richard Weinberger <richard@nod.at>
Tested-by: Richard Weinberger <richard@nod.at>
---

Changes in v4: None
Changes in v3:
  - Change the patch order so that the bug-fix one comes the first

Changes in v2:
  - Split patches into sensible chunks

 drivers/mtd/nand/raw/denali_dt.c | 53 ++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 6b4bd16..afaae37 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -27,7 +27,9 @@
 
 struct denali_dt {
 	struct denali_nand_info	denali;
-	struct clk		*clk;
+	struct clk *clk;	/* core clock */
+	struct clk *clk_x;	/* bus interface clock */
+	struct clk *clk_ecc;	/* ECC circuit clock */
 };
 
 struct denali_dt_data {
@@ -115,28 +117,61 @@ static int denali_dt_probe(struct platform_device *pdev)
 	if (IS_ERR(denali->host))
 		return PTR_ERR(denali->host);
 
-	dt->clk = devm_clk_get(dev, NULL);
+	/*
+	 * A single anonymous clock is supported for the backward compatibility.
+	 * New platforms should support all the named clocks.
+	 */
+	dt->clk = devm_clk_get(dev, "nand");
+	if (IS_ERR(dt->clk))
+		dt->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(dt->clk)) {
 		dev_err(dev, "no clk available\n");
 		return PTR_ERR(dt->clk);
 	}
+
+	dt->clk_x = devm_clk_get(dev, "nand_x");
+	if (IS_ERR(dt->clk_x))
+		dt->clk_x = NULL;
+
+	dt->clk_ecc = devm_clk_get(dev, "ecc");
+	if (IS_ERR(dt->clk_ecc))
+		dt->clk_ecc = NULL;
+
 	ret = clk_prepare_enable(dt->clk);
 	if (ret)
 		return ret;
 
-	/*
-	 * Hardcode the clock rate for the backward compatibility.
-	 * This works for both SOCFPGA and UniPhier.
-	 */
-	denali->clk_x_rate = 200000000;
+	ret = clk_prepare_enable(dt->clk_x);
+	if (ret)
+		goto out_disable_clk;
+
+	ret = clk_prepare_enable(dt->clk_ecc);
+	if (ret)
+		goto out_disable_clk_x;
+
+	if (dt->clk_x) {
+		denali->clk_x_rate = clk_get_rate(dt->clk_x);
+	} else {
+		/*
+		 * Hardcode the clock rates for the backward compatibility.
+		 * This works for both SOCFPGA and UniPhier.
+		 */
+		dev_notice(dev,
+			   "necessary clock is missing. default clock rates are used.\n");
+		denali->clk_x_rate = 200000000;
+	}
 
 	ret = denali_init(denali);
 	if (ret)
-		goto out_disable_clk;
+		goto out_disable_clk_ecc;
 
 	platform_set_drvdata(pdev, dt);
 	return 0;
 
+out_disable_clk_ecc:
+	clk_disable_unprepare(dt->clk_ecc);
+out_disable_clk_x:
+	clk_disable_unprepare(dt->clk_x);
 out_disable_clk:
 	clk_disable_unprepare(dt->clk);
 
@@ -148,6 +183,8 @@ static int denali_dt_remove(struct platform_device *pdev)
 	struct denali_dt *dt = platform_get_drvdata(pdev);
 
 	denali_remove(&dt->denali);
+	clk_disable_unprepare(dt->clk_ecc);
+	clk_disable_unprepare(dt->clk_x);
 	clk_disable_unprepare(dt->clk);
 
 	return 0;
-- 
2.7.4

