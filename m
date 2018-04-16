Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeDPS01 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:26:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40453 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbeDPS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:26:25 -0400
X-Google-Smtp-Source: AIpwx4//P+wsNRcdTcZH+zRGTwRpDjmGk30Dh4TqbeK4Sgf6gcz3i/zSo9Dj7loHomGaVDYAYmMM3w==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Kirill Marinushkin <k.marinushkin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH alsa-lib v4 1/4] ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
Date: Mon, 16 Apr 2018 20:26:38 +0200
Message-Id: <20180416182641.30312-2-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180416182641.30312-1-k.marinushkin@gmail.com>
References: <20180416182641.30312-1-k.marinushkin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values of bclk and fsync are inverted WRT the codec. But the existing
solution already works for Broadwell, see the alsa-lib config:

`alsa-lib/src/conf/topology/broadwell/broadwell.conf`

This commit provides the backwards-compatible solution to fix this misuse.
This commit goes in pair with the corresponding patch for linux.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Tested-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
---
 include/sound/asoc.h                       | 16 ++++++++++++++--
 include/topology.h                         |  4 ++--
 src/conf/topology/broadwell/broadwell.conf |  4 ++--
 src/topology/pcm.c                         | 30 ++++++++++++++++++++++++++----
 4 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 0f5d9f9a..89b00703 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -156,6 +156,18 @@
 #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
 #define SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP            (1 << 3)
 
+/* DAI topology BCLK parameter
+ * For the backwards capability, by default codec is bclk master
+ */
+#define SND_SOC_TPLG_BCLK_CM         0 /* codec is bclk master */
+#define SND_SOC_TPLG_BCLK_CS         1 /* codec is bclk slave */
+
+/* DAI topology FSYNC parameter
+ * For the backwards capability, by default codec is fsync master
+ */
+#define SND_SOC_TPLG_FSYNC_CM         0 /* codec is fsync master */
+#define SND_SOC_TPLG_FSYNC_CS         1 /* codec is fsync slave */
+
 /*
  * Block Header.
  * This header precedes all object and object arrays below.
@@ -311,8 +323,8 @@ struct snd_soc_tplg_hw_config {
 	__u8 clock_gated;	/* 1 if clock can be gated to save power */
 	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
 	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
-	__u8 bclk_master;	/* 1 for master of BCLK, 0 for slave */
-	__u8 fsync_master;	/* 1 for master of FSYNC, 0 for slave */
+	__u8 bclk_master;	/* SND_SOC_TPLG_BCLK_ value */
+	__u8 fsync_master;	/* SND_SOC_TPLG_FSYNC_ value */
 	__u8 mclk_direction;    /* 0 for input, 1 for output */
 	__le16 reserved;	/* for 32bit alignment */
 	__le32 mclk_rate;	/* MCLK or SYSCLK freqency in Hz */
diff --git a/include/topology.h b/include/topology.h
index 8779da4d..5d7b46df 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -1000,8 +1000,8 @@ struct snd_tplg_hw_config_template {
 	unsigned char clock_gated;      /* 1 if clock can be gated to save power */
 	unsigned char  invert_bclk;     /* 1 for inverted BCLK, 0 for normal */
 	unsigned char  invert_fsync;    /* 1 for inverted frame clock, 0 for normal */
-	unsigned char  bclk_master;     /* 1 for master of BCLK, 0 for slave */
-	unsigned char  fsync_master;    /* 1 for master of FSYNC, 0 for slave */
+	unsigned char  bclk_master;     /* SND_SOC_TPLG_BCLK_ value */
+	unsigned char  fsync_master;    /* SND_SOC_TPLG_FSYNC_ value */
 	unsigned char  mclk_direction;  /* 0 for input, 1 for output */
 	unsigned short reserved;        /* for 32bit alignment */
 	unsigned int mclk_rate;	        /* MCLK or SYSCLK freqency in Hz */
diff --git a/src/conf/topology/broadwell/broadwell.conf b/src/conf/topology/broadwell/broadwell.conf
index b8405d93..09fc4daa 100644
--- a/src/conf/topology/broadwell/broadwell.conf
+++ b/src/conf/topology/broadwell/broadwell.conf
@@ -393,8 +393,8 @@ SectionGraph."dsp" {
 SectionHWConfig."CodecHWConfig" {
 	id "1"
 	format "I2S"		# physical audio format.
-	bclk   "master"		# Platform is master of bit clock
-	fsync  "master"		# platform is master of fsync
+	bclk   "codec_slave"	# platform is master of bit clock (codec is slave)
+	fsync  "codec_slave"	# platform is master of fsync (codec is slave)
 }
 
 SectionLink."Codec" {
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index bb47b9af..d0395182 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -1141,8 +1141,19 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			if (!strcmp(val, "master"))
-				hw_cfg->bclk_master = true;
+			if (!strcmp(val, "master")) {
+				/* For backwards capability,
+				 * "master" == "codec is slave"
+				 */
+				SNDERR("warning: deprecated bclk value '%s'\n",
+				       val);
+
+				hw_cfg->bclk_master = SND_SOC_TPLG_BCLK_CS;
+			} else if (!strcmp(val, "codec_slave")) {
+				hw_cfg->bclk_master = SND_SOC_TPLG_BCLK_CS;
+			} else if (!strcmp(val, "codec_master")) {
+				hw_cfg->bclk_master = SND_SOC_TPLG_BCLK_CM;
+			}
 			continue;
 		}
 
@@ -1167,8 +1178,19 @@ int tplg_parse_hw_config(snd_tplg_t *tplg, snd_config_t *cfg,
 			if (snd_config_get_string(n, &val) < 0)
 				return -EINVAL;
 
-			if (!strcmp(val, "master"))
-				hw_cfg->fsync_master = true;
+			if (!strcmp(val, "master")) {
+				/* For backwards capability,
+				 * "master" == "codec is slave"
+				 */
+				SNDERR("warning: deprecated fsync value '%s'\n",
+				       val);
+
+				hw_cfg->fsync_master = SND_SOC_TPLG_FSYNC_CS;
+			} else if (!strcmp(val, "codec_slave")) {
+				hw_cfg->fsync_master = SND_SOC_TPLG_FSYNC_CS;
+			} else if (!strcmp(val, "codec_master")) {
+				hw_cfg->fsync_master = SND_SOC_TPLG_FSYNC_CM;
+			}
 			continue;
 		}
 
-- 
2.13.6
