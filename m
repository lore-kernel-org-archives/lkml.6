Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeDDETa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 00:19:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53578 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751559AbeDDET1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 00:19:27 -0400
X-Google-Smtp-Source: AIpwx4+w/4T9MIcRnzQXhv1equRQkMug9UMXbhXrBvRhD8pQiX4tp1TJLvya40y9XipFD0Wr9C2uWA==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH v4 2/3] ASoC: topology: Add missing clock gating parameter when parsing hw_configs
Date: Wed,  4 Apr 2018 06:19:38 +0200
Message-Id: <20180404041939.23317-3-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180404041939.23317-1-k.marinushkin@gmail.com>
References: <20180404041939.23317-1-k.marinushkin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock gating parameter is a part of `dai_fmt`. It is supported by
`alsa-lib` when creating a topology binary file, but ignored by kernel
when loading this topology file.

After applying this commit, the clock gating parameter is not ignored any
more. This solution is backwards compatible. The existing behaviour is
not broken, because by default the parameter value is 0 and is ignored.

snd_soc_tplg_hw_config.clock_gated = 0 => no effect
snd_soc_tplg_hw_config.clock_gated = 1 => SND_SOC_DAIFMT_GATED
snd_soc_tplg_hw_config.clock_gated = 2 => SND_SOC_DAIFMT_CONT

For example, the following config, based on
alsa-lib/src/conf/topology/broadwell/broadwell.conf, is now supported:

~~~~
SectionHWConfig."CodecHWConfig" {
        id "1"
        format "I2S"            # physical audio format.
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
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
---
 include/uapi/sound/asoc.h | 7 ++++++-
 sound/soc/soc-topology.c  | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index f0e5e21efa54..f3c4b46e39d8 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -139,6 +139,11 @@
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
 #define SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
 
+/* DAI clock gating */
+#define SND_SOC_TPLG_DAI_CLK_GATE_UNDEFINED	0
+#define SND_SOC_TPLG_DAI_CLK_GATE_GATED	1
+#define SND_SOC_TPLG_DAI_CLK_GATE_CONT		2
+
 /* DAI physical PCM data formats.
  * Add new formats to the end of the list.
  */
@@ -324,7 +329,7 @@ struct snd_soc_tplg_hw_config {
 	__le32 size;            /* in bytes of this structure */
 	__le32 id;		/* unique ID - - used to match */
 	__le32 fmt;		/* SND_SOC_DAI_FORMAT_ format value */
-	__u8 clock_gated;	/* 1 if clock can be gated to save power */
+	__u8 clock_gated;	/* SND_SOC_TPLG_DAI_CLK_GATE_ value */
 	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
 	__u8 bclk_master;	/* SND_SOC_TPLG_BCLK_ value */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index c5bdc673b195..04f834e6a6b5 100644
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
