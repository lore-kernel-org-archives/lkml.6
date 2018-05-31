Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754755AbeEaLGp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:06:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50946 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754441AbeEaLGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:06:37 -0400
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Ryder Lee <ryder.lee@mediatek.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: mediatek: export mtk-afe symbols as needed" to the asoc tree
In-Reply-To: <20180530220057.1419933-1-arnd@arndb.de>
Message-Id: <E1fOLPd-0001zu-1m@debutante>
Date: Thu, 31 May 2018 12:06:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: mediatek: export mtk-afe symbols as needed

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

>From 39f56b757cf9778572041f497f6fad890224c9fb Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 31 May 2018 00:00:35 +0200
Subject: [PATCH] ASoC: mediatek: export mtk-afe symbols as needed

The new mt6797-afe driver uses some functions in a common file, which
works for a built-in driver but fails for a loadable module:

ERROR: "mtk_afe_pcm_free" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_add_sub_dai_control" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_pcm_new" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_combine_sub_dai" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_pcm_ops" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!

This exports the five symbols above for modules.

Fixes: b3c702f56bf5 ("ASoC: mt6797: combine DAI to register component")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/common/mtk-afe-platform-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 00618587ef1e..51ec4ff6ed95 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -57,6 +57,7 @@ int mtk_afe_combine_sub_dai(struct mtk_base_afe *afe)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_afe_combine_sub_dai);
 
 int mtk_afe_add_sub_dai_control(struct snd_soc_component *component)
 {
@@ -90,6 +91,7 @@ int mtk_afe_add_sub_dai_control(struct snd_soc_component *component)
 	return 0;
 
 }
+EXPORT_SYMBOL_GPL(mtk_afe_add_sub_dai_control);
 
 static snd_pcm_uframes_t mtk_afe_pcm_pointer
 			 (struct snd_pcm_substream *substream)
@@ -130,6 +132,7 @@ const struct snd_pcm_ops mtk_afe_pcm_ops = {
 	.ioctl = snd_pcm_lib_ioctl,
 	.pointer = mtk_afe_pcm_pointer,
 };
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_ops);
 
 int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
@@ -143,11 +146,13 @@ int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 						     afe->dev,
 						     size, size);
 }
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_new);
 
 void mtk_afe_pcm_free(struct snd_pcm *pcm)
 {
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_free);
 
 const struct snd_soc_component_driver mtk_afe_pcm_platform = {
 	.name = AFE_PCM_NAME,
-- 
2.17.0
