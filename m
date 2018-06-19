Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FE9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F5220661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CXZeBIqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F5220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966975AbeFSQBM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:01:12 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38901 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966650AbeFSQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:00:59 -0400
Received: by mail-wr0-f194.google.com with SMTP id e18-v6so210534wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gcQAXSlxiIfLTKCbjMnRcf6JHeMBzBLqDY93GEZd048=;
        b=CXZeBIqV5GVYUnEhupdf/Y1x7Nov48wz7j3ay90d5aAc7VpzUhfrbIS4savOJo5YKu
         yt8Sz8zBjM66NeAMiN5xP7VmyER1N/stIvQ/1rCtTcsSuOHklAizlRAes2D1pMkZisvQ
         LtXMvCe9ldcwZH2mTufrG3o4cedoCvGZ+i5PAHxpPFyTREen8pQgc4Ve99A/djkwV1He
         A6ceVubDISZrZnVLhoQDRgtRNtofbVdyGugxCertUk8fMz1bEfJBBClcrcqABbuP0ARD
         WWl0PQmiyGqy5OP7UEDPzhTClk3OaW8x4b2W5/YU68u3msCCI5ih7y5sKyojHkZDgplu
         h9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gcQAXSlxiIfLTKCbjMnRcf6JHeMBzBLqDY93GEZd048=;
        b=KQ/FePqdre4xkP5vQgFioODMNtt6cMjf6Je+doAtoCP3AGEJgf21C75ps8GwYgUhNX
         i64a7kpE5fQzAdBc8OdNZOPA7EcW9AC2bizFcwa7ArLxCFmHFUIbsg5CfrsXRQ1tLFrh
         EFbYElO4aL+49hdmUetoPJPiHQKki0leyZoGicFk45djrlX1SK5+az3N39EExERY54nU
         vfOnA3k0rYR6etnu0cILZuXDDsvZ8sgQT7eaaAVbMXBn/ivyueLiDvff3IX9dfyq6aAZ
         HhNlB9H1eGcMRVxTOzxJw8kr0bOAbiq4KWs5BEarKF/eyIVZIjrUFxH+xqgw/t6+LNb1
         /RNg==
X-Gm-Message-State: APt69E10N45SJpxC2bN5dRhlmHB10THw9N0BQHw5AkG+XkHJh6agOMdg
        Im4pT8pM82UuMWNTN2w7tV+CZw==
X-Google-Smtp-Source: ADUXVKLzZXeWo/8lzNFnhJM2uHFUuJkgKiIQYTSMR6KTPvs/QRCAipoJEkiJa/i68zMiZuGhTdZReA==
X-Received: by 2002:adf:e447:: with SMTP id t7-v6mr15198449wrm.145.1529424058320;
        Tue, 19 Jun 2018 09:00:58 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h77-v6sm644210wmd.9.2018.06.19.09.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 09:00:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: meson: remove obsolete register access
Date:   Tue, 19 Jun 2018 18:00:50 +0200
Message-Id: <20180619160050.26958-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy method to access the hhi register space is not longer used.
We can safely drop it now.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg.c  | 37 ++-----------------------------------
 drivers/clk/meson/gxbb.c | 36 ++----------------------------------
 2 files changed, 4 insertions(+), 69 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index bd4dbc696b88..3fb884db1b10 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -12,7 +12,6 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
-#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
@@ -995,49 +994,17 @@ static const struct of_device_id clkc_match_table[] = {
 	{}
 };
 
-static const struct regmap_config clkc_regmap_config = {
-	.reg_bits       = 32,
-	.val_bits       = 32,
-	.reg_stride     = 4,
-};
-
 static int axg_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
-	void __iomem *clk_base = NULL;
 	struct regmap *map;
 	int ret, i;
 
 	/* Get the hhi system controller node if available */
 	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
 	if (IS_ERR(map)) {
-		dev_err(dev,
-			"failed to get HHI regmap - Trying obsolete regs\n");
-
-		/*
-		 * FIXME: HHI registers should be accessed through
-		 * the appropriate system controller. This is required because
-		 * there is more than just clocks in this register space
-		 *
-		 * This fallback method is only provided temporarily until
-		 * all the platform DTs are properly using the syscon node
-		 */
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!res)
-			return -EINVAL;
-
-
-		clk_base = devm_ioremap(dev, res->start, resource_size(res));
-		if (!clk_base) {
-			dev_err(dev, "Unable to map clk base\n");
-			return -ENXIO;
-		}
-
-		map = devm_regmap_init_mmio(dev, clk_base,
-					    &clkc_regmap_config);
-		if (IS_ERR(map))
-			return PTR_ERR(map);
+		dev_err(dev, "failed to get HHI regmap\n");
+		return PTR_ERR(map);
 	}
 
 	/* Populate regmap for the regmap backed clocks */
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 177fffb9ebef..297ebc391475 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -7,7 +7,6 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
-#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
@@ -2228,17 +2227,9 @@ static const struct of_device_id clkc_match_table[] = {
 	{},
 };
 
-static const struct regmap_config clkc_regmap_config = {
-	.reg_bits       = 32,
-	.val_bits       = 32,
-	.reg_stride     = 4,
-};
-
 static int gxbb_clkc_probe(struct platform_device *pdev)
 {
 	const struct clkc_data *clkc_data;
-	struct resource *res;
-	void __iomem *clk_base;
 	struct regmap *map;
 	int ret, i;
 	struct device *dev = &pdev->dev;
@@ -2250,31 +2241,8 @@ static int gxbb_clkc_probe(struct platform_device *pdev)
 	/* Get the hhi system controller node if available */
 	map = syscon_node_to_regmap(of_get_parent(dev->of_node));
 	if (IS_ERR(map)) {
-		dev_err(dev,
-			"failed to get HHI regmap - Trying obsolete regs\n");
-
-		/*
-		 * FIXME: HHI registers should be accessed through
-		 * the appropriate system controller. This is required because
-		 * there is more than just clocks in this register space
-		 *
-		 * This fallback method is only provided temporarily until
-		 * all the platform DTs are properly using the syscon node
-		 */
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!res)
-			return -EINVAL;
-
-		clk_base = devm_ioremap(dev, res->start, resource_size(res));
-		if (!clk_base) {
-			dev_err(dev, "Unable to map clk base\n");
-			return -ENXIO;
-		}
-
-		map = devm_regmap_init_mmio(dev, clk_base,
-					    &clkc_regmap_config);
-		if (IS_ERR(map))
-			return PTR_ERR(map);
+		dev_err(dev, "failed to get HHI regmap\n");
+		return PTR_ERR(map);
 	}
 
 	/* Populate regmap for the common regmap backed clocks */
-- 
2.14.3

