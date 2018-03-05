Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbeCEW00 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:26:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37690 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753573AbeCEWYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:24:47 -0500
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
Subject: [PATCH v4 26/38] drm/bridge: analogix_dp: Reorder plat_data->power_off to happen sooner
Date: Mon,  5 Mar 2018 23:23:18 +0100
Message-Id: <20180305222324.5872-27-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305222324.5872-1-enric.balletbo@collabora.com>
References: <20180305222324.5872-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

The current user of the analogix power_off is "analogix_dp-rockchip".
That driver does this:
- deactivate PSR
- turn off a clock

Both of these things (especially deactive PSR) should be done before
we turn the PHY power off and turn off analog power.  Let's move the
callback up.

Note that without this patch (and with
https://patchwork.kernel.org/patch/9553349/ [seanpaul: this patch was
not applied, but it seems like the race can still occur]), I experienced
an error in reboot testing where one thread was at:

  rockchip_drm_psr_deactivate
  rockchip_dp_powerdown
  analogix_dp_bridge_disable
  drm_bridge_disable

...and the other thread was at:

  analogix_dp_send_psr_spd
  analogix_dp_enable_psr
  analogix_dp_psr_set
  psr_flush_handler

The flush handler thread was finding AUX channel errors and eventually
reported "Failed to apply PSR", where I had a kgdb breakpoint. Presumably
the device would have eventually given up and shut down anyway, but it
seems better to fix the order to be more correct.

Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index e0f96ad4c700..edaca650e6d2 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1337,12 +1337,13 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	}
 
 	disable_irq(dp->irq);
-	phy_power_off(dp->phy);
-	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
 
 	if (dp->plat_data->power_off)
 		dp->plat_data->power_off(dp->plat_data);
 
+	phy_power_off(dp->phy);
+	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
+
 	clk_disable_unprepare(dp->clock);
 
 	pm_runtime_put_sync(dp->dev);
-- 
2.16.1
