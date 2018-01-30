Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeA3U3q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:29:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56234 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbeA3U3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:43 -0500
From: Thierry Escande <thierry.escande@collabora.com>
To: Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Haixia Shi <hshi@chromium.org>,
        =?UTF-8?q?=C3=98rjan=20Eide?= <orjan.eide@arm.com>,
        Zain Wang <wzz@rock-chips.com>, Yakir Yang <ykk@rock-chips.com>,
        Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Mark Yao <mark.yao@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 19/43] drm/bridge: analogix_dp: Ensure edp is disabled when shutting down the panel
Date: Tue, 30 Jan 2018 21:28:49 +0100
Message-Id: <20180130202913.28724-20-thierry.escande@collabora.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180130202913.28724-1-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset = "utf-8"
Content-Transfert-Encoding: 8bit
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

When panel is shut down, we should make sure edp can be disabled to avoid
undefined behavior.

Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index c940a5bb80ac..fa4ef28e286f 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1161,6 +1161,12 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 
 	pm_runtime_get_sync(dp->dev);
 
+	ret = clk_prepare_enable(dp->clock);
+	if (ret < 0) {
+		DRM_ERROR("Failed to prepare_enable the clock clk [%d]\n", ret);
+		goto out_dp_clk_pre;
+	}
+
 	if (dp->plat_data->power_on)
 		dp->plat_data->power_on(dp->plat_data);
 
@@ -1192,6 +1198,8 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 	phy_power_off(dp->phy);
 	if (dp->plat_data->power_off)
 		dp->plat_data->power_off(dp->plat_data);
+	clk_disable_unprepare(dp->clock);
+out_dp_clk_pre:
 	pm_runtime_put_sync(dp->dev);
 
 	return ret;
@@ -1235,10 +1243,13 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 
 	disable_irq(dp->irq);
 	phy_power_off(dp->phy);
+	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
 
 	if (dp->plat_data->power_off)
 		dp->plat_data->power_off(dp->plat_data);
 
+	clk_disable_unprepare(dp->clock);
+
 	pm_runtime_put_sync(dp->dev);
 
 	ret = analogix_dp_prepare_panel(dp, false, true);
-- 
2.14.1
