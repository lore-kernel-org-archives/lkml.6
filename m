Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE0CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E92208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 22:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E92208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756706AbeFOWXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 18:23:10 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52170 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756683AbeFOWXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 18:23:08 -0400
Received: from localhost.localdomain (ppp85-140-190-130.pppoe.mtu-net.ru [85.140.190.130])
        by mail.ispras.ru (Postfix) with ESMTPSA id D5271540110;
        Sat, 16 Jun 2018 01:23:05 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
Subject: [PATCH] ASoC: tegra: fix device_node refcounting
Date:   Sat, 16 Jun 2018 01:22:58 +0300
Message-Id: <1529101378-5543-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tegra_rt5677_probe() gets a couple of device nodes with of_parse_phandle(),
but there is no release of them.

The patch adds the release to tegra_rt5677_remove() and
to error handling paths in the probe.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 sound/soc/tegra/tegra_rt5677.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_rt5677.c b/sound/soc/tegra/tegra_rt5677.c
index 0e4805c7b4ca..7081f15302cc 100644
--- a/sound/soc/tegra/tegra_rt5677.c
+++ b/sound/soc/tegra/tegra_rt5677.c
@@ -264,13 +264,13 @@ static int tegra_rt5677_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Property 'nvidia,i2s-controller' missing or invalid\n");
 		ret = -EINVAL;
-		goto err;
+		goto err_put_codec_of_node;
 	}
 	tegra_rt5677_dai.platform_of_node = tegra_rt5677_dai.cpu_of_node;
 
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
 	if (ret)
-		goto err;
+		goto err_put_cpu_of_node;
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
@@ -283,6 +283,13 @@ static int tegra_rt5677_probe(struct platform_device *pdev)
 
 err_fini_utils:
 	tegra_asoc_utils_fini(&machine->util_data);
+err_put_cpu_of_node:
+	of_node_put(tegra_rt5677_dai.cpu_of_node);
+	tegra_rt5677_dai.cpu_of_node = NULL;
+	tegra_rt5677_dai.platform_of_node = NULL;
+err_put_codec_of_node:
+	of_node_put(tegra_rt5677_dai.codec_of_node);
+	tegra_rt5677_dai.codec_of_node = NULL;
 err:
 	return ret;
 }
@@ -296,6 +303,12 @@ static int tegra_rt5677_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini(&machine->util_data);
 
+	tegra_rt5677_dai.platform_of_node = NULL;
+	of_node_put(tegra_rt5677_dai.codec_of_node);
+	tegra_rt5677_dai.codec_of_node = NULL;
+	of_node_put(tegra_rt5677_dai.cpu_of_node);
+	tegra_rt5677_dai.cpu_of_node = NULL;
+
 	return 0;
 }
 
-- 
2.7.4

