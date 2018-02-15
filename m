Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754895AbeBOHYy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 02:24:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754802AbeBOHYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 02:24:53 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: intel-cht-wc: Also set direction and drv flags for V5 boost GPIO
Date: Thu, 15 Feb 2018 08:24:50 +0100
Message-Id: <20180215072450.7160-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes (firmware bug?) the V5 boost GPIO is not configured as output
by the BIOS, leading to the 5V boost convertor being permanently on,

Explicitly set the direction and drv flags rather then inheriting them
from the firmware to fix this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 7c4bc8c44c3f..b7e9ea377d70 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -66,6 +66,8 @@
 
 #define CHT_WC_VBUS_GPIO_CTLO		0x6e2d
 #define CHT_WC_VBUS_GPIO_CTLO_OUTPUT	BIT(0)
+#define CHT_WC_VBUS_GPIO_CTLO_DRV_OD	BIT(4)
+#define CHT_WC_VBUS_GPIO_CTLO_DIR_OUT	BIT(5)
 
 enum cht_wc_usb_id {
 	USB_ID_OTG,
@@ -183,14 +185,15 @@ static void cht_wc_extcon_set_5v_boost(struct cht_wc_extcon_data *ext,
 {
 	int ret, val;
 
-	val = enable ? CHT_WC_VBUS_GPIO_CTLO_OUTPUT : 0;
-
 	/*
 	 * The 5V boost converter is enabled through a gpio on the PMIC, since
 	 * there currently is no gpio driver we access the gpio reg directly.
 	 */
-	ret = regmap_update_bits(ext->regmap, CHT_WC_VBUS_GPIO_CTLO,
-				 CHT_WC_VBUS_GPIO_CTLO_OUTPUT, val);
+	val = CHT_WC_VBUS_GPIO_CTLO_DRV_OD | CHT_WC_VBUS_GPIO_CTLO_DIR_OUT;
+	if (enable)
+		val |= CHT_WC_VBUS_GPIO_CTLO_OUTPUT;
+
+	ret = regmap_write(ext->regmap, CHT_WC_VBUS_GPIO_CTLO, val);
 	if (ret)
 		dev_err(ext->dev, "Error writing Vbus GPIO CTLO: %d\n", ret);
 }
-- 
2.14.3
