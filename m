Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeA3NTy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:19:54 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:37032 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752383AbeA3NTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:19:52 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] ASoC: rt5514: Fix uninitialized calibration value
Date: Tue, 30 Jan 2018 14:19:43 +0100
Message-Id: <1517318383-14420-2-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517318383-14420-1-git-send-email-geert@linux-m68k.org>
References: <1517318383-14420-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc-4.1.2, if CONFIG_SND_SOC_RT5514_SPI is not set:

    sound/soc/codecs/rt5514.c: In function ‘rt5514_dsp_voice_wake_up_put’:
    sound/soc/codecs/rt5514.c:363: warning: ‘buf[0]’ is used uninitialized in this function
    sound/soc/codecs/rt5514.c:363: warning: ‘buf[1]’ is used uninitialized in this function
    sound/soc/codecs/rt5514.c:363: warning: ‘buf[2]’ is used uninitialized in this function
    sound/soc/codecs/rt5514.c:363: warning: ‘buf[3]’ is used uninitialized in this function

Fix this by initializing the buffer with zeroes, to avoid random bits
being written to the calibration register later.

Fixes: fc9cab05837639ce ("ASoC: rt5514: The DSP clock can be calibrated by the other clock source")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/codecs/rt5514.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 19f01558fbca677f..e5fd0114b1fd4d85 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -358,6 +358,7 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 #else
 				dev_err(codec->dev, "There is no SPI driver for"
 					" loading the firmware\n");
+				memset(buf, 0, sizeof(buf));
 #endif
 				rt5514->pll3_cal_value = buf[0] | buf[1] << 8 |
 					buf[2] << 16 | buf[3] << 24;
-- 
2.7.4
