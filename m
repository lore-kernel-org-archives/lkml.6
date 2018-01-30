Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeA3UjN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:39:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56056 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeA3U3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:29:34 -0500
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
Subject: [PATCH v3 08/43] drm/rockchip: Remove analogix psr worker
Date: Tue, 30 Jan 2018 21:28:38 +0100
Message-Id: <20180130202913.28724-9-thierry.escande@collabora.com>
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

From: Sean Paul <seanpaul@chromium.org>

Now that the spinlocks and timers are gone, we can remove the psr
worker located in rockchip's analogix driver and do the enable/disable
directly. This should simplify the code and remove races on disable.

Cc: 征增 王 <wzz@rock-chips.com>
Cc: Stéphane Marchesin <marcheu@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 31 ++-----------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 7d76ff47028d..36334839a3f8 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -71,10 +71,6 @@ struct rockchip_dp_device {
 	struct regmap            *grf;
 	struct reset_control     *rst;
 
-	struct work_struct	 psr_work;
-	struct mutex             psr_lock;
-	unsigned int             psr_state;
-
 	const struct rockchip_dp_chip_data *data;
 
 	struct analogix_dp_device *adp;
@@ -84,28 +80,13 @@ struct rockchip_dp_device {
 static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 {
 	struct rockchip_dp_device *dp = to_dp(encoder);
+	int ret;
 
 	if (!analogix_dp_psr_supported(dp->adp))
 		return;
 
 	DRM_DEV_DEBUG(dp->dev, "%s PSR...\n", enabled ? "Entry" : "Exit");
 
-	mutex_lock(&dp->psr_lock);
-	if (enabled)
-		dp->psr_state = EDP_VSC_PSR_STATE_ACTIVE;
-	else
-		dp->psr_state = ~EDP_VSC_PSR_STATE_ACTIVE;
-
-	schedule_work(&dp->psr_work);
-	mutex_unlock(&dp->psr_lock);
-}
-
-static void analogix_dp_psr_work(struct work_struct *work)
-{
-	struct rockchip_dp_device *dp =
-				container_of(work, typeof(*dp), psr_work);
-	int ret;
-
 	ret = rockchip_drm_wait_vact_end(dp->encoder.crtc,
 					 PSR_WAIT_LINE_FLAG_TIMEOUT_MS);
 	if (ret) {
@@ -113,12 +94,10 @@ static void analogix_dp_psr_work(struct work_struct *work)
 		return;
 	}
 
-	mutex_lock(&dp->psr_lock);
-	if (dp->psr_state == EDP_VSC_PSR_STATE_ACTIVE)
+	if (enabled)
 		analogix_dp_enable_psr(dp->adp);
 	else
 		analogix_dp_disable_psr(dp->adp);
-	mutex_unlock(&dp->psr_lock);
 }
 
 static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
@@ -135,8 +114,6 @@ static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
 	struct rockchip_dp_device *dp = to_dp(plat_data);
 	int ret;
 
-	cancel_work_sync(&dp->psr_work);
-
 	ret = clk_prepare_enable(dp->pclk);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dp->dev, "failed to enable pclk %d\n", ret);
@@ -355,10 +332,6 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 	dp->plat_data.power_off = rockchip_dp_powerdown;
 	dp->plat_data.get_modes = rockchip_dp_get_modes;
 
-	mutex_init(&dp->psr_lock);
-	dp->psr_state = ~EDP_VSC_PSR_STATE_ACTIVE;
-	INIT_WORK(&dp->psr_work, analogix_dp_psr_work);
-
 	ret = rockchip_drm_psr_register(&dp->encoder, analogix_dp_psr_set);
 	if (ret < 0)
 		goto err_cleanup_encoder;
-- 
2.14.1
