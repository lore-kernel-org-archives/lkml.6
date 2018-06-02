Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeFBTaF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 15:30:05 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:27050 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbeFBTaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 15:30:04 -0400
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 02 Jun 2018 21:30:01 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8] ASoC: pxa: switch to new ac97 bus support
Date: Sat,  2 Jun 2018 21:29:30 +0200
Message-Id: <20180602192930.17846-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new ac97 bus support in sound/ac97 instead of the legacy
snd_ac97 one.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v7: added a NULL pointer check
          v7 was in https://patchwork.kernel.org/patch/9951919/
---
 sound/arm/Kconfig           |  1 -
 sound/soc/pxa/Kconfig       |  5 ++---
 sound/soc/pxa/pxa2xx-ac97.c | 48 +++++++++++++++++++++++----------------------
 3 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/sound/arm/Kconfig b/sound/arm/Kconfig
index 65171f6657a2..f1f25704fe52 100644
--- a/sound/arm/Kconfig
+++ b/sound/arm/Kconfig
@@ -36,7 +36,6 @@ endif	# SND_ARM
 
 config SND_PXA2XX_LIB
 	tristate
-	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
 	select SND_DMAENGINE_PCM
 
 config SND_PXA2XX_LIB_AC97
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 484ab3c2ad67..1a0b55beb282 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -20,13 +20,12 @@ config SND_MMP_SOC
 
 config SND_PXA2XX_AC97
 	tristate
-	select SND_AC97_CODEC
 
 config SND_PXA2XX_SOC_AC97
 	tristate
-	select AC97_BUS
+	select AC97_BUS_NEW
 	select SND_PXA2XX_LIB_AC97
-	select SND_SOC_AC97_BUS
+	select SND_SOC_AC97_BUS_NEW
 
 config SND_PXA2XX_SOC_I2S
 	tristate
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 1b41c0f2a8fb..91ead9cbbb9d 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -17,6 +17,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma/pxa-dma.h>
 
+#include <sound/ac97/controller.h>
 #include <sound/core.h>
 #include <sound/ac97_codec.h>
 #include <sound/soc.h>
@@ -27,43 +28,35 @@
 #include <mach/regs-ac97.h>
 #include <mach/audio.h>
 
-static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
+static void pxa2xx_ac97_warm_reset(struct ac97_controller *adrv)
 {
 	pxa2xx_ac97_try_warm_reset();
 
 	pxa2xx_ac97_finish_reset();
 }
 
-static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
+static void pxa2xx_ac97_cold_reset(struct ac97_controller *adrv)
 {
 	pxa2xx_ac97_try_cold_reset();
 
 	pxa2xx_ac97_finish_reset();
 }
 
-static unsigned short pxa2xx_ac97_legacy_read(struct snd_ac97 *ac97,
-					      unsigned short reg)
+static int pxa2xx_ac97_read_actrl(struct ac97_controller *adrv, int slot,
+				  unsigned short reg)
 {
-	int ret;
-
-	ret = pxa2xx_ac97_read(ac97->num, reg);
-	if (ret < 0)
-		return 0;
-	else
-		return (unsigned short)(ret & 0xffff);
+	return pxa2xx_ac97_read(slot, reg);
 }
 
-static void pxa2xx_ac97_legacy_write(struct snd_ac97 *ac97,
-				     unsigned short reg, unsigned short val)
+static int pxa2xx_ac97_write_actrl(struct ac97_controller *adrv, int slot,
+				   unsigned short reg, unsigned short val)
 {
-	int ret;
-
-	ret = pxa2xx_ac97_write(ac97->num, reg, val);
+	return pxa2xx_ac97_write(slot, reg, val);
 }
 
-static struct snd_ac97_bus_ops pxa2xx_ac97_ops = {
-	.read	= pxa2xx_ac97_legacy_read,
-	.write	= pxa2xx_ac97_legacy_write,
+static struct ac97_controller_ops pxa2xx_ac97_ops = {
+	.read	= pxa2xx_ac97_read_actrl,
+	.write	= pxa2xx_ac97_write_actrl,
 	.warm_reset	= pxa2xx_ac97_warm_reset,
 	.reset	= pxa2xx_ac97_cold_reset,
 };
@@ -219,6 +212,9 @@ static const struct snd_soc_component_driver pxa_ac97_component = {
 static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
 	int ret;
+	struct ac97_controller *ctrl;
+	pxa2xx_audio_ops_t *pdata = pdev->dev.platform_data;
+	void **codecs_pdata;
 
 	if (pdev->id != -1) {
 		dev_err(&pdev->dev, "PXA2xx has only one AC97 port.\n");
@@ -231,10 +227,14 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = snd_soc_set_ac97_ops(&pxa2xx_ac97_ops);
-	if (ret != 0)
-		return ret;
+	codecs_pdata = pdata ? pdata->codecs_pdata : NULL;
+	ctrl = snd_ac97_controller_register(&pxa2xx_ac97_ops, &pdev->dev,
+					    AC97_SLOTS_AVAILABLE_ALL,
+					    codecs_pdata);
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
 
+	platform_set_drvdata(pdev, ctrl);
 	/* Punt most of the init to the SoC probe; we may need the machine
 	 * driver to do interesting things with the clocking to get us up
 	 * and running.
@@ -245,8 +245,10 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 
 static int pxa2xx_ac97_dev_remove(struct platform_device *pdev)
 {
+	struct ac97_controller *ctrl = platform_get_drvdata(pdev);
+
 	snd_soc_unregister_component(&pdev->dev);
-	snd_soc_set_ac97_ops(NULL);
+	snd_ac97_controller_unregister(ctrl);
 	pxa2xx_ac97_hw_remove(pdev);
 	return 0;
 }
-- 
2.11.0
