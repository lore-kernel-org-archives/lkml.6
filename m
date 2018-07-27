Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB33C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F94920842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F94920842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbeG0Wa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 18:30:57 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52938 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389317AbeG0Wa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 18:30:57 -0400
Received: from localhost.localdomain (ppp85-140-182-137.pppoe.mtu-net.ru [85.140.182.137])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6CB3F54006B;
        Sat, 28 Jul 2018 00:07:15 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] ASoC: tegra_alc5632: fix device_node refcounting
Date:   Sat, 28 Jul 2018 00:06:59 +0300
Message-Id: <1532725619-8775-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tegra_alc5632_probe() increments reference count of device nodes
with of_parse_phandle(), but there is no code decrementing them
in the driver.

The patch adds of_node_put() to tegra_alc5632_remove() and
to error handling paths in the probe.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 sound/soc/tegra/tegra_alc5632.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index 5197d6b18cb6..98d87801d57a 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -190,14 +190,14 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Property 'nvidia,i2s-controller' missing or invalid\n");
 		ret = -EINVAL;
-		goto err;
+		goto err_put_codec_of_node;
 	}
 
 	tegra_alc5632_dai.platform_of_node = tegra_alc5632_dai.cpu_of_node;
 
 	ret = tegra_asoc_utils_init(&alc5632->util_data, &pdev->dev);
 	if (ret)
-		goto err;
+		goto err_put_cpu_of_node;
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
@@ -210,6 +210,13 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
 
 err_fini_utils:
 	tegra_asoc_utils_fini(&alc5632->util_data);
+err_put_cpu_of_node:
+	of_node_put(tegra_alc5632_dai.cpu_of_node);
+	tegra_alc5632_dai.cpu_of_node = NULL;
+	tegra_alc5632_dai.platform_of_node = NULL;
+err_put_codec_of_node:
+	of_node_put(tegra_alc5632_dai.codec_of_node);
+	tegra_alc5632_dai.codec_of_node = NULL;
 err:
 	return ret;
 }
@@ -223,6 +230,12 @@ static int tegra_alc5632_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini(&machine->util_data);
 
+	of_node_put(tegra_alc5632_dai.cpu_of_node);
+	tegra_alc5632_dai.cpu_of_node = NULL;
+	tegra_alc5632_dai.platform_of_node = NULL;
+	of_node_put(tegra_alc5632_dai.codec_of_node);
+	tegra_alc5632_dai.codec_of_node = NULL;
+
 	return 0;
 }
 
-- 
2.7.4

