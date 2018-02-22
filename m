Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933285AbeBVQUT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:20:19 -0500
Received: from vps.xff.cz ([195.181.215.36]:52164 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933134AbeBVQUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:20:16 -0500
From: megous@megous.com
To: dev@linux-sunxi.org
Cc: Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR ALLWINNER
        A10),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC] drm/sun4i: Enable the output on the pins (tcon0)
Date: Thu, 22 Feb 2018 17:12:17 +0100
Message-Id: <20180222161217.23904-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

I noticed that with 4.16-rc1 LVDS output on A83T based TBS A711 tablet doesn't
work (there's output but it's garbled). I compared some older patches for LVDS
support with the mainlined ones and this change is missing from mainline Linux.

I don't know what the register does exactly and the harcoded register value
doesn't inspire much confidence that it will work in a general case, so I'm
sending this RFC.

This patch fixes the issue on A83T.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 3c15cf24b503..51740ddb4b32 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -335,6 +335,9 @@ static void sun4i_tcon0_mode_set_lvds(struct sun4i_tcon *tcon,
 	regmap_update_bits(tcon->regs, SUN4I_TCON_GCTL_REG,
 			   SUN4I_TCON_GCTL_IOMAP_MASK,
 			   SUN4I_TCON_GCTL_IOMAP_TCON0);
+
+	/* Enable the output on the pins */
+	regmap_write(tcon->regs, SUN4I_TCON0_IO_TRI_REG, 0xe0000000);
 }
 
 static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
-- 
2.16.2
