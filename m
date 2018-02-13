Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965482AbeBMRIV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:08:21 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55517 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965433AbeBMRB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:28 -0500
X-Google-Smtp-Source: AH8x227YmW5xIRV0aPPEQWx92zI1Ags3xwXyUAfHoBhV5OPl+KNAk+mES4aYTHLjl8lBdhsczocXPA==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org
Cc: david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
        spatakok@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 09/25] ASoC: qcom: qdsp6: Add support to Q6ASM
Date: Tue, 13 Feb 2018 16:58:21 +0000
Message-Id: <20180213165837.1620-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds basic support to Q6 ASM (Audio Stream Manager) module on
Q6DSP. ASM supports up to 8 concurrent streams. each stream can be setup
as playback/capture. ASM provides top control functions like
Pause/flush/resume for playback and record. ASM can Create/destroy encoder,
decoder and also provides POPP dynamic services.

This patch adds support to basic features to allow hdmi playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig        |   5 +
 sound/soc/qcom/qdsp6/Makefile |   1 +
 sound/soc/qcom/qdsp6/q6asm.c  | 252 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h  |  18 +++
 4 files changed, 276 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.c
 create mode 100644 sound/soc/qcom/qdsp6/q6asm.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index bf04e1301608..a14d960b8fe4 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -56,12 +56,17 @@ config SND_SOC_QDSP6_ADM
 	tristate
 	default n
 
+config SND_SOC_QDSP6_ASM
+	tristate
+	default n
+
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
 	depends on QCOM_APR && HAS_DMA
 	select SND_SOC_QDSP6_COMMON
 	select SND_SOC_QDSP6_AFE
 	select SND_SOC_QDSP6_ADM
+	select SND_SOC_QDSP6_ASM
 	help
 	 To add support for MSM QDSP6 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index 930944425051..eea962315ab3 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
 obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
 obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
+obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
new file mode 100644
index 000000000000..768d9b446da9
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2017, The Linux Foundation
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <linux/mutex.h>
+#include <linux/wait.h>
+#include <linux/module.h>
+#include <linux/soc/qcom/apr.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include "q6asm.h"
+#include "q6dsp-errno.h"
+#include "q6dsp-common.h"
+
+#define ASM_SYNC_IO_MODE		0x0001
+#define ASM_ASYNC_IO_MODE		0x0002
+#define ASM_TUN_READ_IO_MODE		0x0004	/* tunnel read write mode */
+#define ASM_TUN_WRITE_IO_MODE		0x0008	/* tunnel read write mode */
+
+struct audio_client {
+	int session;
+	q6asm_cb cb;
+	int cmd_state;
+	void *priv;
+	uint32_t io_mode;
+	struct apr_device *adev;
+	struct mutex lock;
+	wait_queue_head_t cmd_wait;
+	int perf_mode;
+	int stream_id;
+	struct device *dev;
+};
+
+struct q6asm {
+	struct apr_device *adev;
+	int mem_state;
+	struct device *dev;
+	wait_queue_head_t mem_wait;
+	struct mutex	session_lock;
+	struct platform_device *pcmdev;
+	struct audio_client *session[MAX_SESSIONS + 1];
+	void *dai_data;
+};
+
+static bool q6asm_is_valid_audio_client(struct audio_client *ac)
+{
+	struct q6asm *a = dev_get_drvdata(ac->dev);
+	int n;
+
+	if (!ac)
+		return false;
+
+	for (n = 1; n <= MAX_SESSIONS; n++) {
+		if (a->session[n] == ac)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * q6asm_audio_client_free() - Freee allocated audio client
+ *
+ * @ac: audio client to free
+ */
+void q6asm_audio_client_free(struct audio_client *ac)
+{
+	struct q6asm *a = dev_get_drvdata(ac->dev);
+
+	mutex_lock(&a->session_lock);
+	a->session[ac->session] = NULL;
+	mutex_unlock(&a->session_lock);
+	kfree(ac);
+}
+EXPORT_SYMBOL_GPL(q6asm_audio_client_free);
+
+static struct audio_client *q6asm_get_audio_client(struct q6asm *a,
+						   int session_id)
+{
+	if ((session_id <= 0) || (session_id > MAX_SESSIONS)) {
+		dev_err(a->dev, "invalid session: %d\n", session_id);
+		return NULL;
+	}
+
+	if (!a->session[session_id]) {
+		dev_err(a->dev, "session not active: %d\n", session_id);
+		return NULL;
+	}
+
+	return a->session[session_id];
+}
+
+/**
+ * q6asm_set_dai_data() - set dai private data
+ *
+ * @dev: Pointer to asm device.
+ * @data: dai private data
+ *
+ */
+void q6asm_set_dai_data(struct device *dev, void *data)
+{
+	struct q6asm *a = dev_get_drvdata(dev);
+
+	a->dai_data = data;
+}
+EXPORT_SYMBOL_GPL(q6asm_set_dai_data);
+
+/**
+ * q6asm_get_dai_data() - get dai private data
+ *
+ * @dev: Pointer to asm device.
+ *
+ * Return: pointer to dai private data
+ */
+void *q6asm_get_dai_data(struct device *dev)
+{
+	struct q6asm *a = dev_get_drvdata(dev);
+
+	return a->dai_data;
+}
+EXPORT_SYMBOL_GPL(q6asm_get_dai_data);
+
+static int q6asm_srvc_callback(struct apr_device *adev,
+			       struct apr_client_message *data)
+{
+	struct aprv2_ibasic_rsp_result_t *result;
+	struct q6asm *a, *q6asm = dev_get_drvdata(&adev->dev);
+	struct audio_client *ac = NULL;
+	struct audio_port_data *port;
+	uint32_t dir = 0;
+	uint32_t sid = 0;
+
+	result = data->payload;
+	sid = (data->token >> 8) & 0x0F;
+	ac = q6asm_get_audio_client(q6asm, sid);
+	if (!ac) {
+		dev_err(&adev->dev, "Audio Client not active\n");
+		return 0;
+	}
+
+	if (ac->cb)
+		ac->cb(data->opcode, data->token, data->payload, ac->priv);
+
+	return 0;
+}
+
+/**
+ * q6asm_get_session_id() - get session id for audio client
+ *
+ * @ac: audio client pointer
+ *
+ * Return: Will be an session id of the audio client.
+ */
+int q6asm_get_session_id(struct audio_client *c)
+{
+	return c->session;
+}
+EXPORT_SYMBOL_GPL(q6asm_get_session_id);
+
+/**
+ * q6asm_audio_client_alloc() - Allocate a new audio client
+ *
+ * @dev: Pointer to asm child device.
+ * @cb: event callback.
+ * @priv: private data associated with this client.
+ *
+ * Return: Will be an error pointer on error or a valid audio client
+ * on success.
+ */
+struct audio_client *q6asm_audio_client_alloc(struct device *dev, q6asm_cb cb,
+					      void *priv, int stream_id)
+{
+	struct q6asm *a = dev_get_drvdata(dev);
+	struct audio_client *ac;
+
+	if (stream_id + 1 > MAX_SESSIONS)
+		return ERR_PTR(-EINVAL);
+
+	ac = kzalloc(sizeof(*ac), GFP_KERNEL);
+	if (!ac)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_lock(&a->session_lock);
+	a->session[stream_id + 1] = ac;
+	mutex_unlock(&a->session_lock);
+
+	ac->session = stream_id + 1;
+	ac->cb = cb;
+	ac->dev = dev;
+	ac->priv = priv;
+	ac->io_mode = ASM_SYNC_IO_MODE;
+	ac->perf_mode = LEGACY_PCM_MODE;
+	/* DSP expects stream id from 1 */
+	ac->stream_id = 1;
+	ac->adev = a->adev;
+
+	init_waitqueue_head(&ac->cmd_wait);
+	mutex_init(&ac->lock);
+	ac->cmd_state = 0;
+
+	return ac;
+}
+EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
+
+
+static int q6asm_probe(struct apr_device *adev)
+{
+	struct q6asm *q6asm;
+
+	q6asm = devm_kzalloc(&adev->dev, sizeof(*q6asm), GFP_KERNEL);
+	if (!q6asm)
+		return -ENOMEM;
+
+	q6asm->dev = &adev->dev;
+	q6asm->adev = adev;
+	q6asm->mem_state = 0;
+	init_waitqueue_head(&q6asm->mem_wait);
+	mutex_init(&q6asm->session_lock);
+	dev_set_drvdata(&adev->dev, q6asm);
+
+	return q6asm_dai_probe(&adev->dev);
+}
+
+static int q6asm_remove(struct apr_device *adev)
+{
+	return q6asm_dai_remove(&adev->dev);
+}
+
+static const struct of_device_id q6asm_device_id[]  = {
+	{ .compatible = "qcom,q6asm" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6asm_device_id);
+
+static struct apr_driver qcom_q6asm_driver = {
+	.probe = q6asm_probe,
+	.remove = q6asm_remove,
+	.callback = q6asm_srvc_callback,
+	.driver = {
+		.name = "qcom-q6asm",
+		.of_match_table = of_match_ptr(q6asm_device_id),
+	},
+};
+
+module_apr_driver(qcom_q6asm_driver);
+MODULE_DESCRIPTION("Q6 Audio Stream Manager driver");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
new file mode 100644
index 000000000000..b13fe0d2ea61
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __Q6_ASM_H__
+#define __Q6_ASM_H__
+
+#define MAX_SESSIONS	16
+
+void q6asm_set_dai_data(struct device *dev, void *data);
+void *q6asm_get_dai_data(struct device *dev);
+
+typedef void (*q6asm_cb) (uint32_t opcode, uint32_t token,
+			  void *payload, void *priv);
+struct audio_client;
+struct audio_client *q6asm_audio_client_alloc(struct device *dev,
+					      q6asm_cb cb, void *priv,
+					      int session_id);
+void q6asm_audio_client_free(struct audio_client *ac);
+int q6asm_get_session_id(struct audio_client *ac);
+#endif /* __Q6_ASM_H__ */
-- 
2.15.1
