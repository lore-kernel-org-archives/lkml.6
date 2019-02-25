Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA28C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE3520842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfBYQAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:00:31 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:44497 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfBYQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:00:30 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.53.79]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MkYHO-1hQXCd04hq-00m0gc; Mon, 25 Feb 2019 16:59:57 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC V2 3/3] hwmon: pwm-fan: Add RPM support via external interrupt
Date:   Mon, 25 Feb 2019 16:59:19 +0100
Message-Id: <1551110359-19860-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551110359-19860-1-git-send-email-stefan.wahren@i2se.com>
References: <1551110359-19860-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:LwcArMQy/ey2a01eMuwgWYAwoo/T8wEmK05hkYl2hOZTW2ciUh+
 q7Ty+3mW33rWOOg6TacSfQxt/uNnEz82irp+E720/xXNAwbx6XbyXsrHTHu5mKwVoasJMPp
 JPQbxEzxT90mGT7+mZTgVp8HhbmK8Nb7Qlgcy20HPV8nmGCQJqjEWEyoWBSfmEyVRsA7dSJ
 l9Ak6xRFhGPMDIXRqdVLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BPHHqNE7ZSw=:lxL7hosapKqdz2RNnXHk9X
 OqJm604J9zNow/mo+8ioiOptwFjaT8o6tceicE1ShdnXB3X70Dvx3QN93Xq9bhicDrHQBXejh
 HHoDUt1+sN9eQ7Fa8K8mVXzdv2Bkjm20mVP//T3zboik97x8HXfZLIIfs8yS4uMBX3PiGhrGe
 xXpnItHOFSd15N0/ohDaULRRaZcZFwkcs5SQ/MHCIZixKiDbOuWe7XjTXzRmlXx1kpQ9CJ/Nm
 pcxjk7D1cxL6rIpOt35jqMAarWvoHqv3tV0L0/A3iJgkpKuvnAjTG6FRTj5bcDAfW8YRUwMkl
 yqkzlfms+DbYgNovmBLw5YU+yvj6q91gvWMOJCWKUIGK5FDvmqa/OBpuP6tdPG2CYK6FjAxN5
 Nv5cbpzGKOSPGm/5nf4D9ZUUnf1cQDkHe7ZPefClL6tMYMGMWI/T/aKoHrlEFTINkQ4122fwC
 +Wx2wG2zo1CJ/zYLXbS/I6xk01FBkRSVzpB07vxuOu2Y5OHsT9AtJ3l+NtkmOyXb8Tjx8Y+E6
 VyIYZ7S9eBL3Cx0wfND3uSnIv6yz4+LhSbtsAF1cWhpcVy8p+RLBegasJVdXaJDmRheHyiV1u
 bydR+KQC4cCo+e9g9ZqiMc51jkct7OHYTNeMor5I04rcfVUjOb6LjAEb/huMuq5gpSX9OLlUg
 Zze3Mr6MjrBrPPFGSLhGQj7Zr5n2LlyKlkxG3+Gn8NCTkVYEzhbUMjco3yY4ZZqv6+i6zTjpV
 2DPeW+Xa2aUtc6jLRAKGT4wsAZBW69fuHOFQx5k+rRqurMpQtIPu0siYrag=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds RPM support to the pwm-fan driver in order to use with
fancontrol/pwmconfig. This feature is intended for fans with a tachometer
output signal, which generate a defined number of pulses per revolution.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/hwmon/pwm-fan.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 167221c..0bacaba 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -18,6 +18,7 @@
 
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -26,6 +27,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
 #include <linux/thermal.h>
+#include <linux/timer.h>
 
 #define MAX_PWM 255
 
