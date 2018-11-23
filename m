Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BCFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0475F20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uuIUs128"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0475F20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504610AbeKXAqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:46:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46347 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388620AbeKXAqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:46:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so12436994wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 06:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6neJLTpBin4DVsYLiqj428FtdsYuJZgCkxB/kTMWMc=;
        b=uuIUs128AACwGfdXPAHeCrKkJ/0sHj6YLHrYwscTB00RCysXIJ4cqrhoekdp6h1BV7
         lTrfLudgUmHw6dLknH29WZuDLPZ8n89FzASN1C0HFPwnRzPgwvaZ0Ii5t7u0qol6Y8K4
         wTm4AbF8INAh6gRF+nEmnuizWUxZfDJegOP91u2ZB5kP4RuDHWVXR3DkNoTCq4kEdFUm
         Ii+I318+GB7+4NbMVZXd1/KYaDI+to35X7O5DVDu9nJ9pw+f8nr/m60NeJv9id4QgVC7
         lv4fozusJl0tX6kuLUk0wmUQ4nJX4Mg7QqWkD8di6ndV85j3SuDrNCWHyKLhaT6zgXQn
         dyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C6neJLTpBin4DVsYLiqj428FtdsYuJZgCkxB/kTMWMc=;
        b=VyaXHmtoYJtCG1IyQldnNOTeoC6kj/Ek5ITX1wakDOC1z3LenYmYUgwOhmBHQf6IP4
         igmZHR7wUgcf2fr3jE9EcFNd0zL/PG5Q5/Nk02g40+QTrYLrKtQQ1CBDHK6qNCg4Gtss
         wnig44D4w0vX4nu1w9w7qMGf+Wj49BUDbde8R4BzPVV0lXOyJveNkFUQx1Z9fwRIchzC
         K9sIX4jXT/Fg3HtChkvk+txUk2v4wQzNGdSaG9jgPn/muep+RL+NcCL5XAx8yxw4em9u
         67C3iNirSQ5UG4kZu/h7E1I7xRjtKgg0a58taV9vPoZx6lmUYaIFMYyYHPIA3EmS7KnO
         h33w==
X-Gm-Message-State: AA+aEWb8YCJIAuSfuBVzlNx8iqn+DLhdAwPRrFZwdDQAuKM51S0KJMKz
        APum7Fkkla/iHRmJQIaj3yLPeg==
X-Google-Smtp-Source: AFSGD/V6Q4HaeuAw4UE1omdxl8oGKEwfebqNpAKjR7MIrnwe1yZE6sDCa2cYBsXXg9Mc7spICCNYDw==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr13342067wrn.104.1542981750503;
        Fri, 23 Nov 2018 06:02:30 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x8sm15172185wrd.53.2018.11.23.06.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 06:02:29 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/8] drm/meson: add HDMI div40 TMDS mode
Date:   Fri, 23 Nov 2018 15:02:15 +0100
Message-Id: <20181123140221.15700-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123140221.15700-1-narmstrong@baylibre.com>
References: <20181123140221.15700-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for TMDS Clock > 3.4GHz for HDMI2.0 display modes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index d8c5cc34e22e..118c49e054b0 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -365,7 +365,8 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	unsigned int wr_clk =
 		readl_relaxed(priv->io_base + _REG(VPU_HDMI_SETTING));
 
-	DRM_DEBUG_DRIVER("%d:\"%s\"\n", mode->base.id, mode->name);
+	DRM_DEBUG_DRIVER("%d:\"%s\" div%d\n", mode->base.id, mode->name,
+			 mode->clock > 340000 ? 40 : 10);
 
 	/* Enable clocks */
 	regmap_update_bits(priv->hhi, HHI_HDMI_CLK_CNTL, 0xffff, 0x100);
@@ -385,9 +386,17 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	/* Enable normal output to PHY */
 	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_BIST_CNTL, BIT(12));
 
-	/* TMDS pattern setup (TOFIX pattern for 4k2k scrambling) */
-	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01, 0x001f001f);
-	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23, 0x001f001f);
+	/* TMDS pattern setup (TOFIX Handle the YUV420 case) */
+	if (mode->clock > 340000) {
+		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01, 0);
+		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
+				  0x03ff03ff);
+	} else {
+		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_01,
+				  0x001f001f);
+		dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_23,
+				  0x001f001f);
+	}
 
 	/* Load TMDS pattern */
 	dw_hdmi_top_write(dw_hdmi, HDMITX_TOP_TMDS_CLK_PTTN_CNTL, 0x1);
@@ -413,6 +422,8 @@ static int dw_hdmi_phy_init(struct dw_hdmi *hdmi, void *data,
 	/* Disable clock, fifo, fifo_wr */
 	regmap_update_bits(priv->hhi, HHI_HDMI_PHY_CNTL1, 0xf, 0);
 
+	dw_hdmi_set_high_tmds_clock_ratio(hdmi);
+
 	msleep(100);
 
 	/* Reset PHY 3 times in a row */
@@ -562,6 +573,11 @@ dw_hdmi_mode_valid(struct drm_connector *connector,
 		mode->vdisplay, mode->vsync_start,
 		mode->vsync_end, mode->vtotal, mode->type, mode->flags);
 
+	/* If sink max TMDS clock < 340MHz, we reject the HDMI2.0 modes */
+	if (mode->clock > 340000 &&
+	    connector->display_info.max_tmds_clock < 340000)
+		return MODE_BAD;
+
 	/* Check against non-VIC supported modes */
 	if (!vic) {
 		status = meson_venc_hdmi_supported_mode(mode);
-- 
2.19.1

