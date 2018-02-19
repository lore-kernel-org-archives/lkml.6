Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932139AbeBSUgm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:36:42 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34972 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932108AbeBSUgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:36:40 -0500
X-Google-Smtp-Source: AH8x2253iqN7TqqC5szcL6aLfJA1H32MlEPYrN41hMZZK6XN0o6OKE9YqieclraET+hW7CrGTQQsSQ==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ASoC: topology: Add missing clock gating parameter when parsing hw_configs
Date: Mon, 19 Feb 2018 21:36:35 +0100
Message-Id: <20180219203636.3692-2-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180219203636.3692-1-k.marinushkin@gmail.com>
References: <458b66ab-da0a-8063-6555-13fb152c83a4@sakamocchi.jp>
 <20180219203636.3692-1-k.marinushkin@gmail.com>
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
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
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
