Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbeDMLYM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:24:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:39042 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754567AbeDMLYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:24:10 -0400
From: Mark Brown <broonie@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mka@chromium.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: intel: cht_bsw_max98090_ti: Replace GFP_ATOMIC with GFP_KERNEL in snd_cht_mc_probe" to the asoc tree
In-Reply-To: <1523270890-22889-1-git-send-email-baijiaju1990@gmail.com>
Message-Id: <E1f6woG-0000Cp-D7@debutante>
Date: Fri, 13 Apr 2018 12:24:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: intel: cht_bsw_max98090_ti: Replace GFP_ATOMIC with GFP_KERNEL in snd_cht_mc_probe

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

>From f0a0bdcf34579b08acfe0179ad46da4dc123fc91 Mon Sep 17 00:00:00 2001
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Mon, 9 Apr 2018 18:48:10 +0800
Subject: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Replace GFP_ATOMIC with
 GFP_KERNEL in snd_cht_mc_probe

snd_cht_mc_probe() is never called in atomic context.
This function is only set as ".probe" in "struct platform_driver".

Despite never getting called from atomic context,
snd_cht_mc_probe() calls devm_kzalloc() with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
to avoid busy waiting and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index d3e1c7e12004..db6976f4ddaa 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -391,7 +391,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	int ret_val = 0;
 	struct cht_mc_private *drv;
 
-	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 
-- 
2.17.0
