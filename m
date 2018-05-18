Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbeERJqg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:46:36 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46011 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbeERJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:46:32 -0400
X-Google-Smtp-Source: AB8JxZqutsJCs06Kv5KXOp9A0JIecqZZAXrhy7+8tR6PsZYgzveJOABUOFNvP6WlfKodLmwtiq1uaA==
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 05/26] drm/sun4i: DE2 mixer: Add index quirk
Date: Fri, 18 May 2018 15:15:15 +0530
Message-Id: <20180518094536.17201-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180518094536.17201-1-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

When TCON set up TCON TOP, it needs to know mixer index. Here we do that
by setting engine ID to number provided in mixer index quirk.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- New patch

 drivers/gpu/drm/sun4i/sun8i_mixer.c | 4 ++--
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 126899d6f0d3..36d90c76317a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -353,13 +353,13 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	dev_set_drvdata(dev, mixer);
 	mixer->engine.ops = &sun8i_engine_ops;
 	mixer->engine.node = dev->of_node;
-	/* The ID of the mixer currently doesn't matter */
-	mixer->engine.id = -1;
 
 	mixer->cfg = of_device_get_match_data(dev);
 	if (!mixer->cfg)
 		return -EINVAL;
 
+	mixer->engine.id = mixer->cfg->index;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
 	if (IS_ERR(regs))
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index f34e70c42adf..aeda6e9a7627 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -123,6 +123,7 @@ struct de2_fmt_info {
  *	are invalid.
  * @mod_rate: module clock rate that needs to be set in order to have
  *	a functional block.
+ * @index: mixer index, needed to properly set TCON TOP
  */
 struct sun8i_mixer_cfg {
 	int		vi_num;
@@ -130,6 +131,7 @@ struct sun8i_mixer_cfg {
 	int		scaler_mask;
 	int		ccsc;
 	unsigned long	mod_rate;
+	int		index;
 };
 
 struct sun8i_mixer {
-- 
2.14.3
