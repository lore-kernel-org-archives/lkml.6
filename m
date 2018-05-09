Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525870849; cv=none;
        d=google.com; s=arc-20160816;
        b=KxnsoRq2vlxsuRaMj4zHPqgERpw4OawEOJt61Idc4LAYph1lB3CxXu/TudaLf/h3YN
         1RF7MDhsvF9sugJatfDjsC5twmVi8hCINl6xS/uQwHZ8vsh4cJ5a3PT6q0oDHvOVGYnk
         3+XzQsD+P+LCFVO6KTztn/acMOLAkw+/lItdt2BkwVpAwdmVfno7dc298uJenPj8eLSR
         Vd3v9/wtbGz1FC8fnBcFaIF3+jrYC4TpkUUBx9RlE9dyQ2H+oicsRqXET7KUX1LlJDwS
         8MYlX4eez6TqU39qaXsA4tlLRTT0XouFQNLqMHmaWwr+erofpfZBrlxCgTdjlOUe4KGW
         M7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=1FQGwVWt2lSgLHbUmJol3Fc6QbJMc5g8+ARmwFksKxo=;
        b=DsDfTPX3rSeki34DHZgj/L6wKwG005AcOqGzbOnlXHDhWhsoqBP3VoDy4XJoUtjGHd
         w7JjFnPn18/kzhSxHaj5gxn59A8ilHaKv7ZzLNvPmuvodV4uxzD7j28Cvt3uNmnECkez
         v2YUH0SoQeWMLbADDce1GY59eqgDcsnWh94s4rtTLszqgTNfIGf+wiQNzd0WtQk5Ny1m
         v9/CB14hiKdzoOgTTrh4ZZEBe3a144W7tcgQD/7kJF1mAAMy1+7O2et4QmLb6xrd64JS
         mOVl9NrUt5UaCgwWs0sbb5hJhWCp67GS6yE8du+lh4Hg/6EbyImD22YvzM9xaMvHgiQT
         BiPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BhBhkQAB;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BhBhkQAB;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrSLSY9VitswGazeSiMEOJgs2h0kcbD/QSpyW9k2aPz/fHPlxsPlL9KfL6EDZSHb00rMIrelg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org,
	bgoswami@codeaurora.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v8 08/24] ASoC: qdsp6: q6core: Add q6core driver
Date: Wed,  9 May 2018 13:56:19 +0100
Message-Id: <20180509125635.5653-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263616340654821?=
X-GMAIL-MSGID: =?utf-8?q?1599991551783796724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support to core apr service, which is used to query
status of other static and dynamic services on the dsp.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/Kconfig        |   4 +
 sound/soc/qcom/qdsp6/Makefile |   1 +
 sound/soc/qcom/qdsp6/q6core.c | 380 ++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6core.h |  15 ++
 4 files changed, 400 insertions(+)
 create mode 100644 sound/soc/qcom/qdsp6/q6core.c
 create mode 100644 sound/soc/qcom/qdsp6/q6core.h

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index b44a9fcd7ed3..37ee0d958145 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -44,10 +44,14 @@ config SND_SOC_APQ8016_SBC
 config SND_SOC_QDSP6_COMMON
 	tristate
 
+config SND_SOC_QDSP6_CORE
+	tristate
+
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
 	depends on QCOM_APR && HAS_DMA
 	select SND_SOC_QDSP6_COMMON
+	select SND_SOC_QDSP6_CORE
 	help
 	 To add support for MSM QDSP6 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index accebdb49306..03b8e89c9731 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
