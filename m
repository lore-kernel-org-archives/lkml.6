Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965510AbeBMRBo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:01:44 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:47083 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965467AbeBMRBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:33 -0500
X-Google-Smtp-Source: AH8x227f2gvxe3ExBrAuZLsCeqTh8+MOyrW5s6P9TA1T//HGw6Qs/K0/y7ScYw5IX7WScOI7MJe6DA==
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
Subject: [PATCH v3 12/25] ASoC: qcom: qdsp6: Add support to Q6CORE
Date: Tue, 13 Feb 2018 16:58:24 +0000
Message-Id: <20180213165837.1620-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to core apr service, which is used to query
status of other static and dynamic services on the dsp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig        |   5 +
 sound/soc/qcom/qdsp6/Makefile |   1 +
 sound/soc/qcom/qdsp6/q6core.c | 235 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6core.h |   9 ++
 4 files changed, 250 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6core.c
 create mode 100644 sound/soc/qcom/qdsp6/q6core.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index a14d960b8fe4..8c2d65e0a28e 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -60,6 +60,10 @@ config SND_SOC_QDSP6_ASM
 	tristate
 	default n
 
+config SND_SOC_QDSP6_CORE
+	tristate
+	default n
+
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
 	depends on QCOM_APR && HAS_DMA
@@ -67,6 +71,7 @@ config SND_SOC_QDSP6
 	select SND_SOC_QDSP6_AFE
 	select SND_SOC_QDSP6_ADM
 	select SND_SOC_QDSP6_ASM
+	select SND_SOC_QDSP6_CORE
 	help
 	 To add support for MSM QDSP6 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index eea962315ab3..61f089bc0d25 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
 obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
 obj-$(CONFIG_SND_SOC_QDSP6_ADM) += q6adm.o
 obj-$(CONFIG_SND_SOC_QDSP6_ASM) += q6asm.o
+obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
new file mode 100644
index 000000000000..d4a3ff409a34
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2017, The Linux Foundation
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/of.h>
+#include <linux/jiffies.h>
+#include <linux/wait.h>
+#include <linux/soc/qcom/apr.h>
+#include "q6dsp-errno.h"
+
+#define ADSP_STATE_READY_TIMEOUT_MS    3000
+#define Q6_READY_TIMEOUT_MS 100
+#define AVCS_CMD_ADSP_EVENT_GET_STATE		0x0001290C
+#define AVCS_CMDRSP_ADSP_EVENT_GET_STATE	0x0001290D
+#define AVCS_GET_VERSIONS       0x00012905
+#define AVCS_GET_VERSIONS_RSP   0x00012906
+
+struct avcs_svc_info {
+	uint32_t service_id;
+	uint32_t version;
+} __packed;
+
+struct q6core {
+	struct apr_device *adev;
+	wait_queue_head_t wait;
+	uint32_t avcs_state;
+	bool resp_received;
+	uint32_t num_services;
+	struct avcs_svc_info *svcs_info;
+};
+
+struct q6core *core;
+
+static int q6core_callback(struct apr_device *adev,
+			 struct apr_client_message *data)
+{
+	struct q6core *core = dev_get_drvdata(&adev->dev);
+	struct aprv2_ibasic_rsp_result_t *result;
+
+	result = data->payload;
+	switch (data->opcode) {
+	case AVCS_GET_VERSIONS_RSP:
+		core->num_services = result->status;
+
+		core->svcs_info = kcalloc(core->num_services,
+					  sizeof(*core->svcs_info),
+					  GFP_ATOMIC);
+		if (!core->svcs_info)
+			return -ENOMEM;
+
+		/* svc info is after apr result */
+		memcpy(core->svcs_info, result + sizeof(*result),
+		       core->num_services * sizeof(*core->svcs_info));
+
+		core->resp_received = true;
+		wake_up(&core->wait);
+
+		break;
+	case AVCS_CMDRSP_ADSP_EVENT_GET_STATE:
+		core->avcs_state = result->opcode;
+
+		core->resp_received = true;
+		wake_up(&core->wait);
+		break;
+	default:
+		dev_err(&adev->dev, "Message id from adsp core svc: 0x%x\n",
+			data->opcode);
+		break;
+	}
+
+	return 0;
+}
+
+static int q6core_get_svc_versions(struct q6core *core)
+{
+	struct apr_device *adev = core->adev;
+	struct apr_hdr hdr = {0};
+	int rc;
+
+	hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
+	hdr.pkt_size = APR_HDR_SIZE;
+	hdr.opcode = AVCS_GET_VERSIONS;
+
+	rc = apr_send_pkt(adev, &hdr);
+	if (rc < 0)
+		return rc;
+
+	rc = wait_event_timeout(core->wait, (core->resp_received),
+				msecs_to_jiffies(Q6_READY_TIMEOUT_MS));
+	if (rc > 0 && core->resp_received) {
+		core->resp_received = false;
+		return 0;
+	}
+
+	return rc;
+}
+
+static bool __q6core_is_adsp_ready(struct q6core *core)
+{
+	struct apr_device *adev = core->adev;
+	struct apr_hdr hdr = {0};
+	int rc;
+
+	hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
+	hdr.pkt_size = APR_HDR_SIZE;
+	hdr.opcode = AVCS_CMD_ADSP_EVENT_GET_STATE;
+
+	rc = apr_send_pkt(adev, &hdr);
+	if (rc < 0)
+		return false;
+
+	rc = wait_event_timeout(core->wait, (core->resp_received),
+				msecs_to_jiffies(Q6_READY_TIMEOUT_MS));
+	if (rc > 0 && core->resp_received) {
+		core->resp_received = false;
+		if (core->avcs_state == 0x1)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * q6core_get_svc_version() - Get version number of a service.
+ *
+ * @svc_id: service id of the service.
+ *
+ * Return: Will be a valid version number on success and zero on failure.
+ * version number returned contains bits 0 to 15 as Minor version number
+ * Bits 16 to 31 as Major version number
+ */
+uint32_t q6core_get_svc_version(int svc_id)
+{
+	struct apr_device *adev;
+	struct avcs_svc_info *svcs_info;
+	int i, ret;
+
+	if (!core)
+		return 0;
+
+	if (!core->svcs_info) {
+		ret = q6core_get_svc_versions(core);
+		if (ret)
+			return ret;
+	}
+
+	adev  = core->adev;
+	svcs_info = core->svcs_info;
+
+	for (i = 0; i < core->num_services; i++)
+		if (svcs_info[i].service_id == svc_id)
+			return svcs_info[i].version;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(q6core_get_svc_version);
+
+/**
+ * q6core_is_adsp_ready() - Get status of adsp
+ *
+ * Return: Will be an true if adsp is ready and false if not.
+ */
+bool q6core_is_adsp_ready(void)
+{
+	unsigned long  timeout;
+
+	if (!core)
+		return false;
+
+	timeout = jiffies + msecs_to_jiffies(ADSP_STATE_READY_TIMEOUT_MS);
+	for (;;) {
+		if (__q6core_is_adsp_ready(core))
+			return true;
+
+		if (!time_after(timeout, jiffies))
+			return false;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(q6core_is_adsp_ready);
+
+static int q6core_probe(struct apr_device *adev)
+{
+	core = kzalloc(sizeof(*core), GFP_KERNEL);
+	if (!core)
+		return -ENOMEM;
+
+	dev_set_drvdata(&adev->dev, core);
+
+	core->adev = adev;
+	init_waitqueue_head(&core->wait);
+
+	return 0;
+}
+
+static int q6core_exit(struct apr_device *adev)
+{
+	if (core->svcs_info)
+		kfree(core->svcs_info);
+
+	kfree(core);
+	core = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id q6core_device_id[]  = {
+	{ .compatible = "qcom,q6core" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6core_device_id);
+
+static struct apr_driver qcom_q6core_driver = {
+	.probe = q6core_probe,
+	.remove = q6core_exit,
+	.callback = q6core_callback,
+	.driver = {
+		.name = "qcom-q6core",
+		.of_match_table = of_match_ptr(q6core_device_id),
+	},
+};
+
+module_apr_driver(qcom_q6core_driver);
+MODULE_DESCRIPTION("q6 core");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6core.h b/sound/soc/qcom/qdsp6/q6core.h
new file mode 100644
index 000000000000..2852fbb7756e
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6core.h
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __Q6CORE_H__
+#define __Q6CORE_H__
+
+bool q6core_is_adsp_ready(void);
+uint32_t q6core_get_svc_version(int svc_id);
+
+#endif /* __Q6CORE_H__ */
-- 
2.15.1
