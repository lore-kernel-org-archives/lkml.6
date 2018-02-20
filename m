Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeBTRov (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:44:51 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45330 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbeBTRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:44:47 -0500
X-Google-Smtp-Source: AH8x227PDbHT79vO0+9wHQ6GTd3fcT9z1dP9kWo4FfSvQfTyqWxXpIaXrsWX7Ws2D8D5s1g+8+kHbA==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
Subject: [RESEND PATCH v2 2/2] ASoC: topology: Add missing clock gating parameter when parsing hw_configs
Date: Tue, 20 Feb 2018 18:44:46 +0100
Message-Id: <20180220174446.7784-3-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180220174446.7784-1-k.marinushkin@gmail.com>
References: <20180220174446.7784-1-k.marinushkin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock gating parameter is a part of `dai_fmt`. It is supported by
`alsa-lib` when creating a topology binary file, but ignored by kernel
when loading this topology file.

After applying this commit, the clock gating parameter is not ignored any
more. The old behaviour is not broken, as by default the parameter value
is 0.

For example, the following config, based on
alsa-lib/src/conf/topology/broadwell/broadwell.conf, is now supported:

~~~~
SectionHWConfig."CodecHWConfig" {
        id "1"
        format "I2S"            # physical audio format.
        bclk   "master"         # Platform is master of bit clock
        fsync  "master"         # platform is master of fsync
        pm_gate_clocks "true"   # clock can be gated
}

SectionLink."Codec" {

        # used for binding to the physical link
        id "0"

        hw_configs [
                "CodecHWConfig"
        ]

        default_hw_conf_id "1"
}
~~~~

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/soc-topology.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 01a50413c66f..bac70676a6b4 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1981,6 +1981,13 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
 
 		link->dai_fmt = hw_config->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
+		/* clock gating */
+		if (hw_config->clock_gated == SND_SOC_TPLG_DAI_CLK_GATE_GATED)
+			link->dai_fmt |= SND_SOC_DAIFMT_GATED;
+		else if (hw_config->clock_gated ==
+			 SND_SOC_TPLG_DAI_CLK_GATE_CONT)
+			link->dai_fmt |= SND_SOC_DAIFMT_CONT;
+
 		/* clock signal polarity */
 		invert_bclk = hw_config->invert_bclk;
 		invert_fsync = hw_config->invert_fsync;
-- 
2.13.6
