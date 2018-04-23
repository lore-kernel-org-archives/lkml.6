Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755009AbeDWKxp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:53:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39086 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755143AbeDWKvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:51:07 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: dri-devel@lists.freedesktop.org, dianders@chromium.org,
        a.hajda@samsung.com, kernel@collabora.com, m.szyprowski@samsung.com,
        linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com,
        rydberg@bitmath.org, krzk@kernel.org,
        linux-rockchip@lists.infradead.org, kgene@kernel.org,
        orjan.eide@arm.com, wxt@rock-chips.com, jeffy.chen@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, wzz@rock-chips.com,
        hl@rock-chips.com, jingoohan1@gmail.com, sw0312.kim@samsung.com,
        linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
        Laurent.pinchart@ideasonboard.com, kuankuan.y@gmail.com,
        hshi@chromium.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [RESEND PATCH v6 23/27] drm/rockchip: analogix_dp: Do not call Analogix code before bind
Date: Mon, 23 Apr 2018 12:49:59 +0200
Message-Id: <20180423105003.9004-24-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
References: <20180423105003.9004-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tfiga@chromium.org>

Driver callbacks, such as system suspend or resume can be called any
time, specifically they can be called before the component bind
callback. Let's use dp->adp pointer as a safeguard and skip calling
Analogix entry points if it is an ERR_PTR().

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 23317a2269e1..6d45d62466b3 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -368,6 +368,8 @@ static void rockchip_dp_unbind(struct device *dev, struct device *master,
 	analogix_dp_unbind(dp->adp);
 	rockchip_drm_psr_unregister(&dp->encoder);
 	dp->encoder.funcs->destroy(&dp->encoder);
+
+	dp->adp = ERR_PTR(-ENODEV);
 }
 
 static const struct component_ops rockchip_dp_component_ops = {
@@ -391,6 +393,7 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dp->dev = dev;
+	dp->adp = ERR_PTR(-ENODEV);
 	dp->plat_data.panel = panel;
 
 	ret = rockchip_dp_of_probe(dp);
@@ -414,6 +417,9 @@ static int rockchip_dp_suspend(struct device *dev)
 {
 	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
 
+	if (IS_ERR(dp->adp))
+		return 0;
+
 	return analogix_dp_suspend(dp->adp);
 }
 
@@ -421,6 +427,9 @@ static int rockchip_dp_resume(struct device *dev)
 {
 	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
 
+	if (IS_ERR(dp->adp))
+		return 0;
+
 	return analogix_dp_resume(dp->adp);
 }
 #endif
-- 
2.17.0
