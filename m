Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeBSGGM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 01:06:12 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54361 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeBSGGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 01:06:11 -0500
X-Google-Smtp-Source: AH8x227yDNJoEveoipQxTv+79pgbV/o1+RNxlA+2rGv1SBi55mn1MWF4KgjeLu+PTFYpandGZH4ULQ==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoC: topology: Add missing clock gating parameter when parsing hw_configs
Date: Mon, 19 Feb 2018 07:05:31 +0100
Message-Id: <20180219060531.17276-2-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180219060531.17276-1-k.marinushkin@gmail.com>
References: <20180219060531.17276-1-k.marinushkin@gmail.com>
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
        pm_cont_clock "true"    # clock is continuous, and can not be gated
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
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/soc-topology.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 01a50413c66f..21bd4f96348d 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1981,6 +1981,12 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
 
 		link->dai_fmt = hw_config->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
+		/* clock gating */
+		if (hw_config->clock_cont)
+			link->dai_fmt |= SND_SOC_DAIFMT_CONT;
+		else
+			link->dai_fmt |= SND_SOC_DAIFMT_GATED;
+
 		/* clock signal polarity */
 		invert_bclk = hw_config->invert_bclk;
 		invert_fsync = hw_config->invert_fsync;
-- 
2.13.6