+obj-$(CONFIG_SND_SOC_QDSP6_CORE) += q6core.o
diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
new file mode 100644
index 000000000000..06f03a5fe9bd
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/jiffies.h>
+#include <linux/wait.h>
+#include <linux/soc/qcom/apr.h>
+#include "q6core.h"
+#include "q6dsp-errno.h"
+
+#define ADSP_STATE_READY_TIMEOUT_MS    3000
+#define Q6_READY_TIMEOUT_MS 100
+#define AVCS_CMD_ADSP_EVENT_GET_STATE		0x0001290C
+#define AVCS_CMDRSP_ADSP_EVENT_GET_STATE	0x0001290D
+#define AVCS_GET_VERSIONS       0x00012905
+#define AVCS_GET_VERSIONS_RSP   0x00012906
+#define AVCS_CMD_GET_FWK_VERSION	0x001292c
+#define AVCS_CMDRSP_GET_FWK_VERSION	0x001292d
+
+struct avcs_svc_info {
+	uint32_t service_id;
+	uint32_t version;
+} __packed;
+
+struct avcs_cmdrsp_get_version {
+	uint32_t build_id;
+	uint32_t num_services;
+	struct avcs_svc_info svc_api_info[];
+} __packed;
+
+/* for ADSP2.8 and above */
+struct avcs_svc_api_info {
+	uint32_t service_id;
+	uint32_t api_version;
+	uint32_t api_branch_version;
+} __packed;
+
+struct avcs_cmdrsp_get_fwk_version {
+	uint32_t build_major_version;
+	uint32_t build_minor_version;
+	uint32_t build_branch_version;
+	uint32_t build_subbranch_version;
+	uint32_t num_services;
+	struct avcs_svc_api_info svc_api_info[];
+} __packed;
+
+struct q6core {
+	struct apr_device *adev;
+	wait_queue_head_t wait;
+	uint32_t avcs_state;
+	struct mutex lock;
+	bool resp_received;
+	uint32_t num_services;
+	struct avcs_cmdrsp_get_fwk_version *fwk_version;
+	struct avcs_cmdrsp_get_version *svc_version;
+	bool fwk_version_supported;
+	bool get_state_supported;
+	bool get_version_supported;
+	bool is_version_requested;
+};
+
+static struct q6core *g_core;
+
+static int q6core_callback(struct apr_device *adev, struct apr_resp_pkt *data)
+{
+	struct q6core *core = dev_get_drvdata(&adev->dev);
+	struct aprv2_ibasic_rsp_result_t *result;
+	struct apr_hdr *hdr = &data->hdr;
+
+	result = data->payload;
+	switch (hdr->opcode) {
+	case APR_BASIC_RSP_RESULT:{
+		result = data->payload;
+		switch (result->opcode) {
+		case AVCS_GET_VERSIONS:
+			if (result->status == ADSP_EUNSUPPORTED)
+				core->get_version_supported = false;
+			core->resp_received = true;
+			break;
+		case AVCS_CMD_GET_FWK_VERSION:
+			if (result->status == ADSP_EUNSUPPORTED)
+				core->fwk_version_supported = false;
+			core->resp_received = true;
+			break;
+		case AVCS_CMD_ADSP_EVENT_GET_STATE:
+			if (result->status == ADSP_EUNSUPPORTED)
+				core->get_state_supported = false;
+			core->resp_received = true;
+			break;
+		}
+		break;
+	}
+	case AVCS_CMDRSP_GET_FWK_VERSION: {
+		struct avcs_cmdrsp_get_fwk_version *fwk;
+		int bytes;
+
+		fwk = data->payload;
+		bytes = sizeof(*fwk) + fwk->num_services *
+				sizeof(fwk->svc_api_info[0]);
+
+		core->fwk_version = kzalloc(bytes, GFP_ATOMIC);
+		if (!core->fwk_version)
+			return -ENOMEM;
+
+		memcpy(core->fwk_version, data->payload, bytes);
+
+		core->fwk_version_supported = true;
+		core->resp_received = true;
+
+		break;
+	}
+	case AVCS_GET_VERSIONS_RSP: {
+		struct avcs_cmdrsp_get_version *v;
+		int len;
+
+		v = data->payload;
+
+		len = sizeof(*v) + v->num_services * sizeof(v->svc_api_info[0]);
+
+		core->svc_version = kzalloc(len, GFP_ATOMIC);
+		if (!core->svc_version)
+			return -ENOMEM;
+
+		memcpy(core->svc_version, data->payload, len);
+
+		core->get_version_supported = true;
+		core->resp_received = true;
+
+		break;
+	}
+	case AVCS_CMDRSP_ADSP_EVENT_GET_STATE:
+		core->get_state_supported = true;
+		core->avcs_state = result->opcode;
+
+		core->resp_received = true;
+		break;
+	default:
+		dev_err(&adev->dev, "Message id from adsp core svc: 0x%x\n",
+			hdr->opcode);
+		break;
+	}
+
+	if (core->resp_received)
+		wake_up(&core->wait);
+
+	return 0;
+}
+
+static int q6core_get_fwk_versions(struct q6core *core)
+{
+	struct apr_device *adev = core->adev;
+	struct apr_pkt pkt;
+	int rc;
+
+	pkt.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
+	pkt.hdr.pkt_size = APR_HDR_SIZE;
+	pkt.hdr.opcode = AVCS_CMD_GET_FWK_VERSION;
+
+	rc = apr_send_pkt(adev, &pkt);
+	if (rc < 0)
+		return rc;
+
+	rc = wait_event_timeout(core->wait, (core->resp_received),
+				msecs_to_jiffies(Q6_READY_TIMEOUT_MS));
+	if (rc > 0 && core->resp_received) {
+		core->resp_received = false;
+
+		if (!core->fwk_version_supported)
+			return -ENOTSUPP;
+		else
+			return 0;
+	}
+
+
+	return rc;
+}
+
+static int q6core_get_svc_versions(struct q6core *core)
+{
+	struct apr_device *adev = core->adev;
+	struct apr_pkt pkt;
+	int rc;
+
+	pkt.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
+	pkt.hdr.pkt_size = APR_HDR_SIZE;
+	pkt.hdr.opcode = AVCS_GET_VERSIONS;
+
+	rc = apr_send_pkt(adev, &pkt);
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
+	struct apr_pkt pkt;
+	int rc;
+
+	core->get_state_supported = false;
+
+	pkt.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+				      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
+	pkt.hdr.pkt_size = APR_HDR_SIZE;
+	pkt.hdr.opcode = AVCS_CMD_ADSP_EVENT_GET_STATE;
+
+	rc = apr_send_pkt(adev, &pkt);
+	if (rc < 0)
+		return false;
+
+	rc = wait_event_timeout(core->wait, (core->resp_received),
+				msecs_to_jiffies(Q6_READY_TIMEOUT_MS));
+	if (rc > 0 && core->resp_received) {
+		core->resp_received = false;
+
+		if (core->avcs_state)
+			return true;
+	}
+
+	/* assume that the adsp is up if we not support this command */
+	if (!core->get_state_supported)
+		return true;
+
+	return false;
+}
+
+/**
+ * q6core_get_svc_api_info() - Get version number of a service.
+ *
+ * @svc_id: service id of the service.
+ * @ainfo: Valid struct pointer to fill svc api information.
+ *
+ * Return: zero on success and error code on failure or unsupported
+ */
+int q6core_get_svc_api_info(int svc_id, struct q6core_svc_api_info *ainfo)
+{
+	int i;
+	int ret = -ENOTSUPP;
+
+	if (!g_core || !ainfo)
+		return 0;
+
+	mutex_lock(&g_core->lock);
+	if (!g_core->is_version_requested) {
+		if (q6core_get_fwk_versions(g_core) == -ENOTSUPP)
+			q6core_get_svc_versions(g_core);
+		g_core->is_version_requested = true;
+	}
+
+	if (g_core->fwk_version_supported) {
+		for (i = 0; i < g_core->fwk_version->num_services; i++) {
+			struct avcs_svc_api_info *info;
+
+			info = &g_core->fwk_version->svc_api_info[i];
+			if (svc_id != info->service_id)
+				continue;
+
+			ainfo->api_version = info->api_version;
+			ainfo->api_branch_version = info->api_branch_version;
+			ret = 0;
+			break;
+		}
+	} else if (g_core->get_version_supported) {
+		for (i = 0; i < g_core->svc_version->num_services; i++) {
+			struct avcs_svc_info *info;
+
+			info = &g_core->svc_version->svc_api_info[i];
+			if (svc_id != info->service_id)
+				continue;
+
+			ainfo->api_version = info->version;
+			ainfo->api_branch_version = 0;
+			ret = 0;
+			break;
+		}
+	}
+
+	mutex_unlock(&g_core->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(q6core_get_svc_api_info);
+
+/**
+ * q6core_is_adsp_ready() - Get status of adsp
+ *
+ * Return: Will be an true if adsp is ready and false if not.
+ */
+bool q6core_is_adsp_ready(void)
+{
+	unsigned long  timeout;
+	bool ret = false;
+
+	if (!g_core)
+		return false;
+
+	mutex_lock(&g_core->lock);
+	timeout = jiffies + msecs_to_jiffies(ADSP_STATE_READY_TIMEOUT_MS);
+	for (;;) {
+		if (__q6core_is_adsp_ready(g_core)) {
+			ret = true;
+			break;
+		}
+
+		if (!time_after(timeout, jiffies)) {
+			ret = false;
+			break;
+		}
+	}
+
+	mutex_unlock(&g_core->lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(q6core_is_adsp_ready);
+
+static int q6core_probe(struct apr_device *adev)
+{
+	g_core = kzalloc(sizeof(*g_core), GFP_KERNEL);
+	if (!g_core)
+		return -ENOMEM;
+
+	dev_set_drvdata(&adev->dev, g_core);
+
+	mutex_init(&g_core->lock);
+	g_core->adev = adev;
+	init_waitqueue_head(&g_core->wait);
+	return 0;
+}
+
+static int q6core_exit(struct apr_device *adev)
+{
+	struct q6core *core = dev_get_drvdata(&adev->dev);
+
+	if (core->fwk_version_supported)
+		kfree(core->fwk_version);
+	if (core->get_version_supported)
+		kfree(core->svc_version);
+
+	g_core = NULL;
+	kfree(core);
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
index 000000000000..4105b1d730be
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6core.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __Q6CORE_H__
+#define __Q6CORE_H__
+
+struct q6core_svc_api_info {
+	uint32_t service_id;
+	uint32_t api_version;
+	uint32_t api_branch_version;
+};
+
+bool q6core_is_adsp_ready(void);
+int q6core_get_svc_api_info(int svc_id, struct q6core_svc_api_info *ainfo);
+
+#endif /* __Q6CORE_H__ */
-- 
2.16.2
