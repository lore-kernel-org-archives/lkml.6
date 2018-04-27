Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932530AbeD0N4q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:56:46 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:20612 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758529AbeD0N4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:56:44 -0400
From: Jean-Jacques Hiblot <jjhiblot@ti.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC: <dannenberg@ti.com>, <afd@ti.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH v2 1/3] ASoC: tas6424: Add support for the standby pin
Date: Fri, 27 Apr 2018 15:55:47 +0200
Message-ID: <1524837349-16350-2-git-send-email-jjhiblot@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524837349-16350-1-git-send-email-jjhiblot@ti.com>
References: <1524837349-16350-1-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standby pin can be connected to a GPIO. In that case we have to drive
it to the correct values for the TAS6424 to operate properly.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 .../devicetree/bindings/sound/ti,tas6424.txt       |  1 +
 sound/soc/codecs/tas6424.c                         | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas6424.txt b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
index 1c4ada0..df71e41 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas6424.txt
+++ b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
@@ -6,6 +6,7 @@ Required properties:
 	- compatible: "ti,tas6424" - TAS6424
 	- reg: I2C slave address
 	- sound-dai-cells: must be equal to 0
+	- standby-gpios: GPIO used to shut the TAS6424 down.
 
 Example:
 
diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 4f3a16c..5abb17f 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -43,6 +44,7 @@ struct tas6424_data {
 	unsigned int last_fault1;
 	unsigned int last_fault2;
 	unsigned int last_warn;
+	struct gpio_desc *standby_gpio;
 };
 
 /*
@@ -627,6 +629,22 @@ static int tas6424_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	/*
+	 * Get control of the standby pin and set it LOW to take the codec
+	 * out of the stand-by mode.
+	 * Note: The actual pin polarity is taken care of in the GPIO lib
+	 * according the polarity specified in the DTS.
+	 */
+	tas6424->standby_gpio = devm_gpiod_get_optional(dev, "standby",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(tas6424->standby_gpio)) {
+		if (PTR_ERR(tas6424->standby_gpio) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_info(dev, "failed to get standby GPIO: %ld\n",
+			PTR_ERR(tas6424->standby_gpio));
+		tas6424->standby_gpio = NULL;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(tas6424->supplies); i++)
 		tas6424->supplies[i].supply = tas6424_supply_names[i];
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(tas6424->supplies),
@@ -671,6 +689,10 @@ static int tas6424_i2c_remove(struct i2c_client *client)
 
 	cancel_delayed_work_sync(&tas6424->fault_check_work);
 
+	/* put the codec in stand-by */
+	if (tas6424->standby_gpio)
+		gpiod_set_value_cansleep(tas6424->standby_gpio, 1);
+
 	ret = regulator_bulk_disable(ARRAY_SIZE(tas6424->supplies),
 				     tas6424->supplies);
 	if (ret < 0) {
-- 
2.7.4
