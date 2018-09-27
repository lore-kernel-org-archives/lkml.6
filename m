Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E543EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF8C21531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NNPTAF1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF8C21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeI0SHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:07:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34206 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeI0SHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:07:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so1756548pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evIzUViMtSitn37dGrQoWQvRjD//VkqNrRvm4lXczmM=;
        b=NNPTAF1U4bEogAjUdNiqrIQHZg8GLgBKsga6evkO5zcEw2gwBz2qF0pt0Fe+Rx4gm0
         dnZt7VSEI1m0A0yX79IL1dV5jnvpQF80lmWVqJisCd6Wzpuh6yYphE+O3xLxMN330Ycr
         +z+cHLXgV3x13uVBhj0/6hXXMbwAghtwrjDo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evIzUViMtSitn37dGrQoWQvRjD//VkqNrRvm4lXczmM=;
        b=K1x3P1N62hpGTwXwf2XUGIISgSVZhsbU6ve2yl2jKauUMReNqcxtjXAsDM3ZFQMe8P
         vNAXvZvB3lDCVN4aA8Zq84+ANgXBGEJsqtTwPgz1CBGi5Bmc2N4w3QV4r6nZDBSF9UJe
         7PPNuhC2SQkAjASuCxtl6Lko4u6kE4KxmwzwloK0GDiampIq3eM1GjO+XPWDZyx5RgPH
         VjUx2yrujbepG/2PiJcP//cXV4GyXKM2nqPZJrE5jo2idB8TywP4RzeVdZHFiTFsfnUn
         Fza+SOINiueZYkLvA6074kdKyJXzfnnc1bSl2M3tuGfCiT4hj7kw2wIdcaPWxbVNYfvl
         AeRw==
X-Gm-Message-State: ABuFfohh3XXM+kohO+NHMCYVJs8H4wxzKKwgbFbigwrVJBdGJ46ltTRn
        FTHo9h6dV+UImoONyll6JbwIRA==
X-Google-Smtp-Source: ACcGV62ZFmQwjQws/+ouyXzbnrxyyZGVERygjSkmC5OOlNytyjL5JB3pypWcGjIxaP09zerRD1ysyA==
X-Received: by 2002:a63:d646:: with SMTP id d6-v6mr667310pgj.450.1538048983513;
        Thu, 27 Sep 2018 04:49:43 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.83])
        by smtp.gmail.com with ESMTPSA id v36-v6sm3744872pgn.85.2018.09.27.04.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 04:49:42 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 04/12] drm/sun4i: sun6i_mipi_dsi: Enable missing DSI bus clock
Date:   Thu, 27 Sep 2018 17:18:42 +0530
Message-Id: <20180927114850.24565-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180927114850.24565-1-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI bus_clk is already available in sun6i_dsi but missed to
get the clk and process for enable/disable.

This patch add support for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 8e9c76febca2..156b371243c6 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1004,6 +1004,12 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->reset);
 	}
 
+	dsi->bus_clk = devm_clk_get(dev, "bus");
+	if (IS_ERR(dsi->bus_clk)) {
+		dev_err(dev, "Couldn't get the DSI bus clock\n");
+		return PTR_ERR(dsi->bus_clk);
+	}
+
 	if (dsi->variant->has_mod_clk) {
 		dsi->mod_clk = devm_clk_get(dev, "mod");
 		if (IS_ERR(dsi->mod_clk)) {
@@ -1012,6 +1018,7 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		}
 	}
 
+	clk_prepare_enable(dsi->bus_clk);
 	/*
 	 * In order to operate properly, that clock seems to be always
 	 * set to 297MHz.
@@ -1065,6 +1072,7 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	sun6i_dphy_remove(dsi);
 	if (dsi->variant->has_mod_clk)
 		clk_rate_exclusive_put(dsi->mod_clk);
+	clk_disable_unprepare(dsi->bus_clk);
 
 	return 0;
 }
-- 
2.18.0.321.gffc6fa0e3

