Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932539AbeE3WHa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 18:07:30 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41709 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753587AbeE3WH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 18:07:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: unhide snd_soc_new_compress() declaration
Date: Thu, 31 May 2018 00:06:03 +0200
Message-Id: <20180530220628.1613824-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:zo7ZsdWUAL+5d2VAO/P3sx4J9wU5AU2UYT5zZHWTqgfm2zGKQh4
 jzX8r68lzHZ7ENbTWREM6i0jigQ1V6wwSCHNNaFCtuisy1qHMB5VZJFx9cz4Z+g3qZSZyj9
 w/ZqlCR4bVRh5FeD/JZAVuLwphwhVVIGMEY9L4pta45LMTgG7Gvp4Fhq6k/Q7LxCDzB2Hfr
 Mv9u3CQm9Nzl/+e2Z2a5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qQV5uOLA3x4=:4W0gFgKzGnx+fMzFFW9KLo
 ny0+pCgYB6gjMrdbGoIDRablytFUd7h5iM92sOEz0f4zkxyhE6LPOmNfUz8C8rF8fI2VfUqqL
 7PIs8SiDXXeuGcouQ8XmkeKD+NvVvaiVPVgqY+M1ArMw5HAJyUFjWGXd3euyQJiAg4BxWOBsA
 +3uAYBXMyAeKVyJ2B6h3IUdbomngn4l8+fR+tgwsIKNxfQnGgEOP8Q5tdcZnKWIYr9hgu70Ab
 RikXIXNZ3FSKJzC05lMIqdsFCwy8tLn7zKihkEMwJg35IozIATdaJSSkQKuPcuRwDe9wqbziN
 ovwChMV1nUvLMVqa8Mt1aQUmVa+5DNwkHzr0LlUA9RVEVnaSfxmOx0deKcAlTNhZUNP3e09jq
 z4saAuHHDbVg2dV/OSo6rf7PTWaCDgIOOSCHTQv8Sn8MDWj+yuD/5Eod9/vECm1BcVf2DrUWH
 hLvrlRoThFo10UHvhiXsaBqswvWfvzmnNVxhv2GzZVqS8hWioGL/bMyCEHnCzg4p+7j1MMFM2
 QEsMIaMC/2kXPRWQWFFPoV3CClBf6aLGJbzabZwInuTITCxs0n+IsHR9TQeUI8IsRPAJOYv4q
 gStmQA7InfiDr/z7YSwk/FyP5GrWqii3+hPK4zAMgglylJaMkMrkj0+CRqlq9arFnDkK5d7Eb
 rqGJqr3Ia6lIlBcYe1tSNBxkd0We0fjBhVBthTjMeCV2vj9ILj6/obFiM4S8vtyr1QJQ=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My randconfig build setup came across a new build failure today:

sound/soc/soc-topology.c: In function 'soc_tplg_dai_create':
sound/soc/soc-topology.c:1758:27: error: 'snd_soc_new_compress' undeclared (first use in this function); did you mean 'snd_soc_compr_ops'?
   dai_drv->compress_new = snd_soc_new_compress;

Simply making that prototype visible again fixes the build failure
for me, though I'm not exactly sure why we don't get a link
error now.

The reference to snd_soc_new_compress() was added a few weeks
ago and seems to have caused the problem.

Fixes: 5db6aab6f36f ("ASoC: topology: Add support for compressed PCMs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/soc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 600a7ebd10c0..8e073865bde3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -460,9 +460,7 @@ struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
 						   const char *driver_name);
 
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
-#ifdef CONFIG_SND_SOC_COMPRESS
 int snd_soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num);
-#endif
 
 void snd_soc_disconnect_sync(struct device *dev);
 
-- 
2.9.0
