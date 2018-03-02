Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947089AbeCBR7b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:59:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48708 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947001AbeCBR6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:58:18 -0500
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
Subject: [PATCH v9 2/5] drm/rockchip: inno_hdmi: Fix error handling path.
Date: Fri,  2 Mar 2018 18:57:54 +0100
Message-Id: <20180302175757.28192-3-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180302175757.28192-1-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

Add missing error handling in bind().

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
[moved clk_disable_unprepare reordering in unbind to separate patch]
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v9:
- Moved clk_disable_unprepare reordering in unbin to separate patch.

 drivers/gpu/drm/rockchip/inno_hdmi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index f6ad48766d49..a5c661930250 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -849,8 +849,10 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err_disable_clk;
+	}
 
 	inno_hdmi_reset(hdmi);
 
@@ -858,7 +860,7 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	if (IS_ERR(hdmi->ddc)) {
 		ret = PTR_ERR(hdmi->ddc);
 		hdmi->ddc = NULL;
-		return ret;
+		goto err_disable_clk;
 	}
 
 	/*
@@ -872,7 +874,7 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 
 	ret = inno_hdmi_register(drm, hdmi);
 	if (ret)
-		return ret;
+		goto err_put_adapter;
 
 	dev_set_drvdata(dev, hdmi);
 
@@ -882,7 +884,17 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	ret = devm_request_threaded_irq(dev, irq, inno_hdmi_hardirq,
 					inno_hdmi_irq, IRQF_SHARED,
 					dev_name(dev), hdmi);
+	if (ret < 0)
+		goto err_cleanup_hdmi;
 
+	return 0;
+err_cleanup_hdmi:
+	hdmi->connector.funcs->destroy(&hdmi->connector);
+	hdmi->encoder.funcs->destroy(&hdmi->encoder);
+err_put_adapter:
+	i2c_put_adapter(hdmi->ddc);
+err_disable_clk:
+	clk_disable_unprepare(hdmi->pclk);
 	return ret;
 }
 
-- 
2.16.1
