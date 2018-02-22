Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753782AbeBVMDK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 07:03:10 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:57713 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932121AbeBVMDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 07:03:06 -0500
X-IronPort-AV: E=Sophos;i="5.46,543,1511852400";
   d="scan'208";a="9043020"
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <thierry.reding@gmail.com>, <shc_work@mail.ru>, <kgene@kernel.org>,
        <krzk@kernel.org>, <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@codeaurora.org>, <jani.nikula@linux.intel.com>,
        <joonas.lahtinen@linux.intel.com>, <rodrigo.vivi@intel.com>,
        <airlied@linux.ie>, <kamil@wypas.org>, <b.zolnierkie@samsung.com>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <dmitry.torokhov@gmail.com>,
        <rpurdie@rpsys.net>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <mchehab@kernel.org>, <sean@mess.org>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>, <jingoohan1@gmail.com>,
        <milo.kim@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <corbet@lwn.net>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>
CC: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-hwmon@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 03/10] pwm: cros-ec: populate PWM mode in of_xlate function
Date: Thu, 22 Feb 2018 14:01:14 +0200
Message-ID: <1519300881-8136-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate PWM mode in of_xlate function to avoid pwm_apply_state() failure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pwm/pwm-cros-ec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 9c13694eaa24..e54954c13323 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -137,6 +137,7 @@ static struct pwm_device *
 cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 {
 	struct pwm_device *pwm;
+	struct pwm_caps caps;
 
 	if (args->args[0] >= pc->npwm)
 		return ERR_PTR(-EINVAL);
@@ -145,8 +146,11 @@ cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 	if (IS_ERR(pwm))
 		return pwm;
 
+	pwm_get_caps(pc, pwm, &caps);
+
 	/* The EC won't let us change the period */
 	pwm->args.period = EC_PWM_MAX_DUTY;
+	pwm->args.mode = BIT(ffs(caps.modes) - 1);
 
 	return pwm;
 }
-- 
2.7.4
