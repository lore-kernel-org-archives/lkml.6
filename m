Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755177AbeDWKyC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:54:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39058 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755032AbeDWKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:51:05 -0400
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
        hshi@chromium.org, "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [RESEND PATCH v6 22/27] drm/bridge: analogix_dp: Split the platform-specific poweron in two parts
Date: Mon, 23 Apr 2018 12:49:58 +0200
Message-Id: <20180423105003.9004-23-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
References: <20180423105003.9004-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

Some of the platform-specific stuff in rockchip_dp_poweron() needs to
happen before the generic code.  Some needs to happen after.  Let's
split the callback in two.

Specifically we can't start doing PSR work until _after_ the whole
controller is up, so don't set the enable until the end.

Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
[seanpaul added exynos change]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  7 +++++--
 drivers/gpu/drm/exynos/exynos_dp.c                 |  2 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 12 ++++++++++--
 include/drm/bridge/analogix_dp.h                   |  3 ++-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index a260de4f0bd8..2bcbfadb6ac5 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1260,8 +1260,8 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 		goto out_dp_clk_pre;
 	}
 
-	if (dp->plat_data->power_on)
-		dp->plat_data->power_on(dp->plat_data);
+	if (dp->plat_data->power_on_start)
+		dp->plat_data->power_on_start(dp->plat_data);
 
 	phy_power_on(dp->phy);
 
@@ -1286,6 +1286,9 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 		goto out_dp_init;
 	}
 
+	if (dp->plat_data->power_on_end)
+		dp->plat_data->power_on_end(dp->plat_data);
+
 	enable_irq(dp->irq);
 	return 0;
 
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index 964831dab102..86330f396784 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -162,7 +162,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
 	dp->drm_dev = drm_dev;
 
 	dp->plat_data.dev_type = EXYNOS_DP;
-	dp->plat_data.power_on = exynos_dp_poweron;
+	dp->plat_data.power_on_start = exynos_dp_poweron;
 	dp->plat_data.power_off = exynos_dp_poweroff;
 	dp->plat_data.attach = exynos_dp_bridge_attach;
 	dp->plat_data.get_modes = exynos_dp_get_modes;
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index b3f46ed24cdc..23317a2269e1 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -109,7 +109,7 @@ static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
 	return 0;
 }
 
-static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
+static int rockchip_dp_poweron_start(struct analogix_dp_plat_data *plat_data)
 {
 	struct rockchip_dp_device *dp = to_dp(plat_data);
 	int ret;
@@ -127,6 +127,13 @@ static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
 		return ret;
 	}
 
+	return ret;
+}
+
+static int rockchip_dp_poweron_end(struct analogix_dp_plat_data *plat_data)
+{
+	struct rockchip_dp_device *dp = to_dp(plat_data);
+
 	return rockchip_drm_psr_activate(&dp->encoder);
 }
 
@@ -330,7 +337,8 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 	dp->plat_data.encoder = &dp->encoder;
 
 	dp->plat_data.dev_type = dp->data->chip_type;
-	dp->plat_data.power_on = rockchip_dp_poweron;
+	dp->plat_data.power_on_start = rockchip_dp_poweron_start;
+	dp->plat_data.power_on_end = rockchip_dp_poweron_end;
 	dp->plat_data.power_off = rockchip_dp_powerdown;
 	dp->plat_data.get_modes = rockchip_dp_get_modes;
 
diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
index e9a1116d2f8e..475b706b49de 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -33,7 +33,8 @@ struct analogix_dp_plat_data {
 	struct drm_connector *connector;
 	bool skip_connector;
 
-	int (*power_on)(struct analogix_dp_plat_data *);
+	int (*power_on_start)(struct analogix_dp_plat_data *);
+	int (*power_on_end)(struct analogix_dp_plat_data *);
 	int (*power_off)(struct analogix_dp_plat_data *);
 	int (*attach)(struct analogix_dp_plat_data *, struct drm_bridge *,
 		      struct drm_connector *);
-- 
2.17.0
