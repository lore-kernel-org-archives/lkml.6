Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968F2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5910820685
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hIlJQVhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5910820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbeKMVQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:16:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33026 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732834AbeKMVQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:16:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id v68-v6so5893252pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkLnvoOX4ZeeFgDP21cZlyAYt8eoNNgptp85ozSuxkM=;
        b=hIlJQVhVUdQcaqiwZ8zMD9S/GTPcfU6bGult6R0AmcVzWlMLUbeG3105tQrLOAYyXU
         yuu/MRK3A+caQcXCMNfAzdWQ0xzQGCaAVnjXCU0bdc47FRKo2002zGOEXkYBrjtmS5Vi
         S0683JP7LD80DGI7FN52fsFhJT4RBqaH7Qp4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkLnvoOX4ZeeFgDP21cZlyAYt8eoNNgptp85ozSuxkM=;
        b=qiyt0gXACPOz68OszjSVugCdt4VlLgtfbPVvM18Ft6ZsU0OdBg6U3H/qU6NidSOMnC
         kkMckdRjQNgrCdPwclnQ5Zxr2YQ5Q12aXDGhrx9DJpEAe1vQRKlMbvcr5uC5RsZgkntP
         gy/qw7uaugXi8GPb1TcOX/2/G0fld172U4KE9fHDQ8ZpBq80mwwF4eWyQp4UCGNY4umP
         6dJfOyEc17StJhkcCVP0z6/qHvuzKQ+yj3LVjMGHQSICuZmteaXD+nlPylLmZrs2W5qX
         kuqan28zovwW/kio5KM+3LQsaf1ajpS1qxcz8Vptz5aiEzdog1Hnf6JGiXJ2PDsr/8je
         Nk8Q==
X-Gm-Message-State: AGRZ1gJnpFXpHMgThVVEBx9U8TkGM2OrOIb0RKDsPgc8cdKbawbG6Bnm
        lbLLcGlVD7sCwrfY7/qpJtQCpA==
X-Google-Smtp-Source: AJdET5e4RQjmGf7Y5LCHGUZh9GSy6Fvzs9Y4bDH3tpboGx83iiu0Jce0FHPu48sC2J1+B+Be+HoBMA==
X-Received: by 2002:a63:dd55:: with SMTP id g21mr4294702pgj.86.1542107910969;
        Tue, 13 Nov 2018 03:18:30 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:18:30 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 16/26] drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI voltage regulator
Date:   Tue, 13 Nov 2018 16:46:23 +0530
Message-Id: <20181113111633.20189-17-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards have VCC-DSI pin connected to voltage regulator which may
not be turned on by default.

Add support for such boards by adding voltage regulator handling code to
MIPI DSI driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 703722f7c81b..2ea33db61ae1 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1026,6 +1026,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	}
 
+	dsi->regulator = devm_regulator_get(dev, "vcc-dsi");
+	if (IS_ERR(dsi->regulator)) {
+		dev_err(dev, "Couldn't get VCC-DSI supply\n");
+		return PTR_ERR(dsi->regulator);
+	}
+
 	dsi->regs = devm_regmap_init_mmio_clk(dev, "bus", base,
 					      &sun6i_dsi_regmap_config);
 	if (IS_ERR(dsi->regs)) {
@@ -1107,6 +1113,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
+	int err;
+
+	err = regulator_enable(dsi->regulator);
+	if (err) {
+		dev_err(dsi->dev, "failed to enable VCC-DSI supply: %d\n", err);
+		return err;
+	}
 
 	reset_control_deassert(dsi->reset);
 	if (dsi->variant->has_mod_clk)
@@ -1141,6 +1154,7 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
 	if (dsi->variant->has_mod_clk)
 		clk_disable_unprepare(dsi->mod_clk);
 	reset_control_assert(dsi->reset);
+	regulator_disable(dsi->regulator);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index 597b62227019..0df60f84bab3 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -13,6 +13,8 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
 
+#include <linux/regulator/consumer.h>
+
 struct sun6i_dphy {
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
@@ -32,6 +34,7 @@ struct sun6i_dsi {
 	struct clk		*bus_clk;
 	struct clk		*mod_clk;
 	struct regmap		*regs;
+	struct regulator	*regulator;
 	struct reset_control	*reset;
 	struct sun6i_dphy	*dphy;
 
-- 
2.18.0.321.gffc6fa0e3

