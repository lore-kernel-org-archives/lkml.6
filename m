Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeA3NTw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:19:52 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:55024 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeA3NTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:19:51 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] ASoC: rt5514: Fix rt5514_spi_burst_read() buffer passing
Date: Tue, 30 Jan 2018 14:19:42 +0100
Message-Id: <1517318383-14420-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rt5514_dsp_voice_wake_up_put() passes "(u8 *)&buf" to
rt5514_spi_burst_read(), where the cast is needed to silence a compiler
warning:

    sound/soc/codecs/rt5514.c: In function ‘rt5514_dsp_voice_wake_up_put’:
    sound/soc/codecs/rt5514.c:357: warning: passing argument 2 of ‘rt5514_spi_burst_read’ from incompatible pointer type

However, as the variable is declared as an array ("u8 buf[8]"), the
function should just pass "buf" instead.

Fixes: fc9cab05837639ce ("ASoC: rt5514: The DSP clock can be calibrated by the other clock source")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/codecs/rt5514.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 198df016802f826d..19f01558fbca677f 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -354,8 +354,7 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 				msleep(20);
 #if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
 				rt5514_spi_burst_read(RT5514_PLL3_CALIB_CTRL6 |
-					RT5514_DSP_MAPPING,
-					(u8 *)&buf, sizeof(buf));
+					RT5514_DSP_MAPPING, buf, sizeof(buf));
 #else
 				dev_err(codec->dev, "There is no SPI driver for"
 					" loading the firmware\n");
-- 
2.7.4
