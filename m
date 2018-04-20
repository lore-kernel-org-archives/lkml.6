Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754442AbeDTKFI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:05:08 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:28929 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754273AbeDTKFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:05:06 -0400
From: Jean-Jacques Hiblot <jjhiblot@ti.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <perex@perex.cz>, <tiwai@suse.com>
CC: <dannenberg@ti.com>, <afd@ti.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: [PATCH 1/3] ASoC: tas6424: Allow disabling auto diagnostics for faster power-on
Date: Fri, 20 Apr 2018 12:04:42 +0200
Message-ID: <1524218684-19752-2-git-send-email-jjhiblot@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TAS6424 incorporates both DC-load and AC-load diagnostics which are
used to determine the status of the load. The DC diagnostics runs when any
channel is directed to leave the Hi-Z state and enter the MUTE or PLAY
state.
The DC diagnostics are turned on by default but if a fast startup without
diagnostics is required the DC diagnostics can be bypassed by adding the
property "disable-auto-diagnostics".

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 .../devicetree/bindings/sound/ti,tas6424.txt       |  2 ++
 sound/soc/codecs/tas6424.c                         | 22 +++++++++++++++++++++-
 sound/soc/codecs/tas6424.h                         |  3 +++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas6424.txt b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
index 1c4ada0..bf2ff98 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas6424.txt
+++ b/Documentation/devicetree/bindings/sound/ti,tas6424.txt
@@ -6,6 +6,8 @@ Required properties:
 	- compatible: "ti,tas6424" - TAS6424
 	- reg: I2C slave address
 	- sound-dai-cells: must be equal to 0
+	- disable-auto-diagnostics: disable DC auto diagnostics (faster power
+	  on, but less safe as shortage won't be detected)
 
 Example:
 
diff --git a/sound/soc/codecs/tas6424.c b/sound/soc/codecs/tas6424.c
index 4f3a16c..5cee400 100644
--- a/sound/soc/codecs/tas6424.c
+++ b/sound/soc/codecs/tas6424.c
@@ -43,6 +43,7 @@ struct tas6424_data {
 	unsigned int last_fault1;
 	unsigned int last_fault2;
 	unsigned int last_warn;
+	bool no_auto_diags;
 };
 
 /*
@@ -308,7 +309,8 @@ static int tas6424_power_on(struct snd_soc_component *component)
 	/* any time we come out of HIZ, the output channels automatically run DC
 	 * load diagnostics, wait here until this completes
 	 */
-	msleep(230);
+	if (!tas6424->no_auto_diags)
+		msleep(230);
 
 	return 0;
 }
@@ -627,6 +629,9 @@ static int tas6424_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	tas6424->no_auto_diags = of_property_read_bool(dev->of_node,
+						"disable-auto-diagnostics");
+
 	for (i = 0; i < ARRAY_SIZE(tas6424->supplies); i++)
 		tas6424->supplies[i].supply = tas6424_supply_names[i];
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(tas6424->supplies),
@@ -651,6 +656,21 @@ static int tas6424_i2c_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	if (tas6424->no_auto_diags) {
+		/*
+		 * Disable DC auto-diagnostics to save time when channel leave
+		 * Hi-Z state
+		 */
+		ret = regmap_update_bits(tas6424->regmap,
+					 TAS6424_DC_DIAG_CTRL1,
+					  0xff, TAS6424_LDGBYPASS);
+		if (ret) {
+			dev_err(dev, "failed to disable auto-diags: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	INIT_DELAYED_WORK(&tas6424->fault_check_work, tas6424_fault_check_work);
 
 	ret = devm_snd_soc_register_component(dev, &soc_codec_dev_tas6424,
diff --git a/sound/soc/codecs/tas6424.h b/sound/soc/codecs/tas6424.h
index 4305883..3aea0f7 100644
--- a/sound/soc/codecs/tas6424.h
+++ b/sound/soc/codecs/tas6424.h
@@ -111,6 +111,9 @@
 					 TAS6424_CH3_STATE_DIAG | \
 					 TAS6424_CH4_STATE_DIAG)
 
+/* TAS6424_DC_DIAG_CTRL1 */
+#define TAS6424_LDGBYPASS		BIT(0)
+
 /* TAS6424_GLOB_FAULT1_REG */
 #define TAS6424_FAULT_CLOCK		BIT(4)
 #define TAS6424_FAULT_PVDD_OV		BIT(3)
-- 
2.7.4
