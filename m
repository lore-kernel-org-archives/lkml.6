Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755226AbeDWKzc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:55:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38934 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755063AbeDWKuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:50:55 -0400
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
Subject: [RESEND PATCH v6 18/27] drm/bridge: analogix_dp: Reorder plat_data->power_off to happen sooner
Date: Mon, 23 Apr 2018 12:49:54 +0200
Message-Id: <20180423105003.9004-19-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
References: <20180423105003.9004-1-enric.balletbo@collabora.com>
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
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 69b2c16e5776..a260de4f0bd8 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1337,12 +1337,13 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 	}
 
 	disable_irq(dp->irq);
-	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
-	phy_power_off(dp->phy);
 
 	if (dp->plat_data->power_off)
 		dp->plat_data->power_off(dp->plat_data);
 
+	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
+	phy_power_off(dp->phy);
+
 	clk_disable_unprepare(dp->clock);
 
 	pm_runtime_put_sync(dp->dev);
-- 
2.17.0
