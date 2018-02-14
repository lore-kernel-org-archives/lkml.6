Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031296AbeBNUQb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:16:31 -0500
Received: from mailoutvs4.siol.net ([213.250.19.137]:36730 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031325AbeBNUJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:09:41 -0500
From: Jernej Skrabec <jernej.skrabec@siol.net>
To: maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com
Cc: jernej.skrabec@siol.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v5 03/12] drm/bridge/synopsys: dw-hdmi: Enable workaround for v1.32a
Date: Wed, 14 Feb 2018 21:08:57 +0100
Message-Id: <20180214200906.31509-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180214200906.31509-1-jernej.skrabec@siol.net>
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner SoCs have dw hdmi controller v1.32a which exhibits same
magenta line issue as i.MX6Q and i.MX6DL. Enable workaround for it.

Tests show that one iteration is enough.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index a38db40ce990..7ca14d7325b5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1634,9 +1634,10 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 	 * then write one of the FC registers several times.
 	 *
 	 * The number of iterations matters and depends on the HDMI TX revision
-	 * (and possibly on the platform). So far only i.MX6Q (v1.30a) and
-	 * i.MX6DL (v1.31a) have been identified as needing the workaround, with
-	 * 4 and 1 iterations respectively.
+	 * (and possibly on the platform). So far i.MX6Q (v1.30a), i.MX6DL
+	 * (v1.31a) and multiple Allwinner SoCs (v1.32a) have been identified
+	 * as needing the workaround, with 4 iterations for v1.30a and 1
+	 * iteration for others.
 	 */
 
 	switch (hdmi->version) {
@@ -1644,6 +1645,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
 		count = 4;
 		break;
 	case 0x131a:
+	case 0x132a:
 		count = 1;
 		break;
 	default:
-- 
2.16.1
