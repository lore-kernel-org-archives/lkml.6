Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0D7C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D3E20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDpJ2Sg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D3E20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732945AbeHAFXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:23:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35685 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbeHAFXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:23:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so10097965pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 20:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nLg8nF2BVGhHBSt4qBWUxorV5/Diq0j0iCeB6+14Bu0=;
        b=cDpJ2Sg7+xTvhO/XV7boURbpH+hTQpETKhd5CsCXhbGtk37EPIe93+0S8UZeNS2wae
         mNOV9md7MCmqL21HP/9CfENPIqBQafmHEHGu6aUo6A16jzysJmLCeqYeBuJ/WuGGXtPA
         bk5FCH3UfQ9249y8GgE+ZIp8XRT3uEj8hQLgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nLg8nF2BVGhHBSt4qBWUxorV5/Diq0j0iCeB6+14Bu0=;
        b=uXm68eRpMTEZSAw0jRK3/SVVP7w0igPy4WWKdiaLxbCfE/snT9fjihD682qF2mE3on
         9Xg/DBr9auSyF9nx2OPExIqh5TymFsMjeVNkUbQyEeaXVfE8EkrPp732BCvg0Bx7fZ3u
         nCaIHXlkf9JpJmZu7Gk5U4YyvAQpGDXD/zMKBw1JTyGdH+Vrcx7TN1KgGpGxNfbH3QRn
         byYhKmai/PdOdkACAWNHYbkuV0a2RffGvgXqJ9LFi7ukNSzVINRMXTd4sw2HN1E8LvAB
         3WzxLCE3RjFkakNJuzcvuaJhoyDd06Nn+6s7cQeT8q9YEOSwXTduKi+66ry4U/d/+wmh
         VkWw==
X-Gm-Message-State: AOUpUlF5OcvM7ujFOZjOqdUFPS3vrj/ysKIE1UTAYnEjXZG2pKIlymEs
        4J4eySTiJBVHX9s4/nh7LxtM
X-Google-Smtp-Source: AAOMgpc+CncLM+oT4KbG11DOrYzfzrkeMAptSxioVxsQH3+3nEcCzl15PlHFEu+1jALiTc6rp+DFnQ==
X-Received: by 2002:a63:ae02:: with SMTP id q2-v6mr22509271pgf.189.1533094819428;
        Tue, 31 Jul 2018 20:40:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730e:f0ae:ac4e:9cdd:28a2:4bf9])
        by smtp.gmail.com with ESMTPSA id d19-v6sm34879545pgi.50.2018.07.31.20.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 20:40:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org, lee.jones@linaro.org,
        arnd@arndb.de
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 03/10] clk: actions: Add syscon support for Actions Semi Owl SoCs
Date:   Wed,  1 Aug 2018 09:09:08 +0530
Message-Id: <20180801033915.15880-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the clock and reset management units are sharing the same memory
map, convert the Owl common clock driver to support System Controller so
that the reset driver can reuse the same memory region.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/owl-common.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/actions/owl-common.c b/drivers/clk/actions/owl-common.c
index 61c1071b5180..080f980b2ec4 100644
--- a/drivers/clk/actions/owl-common.c
+++ b/drivers/clk/actions/owl-common.c
@@ -8,6 +8,7 @@
 // Copyright (c) 2018 Linaro Ltd.
 // Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 
+#include <linux/mfd/syscon.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -15,14 +16,6 @@
 
 #include "owl-common.h"
 
-static const struct regmap_config owl_regmap_config = {
-	.reg_bits	= 32,
-	.reg_stride	= 4,
-	.val_bits	= 32,
-	.max_register	= 0x00cc,
-	.fast_io	= true,
-};
-
 static void owl_clk_set_regmap(const struct owl_clk_desc *desc,
 			 struct regmap *regmap)
 {
@@ -41,18 +34,11 @@ static void owl_clk_set_regmap(const struct owl_clk_desc *desc,
 int owl_clk_regmap_init(struct platform_device *pdev,
 			 const struct owl_clk_desc *desc)
 {
-	void __iomem *base;
 	struct regmap *regmap;
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
 
-	regmap = devm_regmap_init_mmio(&pdev->dev, base, &owl_regmap_config);
+	regmap = syscon_node_to_regmap(of_get_parent(pdev->dev.of_node));
 	if (IS_ERR(regmap)) {
-		pr_err("failed to init regmap\n");
+		dev_err(&pdev->dev, "failed to get regmap\n");
 		return PTR_ERR(regmap);
 	}
 
-- 
2.17.1

