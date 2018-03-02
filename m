Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947076AbeCBR7M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:59:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48726 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947002AbeCBR6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:58:19 -0500
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
Subject: [PATCH v9 3/5] drm/rockchip: inno_hdmi: reorder clk_disable_unprepare call in unbind
Date: Fri,  2 Mar 2018 18:57:55 +0100
Message-Id: <20180302175757.28192-4-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180302175757.28192-1-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

In bind the clk_prepare_enable of the HDMI pclk is called before adding the
i2c_adapter. So it should be the other way around in unbind, first remove
the i2c_adapter and then call the clk_disable_unprepare.

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v9:
- Added new patch to reorder clk_disable_unprepare call in inno_hdmi
  unbind()

 drivers/gpu/drm/rockchip/inno_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index a5c661930250..88d0774c97bd 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -906,8 +906,8 @@ static void inno_hdmi_unbind(struct device *dev, struct device *master,
 	hdmi->connector.funcs->destroy(&hdmi->connector);
 	hdmi->encoder.funcs->destroy(&hdmi->encoder);
 
-	clk_disable_unprepare(hdmi->pclk);
 	i2c_put_adapter(hdmi->ddc);
+	clk_disable_unprepare(hdmi->pclk);
 }
 
 static const struct component_ops inno_hdmi_ops = {
-- 
2.16.1
