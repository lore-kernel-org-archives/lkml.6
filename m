Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeB0VZS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 16:25:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39287 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751901AbeB0VZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 16:25:12 -0500
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mylene.josserand@bootlin.com,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com
Subject: [PATCH v1 3/4] ASoC: codecs: pcm179x: Add reset gpio
Date: Tue, 27 Feb 2018 22:24:32 +0100
Message-Id: <20180227212433.2189-4-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180227212433.2189-1-mylene.josserand@bootlin.com>
References: <20180227212433.2189-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset gpio to be able to reset this line at startup.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 sound/soc/codecs/pcm179x.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index 2285a51ff9e9..0242dfd67b53 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -22,6 +22,8 @@
 #include <linux/device.h>
 
 #include <sound/core.h>
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
@@ -106,6 +108,7 @@ struct pcm179x_private {
 	struct regmap *regmap;
 	unsigned int format;
 	unsigned int rate;
+	int reset;
 };
 
 static int pcm179x_set_dai_fmt(struct snd_soc_dai *codec_dai,
@@ -381,6 +384,8 @@ int pcm179x_common_init(struct device *dev, struct regmap *regmap,
 			enum pcm17xx_type type)
 {
 	struct pcm179x_private *pcm179x;
+	struct device_node *np = dev->of_node;
+	int ret;
 
 	pcm179x = devm_kzalloc(dev, sizeof(struct pcm179x_private),
 				GFP_KERNEL);
@@ -390,6 +395,21 @@ int pcm179x_common_init(struct device *dev, struct regmap *regmap,
 	pcm179x->regmap = regmap;
 	dev_set_drvdata(dev, pcm179x);
 
+	pcm179x->reset = of_get_named_gpio(np, "reset-gpios", 0);
+	if (gpio_is_valid(pcm179x->reset)) {
+		ret = devm_gpio_request_one(dev, pcm179x->reset,
+					    GPIOF_OUT_INIT_LOW,
+					    "pcm179x reset");
+		if (ret) {
+			dev_err(dev,
+				"Failed to request GPIO %d as reset pin, error %d\n",
+				pcm179x->reset, ret);
+			return ret;
+		}
+
+		gpio_set_value(pcm179x->reset, 1);
+	}
+
 	if (type == PCM1789)
 		return devm_snd_soc_register_component(dev,
 						       &soc_component_dev_pcm1789,
-- 
2.11.0
