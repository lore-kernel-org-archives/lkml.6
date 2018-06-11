Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 15C5DC004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C732086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C732086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934012AbeFKUWf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:22:35 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:60940 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933789AbeFKUWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:22:30 -0400
Received: from belgarion.home ([90.55.202.35])
        by mwinf5d72 with ME
        id xYNJ1x0040mKt3N03YNTSD; Mon, 11 Jun 2018 22:22:29 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 11 Jun 2018 22:22:29 +0200
X-ME-IP: 90.55.202.35
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] ASoC: pxa: add devicetree support
Date:   Mon, 11 Jun 2018 22:22:11 +0200
Message-Id: <20180611202211.15501-2-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180611202211.15501-1-robert.jarzmik@free.fr>
References: <20180611202211.15501-1-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devicetree support, so that the driver can be used in a
devictree platform.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/arm/pxa2xx-ac97-lib.c | 11 +++++++++++
 sound/soc/pxa/pxa2xx-ac97.c | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 5950a9e218d9..17c3f26b92b9 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 
 #include <sound/pxa2xx-lib.h>
 
@@ -337,6 +338,16 @@ int pxa2xx_ac97_hw_probe(struct platform_device *dev)
 			dev_err(&dev->dev, "Invalid reset GPIO %d\n",
 				pdata->reset_gpio);
 		}
+	} else if (!pdata && dev->dev.of_node) {
+		pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+		pdata->reset_gpio = of_get_named_gpio(dev->dev.of_node,
+						      "reset-gpio", 0);
+		if (pdata->reset_gpio == -ENOENT)
+			pdata->reset_gpio = -1;
+		else if (pdata->reset_gpio < 0)
+			return pdata->reset_gpio;
 	} else {
 		if (cpu_is_pxa27x())
 			reset_gpio = 113;
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index bd36578ceb86..8fda29262ef1 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -231,6 +231,15 @@ static const struct snd_soc_component_driver pxa_ac97_component = {
 	.name		= "pxa-ac97",
 };
 
+#ifdef CONFIG_OF
+static const struct of_device_id pxa2xx_ac97_dt_ids[] = {
+	{ .compatible = "marvell,pxa2xx-ac97", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pxa2xx_ac97_dt_ids);
+
+#endif
+
 static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -298,6 +307,7 @@ static struct platform_driver pxa2xx_ac97_driver = {
 #ifdef CONFIG_PM_SLEEP
 		.pm	= &pxa2xx_ac97_pm_ops,
 #endif
+		.of_match_table = of_match_ptr(pxa2xx_ac97_dt_ids),
 	},
 };
 
-- 
2.11.0

