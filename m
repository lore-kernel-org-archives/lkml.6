Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeFARM1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:12:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60624 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeFARMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:12:23 -0400
From: Mark Brown <broonie@kernel.org>
To: Guenter Roeck <groeck@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Chintan Patel <chintan.m.patel@intel.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: topology: Move v4 manifest header data structures to uapi" to the asoc tree
In-Reply-To: <1527191363-21021-2-git-send-email-linux@roeck-us.net>
Message-Id: <E1fOnb5-0003FX-FL@debutante>
Date: Fri, 01 Jun 2018 18:12:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: topology: Move v4 manifest header data structures to uapi

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 348f48220b97130817de4aa2058569133c5cc051 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <groeck@chromium.org>
Date: Thu, 24 May 2018 12:49:22 -0700
Subject: [PATCH] ASoC: topology: Move v4 manifest header data structures to
 uapi

Topology manifest v4 is still part of the ABI. Move its data structures
into the uapi header file.

No functional change.

Signed-off-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asoc.h | 57 +++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-topology.c  | 56 --------------------------------------
 2 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index b901cdbe532a..a74ca232f1fc 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -573,4 +573,61 @@ struct snd_soc_tplg_dai {
 	__le32 flags;           /* SND_SOC_TPLG_DAI_FLGBIT_* */
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
+
+/*
+ * Old version of ABI structs, supported for backward compatibility.
+ */
+
+/* Manifest v4 */
+struct snd_soc_tplg_manifest_v4 {
+	__le32 size;		/* in bytes of this structure */
+	__le32 control_elems;	/* number of control elements */
+	__le32 widget_elems;	/* number of widget elements */
+	__le32 graph_elems;	/* number of graph elements */
+	__le32 pcm_elems;	/* number of PCM elements */
+	__le32 dai_link_elems;	/* number of DAI link elements */
+	struct snd_soc_tplg_private priv;
+} __packed;
+
+/* Stream Capabilities v4 */
+struct snd_soc_tplg_stream_caps_v4 {
+	__le32 size;		/* in bytes of this structure */
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	__le64 formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
+	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
+	__le32 rate_min;	/* min rate */
+	__le32 rate_max;	/* max rate */
+	__le32 channels_min;	/* min channels */
+	__le32 channels_max;	/* max channels */
+	__le32 periods_min;	/* min number of periods */
+	__le32 periods_max;	/* max number of periods */
+	__le32 period_size_min;	/* min period size bytes */
+	__le32 period_size_max;	/* max period size bytes */
+	__le32 buffer_size_min;	/* min buffer size bytes */
+	__le32 buffer_size_max;	/* max buffer size bytes */
+} __packed;
+
+/* PCM v4 */
+struct snd_soc_tplg_pcm_v4 {
+	__le32 size;		/* in bytes of this structure */
+	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	__le32 pcm_id;		/* unique ID - used to match with DAI link */
+	__le32 dai_id;		/* unique ID - used to match */
+	__le32 playback;	/* supports playback mode */
+	__le32 capture;		/* supports capture mode */
+	__le32 compress;	/* 1 = compressed; 0 = PCM */
+	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
+	__le32 num_streams;	/* number of streams */
+	struct snd_soc_tplg_stream_caps_v4 caps[2]; /* playback and capture for DAI */
+} __packed;
+
+/* Physical link config v4 */
+struct snd_soc_tplg_link_config_v4 {
+	__le32 size;            /* in bytes of this structure */
+	__le32 id;              /* unique ID - used to match */
+	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
+	__le32 num_streams;     /* number of streams */
+} __packed;
+
 #endif
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 3d04fa297677..3fd5d9c867b9 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -54,62 +54,6 @@
 #define SOC_TPLG_PASS_START	SOC_TPLG_PASS_MANIFEST
 #define SOC_TPLG_PASS_END	SOC_TPLG_PASS_LINK
 
-/*
- * Old version of ABI structs, supported for backward compatibility.
- */
-
-/* Manifest v4 */
-struct snd_soc_tplg_manifest_v4 {
-	__le32 size;		/* in bytes of this structure */
-	__le32 control_elems;	/* number of control elements */
-	__le32 widget_elems;	/* number of widget elements */
-	__le32 graph_elems;	/* number of graph elements */
-	__le32 pcm_elems;	/* number of PCM elements */
-	__le32 dai_link_elems;	/* number of DAI link elements */
-	struct snd_soc_tplg_private priv;
-} __packed;
-
-/* Stream Capabilities v4 */
-struct snd_soc_tplg_stream_caps_v4 {
-	__le32 size;		/* in bytes of this structure */
-	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le64 formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
-	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
-	__le32 rate_min;	/* min rate */
-	__le32 rate_max;	/* max rate */
-	__le32 channels_min;	/* min channels */
-	__le32 channels_max;	/* max channels */
-	__le32 periods_min;	/* min number of periods */
-	__le32 periods_max;	/* max number of periods */
-	__le32 period_size_min;	/* min period size bytes */
-	__le32 period_size_max;	/* max period size bytes */
-	__le32 buffer_size_min;	/* min buffer size bytes */
-	__le32 buffer_size_max;	/* max buffer size bytes */
-} __packed;
-
-/* PCM v4 */
-struct snd_soc_tplg_pcm_v4 {
-	__le32 size;		/* in bytes of this structure */
-	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le32 pcm_id;		/* unique ID - used to match with DAI link */
-	__le32 dai_id;		/* unique ID - used to match */
-	__le32 playback;	/* supports playback mode */
-	__le32 capture;		/* supports capture mode */
-	__le32 compress;	/* 1 = compressed; 0 = PCM */
-	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
-	__le32 num_streams;	/* number of streams */
-	struct snd_soc_tplg_stream_caps_v4 caps[2]; /* playback and capture for DAI */
-} __packed;
-
-/* Physical link config v4 */
-struct snd_soc_tplg_link_config_v4 {
-	__le32 size;            /* in bytes of this structure */
-	__le32 id;              /* unique ID - used to match */
-	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
-	__le32 num_streams;     /* number of streams */
-} __packed;
-
 /* topology context */
 struct soc_tplg {
 	const struct firmware *fw;
-- 
2.17.0
