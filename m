Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753752AbeCEWZu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:25:50 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37780 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753627AbeCEWZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:25:02 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: architt@codeaurora.org, inki.dae@samsung.com, thierry.reding@gmail.com,
        hjc@rock-chips.com, seanpaul@chromium.org, airlied@linux.ie,
        tfiga@chromium.org, heiko@sntech.de
Cc: hshi@chromium.org, wzz@rock-chips.com, hl@rock-chips.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        orjan.eide@arm.com, m.szyprowski@samsung.com,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 30/38] drm/bridge: analogix_dp: Split the platform-specific poweron in two parts
Date: Mon,  5 Mar 2018 23:23:22 +0100
Message-Id: <20180305222324.5872-31-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
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
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  7 +++++--
 drivers/gpu/drm/exynos/exynos_dp.c                 |  2 +-
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 12 ++++++++++--
 include/drm/bridge/analogix_dp.h                   |  3 ++-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index edaca650e6d2..8703c3cc5ff8 100644
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
2.16.1
