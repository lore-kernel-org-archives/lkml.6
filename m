Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755612AbeEaQJn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 12:09:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51390 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755578AbeEaQJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 12:09:41 -0400
From: Mark Brown <broonie@kernel.org>
To: Xie Yisheng <xieyisheng1@huawei.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, Yisheng Xie <xieyisheng1@huawei.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Yisheng Xie <xieyisheng1@huawei.com>, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: dapm: use match_string() helper" to the asoc tree
In-Reply-To: <1526903890-35761-34-git-send-email-xieyisheng1@huawei.com>
Message-Id: <E1fOQ8w-0003A4-5a@debutante>
Date: Thu, 31 May 2018 17:09:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dapm: use match_string() helper

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

>From f9e0b4afd4e9b19e95158962d81b5b776d57ca06 Mon Sep 17 00:00:00 2001
From: Xie Yisheng <xieyisheng1@huawei.com>
Date: Thu, 31 May 2018 19:11:23 +0800
Subject: [PATCH] ASoC: dapm: use match_string() helper

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2d9709104ec5..1e9a36389667 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -724,18 +724,14 @@ static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
 		item = 0;
 	}
 
-	for (i = 0; i < e->items; i++) {
-		if (!(strcmp(control_name, e->texts[i]))) {
-			path->name = e->texts[i];
-			if (i == item)
-				path->connect = 1;
-			else
-				path->connect = 0;
-			return 0;
-		}
-	}
+	i = match_string(e->texts, e->items, control_name);
+	if (i < 0)
+		return -ENODEV;
+
+	path->name = e->texts[i];
+	path->connect = (i == item);
+	return 0;
 
-	return -ENODEV;
 }
 
 /* set up initial codec paths */
-- 
2.17.0
