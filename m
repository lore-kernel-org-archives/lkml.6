Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbeCSIJT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:09:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58100 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeCSIJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:09:13 -0400
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org,
        Jernej =?ISO-8859-2?Q?=A9krabec?= <jernej.skrabec@siol.net>,
        linux-kernel@vger.kernel.org, wens@csie.org,
        maxime.ripard@free-electrons.com, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "soc-core: don't call kfree() for component" to the asoc tree
In-Reply-To: <87h8pq166i.wl%kuninori.morimoto.gx@renesas.com>
Message-Id: <20180319080854.94EE3440079@finisterre.ee.mobilebroadband>
Date: Mon, 19 Mar 2018 08:08:54 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   soc-core: don't call kfree() for component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7ecbd6a91b1e9bb90a4f3be641669347aacc5ab5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 19 Mar 2018 07:27:17 +0000
Subject: [PATCH] soc-core: don't call kfree() for component

When driver register its component to ALSA SoC, almost all drivers are
using snd_soc_register_component(), but soc-generic-dmaengine-pcm is
using snd_soc_add_component().

Existing component function had been assumed that registered component
was allocated, and it calling kfree() for it.
But, the user who used snd_soc_add_component() doesn't.

This patch uses devm_kzalloc() instead of kzalloc() for component,
and doesn't call kree() anymore.
This patch fixes commit be7ee5f32a9a ("ASoC: soc-generic-dmaengine-pcm:
replace platform to component").
Allwinner H3 SoC will crash without this patch.
Thanks Jernej report.

Reported-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9558125b448d..8b1ef90f7b57 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3454,7 +3454,6 @@ int snd_soc_add_component(struct device *dev,
 err_cleanup:
 	snd_soc_component_cleanup(component);
 err_free:
-	kfree(component);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_component);
@@ -3466,7 +3465,7 @@ int snd_soc_register_component(struct device *dev,
 {
 	struct snd_soc_component *component;
 
-	component = kzalloc(sizeof(*component), GFP_KERNEL);
+	component = devm_kzalloc(dev, sizeof(*component), GFP_KERNEL);
 	if (!component)
 		return -ENOMEM;
 
@@ -3501,7 +3500,6 @@ static int __snd_soc_unregister_component(struct device *dev)
 
 	if (found) {
 		snd_soc_component_cleanup(component);
-		kfree(component);
 	}
 
 	return found;
-- 
2.16.2
