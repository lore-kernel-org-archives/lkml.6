Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162158AbeCAVfQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:35:16 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:33171 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161792AbeCAVfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:35:09 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 06/16] drm/sun4i: Release exclusive clock lock when disabling TCON
Date: Thu,  1 Mar 2018 22:34:32 +0100
Message-Id: <20180301213442.16677-7-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301213442.16677-1-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently exclusive TCON clock lock is never released, which, for
example, prevents changing resolution on HDMI.

In order to fix that, release clock when disabling TCON. TCON is always
disabled first before new mode is set.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 1d714c06ec9d..7f6c4125c89f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -102,10 +102,12 @@ static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
 		return;
 	}
 
-	if (enabled)
+	if (enabled) {
 		clk_prepare_enable(clk);
-	else
+	} else {
+		clk_rate_exclusive_put(clk);
 		clk_disable_unprepare(clk);
+	}
 }
 
 static void sun4i_tcon_lvds_set_status(struct sun4i_tcon *tcon,
-- 
2.16.2
