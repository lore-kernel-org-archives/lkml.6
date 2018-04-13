Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754561AbeDMK5i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:57:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47686 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754424AbeDMKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:55:50 -0400
From: Mark Brown <broonie@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: intel: skl_nau88l25_ssm4567: Replace GFP_ATOMIC with GFP_KERNEL in skylake_audio_probe" to the asoc tree
In-Reply-To: <1523270974-23082-1-git-send-email-baijiaju1990@gmail.com>
Message-Id: <E1f6wMp-000776-MO@debutante>
Date: Fri, 13 Apr 2018 11:55:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: intel: skl_nau88l25_ssm4567: Replace GFP_ATOMIC with GFP_KERNEL in skylake_audio_probe

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

>From fe552c82476f2fb16e87a76ee178465325e57f61 Mon Sep 17 00:00:00 2001
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Mon, 9 Apr 2018 18:49:34 +0800
Subject: [PATCH] ASoC: intel: skl_nau88l25_ssm4567: Replace GFP_ATOMIC with
 GFP_KERNEL in skylake_audio_probe

skylake_audio_probe() is never called in atomic context.
This function is only set as ".probe" in "struct platform_driver".

Despite never getting called from atomic context,
skylake_audio_probe() calls devm_kzalloc() with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
to avoid busy waiting and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 212ac8971e55..b0610bba3cfa 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -696,7 +696,7 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	struct skl_nau88125_private *ctx;
 	struct skl_machine_pdata *pdata;
 
-	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
-- 
2.17.0
