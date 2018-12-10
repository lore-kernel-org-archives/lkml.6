Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E882AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A900020672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bdtJzKSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A900020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbeLJQSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:18:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36140 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeLJQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:18:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so11120111wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=00q3XfiQq5Un+1gbOZybpEVXgQFaLUYl4K2oxVIJvfo=;
        b=bdtJzKSohaqs/xFQ2lRdqluAHitNCxTJ1T6qCPzDp+8cSpK9Aw/9HNW92lxNV7Vvka
         E4MU+osHjfuP/ALbPKdi66NNY2T/cjiBTxu/yeFbZ3cIRY3t8oSic3Ni78g7wAHTxlue
         pGlOkVwv0gak1VI8qe1BqgCfWDpDW3tBJLUEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00q3XfiQq5Un+1gbOZybpEVXgQFaLUYl4K2oxVIJvfo=;
        b=L+b/MekliAXWjof21ULzIpw4HbI1q0sRmclryoJIQLIFSR5cPOfOVtanAmypyCv8p7
         EhDd1TGwbzO4gtsfO41pddHme7Iv50rYb6KcjU5/ZajUzGBPnbPGlOdE1VxqU9YlPnC4
         TadJVg0tfl03KG3KhUgm2qrBDm8NaigfOx2SFdmElE+1r+tJFUnREFa4w4UnI8A3WJ/F
         JxosKZ9cCr41AalRdHOVQfprbbDQGfb2GAtQ2q6FoMNtpOPvKvrkXklTPQNfjOVAk5Vo
         sq75ShjXyQ3a0gmzKY2+b7lq5c5TJK3DA9WNn4Tnqmf5rfcSMLKBV8Q9aafY/DvOhkYn
         QBCw==
X-Gm-Message-State: AA+aEWZQFvDkebI9nhbKsmzq9Ir1Xe3R4nojv/+OyYAccGQtRhV6bxaB
        0oYyrDM9Aj/hKXZnBOjtSd6Jzg==
X-Google-Smtp-Source: AFSGD/WIIhGNAtofTDEjWfZNJq8NHZ5r84pdS+Vg4KRajzLQ+W2qdsgCoQZTkL+O2cEpDZQpEY9rfg==
X-Received: by 2002:adf:a28d:: with SMTP id s13mr11073625wra.100.1544458686730;
        Mon, 10 Dec 2018 08:18:06 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:18:05 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 13/17] drm/sun4i: sun6i_mipi_dsi: Add support for VCC-DSI voltage regulator
Date:   Mon, 10 Dec 2018 21:47:25 +0530
Message-Id: <20181210161729.29720-14-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
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
index cbcef7bf7681..a87b65fff0e0 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1023,6 +1023,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
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
@@ -1104,6 +1110,13 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
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
@@ -1138,6 +1151,7 @@ static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
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

