Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934745AbeBLMwd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:52:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51882 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbeBLMwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:52:31 -0500
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: wm_adsp: Don't init cache from DSP memory if control is write-only" to the asoc tree
In-Reply-To: <20180205113817.16470-1-rf@opensource.cirrus.com>
Message-Id: <E1elDau-0006Xq-1z@debutante>
Date: Mon, 12 Feb 2018 12:52:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm_adsp: Don't init cache from DSP memory if control is write-only

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

>From 04ff40a983e864b586f189b4c3503b6f61263643 Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.cirrus.com>
Date: Mon, 5 Feb 2018 11:38:17 +0000
Subject: [PATCH] ASoC: wm_adsp: Don't init cache from DSP memory if control is
 write-only

For controls marked write-only don't initialize the cache from the
content of the DSP memory. We stil need the cache for any new data
that is written to this control, and we need to return something
for a read of the ALSA control because most user-side code assumes
all ALSA controls are readable. The cache is already created zero-
filled so the only change needed is to skip populating it from
DSP memory if the control isn't readable.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 66e32f5d2917..0060aeb63a9f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1237,9 +1237,16 @@ static int wm_coeff_init_control_caches(struct wm_adsp *dsp)
 		if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
 			continue;
 
-		ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
-		if (ret < 0)
-			return ret;
+		/*
+		 * For readable controls populate the cache from the DSP memory.
+		 * For non-readable controls the cache was zero-filled when
+		 * created so we don't need to do anything.
+		 */
+		if (!ctl->flags || (ctl->flags & WMFW_CTL_FLAG_READABLE)) {
+			ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.16.1
