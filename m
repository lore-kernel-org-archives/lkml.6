Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819FCECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5466F2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5466F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeJRTUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:20:15 -0400
Received: from mout.perfora.net ([74.208.4.194]:57799 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbeJRTUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:20:15 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MacbH-1ftV8t3ldp-00K7TE; Thu, 18 Oct 2018 13:18:43 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MacbH-1ftV8t3ldp-00K7TE; Thu, 18 Oct 2018 13:18:43 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v1 1/3] ASoC: tegra_sgtl5000: fix device_node refcounting
Date:   Thu, 18 Oct 2018 13:18:27 +0200
Message-Id: <20181018111829.27056-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181018111829.27056-1-marcel@ziswiler.com>
References: <20181018111829.27056-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:h/RwB9KJSeshyjTp77xr2mPVM7dco829n86Dq8wxKpnlzn2pE4v
 DbDs+3TIMI7qUrUIrJtQHkIiZxptkRySzFRLkHq8ivFIVWouxpNIYeOgJCkAoAgcfagbjh1
 UVdKlJmjMVFeO+Bx+1Vhh1WytoxHYS06R5fxKxAFa8nef5sf5IKJHMw2PP+k53SOoFULebA
 GY10TFDx7bJ1vCcea684g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jA1xLb7G+uQ=:FUsTvKVxL4HmK1TbnmKvX2
 ts4Qvi2FKGGsifaGKNcMDHkmxwTfRrvwX4yW3Hhu8HJh+kJG50ijETD8hsQ53yMD+Ng9deLMj
 Zrnpg6FGmngJJQMEJU/jbkjm/QaNk4w+RqILNu51f0nqLjyn2BXRyVI7Dl2kilh0zhCWgGrwy
 KHZcAYG7EPb7JPF/HINqn6aW673eS6ptCI9VsjmamMYDjC6uQhxoxwRldXoZTtKJCg1zzZ/5X
 vcHsl1v5KPK2DWM+pYZjZxQT5Vwrrrc6i1hIy1tMFqXx/aD+MGb29eIhW/bxXeudHv7KAXPbF
 etoH1taDEg9fZg4jHqlsuV5dww6eXoCpkNHbAnxGGvXvC/hHVZB83F+1cDODTyR8TgzNeBTaY
 NIRtoSYA/R/nrnvOCQH4UQDqaHg1wm/ZS2ImkwcfCrQgOZgNF/pqJc4odlEwe8ZiZx/wnNTfb
 S96OGMAYIITlcq5a/LOn0MY45H7W/Od2MVobVboZ9K0FYavdSadYS9egoRNeUGdOL7WMFaTOC
 KTZlUgXvK+EOJqi7bb+x3QxL++fYVFcwM3sDLazCwA7DuiJk03oKhILkkT5tHdXC0eakgweXc
 mJYiY2bM53SjRraFAgUvYsKRcE4LkXbCm7NyM3QVwf6yCQxCUiIl/jcuXDleAjT1Wmx8DjO8d
 6WY/3UxPiKry2TU6CGaGrjc8g6QxP295XBpX8ETyg03o04CHopYzmYgWfCXXus3wbSBw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Similar to the following:

commit 4321723648b0 ("ASoC: tegra_alc5632: fix device_node refcounting")

commit 7c5dfd549617 ("ASoC: tegra: fix device_node refcounting")

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>

---

Changes in v1: None

 sound/soc/tegra/tegra_sgtl5000.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_sgtl5000.c b/sound/soc/tegra/tegra_sgtl5000.c
index 45a4aa9d2a47..901457da25ec 100644
--- a/sound/soc/tegra/tegra_sgtl5000.c
+++ b/sound/soc/tegra/tegra_sgtl5000.c
@@ -149,14 +149,14 @@ static int tegra_sgtl5000_driver_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Property 'nvidia,i2s-controller' missing/invalid\n");
 		ret = -EINVAL;
-		goto err;
+		goto err_put_codec_of_node;
 	}
 
 	tegra_sgtl5000_dai.platform_of_node = tegra_sgtl5000_dai.cpu_of_node;
 
 	ret = tegra_asoc_utils_init(&machine->util_data, &pdev->dev);
 	if (ret)
-		goto err;
+		goto err_put_cpu_of_node;
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
@@ -169,6 +169,13 @@ static int tegra_sgtl5000_driver_probe(struct platform_device *pdev)
 
 err_fini_utils:
 	tegra_asoc_utils_fini(&machine->util_data);
+err_put_cpu_of_node:
+	of_node_put(tegra_sgtl5000_dai.cpu_of_node);
+	tegra_sgtl5000_dai.cpu_of_node = NULL;
+	tegra_sgtl5000_dai.platform_of_node = NULL;
+err_put_codec_of_node:
+	of_node_put(tegra_sgtl5000_dai.codec_of_node);
+	tegra_sgtl5000_dai.codec_of_node = NULL;
 err:
 	return ret;
 }
@@ -183,6 +190,12 @@ static int tegra_sgtl5000_driver_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini(&machine->util_data);
 
+	of_node_put(tegra_sgtl5000_dai.cpu_of_node);
+	tegra_sgtl5000_dai.cpu_of_node = NULL;
+	tegra_sgtl5000_dai.platform_of_node = NULL;
+	of_node_put(tegra_sgtl5000_dai.codec_of_node);
+	tegra_sgtl5000_dai.codec_of_node = NULL;
+
 	return ret;
 }
 
-- 
2.14.4

