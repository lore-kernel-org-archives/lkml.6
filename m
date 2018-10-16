Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D22C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B2620881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B2620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeJPSjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:39:09 -0400
Received: from mout.perfora.net ([74.208.4.194]:46115 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbeJPSjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:39:08 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MFrWa-1gP4jd3ndO-00EvqI; Tue, 16 Oct 2018 12:48:04 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MFrWa-1gP4jd3ndO-00EvqI; Tue, 16 Oct 2018 12:48:04 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2 8/9] ASoC: tegra_sgtl5000: fix device_node refcounting
Date:   Tue, 16 Oct 2018 12:47:29 +0200
Message-Id: <20181016104730.4598-9-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181016104730.4598-1-marcel@ziswiler.com>
References: <20181016104730.4598-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:7TKYwea7pN/FWXKM2Q9kNjlXDrov0p69mKi9DQOv0CigpMCpmmc
 kob2L8tHU6iGejBFVZKzaRpmEAjuN0cF3PXJBWzgLRAGFevl/3Yp8BGnpdLdf7pj22J2OEh
 5/nhOBF7qtXlGWqFbxQkGqFVNsx/6jo/ABLZSqPP81dNlY+iT+ozXbKt8kYHyln/7W99hyd
 2UlkfMUt+qHamyyY7/fsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GG2omMcOvbQ=:pA8YgHqtjekhBq7pBHqxoI
 IhIFE81AouqFaqljSnIM8sdpsVACEXFrkngdFs2Ua6o5zf9XmSh9+WwnSBto/4bjmezMxCp7f
 bMb6s3hPGZSekx/5+h8PmuI/VF/RCtBic7+I/AGoIi7nKydE2z3IN29QAm4lvEcxOmCUvbaQr
 CugDw5ncPquW/L/ua8qcUTPSy84k0X76DBw7mP4J02jPZ+awU3fhPtrbjE8OMPBftwff49Mfb
 YiS7LIAPJGs+tvBYESOIJfqY5OX34ml/5PB/V103HbRLScbHPZrc9HSOBywZquvL6riNQFWgl
 y/UPdtGG1lItAyPeFIInk6bZQ6zUN5Hy7hfZ8Rz3cLM3BU3RMopsLGOVEL+1DVZR65t86OIev
 hr7gM8WfAe+A+kHj+7mK5cljZkTDaHOZwiT5o5iqA7xbI/8XgVvXZMgZMX+jKoDIkmSgVAmqf
 Spi7jhvXH4anVp1KdFptRWdPlFko5+lD26ebgEtfmvM+XS1Qlym+bpbCNyecHypHrVi+z2aXd
 ZAZwYc2s51/5ra8OZ6EhtRxTzcVkb14icOXI9gioOY8U30GZcAcAl0QAHYnwG4rwzjGv2RIpY
 EEqPDSlIXjM+N+EZ+qbyxnFHx3IrJUOtOdYhrl+/RaMEPYp/97AhJ5kKs4mZC+Wa1caahfmNi
 F+g13naxEgQIyGMXAq9nrFbULvTuOEsIwWc0A7UiSkLuaXa1rlpqWBMDF1b2xaaQ7e1g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Similar to the following:

commit 4321723648b0 ("ASoC: tegra_alc5632: fix device_node refcounting")

commit 7c5dfd549617 ("ASoC: tegra: fix device_node refcounting")

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: New patch

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

