Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530ACC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2256721726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C2Q0VDKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731814AbfAXT7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:59:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38791 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbfAXT72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:59:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so3528292pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 11:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Ak/RzbTyrrXIVZkdGtey2LIaf9k4mP2yZqsX+ON3ZQ=;
        b=C2Q0VDKtacLIgo4Mjh++5QTJFI5flCR8BhPzFH1OJGMSW92ZiSnDvX6ObOTGi3Vh+5
         7GdaDav2EZc4+yTV3gCBsh3xebpBRzpcSM0E8wH+xdfQ8F/juUgrG29Ve/3dL2UTWiXv
         bammi2n2cGE1VQH6vo0jsMBdrZlBe0lWufylk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Ak/RzbTyrrXIVZkdGtey2LIaf9k4mP2yZqsX+ON3ZQ=;
        b=b3kut2vEkSbuNVmnPo/zeq/SLhEDLMPHo7M52v4RsGFo/GDT5k1YctmAyIVbq86JXa
         MLjhy/+y0lTYhL+pR+e7iL3s7n8MjPf8VYa6HsUQHdJMcfbD5eg2eg2c6S2+PAejS1sG
         OgQmWZs9yOWOpwbdW5C3Y9XYSPTrNJFoUH561Q2SusHFK/8AlHyCV6+4zoyhSFF0Y34O
         KLUT2mdLbmFavGWg6u29gkZpFtlPGqeYYoQIs9XD49ZWF0TDfoCITkevQ1iqPtWhFylP
         x/WG/f5U896ftxNbtNcaiazEotap+EY/KYGNedPD3G5yrTqkpq0N2NSmyUn9uyqsbSMU
         6N/w==
X-Gm-Message-State: AJcUukegHIMQ48D7nTrxfmcrJSdeNXO3WoypgoKv07RVsGgdfPS9OY8y
        ikZSVKFY11OlQbC+eQV6/YK4tw==
X-Google-Smtp-Source: ALg8bN70Hto641qCAhjyPHIEGxG0+WOYHri2dEXZu/4KY0n5xb4Bmf7S/rYMO8nj1Duk/+WXrZQc4w==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr7244592pgd.49.1548359967683;
        Thu, 24 Jan 2019 11:59:27 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 11:59:27 -0800 (PST)
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
Subject: [PATCH v6 02/22] drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
Date:   Fri, 25 Jan 2019 01:28:40 +0530
Message-Id: <20190124195900.22620-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instruction loop selection would require before writing
loop number registers, so enable idle, LP11 bits on
loop selection register.

Reference code available in BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

(dsi_dev[sel]->dsi_inst_loop_sel.dwval = 2<<(4*DSI_INST_ID_LP11) |
	3<<(4*DSI_INST_ID_DLY);

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a5fcee750bee..813d5523f1c7 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -403,6 +403,9 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 {
 	u16 delay = sun6i_dsi_setup_inst_delay(dsi, mode);
 
+	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_SEL_REG,
+		     DSI_INST_ID_HSC  << (4 * DSI_INST_ID_LP11) |
+		     DSI_INST_ID_HSD  << (4 * DSI_INST_ID_DLY));
 	regmap_write(dsi->regs, SUN6I_DSI_INST_LOOP_NUM_REG(0),
 		     SUN6I_DSI_INST_LOOP_NUM_N0(50 - 1) |
 		     SUN6I_DSI_INST_LOOP_NUM_N1(delay));
-- 
2.18.0.321.gffc6fa0e3

