Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeA3U3d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:29:33 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55958 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeA3U3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:31 -0500
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
Subject: [PATCH v3 05/43] drm/bridge: analogix_dp: Don't power bridge in analogix_dp_bind
Date: Tue, 30 Jan 2018 21:28:35 +0100
Message-Id: <20180130202913.28724-6-thierry.escande@collabora.com>
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

From: zain wang <wzz@rock-chips.com>

The bridge does not need to be powered in analogix_dp_bind(), so
remove the calls to pm_runtime_get()/phy_power_on()/analogix_dp_init_dp()
as well as their power-off counterparts.

Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
[the patch originally just removed the power_on portion, seanpaul removed
the power off code as well as improved the commit message]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index cb5e18d6ba04..1477ea9ba85d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1382,11 +1382,6 @@ analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 
 	pm_runtime_enable(dev);
 
-	pm_runtime_get_sync(dev);
-	phy_power_on(dp->phy);
-
-	analogix_dp_init_dp(dp);
-
 	ret = devm_request_threaded_irq(&pdev->dev, dp->irq,
 					analogix_dp_hardirq,
 					analogix_dp_irq_thread,
@@ -1414,15 +1409,10 @@ analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 		goto err_disable_pm_runtime;
 	}
 
-	phy_power_off(dp->phy);
-	pm_runtime_put(dev);
-
 	return dp;
 
 err_disable_pm_runtime:
 
-	phy_power_off(dp->phy);
-	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 
 	return ERR_PTR(ret);
-- 
2.14.1
