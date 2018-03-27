Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeC0U4W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 16:56:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55856 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeC0U4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 16:56:17 -0400
X-Google-Smtp-Source: AIpwx4/BZuOQjD2IKHcfwS/9vcAJtb2GwR5rx0KiXh4GDBxR2N0OE8LflQHNt5Y6BeiGqHabEu0gLA==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Mark Brown <broonie@kernel.org>
Cc: Pan Xiuli <xiuli.pan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: [PATCH v3 1/2] ASoC: topology: Fix bclk and fsync inversion in set_link_hw_format()
Date: Tue, 27 Mar 2018 22:56:31 +0200
Message-Id: <20180327205632.3677-2-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180327205632.3677-1-k.marinushkin@gmail.com>
References: <20180327205632.3677-1-k.marinushkin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values of bclk and fsync are inverted WRT the codec. But the existing
solution already works for Broadwell, see the alsa-lib config:

`alsa-lib/src/conf/topology/broadwell/broadwell.conf`

This commit provides the backwards-compatible solution to fix this misuse.

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Tested-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
---
 include/uapi/sound/asoc.h | 16 ++++++++++++++--
 sound/soc/soc-topology.c  | 12 +++++++-----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index 69c37ecbff7e..f0e5e21efa54 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -160,6 +160,18 @@
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
@@ -315,8 +327,8 @@ struct snd_soc_tplg_hw_config {
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
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 01a50413c66f..c5bdc673b195 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1994,13 +1994,15 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
 			link->dai_fmt |= SND_SOC_DAIFMT_IB_IF;
 
 		/* clock masters */
-		bclk_master = hw_config->bclk_master;
-		fsync_master = hw_config->fsync_master;
-		if (!bclk_master && !fsync_master)
+		bclk_master = (hw_config->bclk_master ==
+			       SND_SOC_TPLG_BCLK_CM);
+		fsync_master = (hw_config->fsync_master ==
+				SND_SOC_TPLG_FSYNC_CM);
+		if (bclk_master && fsync_master)
 			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
-		else if (bclk_master && !fsync_master)
-			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
 		else if (!bclk_master && fsync_master)
+			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
+		else if (bclk_master && !fsync_master)
 			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
 		else
 			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
-- 
2.13.6
