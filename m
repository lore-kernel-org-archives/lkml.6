Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C328C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB7620855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JDwATJVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfBAPnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:43:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41340 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbfBAPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:43:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so5364159lfj.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4aZjzTCb7nb2tKftkTHdgQPoUpPvat/+j26yjBhx4a4=;
        b=JDwATJVLIRANYmNxWOY+tdnl8MBY99Uv8xzUB/mvnm/ixBPg0Yk9K6Bw/tuhzo1Rfy
         GIE9GIxYaNphC0QqB4EFcBGfNndjUo975r01z4SrCbqxrdacbAn50p0+CyHl5lnvjPp1
         7R5p90d5SoFMOPTyGw3Z0ELtMH39BCZTt/Z/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aZjzTCb7nb2tKftkTHdgQPoUpPvat/+j26yjBhx4a4=;
        b=Xk1uQ+n6VyEvUH5Rgp2aUnvBcvVCV5sHjAQHX1ds9m5bYhA74U5UtDXPN6Ul+7he3Z
         WHS9JHoLqRT1Sco9JGK9zGlJZUNEVIyV6UR2K/gzG+Odhb53GOMMZQ7jQvOUQVKZAJrg
         fENYayB7YZMcL+O7P2xWqSzJ2hmzBHOvW8FNpcLPYVayWrBucQwiBP3cgJtGvAvcddED
         bhYONyrQ7+3zx43iTapraAiCGbX8QVVRf3PoM0LcTkTuY8ay4McGD8RfPd+Yk8wwgeC7
         qM/bQ1UKs3pNHT29xD40eSkWsQT0gOtRTexAsn1WyOvY1M7WqEMD66dpS8Too2/u62go
         RU6g==
X-Gm-Message-State: AJcUukcNunkZGcxJJJVdCwo01ViIfz3mFksJzoh8GWl0/2PfNjbFfxJj
        69iCpNcwy59f2u3GflkJypniKQ==
X-Google-Smtp-Source: ALg8bN48XbZpc/7XwnNE112fo8VcA1h2Tot+eMsP4TZ3TubNUgilRPPeFrZUr5WpmZiFVxYgbc+Knw==
X-Received: by 2002:a19:7919:: with SMTP id u25mr32430275lfc.18.1549035792565;
        Fri, 01 Feb 2019 07:43:12 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:43:11 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 16/23] drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI DSI support
Date:   Fri,  1 Feb 2019 21:12:25 +0530
Message-Id: <20190201154232.10505-17-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller in Allwinner A64 is similar to A33.

But unlike A33, A64 doesn't have DSI_SCLK gating so add compatible
for Allwinner A64 with uninitialized has_mod_clk driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index de7d9dcb049f..a0697d78b915 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1252,11 +1252,18 @@ static const struct sun6i_dsi_variant sun6i_a31_mipi_dsi = {
 	.has_mod_clk = true,
 };
 
+static const struct sun6i_dsi_variant sun50i_a64_mipi_dsi = {
+};
+
 static const struct of_device_id sun6i_dsi_of_table[] = {
 	{
 		.compatible = "allwinner,sun6i-a31-mipi-dsi",
 		.data = &sun6i_a31_mipi_dsi,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-mipi-dsi",
+		.data = &sun50i_a64_mipi_dsi,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
-- 
2.18.0.321.gffc6fa0e3

