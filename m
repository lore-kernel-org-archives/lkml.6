Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947015AbeCBR6U (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:58:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48680 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947000AbeCBR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:58:16 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        linux-rockchip@lists.infradead.org,
        Archit Taneja <architt@codeaurora.org>, linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>, kernel@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v9 1/5] drm/rockchip: dw-mipi-dsi: Fix connector and encoder cleanup.
Date: Fri,  2 Mar 2018 18:57:53 +0100
Message-Id: <20180302175757.28192-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180302175757.28192-1-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

In bind()'s error handling path call destroy functions instead of
cleanup functions for encoder and connector and reorder to match how is
called in bind().

In unbind() call the connector and encoder destroy functions.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v9:
- Removed the pm_runtime_disable call as is not really needed.

 drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
index 591953cbdd18..d53d5a09547f 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -1302,8 +1302,8 @@ static int dw_mipi_dsi_bind(struct device *dev, struct device *master,
 err_mipi_dsi_host:
 	mipi_dsi_host_unregister(&dsi->dsi_host);
 err_cleanup:
-	drm_encoder_cleanup(&dsi->encoder);
-	drm_connector_cleanup(&dsi->connector);
+	dsi->connector.funcs->destroy(&dsi->connector);
+	dsi->encoder.funcs->destroy(&dsi->encoder);
 err_pllref:
 	clk_disable_unprepare(dsi->pllref_clk);
 	return ret;
@@ -1316,6 +1316,10 @@ static void dw_mipi_dsi_unbind(struct device *dev, struct device *master,
 
 	mipi_dsi_host_unregister(&dsi->dsi_host);
 	pm_runtime_disable(dev);
+
+	dsi->connector.funcs->destroy(&dsi->connector);
+	dsi->encoder.funcs->destroy(&dsi->encoder);
+
 	clk_disable_unprepare(dsi->pllref_clk);
 }
 
-- 
2.16.1
