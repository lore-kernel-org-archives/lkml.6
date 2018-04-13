Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbeDMK43 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:56:29 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48738 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754256AbeDMK4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:56:25 -0400
From: Mark Brown <broonie@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        sathyanarayana.nujella@intel.com, Adam.Thomson.Opensource@diasemi.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: intel: bxt_da7219_max98357a: Replace GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe" to the asoc tree
In-Reply-To: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
Message-Id: <E1f6wNN-0007DY-4j@debutante>
Date: Fri, 13 Apr 2018 11:56:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: intel: bxt_da7219_max98357a: Replace GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe

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

>From 8f2f9215aa14904ddd9775f3b4e7af2d94189dea Mon Sep 17 00:00:00 2001
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Mon, 9 Apr 2018 18:46:21 +0800
Subject: [PATCH] ASoC: intel: bxt_da7219_max98357a: Replace GFP_ATOMIC with
 GFP_KERNEL in broxton_audio_probe

broxton_audio_probe() is never called in atomic context.
This function is only set as ".probe" in "struct platform_driver".

Despite never getting called from atomic context,
broxton_audio_probe() calls devm_kzalloc() with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
to avoid busy waiting and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 668c0934e942..40eb979d5ac1 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -571,7 +571,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
 {
 	struct bxt_card_private *ctx;
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
-- 
2.17.0
