Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665DAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EE62245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VFv7Hyja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EE62245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732607AbeKMVPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:15:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33601 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732525AbeKMVO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:14:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id w22-v6so5865245plk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHVyHtVc0G3Kpp5cjsZwGbecU0Xlg/ozATiwaeVvdoQ=;
        b=VFv7HyjaAFJVaEpP0/tABHxGq9IG4jR4+I+ksUJUO56HgHnRyQwSzsCIK68DbCybw1
         vIx4QZL+RqAdezl0G/qE/QDPM9XmIrkJoPA114b73R/wMKK+pw+RpJm3SzxUs4pxA1tB
         6WtQSPm2Hlt2w49QSHNL4CJek4wA+aQVJ8Uu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHVyHtVc0G3Kpp5cjsZwGbecU0Xlg/ozATiwaeVvdoQ=;
        b=Cmy9BkEGk2+rYbdVgYaGWX1Esj4jJdLI8BLbriCqckXHIFcY1MNICPaTcz9ShvzHou
         75hJEML9LxdUa8uLy15AMkJgpRx0xpaMJtUUGS8D7FqDXL652vL+fB+HNP0U7Nj9aRu+
         z4ahs6SKZcMdVMlS/k8hycEHuKqqzmItfezUAq4EPsuvUpH7JoBLStMDpG/Mu1csXo9d
         wz6gFU8Sze4Tvt/eYPk9RgMn3BBzCGadeQm+HyeoXfLrG7eMBC4Rdd1RqwzKWIJLASbT
         u7kTygzj0RC2/cX3LHCgc3gy9CcTky+tDdF4AVx6QyLTWo9gAg3MiQ9kDNaRI3xyhAch
         r+VQ==
X-Gm-Message-State: AGRZ1gK5+YtmmFlQ9ZGNQQuoE7k92jjmrWQqPW/85EHaoOPzDxN9ZQAV
        cIwfsPw3kCtueutEooQfqIMriw==
X-Google-Smtp-Source: AJdET5c/DumAFiebpmj/z+JBlCmyxGzrIbyf8IeI/aUzuNs2L2St6T79kpwLkVA0B9wa9RjOhBEHNw==
X-Received: by 2002:a17:902:bf03:: with SMTP id bi3-v6mr4742841plb.288.1542107841544;
        Tue, 13 Nov 2018 03:17:21 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:17:20 -0800 (PST)
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
Subject: [PATCH v4 05/26] drm/sun4i: sun6i_mipi_dsi: Add Allwinner A64 MIPI DSI support
Date:   Tue, 13 Nov 2018 16:46:12 +0530
Message-Id: <20181113111633.20189-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller on Allwinner A64 is similar to
Allwinner A31 without support of DSI mod clock(CLK_DSI_SCLK)

So, alter has_mod_clk bool via driver data for respective
SoC's compatible.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 561de393ea23..50f535ae57e9 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1120,11 +1120,18 @@ static const struct sun6i_dsi_variant sun6i_a31_dsi = {
 	.has_mod_clk = true,
 };
 
+static const struct sun6i_dsi_variant sun50i_a64_dsi = {
+};
+
 static const struct of_device_id sun6i_dsi_of_table[] = {
 	{
 		.compatible = "allwinner,sun6i-a31-mipi-dsi",
 		.data = &sun6i_a31_dsi,
 	},
+	{
+		.compatible = "allwinner,sun50i-a64-mipi-dsi",
+		.data = &sun50i_a64_dsi,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dsi_of_table);
-- 
2.18.0.321.gffc6fa0e3

