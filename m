Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id VlPcGt1SHFt2OQAAmS7hNA
	; Sat, 09 Jun 2018 22:21:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 56B0B607DC; Sat,  9 Jun 2018 22:21:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 90528600D0;
	Sat,  9 Jun 2018 22:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90528600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753487AbeFIWVO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 18:21:14 -0400
Received: from mail.ispras.ru ([83.149.199.45]:58122 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753408AbeFIWVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 18:21:13 -0400
Received: from localhost.localdomain (ppp85-140-176-5.pppoe.mtu-net.ru [85.140.176.5])
        by mail.ispras.ru (Postfix) with ESMTPSA id 4A47C54010F;
        Sun, 10 Jun 2018 01:21:10 +0300 (MSK)
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, Julia Lawall <julia.lawall@lip6.fr>,
        sil2review@lists.osadl.org
Subject: [PATCH] ASoC: rockchip: put device_node on remove
Date: Sun, 10 Jun 2018 01:20:54 +0300
Message-Id: <1528582854-8402-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_rk_mc_probe() gets a couple of device nodes with of_parse_phandle(),
but there is no release of them.

The patch adds remove handler and proper error handling in the probe.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 sound/soc/rockchip/rockchip_rt5645.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 4db4fd56db35..881c32498808 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -181,7 +181,8 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	if (!rk_dailink.cpu_of_node) {
 		dev_err(&pdev->dev,
 			"Property 'rockchip,i2s-controller' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_codec_of_node;
 	}
 
 	rk_dailink.platform_of_node = rk_dailink.cpu_of_node;
@@ -190,17 +191,36 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Soc parse card name failed %d\n", ret);
-		return ret;
+		goto put_cpu_of_node;
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Soc register card failed %d\n", ret);
-		return ret;
+		goto put_cpu_of_node;
 	}
 
 	return ret;
+
+put_cpu_of_node:
+	of_node_put(rk_dailink.cpu_of_node);
+	rk_dailink.cpu_of_node = NULL;
+put_codec_of_node:
+	of_node_put(rk_dailink.codec_of_node);
+	rk_dailink.codec_of_node = NULL;
+
+	return ret;
+}
+
+static int snd_rk_mc_remove(struct platform_device *pdev)
+{
+	of_node_put(rk_dailink.cpu_of_node);
+	rk_dailink.cpu_of_node = NULL;
+	of_node_put(rk_dailink.codec_of_node);
+	rk_dailink.codec_of_node = NULL;
+
+	return 0;
 }
 
 static const struct of_device_id rockchip_rt5645_of_match[] = {
@@ -212,6 +232,7 @@ MODULE_DEVICE_TABLE(of, rockchip_rt5645_of_match);
 
 static struct platform_driver snd_rk_mc_driver = {
 	.probe = snd_rk_mc_probe,
+	.remove = snd_rk_mc_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &snd_soc_pm_ops,
-- 
2.7.4
