Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 46020C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0726220891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0726220891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934780AbeFLUH2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:07:28 -0400
Received: from mailoutvs63.siol.net ([185.57.226.254]:38482 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934236AbeFLUCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:02:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 51157521F5C;
        Tue, 12 Jun 2018 22:02:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4YsOfnwjD-Qi; Tue, 12 Jun 2018 22:02:15 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id C82D1521DC5;
        Tue, 12 Jun 2018 22:02:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPSA id 4EC07521ED2;
        Tue, 12 Jun 2018 22:02:13 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org
Cc:     airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        mark.rutland@arm.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v2 11/27] drm/sun4i: tcon: Add support for tcon-top gate
Date:   Tue, 12 Jun 2018 22:00:20 +0200
Message-Id: <20180612200036.21483-12-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TV TCONs connected to TCON TOP have to enable additional gate in order
to work.

Add support for such TCONs.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 08747fc3ee71..0afb5a94a414 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 		dev_err(dev, "Couldn't get the TCON bus clock\n");
 		return PTR_ERR(tcon->clk);
 	}
+
+	if (tcon->quirks->has_tcon_top_gate) {
+		tcon->top_clk = devm_clk_get(dev, "tcon-top");
+		if (IS_ERR(tcon->top_clk)) {
+			dev_err(dev, "Couldn't get the TCON TOP bus clock\n");
+			return PTR_ERR(tcon->top_clk);
+		}
+		clk_prepare_enable(tcon->top_clk);
+	}
+
 	clk_prepare_enable(tcon->clk);
 
 	if (tcon->quirks->has_channel_0) {
@@ -712,6 +722,7 @@ static int sun4i_tcon_init_clocks(struct device *dev,
 static void sun4i_tcon_free_clocks(struct sun4i_tcon *tcon)
 {
 	clk_disable_unprepare(tcon->clk);
+	clk_disable_unprepare(tcon->top_clk);
 }
 
 static int sun4i_tcon_init_irq(struct device *dev,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index f6a071cd5a6f..652d5c37d7b4 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -224,6 +224,7 @@ struct sun4i_tcon_quirks {
 	bool	needs_de_be_mux; /* sun6i needs mux to select backend */
 	bool    needs_edp_reset; /* a80 edp reset needed for tcon0 access */
 	bool	supports_lvds;   /* Does the TCON support an LVDS output? */
+	bool	has_tcon_top_gate;  /* TCON TOP holds additional gate to enable */
 
 	/* callback to handle tcon muxing options */
 	int	(*set_mux)(struct sun4i_tcon *, const struct drm_encoder *);
@@ -249,6 +250,9 @@ struct sun4i_tcon {
 	u8				dclk_max_div;
 	u8				dclk_min_div;
 
+	/* TCON TOP clock */
+	struct clk			*top_clk;
+
 	/* Reset control */
 	struct reset_control		*lcd_rst;
 	struct reset_control		*lvds_rst;
-- 
2.17.1

