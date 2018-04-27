Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758029AbeD0SY3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 14:24:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45276 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757954AbeD0SY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 14:24:26 -0400
From: Mark Brown <broonie@kernel.org>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, afd@ti.com,
        dannenberg@ti.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: tas6424: Add support for the standby pin" to the asoc tree
In-Reply-To: <1524837349-16350-2-git-send-email-jjhiblot@ti.com>
Message-Id: <E1fC82d-0004JA-E2@debutante>
Date: Fri, 27 Apr 2018 19:24:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tas6424: Add support for the standby pin

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e3976aa6fb409aea3cea812f6a0beebb545e5996 Mon Sep 17 00:00:00 2001
From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Date: Fri, 27 Apr 2018 15:55:47 +0200
Subject: [PATCH] ASoC: tas6424: Add support for the standby pin

The standby pin can be connected to a GPIO. In that case we have to drive
it to the correct values for the TAS6424 to operate properly.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/ti,tas6424.txt  |  1 +
 sound/soc/codecs/tas6424.c                    | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas6424.txt b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
index 1c4ada0eef4e..df71e414dc5b 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas6424.txt
+++ b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
@@ -6,6 +6,7 @@ Required properties:
 	- compatible: "ti,tas6424" - TAS6424
 	- reg: I2C slave address
 	- sound-dai-cells: must be equal to 0
+	- standby-gpios: GPIO used to shut the TAS6424 down.
 
 Example:
 
diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 4f3a16c520a2..5abb17f8d3dd 100644
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
2.17.0