@@ -33,6 +35,14 @@ struct pwm_fan_ctx {
 	struct mutex lock;
 	struct pwm_device *pwm;
 	struct regulator *reg_en;
+
+	int irq;
+	atomic_t pulses;
+	unsigned int rpm;
+	u32 pulse_per_revolution;
+	ktime_t sample_start;
+	struct timer_list rpm_timer;
+
 	unsigned int pwm_value;
 	unsigned int pwm_fan_state;
 	unsigned int pwm_fan_max_state;
@@ -40,6 +50,32 @@ struct pwm_fan_ctx {
 	struct thermal_cooling_device *cdev;
 };
 
+/* This handler assumes self resetting edge triggered interrupt. */
+static irqreturn_t pulse_handler(int irq, void *dev_id)
+{
+	struct pwm_fan_ctx *ctx = dev_id;
+
+	/* Avoid possible overflow */
+	if (atomic_read(&ctx->pulses) < 100000)
+		atomic_inc(&ctx->pulses);
+
+	return IRQ_HANDLED;
+}
+
+static void sample_timer(struct timer_list *t)
+{
+	struct pwm_fan_ctx *ctx = from_timer(ctx, t, rpm_timer);
+	int pulses, sample_ms;
+
+	pulses = atomic_read(&ctx->pulses);
+	atomic_sub(pulses, &ctx->pulses);
+	sample_ms = ktime_ms_delta(ktime_get(), ctx->sample_start);
+	ctx->rpm = pulses * 60 * sample_ms / 1000 / ctx->pulse_per_revolution;
+
+	ctx->sample_start = ktime_get();
+	mod_timer(&ctx->rpm_timer, jiffies + HZ);
+}
+
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
 	unsigned long period;
@@ -100,15 +136,49 @@ static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%u\n", ctx->pwm_value);
 }
 
+static ssize_t rpm_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", ctx->rpm);
+}
 
 static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RO(fan1_input, rpm, 0);
 
 static struct attribute *pwm_fan_attrs[] = {
 	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	NULL,
 };
 
-ATTRIBUTE_GROUPS(pwm_fan);
+static umode_t pwm_fan_attrs_visible(struct kobject *kobj, struct attribute *a,
+				     int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	struct device_attribute *devattr;
+
+	/* Hide fan_input in case no interrupt is available  */
+	devattr = container_of(a, struct device_attribute, attr);
+	if (devattr == &sensor_dev_attr_fan1_input.dev_attr) {
+		if (ctx->irq < 0)
+			return 0;
+	}
+
+	return a->mode;
+}
+
+static const struct attribute_group pwm_fan_group = {
+	.attrs = pwm_fan_attrs,
+	.is_visible = pwm_fan_attrs_visible,
+};
+
+static const struct attribute_group *pwm_fan_groups[] = {
+	&pwm_fan_group,
+	NULL,
+};
 
 /* thermal cooling device callbacks */
 static int pwm_fan_get_max_state(struct thermal_cooling_device *cdev,
@@ -261,6 +331,26 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		goto err_reg_disable;
 	}
 
+	timer_setup(&ctx->rpm_timer, sample_timer, 0);
+
+	if (of_property_read_u32(pdev->dev.of_node, "interrupt-ratio",
+				 &ctx->pulse_per_revolution)) {
+		ctx->pulse_per_revolution = 2;
+	}
+
+	atomic_set(&ctx->pulses, 0);
+	ctx->irq = platform_get_irq(pdev, 0);
+	if (ctx->irq >= 0) {
+		ret = devm_request_irq(&pdev->dev, ctx->irq, pulse_handler, 0,
+				       pdev->name, ctx);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't get interrupt working.\n");
+			return ret;
+		}
+		ctx->sample_start = ktime_get();
+		mod_timer(&ctx->rpm_timer, jiffies + HZ);
+	}
+
 	hwmon = devm_hwmon_device_register_with_groups(&pdev->dev, "pwmfan",
 						       ctx, pwm_fan_groups);
 	if (IS_ERR(hwmon)) {
@@ -306,6 +396,8 @@ static int pwm_fan_remove(struct platform_device *pdev)
 	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
 
 	thermal_cooling_device_unregister(ctx->cdev);
+	del_timer_sync(&ctx->rpm_timer);
+
 	if (ctx->pwm_value)
 		pwm_disable(ctx->pwm);
 
-- 
2.7.4

