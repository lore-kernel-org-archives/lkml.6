Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F509C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3436120859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="yKNEibH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfAOING (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:13:06 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:43605 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbfAOING (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:13:06 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0F8BngX023329;
        Tue, 15 Jan 2019 17:11:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0F8BngX023329
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547539910;
        bh=OUfJ3OLYNT1gN1lsc/KpmyBq7v1Da05HpG6V735Lw48=;
        h=From:To:Cc:Subject:Date:From;
        b=yKNEibH8fL7l/0/Aa4bU17wH3pgw9gXrLlp732DFHbz+Y6MdellPcLb7uwFSWo5/Y
         XySbgwg9U9ywsgXCA6KXkqasl1mYVfTGt82AjibLGym3jn8/uS8h0JdrM+iNkyqCyx
         YozNywHjxz+cdurKqtHISblzhgoprj4Lcf6Ph608mPMwaSdKOty4oLYKW5z43KU3vA
         uEdjjCTDezM40AgnBWdOQz7+BEXcrte74tqneUiLl8jc01Mig/JEbarupYhvKhzZG6
         bsqgGiv+Kw0A1mxrnlUy7CkvEjZEGWh3VjtT8LhxFfP/+kfhCVxshA5gkxrQ4Mg55Z
         CAFsMv3YGw4JA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH] mtd: rawnand: denali_dt: remove single anonymous clock support
Date:   Tue, 15 Jan 2019 17:11:34 +0900
Message-Id: <1547539894-12898-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6f1fe97bec34 ("mtd: rawnand: denali_dt: add more clocks based
on IP datasheet") introduced a more correct binding that requires
three named clocks.

Now that all upstream DT files migrated over to it, remove the single
anonymous clock support.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali_dt.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 7c6a8a4..0b5ae24 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -109,25 +109,17 @@ static int denali_dt_probe(struct platform_device *pdev)
 	if (IS_ERR(denali->host))
 		return PTR_ERR(denali->host);
 
-	/*
-	 * A single anonymous clock is supported for the backward compatibility.
-	 * New platforms should support all the named clocks.
-	 */
 	dt->clk = devm_clk_get(dev, "nand");
 	if (IS_ERR(dt->clk))
-		dt->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(dt->clk)) {
-		dev_err(dev, "no clk available\n");
 		return PTR_ERR(dt->clk);
-	}
 
 	dt->clk_x = devm_clk_get(dev, "nand_x");
 	if (IS_ERR(dt->clk_x))
-		dt->clk_x = NULL;
+		return PTR_ERR(dt->clk_x);
 
 	dt->clk_ecc = devm_clk_get(dev, "ecc");
 	if (IS_ERR(dt->clk_ecc))
-		dt->clk_ecc = NULL;
+		return PTR_ERR(dt->clk_ecc);
 
 	ret = clk_prepare_enable(dt->clk);
 	if (ret)
@@ -141,19 +133,8 @@ static int denali_dt_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_disable_clk_x;
 
-	if (dt->clk_x) {
-		denali->clk_rate = clk_get_rate(dt->clk);
-		denali->clk_x_rate = clk_get_rate(dt->clk_x);
-	} else {
-		/*
-		 * Hardcode the clock rates for the backward compatibility.
-		 * This works for both SOCFPGA and UniPhier.
-		 */
-		dev_notice(dev,
-			   "necessary clock is missing. default clock rates are used.\n");
-		denali->clk_rate = 50000000;
-		denali->clk_x_rate = 200000000;
-	}
+	denali->clk_rate = clk_get_rate(dt->clk);
+	denali->clk_x_rate = clk_get_rate(dt->clk_x);
 
 	ret = denali_init(denali);
 	if (ret)
-- 
2.7.4

