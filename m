Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933760AbeCMQaj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:30:39 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60501 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933578AbeCMQaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:30:05 -0400
From: Olivier Moysan <olivier.moysan@st.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@stlinux.com>, <linux-kernel@vger.kernel.org>,
        <olivier.moysan@st.com>
CC: <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>,
        <rmk@arm.linux.org.uk>, <jsarha@ti.com>
Subject: [PATCH 1/3] ALSA: pcm: add IEC958 channel status control helper
Date: Tue, 13 Mar 2018 17:27:06 +0100
Message-ID: <1520958428-10930-2-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Add IEC958 channel status helper that creates control to handle the
IEC60958 status bits.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 include/sound/pcm_iec958.h |  19 ++++++++
 sound/core/pcm_iec958.c    | 113 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/include/sound/pcm_iec958.h b/include/sound/pcm_iec958.h
index 0939aa45e2fe..3c9701a9b1b0 100644
--- a/include/sound/pcm_iec958.h
+++ b/include/sound/pcm_iec958.h
@@ -4,9 +4,28 @@
 
 #include <linux/types.h>
 
+/**
+ * struct snd_pcm_iec958_params: IEC 60958 controls parameters
+ * @ctrl_set: control set callback
+ * This callback is optional and shall be used to set associated driver
+ * configuration.
+ * @iec: Mandatory pointer to iec958 structure.
+ * @cs: Mandatory pointer to AES/IEC958  channel status bits.
+ * @cs_len: size in byte of the AES/IEC958  channel status bits.
+ * @private_data: Optional private pointer to driver context.
+ */
+struct snd_pcm_iec958_params {
+	int (*ctrl_set)(struct snd_pcm_iec958_params *iec_param);
+	unsigned char *cs;
+	unsigned char cs_len;
+	void *private_data;
+};
+
 int snd_pcm_create_iec958_consumer(struct snd_pcm_runtime *runtime, u8 *cs,
 	size_t len);
 
 int snd_pcm_create_iec958_consumer_hw_params(struct snd_pcm_hw_params *params,
 					     u8 *cs, size_t len);
+int snd_pcm_add_iec958_ctl(struct snd_pcm *pcm, int subdevice, int stream,
+			   struct snd_pcm_iec958_params *params);
 #endif
diff --git a/sound/core/pcm_iec958.c b/sound/core/pcm_iec958.c
index 5e6aed64f451..aba1f522e98a 100644
--- a/sound/core/pcm_iec958.c
+++ b/sound/core/pcm_iec958.c
@@ -7,11 +7,88 @@
  */
 #include <linux/export.h>
 #include <linux/types.h>
+#include <linux/wait.h>
 #include <sound/asoundef.h>
+#include <sound/control.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/pcm_iec958.h>
 
+static int snd_pcm_iec958_info(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
+/*
+ * IEC958 channel status default controls callbacks
+ */
+static int snd_pcm_iec958_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *uctl)
+{
+	struct snd_pcm_iec958_params *params = snd_kcontrol_chip(kcontrol);
+	int i;
+
+	for (i = 0; i < params->cs_len; i++)
+		uctl->value.iec958.status[i] = params->cs[i];
+
+	return 0;
+}
+
+static int snd_pcm_iec958_put(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *uctl)
+{
+	struct snd_pcm_iec958_params *params = snd_kcontrol_chip(kcontrol);
+	int err = 0;
+	unsigned int i, updated = 0;
+	unsigned char old_status[5];
+
+	for (i = 0; i < params->cs_len; i++) {
+		if (params->cs[i] != uctl->value.iec958.status[i])
+			updated = 1;
+	}
+
+	if (!updated)
+		return 0;
+
+	/* Store current status to restore them in error case */
+	for (i = 0; i < params->cs_len; i++) {
+		old_status[i] = params->cs[i];
+		params->cs[i] = uctl->value.iec958.status[i];
+	}
+
+	if (params->ctrl_set)
+		err = params->ctrl_set(params);
+	if (err < 0) {
+		for (i = 0; i < params->cs_len; i++)
+			params->cs[i] = old_status[i];
+	}
+
+	return err;
+}
+
+static const struct snd_kcontrol_new iec958_ctls[] = {
+	{
+		.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			   SNDRV_CTL_ELEM_ACCESS_VOLATILE),
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
+		.info = snd_pcm_iec958_info,
+		.get = snd_pcm_iec958_get,
+		.put = snd_pcm_iec958_put,
+	},
+	{
+		.access = (SNDRV_CTL_ELEM_ACCESS_READ |
+			   SNDRV_CTL_ELEM_ACCESS_VOLATILE),
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", CAPTURE, DEFAULT),
+		.info = snd_pcm_iec958_info,
+		.get = snd_pcm_iec958_get,
+	},
+};
+
 static int create_iec958_consumer(uint rate, uint sample_width,
 				  u8 *cs, size_t len)
 {
@@ -21,6 +98,9 @@ static int create_iec958_consumer(uint rate, uint sample_width,
 		return -EINVAL;
 
 	switch (rate) {
+	case 0:
+		fs = IEC958_AES3_CON_FS_NOTID;
+		break;
 	case 32000:
 		fs = IEC958_AES3_CON_FS_32000;
 		break;
@@ -48,6 +128,9 @@ static int create_iec958_consumer(uint rate, uint sample_width,
 
 	if (len > 4) {
 		switch (sample_width) {
+		case 0:
+			ws = IEC958_AES4_CON_WORDLEN_NOTID;
+			break;
 		case 16:
 			ws = IEC958_AES4_CON_WORDLEN_20_16;
 			break;
@@ -124,3 +207,33 @@ int snd_pcm_create_iec958_consumer_hw_params(struct snd_pcm_hw_params *params,
 				      cs, len);
 }
 EXPORT_SYMBOL(snd_pcm_create_iec958_consumer_hw_params);
+
+/**
+ * snd_pcm_add_iec958_ctl - Add a IEC958 control associated to the pcm device
+ * @pcm: pcm device to associate to the control.
+ * @subdevice: subdevice index.Must be set to 0 if unused
+ * @iec958: snd_pcm_iec958_params structure that contains callbacks
+ *          and channel status buffer.
+ * @stream: stream type SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CATURE.
+ * Returns:  negative error code if something failed.
+ */
+int snd_pcm_add_iec958_ctl(struct snd_pcm *pcm, int subdevice, int stream,
+			   struct snd_pcm_iec958_params *params)
+{
+	struct snd_kcontrol_new knew;
+
+	if (stream > SNDRV_PCM_STREAM_LAST)
+		return -EINVAL;
+	if (!params->cs)
+		return -EINVAL;
+	if (params->cs_len < 4)
+		return -EINVAL;
+
+	create_iec958_consumer(0, 0, params->cs, params->cs_len);
+	knew = iec958_ctls[stream];
+	knew.device = pcm->device;
+	knew.subdevice = subdevice;
+
+	return snd_ctl_add(pcm->card, snd_ctl_new1(&knew, params));
+}
+EXPORT_SYMBOL(snd_pcm_add_iec958_ctl);
-- 
1.9.1
