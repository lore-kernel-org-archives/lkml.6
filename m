Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757509AbeD0LcE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:32:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54950 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeD0LcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:32:03 -0400
X-Google-Smtp-Source: AB8JxZpB0+6Pq75vz7kM/H935azIjXNKJiEfhqgGWUKPeUNGW/kIxrTw9mnibzZK71+MEHNtPCq8Hg==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Greer <mgreer@baylibre.com>
Subject: [PATCH] ASoC: dai playback and capture active  may be greater than 1
Date: Fri, 27 Apr 2018 13:31:51 +0200
Message-Id: <20180427113151.19299-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

Hi,

I found this problem while working on ASoC support for a new platform.
During a playback, using DPCM, if I changed the backend dai, nothing
happened, old backend path is not pruned, new backend path is not added.

Here is how it goes:
1 FE and 2 BE, all 3 using snd-soc-dummy-dai for the codec_dai (ATM).

On playback start:
 - BE #1 activates and increments snd-soc-dummy-dai's playback_active
 - FE activates and increments snd-soc-dummy-dai's playback_active

The playback works but snd-soc-dummy-dai's playback_active value is now 0.

Through a mux kcontrol, change BE client of FE, from BE #1 to BE #2.
 -> trigger soc_dpcm_runtime_update().
    -> checks fe's codec_dai playback_active which is zero so playback
    path processing is skipped, keeping the old invalid path.

 * No change since initial RFC [0], just droppped the RFC prefix.

[0]: https://lkml.kernel.org/r/20180419140612.11049-1-jbrunet@baylibre.com

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
2.14.3
