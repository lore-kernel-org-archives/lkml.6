Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7A1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A774C2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 01:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeLZBE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 20:04:58 -0500
Received: from inva020.nxp.com ([92.121.34.13]:55164 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbeLZBE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 20:04:58 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1EB731A0063;
        Wed, 26 Dec 2018 02:04:56 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3A3B11A0085;
        Wed, 26 Dec 2018 02:04:52 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 20E24402DD;
        Wed, 26 Dec 2018 09:04:47 +0800 (SGT)
From:   Alison Wang <alison.wang@nxp.com>
To:     fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     alison.wang@nxp.com
Subject: [PATCH v2] ASoC: sgtl5000: Allow SCLK pad drive strength to be changed
Date:   Wed, 26 Dec 2018 08:59:53 +0800
Message-Id: <20181226005953.40908-1-alison.wang@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces "sclk-strength" property to allow SCLK pad drive
strength to be changed via device tree.

When running playback test on LS1028ARDB, Tx Frame sync error interrupt
will occur sometimes. Some noises also exist. After changing SCLK pad
drive strength to the maximum value, the issues are gone.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
Change in v2:
 - Add the description about this new property in the dt-bindings.

 .../devicetree/bindings/sound/sgtl5000.txt         |    9 +++++++++
 sound/soc/codecs/sgtl5000.c                        |   19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 9c58f72..9d9ff51 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -37,6 +37,15 @@ VDDIO		1.8V		2.5V		3.3V
 2 =		3.33 mA		5.74 mA		8.03  mA
 3 =		4.99 mA		8.61 mA		12.05 mA
 
+- sclk-strength: the SCLK pad strength. Possible values are:
+0, 1, 2 and 3 as per the table below:
+
+VDDIO		1.8V		2.5V		3.3V
+0 = 		Disable
+1 =		1.66 mA		2.87 mA		4.02  mA
+2 =		3.33 mA		5.74 mA		8.03  mA
+3 =		4.99 mA		8.61 mA		12.05 mA
+
 Example:
 
 sgtl5000: codec@a {
diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index add18d6..a6a4748 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -116,6 +116,13 @@ enum  {
 	I2S_LRCLK_STRENGTH_HIGH,
 };
 
+enum  {
+	I2S_SCLK_STRENGTH_DISABLE,
+	I2S_SCLK_STRENGTH_LOW,
+	I2S_SCLK_STRENGTH_MEDIUM,
+	I2S_SCLK_STRENGTH_HIGH,
+};
+
 /* sgtl5000 private structure in codec */
 struct sgtl5000_priv {
 	int sysclk;	/* sysclk rate */
@@ -129,6 +136,7 @@ struct sgtl5000_priv {
 	u8 micbias_resistor;
 	u8 micbias_voltage;
 	u8 lrclk_strength;
+	u8 sclk_strength;
 };
 
 /*
@@ -1302,7 +1310,9 @@ static int sgtl5000_probe(struct snd_soc_component *component)
 			SGTL5000_DAC_MUTE_RIGHT |
 			SGTL5000_DAC_MUTE_LEFT);
 
-	reg = ((sgtl5000->lrclk_strength) << SGTL5000_PAD_I2S_LRCLK_SHIFT | 0x5f);
+	reg = ((sgtl5000->lrclk_strength) << SGTL5000_PAD_I2S_LRCLK_SHIFT |
+	       (sgtl5000->sclk_strength) << SGTL5000_PAD_I2S_SCLK_SHIFT |
+	       0x1f);
 	snd_soc_component_write(component, SGTL5000_CHIP_PAD_STRENGTH, reg);
 
 	snd_soc_component_write(component, SGTL5000_CHIP_ANA_CTRL,
@@ -1542,6 +1552,13 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 		sgtl5000->lrclk_strength = value;
 	}
 
+	sgtl5000->sclk_strength = I2S_SCLK_STRENGTH_LOW;
+	if (!of_property_read_u32(np, "sclk-strength", &value)) {
+		if (value > I2S_SCLK_STRENGTH_HIGH)
+			value = I2S_SCLK_STRENGTH_LOW;
+		sgtl5000->sclk_strength = value;
+	}
+
 	/* Ensure sgtl5000 will start with sane register values */
 	sgtl5000_fill_defaults(client);
 
-- 
1.7.1

