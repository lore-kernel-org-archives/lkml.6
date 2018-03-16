Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeCPC7r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 22:59:47 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42926 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752404AbeCPC7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 22:59:45 -0400
X-Google-Smtp-Source: AG47ELtl9WMM8p3hd7ipXWjPRuLPfeWt9WXKDu+kIhqqHu2vo0J24aaiz0ncvTam11BqhW4ilkgNoQ==
From: Alexandru M Stan <amstan@chromium.org>
To: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>
Cc: devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        marcheu@chromium.org, hoegsberg@chromium.org,
        Thierry Escande <thierry.escande@collabora.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Yakir Yang <kuankuan.y@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        zain wang <wzz@rock-chips.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 2/2] drm/bridge: analogix: Enable EDP_BACKLIGHT_FREQ_PWM_PIN_PASSTHRU
Date: Thu, 15 Mar 2018 19:56:59 -0700
Message-Id: <20180316025659.217423-3-amstan@chromium.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180316025659.217423-1-amstan@chromium.org>
References: <20180316025659.217423-1-amstan@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the DPCD registers for the backlight to respect the pwm frequency
of the input. We sometimes don't want it to generate its own.

Signed-off-by: Alexandru M Stan <amstan@chromium.org>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 48 ++++++++++++++++++++++
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  1 +
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 5c52307146c7..b830403be8eb 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -916,6 +916,46 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static int analogix_dp_backlight_pwm_passthru(struct analogix_dp_device *dp)
+{
+	u8 value;
+	const u8 expected_cap = DP_EDP_BACKLIGHT_BRIGHTNESS_PWM_PIN_CAP |
+				DP_EDP_BACKLIGHT_FREQ_PWM_PIN_PASSTHRU_CAP;
+	int ret = 0;
+
+	ret = drm_dp_dpcd_readb(&dp->aux, DP_EDP_BACKLIGHT_ADJUSTMENT_CAP,
+				&value);
+	if (ret != 1) {
+		DRM_DEV_ERROR(dp->dev,
+			"backlight PWM passthru: Can't read BACKLIGHT_ADJUSTMENT_CAP\n");
+		return ret;
+	}
+
+	if ((value & expected_cap) != expected_cap) {
+		DRM_DEV_ERROR(dp->dev,
+			"panel doesn't support backlight PWM passthru, BACKLIGHT_ADJUSTMENT_CAP=0x%02x\n",
+			value);
+		return -1;
+	}
+
+	ret = drm_dp_dpcd_readb(&dp->aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
+				&value);
+	if (ret != 1) {
+		DRM_DEV_ERROR(dp->dev,
+			"backlight PWM passthru: Can't read BACKLIGHT_MODE_SET_REGISTER\n");
+		return ret;
+	}
+
+	value |= DP_EDP_BACKLIGHT_FREQ_PWM_PIN_PASSTHRU_ENABLE;
+	ret = drm_dp_dpcd_writeb(&dp->aux, DP_EDP_BACKLIGHT_MODE_SET_REGISTER,
+				 value);
+	if (ret != 1) {
+		DRM_DEV_ERROR(dp->dev,
+			"backlight PWM passthru: Can't write BACKLIGHT_MODE_SET_REGISTER\n");
+	}
+	return ret;
+}
+
 static void analogix_dp_commit(struct analogix_dp_device *dp)
 {
 	int ret;
@@ -954,6 +994,12 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
 	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
 	if (dp->psr_enable)
 		analogix_dp_enable_sink_psr(dp);
+
+	if (dp->backlight_pwm_passthru) {
+		if (analogix_dp_backlight_pwm_passthru(dp) != 1)
+			DRM_DEV_ERROR(dp->dev,
+				 "Could not enable backlight pwm pin passthru.\n");
+	}
 }
 
 /*
@@ -1424,6 +1470,8 @@ analogix_dp_bind(struct device *dev, struct drm_device *drm_dev,
 	if (IS_ERR(dp->reg_base))
 		return ERR_CAST(dp->reg_base);
 
+	dp->backlight_pwm_passthru =
+	       of_property_read_bool(dev->of_node, "backlight-pwm-passthru");
 	dp->force_hpd = of_property_read_bool(dev->of_node, "force-hpd");
 
 	dp->hpd_gpio = of_get_named_gpio(dev->of_node, "hpd-gpios", 0);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 6a96ef7e6934..aea51413e78e 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -171,6 +171,7 @@ struct analogix_dp_device {
 	struct phy		*phy;
 	int			dpms_mode;
 	int			hpd_gpio;
+	bool			backlight_pwm_passthru;
 	bool                    force_hpd;
 	bool			psr_enable;
 	bool			fast_train_support;
-- 
2.13.5
