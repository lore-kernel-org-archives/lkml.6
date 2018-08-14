Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ACCC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 470D9216F2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470D9216F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbeHNQuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:50:13 -0400
Received: from mout.perfora.net ([74.208.4.194]:46343 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbeHNQuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:50:12 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MMVI0-1fnxb0420s-008I1Z; Tue, 14 Aug 2018 16:01:57 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org
Cc:     Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH v2] ASoC: tegra: probe deferral error reporting
Date:   Tue, 14 Aug 2018 16:01:44 +0200
Message-Id: <20180814140145.12212-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:Sayw6tQDNtlkZY1En5ZSgkELCTwmLGy/4JkqynxVNaiDeHAaB8Y
 f0JpTn84ty3WJzOjkf9FB2ku9G1gVuRTwZNY32HTtESWWAMZp+74ms7cjHwhjJRx6RY5Oqb
 YA9r3WhgVEMufMmxILEzh/5FMQ2Scasi/EPnjpif+TWaETPbnOApM5t7E7qGLRnaRJ6Kl8I
 Gr5UjLT6XfRxw1bNzEwgA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e1lenST1Pc8=:f9S0bhjspiSZqPD317KrBg
 +OUu5NYXmb78Yz8gYx8vDh6ZCNzWCIMyujOgwxRwOgDk8KLvpVePWWqgqkMV7ouwgxD4y3G+n
 I0ofvdck/qG9lFDSgoV6mFQtT7mBep3UexNnfese4qCX4pz7K+5B0B85fVbXSCQqXxBHin2fK
 hgtdYIxUbtqBmfE2tgGcwveYe7S7CG75YJ/GA7oyOBVJyEaJ8iAud2OPzPo/1cfLW/D9LRk98
 EPSJWVFbLhUG3DV1ry5NqgfBTLt7IyQgAuyJRE2cSp07OdQtGyb979p1NxgdVZyW+kE3R2CGM
 L/ONFFpBUzpEp1COhmGycLCF1CJKb4JMzyHHVDgMRKEBipMgFKfSm72clAXUnLUIR4QctqswE
 yRiNFNsXJyx1oSLQK0OYz0HTNuF/sGE+V6n+emIrSZKQs1o9tpgH8yleYLOmcD14HcOLUscy9
 E/OSRYs5EJI4osRQioMoyOD2/euWCWoIonqTwjhpNhO7VPmphXzazd8Y91HAcZRIhVlcKAisu
 oImV0lF5/fVu35DuVfBIde8qd/rW4qpCsD/aMOrdGwbH6qdsiEBNRmH0twKOmY0rUlYmytx5x
 xxZDjqoMft2h64sg8JvPmLMucCCvTecwXrzpEBWHoHSiBojT3KJio7FpZx26Ix3Nm0fcQ77AY
 AH/dEumriqhF7IDbcKU1FGQwSxG3vfbb093VGnXS4xIvn6wEj3it5bVNX/3fhrQCHd6g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Actually report the error codes from of_get_named_gpio() resp.
devm_gpio_request_one() upon trying to get the codec reset resp. sync
GPIOs unless it is just a probe deferral.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- Silence probe deferral as suggested by Stefan.
- Fix line over 80 characters as reported by checkpatch.

 sound/soc/tegra/tegra20_ac97.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index 682ef33afb5f..2ac6b2d73980 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -351,18 +351,31 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 		ret = devm_gpio_request_one(&pdev->dev, ac97->reset_gpio,
 					    GPIOF_OUT_INIT_HIGH, "codec-reset");
 		if (ret) {
-			dev_err(&pdev->dev, "could not get codec-reset GPIO\n");
+			if (ret != -EPROBE_DEFER)
+				dev_err(&pdev->dev,
+					"could not get codec-reset GPIO: %d\n",
+					ret);
+
 			goto err_clk_put;
 		}
 	} else {
-		dev_err(&pdev->dev, "no codec-reset GPIO supplied\n");
+		ret = ac97->reset_gpio;
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"no codec-reset GPIO supplied: %d\n",
+				ret);
+
 		goto err_clk_put;
 	}
 
 	ac97->sync_gpio = of_get_named_gpio(pdev->dev.of_node,
 					    "nvidia,codec-sync-gpio", 0);
 	if (!gpio_is_valid(ac97->sync_gpio)) {
-		dev_err(&pdev->dev, "no codec-sync GPIO supplied\n");
+		ret = ac97->sync_gpio;
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "no codec-sync GPIO supplied: %d\n",
+				ret);
+
 		goto err_clk_put;
 	}
 
-- 
2.14.4

