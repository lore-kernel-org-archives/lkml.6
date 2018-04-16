Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbeDPS0d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:26:33 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41825 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbeDPS0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:26:31 -0400
X-Google-Smtp-Source: AIpwx48NrewlsOXlgI2nppf6kN62JLvawdR9qVgJk1cqA9G5VL1tKvQmjCxx8I7yIvkXgbF2P2Y/QQ==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Kirill Marinushkin <k.marinushkin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH alsa-lib v4 2/4] ASoC: topology: Add missing clock gating parameter when parsing hw_configs
Date: Mon, 16 Apr 2018 20:26:39 +0200
Message-Id: <20180416182641.30312-3-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180416182641.30312-1-k.marinushkin@gmail.com>
References: <20180416182641.30312-1-k.marinushkin@gmail.com>
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
 include/sound/asoc.h | 7 ++++++-
 include/topology.h   | 2 +-
 src/topology/pcm.c   | 6 +++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 89b00703..297e837c 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -135,6 +135,11 @@
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
@@ -320,7 +325,7 @@ struct snd_soc_tplg_hw_config {
 	__le32 size;            /* in bytes of this structure */
 	__le32 id;		/* unique ID - - used to match */
 	__le32 fmt;		/* SND_SOC_DAI_FORMAT_ format value */
-	__u8 clock_gated;	/* 1 if clock can be gated to save power */
+	__u8 clock_gated;	/* SND_SOC_TPLG_DAI_CLK_GATE_ value */
 	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
 	__u8 bclk_master;	/* SND_SOC_TPLG_BCLK_ value */
diff --git a/include/topology.h b/include/topology.h
index 5d7b46df..3793115c 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -997,7 +997,7 @@ struct snd_tplg_pcm_template {
 struct snd_tplg_hw_config_template {
 	int id;                         /* unique ID - - used to match */
 	unsigned int fmt;               /* SND_SOC_DAI_FORMAT_ format value */
-	unsigned char clock_gated;      /* 1 if clock can be gated to save power */
+	unsigned char clock_gated;      /* SND_SOC_TPLG_DAI_CLK_GATE_ value */
 	unsigned char  invert_bclk;     /* 1 for inverted BCLK, 0 for normal */
 	unsigned char  invert_fsync;    /* 1 for inverted frame clock, 0 for normal */
 	unsigned char  bclk_master;     /* SND_SOC_TPLG_BCLK_ value */
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index d0395182..b53f6b03 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -1233,7 +1233,11 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 				return -EINVAL;
 
 			if (!strcmp(val, "true"))
-				hw_cfg->clock_gated = true;
+				hw_cfg->clock_gated =
+					SND_SOC_TPLG_DAI_CLK_GATE_GATED;
+			else
+				hw_cfg->clock_gated =
+					SND_SOC_TPLG_DAI_CLK_GATE_CONT;
 			continue;
 		}
 
-- 
2.13.6
