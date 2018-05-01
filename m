Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeEAVH1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 17:07:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47508 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeEAVH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 17:07:26 -0400
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: dai playback and capture active may be greater than 1" to the asoc tree
In-Reply-To: <20180419140612.11049-1-jbrunet@baylibre.com>
Message-Id: <20180501210718.47E4B44007A@finisterre.ee.mobilebroadband>
Date: Tue,  1 May 2018 22:07:18 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dai playback and capture active may be greater than 1

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

>From 40c57963789d451c26269e3bc9f9e803060fd9af Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 27 Apr 2018 13:31:51 +0200
Subject: [PATCH] ASoC: dai playback and capture active may be greater than 1

At the moment playback_active and capture_active are using only 1 bit so
the maximum active count is 1.

However, snd_soc_runtime_activate() may be called several time on the
same dai. This happens when a dai is part of several dai_links. It is
often the case for "snd-soc-dummy-dai".

This is a problem if snd_soc_runtime_activate() is called an even number
of times on a dai. In this case the active count overflow back to 0. As
consequence, ASoC functions, such as soc_dpcm_runtime_update(), won't run
correctly.

Storing these usage counts on plain 'unsigned int' solves the problem.

Fixes: f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 8ad11669e4d8..35ebb0be5114 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -294,8 +294,8 @@ struct snd_soc_dai {
 	struct snd_soc_dai_driver *driver;
 
 	/* DAI runtime info */
-	unsigned int capture_active:1;		/* stream is in use */
-	unsigned int playback_active:1;		/* stream is in use */
+	unsigned int capture_active;		/* stream usage count */
+	unsigned int playback_active;		/* stream usage count */
 	unsigned int probed:1;
 
 	unsigned int active;
-- 
2.17.0
