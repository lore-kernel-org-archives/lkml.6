Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DEE30C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A82208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="K/jV6Wk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A82208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeFLKei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:34:38 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:31391 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeFLKeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:34:36 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w5CAWQLv002200;
        Tue, 12 Jun 2018 19:32:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w5CAWQLv002200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1528799547;
        bh=xlmkvhS34IsF0Tfr28zTqZ9AIGpKQH78cmpXUmOKdkI=;
        h=From:To:Cc:Subject:Date:From;
        b=K/jV6Wk3ujLEU8nxf8u3SIcjXVWU7kPB+VqYiB73skYLM8Rlpolb18cbyLMtXo7OZ
         CWh6iTUseXm4TIOAWiYL5l5lV6XC6yzehgeN0EpejHP0FQEu4WXj9tHyg6m/tEBwHT
         A/G8c8vIqHnzo8Y19uVGCNtBU6flwVUiWFBJxD7r8Ua7qtzWpP0j3JQZtEOfsKhc3G
         nujqRRvvTwMP0sp2IJvNHATeGYmEGNpeeLJQX+RoHUPrRgdx9CTBV4LpOn1H0Jm7xE
         l7c4xKG/K21djMWIZ9HaoWbGMd2qvnlY4laEu84AXZzEEbgL4EeipZrkQDtU5mrdQ7
         kIxkmLqy9FSTw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Richard Weinberger <richard@sigma-star.at>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Rob Herring <robh@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 1/2] mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
Date:   Tue, 12 Jun 2018 19:31:54 +0900
Message-Id: <1528799515-1356-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'dev' as a shorthand before adding more code that takes a
pointer to struce device.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali_dt.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index cfd33e6..d923cfa 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -79,44 +79,45 @@ MODULE_DEVICE_TABLE(of, denali_nand_dt_ids);
 
 static int denali_dt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct resource *res;
 	struct denali_dt *dt;
 	const struct denali_dt_data *data;
 	struct denali_nand_info *denali;
 	int ret;
 
-	dt = devm_kzalloc(&pdev->dev, sizeof(*dt), GFP_KERNEL);
+	dt = devm_kzalloc(dev, sizeof(*dt), GFP_KERNEL);
 	if (!dt)
 		return -ENOMEM;
 	denali = &dt->denali;
 
-	data = of_device_get_match_data(&pdev->dev);
+	data = of_device_get_match_data(dev);
 	if (data) {
 		denali->revision = data->revision;
 		denali->caps = data->caps;
 		denali->ecc_caps = data->ecc_caps;
 	}
 
-	denali->dev = &pdev->dev;
+	denali->dev = dev;
 	denali->irq = platform_get_irq(pdev, 0);
 	if (denali->irq < 0) {
-		dev_err(&pdev->dev, "no irq defined\n");
+		dev_err(dev, "no irq defined\n");
 		return denali->irq;
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "denali_reg");
-	denali->reg = devm_ioremap_resource(&pdev->dev, res);
+	denali->reg = devm_ioremap_resource(dev, res);
 	if (IS_ERR(denali->reg))
 		return PTR_ERR(denali->reg);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nand_data");
-	denali->host = devm_ioremap_resource(&pdev->dev, res);
+	denali->host = devm_ioremap_resource(dev, res);
 	if (IS_ERR(denali->host))
 		return PTR_ERR(denali->host);
 
-	dt->clk = devm_clk_get(&pdev->dev, NULL);
+	dt->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(dt->clk)) {
-		dev_err(&pdev->dev, "no clk available\n");
+		dev_err(dev, "no clk available\n");
 		return PTR_ERR(dt->clk);
 	}
 	ret = clk_prepare_enable(dt->clk);
-- 
2.7.4

