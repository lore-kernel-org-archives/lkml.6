Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6204DC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395E12175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBGGqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:46:33 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34064 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfBGGpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:45:45 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id AC7B05FD5F; Thu,  7 Feb 2019 14:45:39 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [RFT PATCH 4/9] power: supply: axp20x_usb_power: use polling to detect vbus status change
Date:   Thu,  7 Feb 2019 14:45:30 +0800
Message-Id: <20190207064535.9226-5-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207064535.9226-1-wens@csie.org>
References: <20190207064535.9226-1-wens@csie.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AXP221 and later AXP PMICs that have the N_VBUSEN pin, when this pin
is high, either due to the PMIC driving it high or as an input, the VBUS
detection related interrupt mechanisms are disabled.

Previously this was worked around in the phy-sun4i-usb driver, which
needed to sense VBUS changes and report them to the musb driver in a
timely matter. However this workaround was only for the A31 and A33 type
USB PHYs. To support newer platforms we would have to enable it for
almost all the post-A31 SoCs.

However, since this is actually the result of the PMIC's behavior, the
workaround would be better if done in the PMIC driver, in this case the
VBUS power supply driver.

Add the same workqueue-based polling to the VBUS power supply driver.
The polling interval is chosen to be the debounce interval from the USB
PHY driver, as this short interval is needed in some cases, but the
power supply driver would not know when.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/power/supply/axp20x_usb_power.c | 53 +++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index e2f353906bb1..ac061bcdc056 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -24,6 +24,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/iio/consumer.h>
+#include <linux/workqueue.h>
 
 #define DRVNAME "axp20x-usb-power-supply"
 
@@ -46,6 +47,12 @@
 
 #define AXP20X_VBUS_MON_VBUS_VALID	BIT(3)
 
+/*
+ * Note do not raise the debounce time, we must report Vusb high within
+ * 100ms otherwise we get Vbus errors in musb.
+ */
+#define DEBOUNCE_TIME			msecs_to_jiffies(50)
+
 struct axp20x_usb_power {
 	struct device_node *np;
 	struct regmap *regmap;
@@ -53,6 +60,8 @@ struct axp20x_usb_power {
 	enum axp20x_variants axp20x_id;
 	struct iio_channel *vbus_v;
 	struct iio_channel *vbus_i;
+	struct delayed_work vbus_detect;
+	unsigned int old_status;
 };
 
 static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
@@ -64,6 +73,35 @@ static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+static void axp20x_usb_power_poll_vbus(struct work_struct *work)
+{
+	struct axp20x_usb_power *power =
+		container_of(work, struct axp20x_usb_power, vbus_detect.work);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(power->regmap, AXP20X_PWR_INPUT_STATUS, &val);
+	if (ret)
+		goto out;
+
+	val &= (AXP20X_PWR_STATUS_VBUS_PRESENT | AXP20X_PWR_STATUS_VBUS_USED);
+	if (val != power->old_status)
+		power_supply_changed(power->supply);
+
+	power->old_status = val;
+
+out:
+	mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
+}
+
+static bool axp20x_usb_vbus_needs_polling(struct axp20x_usb_power *power)
+{
+	if (power->axp20x_id >= AXP221_ID)
+		return true;
+
+	return false;
+}
+
 static int axp20x_usb_power_get_property(struct power_supply *psy,
 	enum power_supply_property psp, union power_supply_propval *val)
 {
@@ -362,6 +400,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	if (!power)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, power);
 	power->axp20x_id = (enum axp20x_variants)of_device_get_match_data(
 								&pdev->dev);
 
@@ -420,6 +459,19 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 				 irq_names[i], ret);
 	}
 
+	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
+	if (axp20x_usb_vbus_needs_polling(power))
+		queue_delayed_work(system_wq, &power->vbus_detect, 0);
+
+	return 0;
+}
+
+static int axp20x_usb_power_remove(struct platform_device *pdev)
+{
+	struct axp20x_usb_power *power = platform_get_drvdata(pdev);
+
+	cancel_delayed_work_sync(&power->vbus_detect);
+
 	return 0;
 }
 
@@ -439,6 +491,7 @@ MODULE_DEVICE_TABLE(of, axp20x_usb_power_match);
 
 static struct platform_driver axp20x_usb_power_driver = {
 	.probe = axp20x_usb_power_probe,
+	.remove = axp20x_usb_power_remove,
 	.driver = {
 		.name = DRVNAME,
 		.of_match_table = axp20x_usb_power_match,
-- 
2.20.1

