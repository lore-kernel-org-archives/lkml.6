Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965516AbeBMRJM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:09:12 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41311 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965424AbeBMRBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:01:23 -0500
X-Google-Smtp-Source: AH8x226t5/CWqvY7rEWB57EFB4Px/UJdwrDoWByCVcPegefGhH7pic6fD82IOT63oDY+yNbW8okbLg==
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
Subject: [PATCH v3 05/25] ASoC: qcom: qdsp6: Add support to Q6AFE
Date: Tue, 13 Feb 2018 16:58:17 +0000
Message-Id: <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to Q6AFE (Audio Front End) module on Q6DSP.

AFE module sits right at the other end of cpu where the codec/audio
devices are connected.

AFE provides abstraced interfaces to both hardware and virtual devices.
Each AFE tx/rx port can be configured to connect to one of the hardware
devices like codec, hdmi, slimbus, i2s and so on. AFE services include
starting, stopping, and if needed, any configurations of the ports.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/dt-bindings/sound/qcom,q6afe.h |   9 +
 sound/soc/qcom/Kconfig                 |   5 +
 sound/soc/qcom/Makefile                |   5 +
 sound/soc/qcom/qdsp6/Makefile          |   1 +
 sound/soc/qcom/qdsp6/q6afe.c           | 520 +++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h           |  37 +++
 6 files changed, 577 insertions(+)
 create mode 100644 include/dt-bindings/sound/qcom,q6afe.h
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.c
 create mode 100644 sound/soc/qcom/qdsp6/q6afe.h

diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
new file mode 100644
index 000000000000..b4d82cccdc86
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __DT_BINDINGS_Q6_AFE_H__
+#define __DT_BINDINGS_Q6_AFE_H__
+
+/* Audio Front End (AFE) Ports */
+#define AFE_PORT_HDMI_RX	8
+
+#endif /* __DT_BINDINGS_Q6_AFE_H__ */
+
diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index b01f347b427d..caeaf8b1b561 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -48,10 +48,15 @@ config SND_SOC_QDSP6_COMMON
 	tristate
 	default n
 
+config SND_SOC_QDSP6_AFE
+	tristate
+	default n
+
 config SND_SOC_QDSP6
 	tristate "SoC ALSA audio driver for QDSP6"
 	depends on QCOM_APR && HAS_DMA
 	select SND_SOC_QDSP6_COMMON
+	select SND_SOC_QDSP6_AFE
 	help
 	 To add support for MSM QDSP6 Soc Audio.
 	 This will enable sound soc platform specific
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index d5280355c24f..748f5e891dcf 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -13,6 +13,11 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
 # Machine
 snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
+snd-soc-msm8996-objs := apq8096.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
+obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-msm8996.o
+
+#DSP lib
+obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
diff --git a/sound/soc/qcom/qdsp6/Makefile b/sound/soc/qcom/qdsp6/Makefile
index accebdb49306..9ec951e0833b 100644
--- a/sound/soc/qcom/qdsp6/Makefile
+++ b/sound/soc/qcom/qdsp6/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_SND_SOC_QDSP6_COMMON) += q6dsp-common.o
+obj-$(CONFIG_SND_SOC_QDSP6_AFE) += q6afe.o
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
new file mode 100644
index 000000000000..0a5af06bb50e
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -0,0 +1,520 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2017, The Linux Foundation
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+#include <linux/jiffies.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/soc/qcom/apr.h>
+#include "q6dsp-errno.h"
+#include "q6afe.h"
+
+/* AFE CMDs */
+#define AFE_PORT_CMD_DEVICE_START	0x000100E5
+#define AFE_PORT_CMD_DEVICE_STOP	0x000100E6
+#define AFE_PORT_CMD_SET_PARAM_V2	0x000100EF
+#define AFE_PORT_CMDRSP_GET_PARAM_V2	0x00010106
+#define AFE_PARAM_ID_HDMI_CONFIG	0x00010210
+#define AFE_MODULE_AUDIO_DEV_INTERFACE	0x0001020C
+
+/* Port IDs */
+#define AFE_API_VERSION_HDMI_CONFIG	0x1
+#define AFE_PORT_ID_MULTICHAN_HDMI_RX	0x100E
+#define TIMEOUT_MS 1000
+#define AFE_CMD_RESP_AVAIL	0
+#define AFE_CMD_RESP_NONE	1
+
+struct q6afe {
+	struct apr_device *apr;
+	struct device *dev;
+	int state;
+	int status;
+
+	struct mutex lock;
+	struct list_head port_list;
+	spinlock_t port_list_lock;
+	struct list_head node;
+	void *dai_data;
+};
+
+struct afe_port_cmd_device_start {
+	struct apr_hdr hdr;
+	u16 port_id;
+	u16 reserved;
+} __packed;
+
+struct afe_port_cmd_device_stop {
+	struct apr_hdr hdr;
+	u16 port_id;
+	u16 reserved;
+/* Reserved for 32-bit alignment. This field must be set to 0.*/
+} __packed;
+
+struct afe_port_param_data_v2 {
+	u32 module_id;
+	u32 param_id;
+	u16 param_size;
+	u16 reserved;
+} __packed;
+
+struct afe_port_cmd_set_param_v2 {
+	u16 port_id;
+	u16 payload_size;
+	u32 payload_address_lsw;
+	u32 payload_address_msw;
+	u32 mem_map_handle;
+} __packed;
+
+struct afe_param_id_hdmi_multi_chan_audio_cfg {
+	u32 hdmi_cfg_minor_version;
+	u16 datatype;
+	u16 channel_allocation;
+	u32 sample_rate;
+	u16 bit_width;
+	u16 reserved;
+} __packed;
+
+union afe_port_config {
+	struct afe_param_id_hdmi_multi_chan_audio_cfg hdmi_multi_ch;
+} __packed;
+
+struct q6afe_port {
+	wait_queue_head_t wait;
+	union afe_port_config port_cfg;
+	int token;
+	int id;
+	int cfg_type;
+	struct q6afe *afe;
+	struct list_head	node;
+};
+
+struct afe_audioif_config_command {
+	struct apr_hdr hdr;
+	struct afe_port_cmd_set_param_v2 param;
+	struct afe_port_param_data_v2 pdata;
+	union afe_port_config port;
+} __packed;
+
+struct afe_port_map {
+	int port_id;
+	int token;
+	int is_rx;
+	int is_dig_pcm;
+};
+
+/* Port map of index vs real hw port ids */
+static struct afe_port_map port_maps[AFE_PORT_MAX] = {
+	[AFE_PORT_HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX,
+				AFE_PORT_HDMI_RX, 1, 1},
+};
+
+static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
+{
+	struct q6afe_port *p = NULL;
+
+	spin_lock(&afe->port_list_lock);
+	list_for_each_entry(p, &afe->port_list, node)
+		if (p->token == token)
+			break;
+
+	spin_unlock(&afe->port_list_lock);
+	return p;
+}
+
+static int afe_callback(struct apr_device *adev,
+			struct apr_client_message *data)
+{
+	struct q6afe *afe = dev_get_drvdata(&adev->dev);
+	struct aprv2_ibasic_rsp_result_t *res;
+	struct q6afe_port *port;
+
+	if (!data->payload_size)
+		return 0;
+
+	res = data->payload;
+	if (data->opcode == APR_BASIC_RSP_RESULT) {
+		if (res->status) {
+			afe->status = res->status;
+			dev_err(afe->dev, "cmd = 0x%x returned error = 0x%x\n",
+				res->opcode, res->status);
+		}
+
+		switch (res->opcode) {
+		case AFE_PORT_CMD_SET_PARAM_V2:
+		case AFE_PORT_CMD_DEVICE_STOP:
+		case AFE_PORT_CMD_DEVICE_START:
+			afe->state = AFE_CMD_RESP_AVAIL;
+			port = afe_find_port(afe, data->token);
+			if (port)
+				wake_up(&port->wait);
+
+			break;
+		default:
+			dev_err(afe->dev, "Unknown cmd 0x%x\n",	res->opcode);
+			break;
+		}
+	}
+
+	return 0;
+}
+/**
+ * q6afe_get_port_id() - Get port id from a given port index
+ *
+ * @index: port index
+ *
+ * Return: Will be an negative on error or valid port_id on success
+ */
+int q6afe_get_port_id(int index)
+{
+	if (index < 0 || index > AFE_PORT_MAX)
+		return -EINVAL;
+
+	return port_maps[index].port_id;
+}
+EXPORT_SYMBOL_GPL(q6afe_get_port_id);
+
+static int afe_apr_send_pkt(struct q6afe *afe, void *data,
+			    wait_queue_head_t *wait)
+{
+	int ret;
+
+	mutex_lock(&afe->lock);
+	afe->status = 0;
+	afe->state = AFE_CMD_RESP_NONE;
+
+	ret = apr_send_pkt(afe->apr, data);
+	if (ret < 0) {
+		dev_err(afe->dev, "packet not transmitted\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = wait_event_timeout(*wait, (afe->state == AFE_CMD_RESP_AVAIL),
+				 msecs_to_jiffies(TIMEOUT_MS));
+	if (!ret) {
+		ret = -ETIMEDOUT;
+	} else if (afe->status > 0) {
+		dev_err(afe->dev, "DSP returned error[%s]\n",
+		       q6dsp_strerror(afe->status));
+		ret = q6dsp_errno(afe->status);
+	} else {
+		ret = 0;
+	}
+
+err:
+	mutex_unlock(&afe->lock);
+
+	return ret;
+}
+
+static int afe_send_cmd_port_start(struct q6afe_port *port)
+{
+	u16 port_id = port->id;
+	struct afe_port_cmd_device_start start;
+	struct q6afe *afe = port->afe;
+	int ret;
+
+	start.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					    APR_HDR_LEN(APR_HDR_SIZE),
+					    APR_PKT_VER);
+	start.hdr.pkt_size = sizeof(start);
+	start.hdr.src_port = 0;
+	start.hdr.dest_port = 0;
+	start.hdr.token = port->token;
+	start.hdr.opcode = AFE_PORT_CMD_DEVICE_START;
+	start.port_id = port_id;
+
+	ret = afe_apr_send_pkt(afe, &start, &port->wait);
+	if (ret)
+		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
+		       port_id, ret);
+
+	return ret;
+}
+
+static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
+				   int param_id, int psize)
+{
+	struct apr_hdr *hdr;
+	struct afe_port_cmd_set_param_v2 *param;
+	struct afe_port_param_data_v2 *pdata;
+	struct q6afe *afe = port->afe;
+	u16 port_id = port->id;
+	int ret;
+
+	hdr = data;
+	param = data + sizeof(*hdr);
+	pdata = data + sizeof(*hdr) + sizeof(*param);
+
+	hdr->hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					      APR_HDR_LEN(APR_HDR_SIZE),
+					      APR_PKT_VER);
+	hdr->pkt_size = sizeof(*hdr) + sizeof(*param) +
+			sizeof(*pdata) + psize;
+	hdr->src_port = 0;
+	hdr->dest_port = 0;
+	hdr->token = port->token;
+	hdr->opcode = AFE_PORT_CMD_SET_PARAM_V2;
+	param->port_id = port_id;
+	param->payload_size = sizeof(*pdata) + psize;
+	param->payload_address_lsw = 0x00;
+	param->payload_address_msw = 0x00;
+	param->mem_map_handle = 0x00;
+	pdata->module_id = AFE_MODULE_AUDIO_DEV_INTERFACE;
+	pdata->param_id = param_id;
+	pdata->param_size = psize;
+
+	ret = afe_apr_send_pkt(afe, data, &port->wait);
+	if (ret)
+		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
+		       port_id, ret);
+
+
+	return ret;
+}
+
+static int afe_port_start(struct q6afe_port *port,
+			  union afe_port_config *afe_config)
+{
+	struct afe_audioif_config_command config = {0,};
+	struct q6afe *afe = port->afe;
+	int port_id = port->id;
+	int ret, param_id = port->cfg_type;
+
+	config.port = *afe_config;
+
+	ret  = q6afe_port_set_param_v2(port, &config, param_id,
+				       sizeof(*afe_config));
+	if (ret) {
+		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
+			port_id, ret);
+		return ret;
+	}
+	return afe_send_cmd_port_start(port);
+}
+
+/**
+ * q6afe_port_stop() - Stop a afe port
+ *
+ * @port: Instance of port to stop
+ *
+ * Return: Will be an negative on packet size on success.
+ */
+int q6afe_port_stop(struct q6afe_port *port)
+{
+	int port_id = port->id;
+	struct afe_port_cmd_device_stop stop;
+	struct q6afe *afe = port->afe;
+	int ret = 0;
+	int index = 0;
+
+	port_id = port->id;
+	index = port->token;
+	if (index < 0 || index > AFE_PORT_MAX) {
+		dev_err(afe->dev, "AFE port index[%d] invalid!\n", index);
+		return -EINVAL;
+	}
+
+	stop.hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
+					   APR_HDR_LEN(APR_HDR_SIZE),
+					   APR_PKT_VER);
+	stop.hdr.pkt_size = sizeof(stop);
+	stop.hdr.src_port = 0;
+	stop.hdr.dest_port = 0;
+	stop.hdr.token = index;
+	stop.hdr.opcode = AFE_PORT_CMD_DEVICE_STOP;
+	stop.port_id = port_id;
+	stop.reserved = 0;
+
+	ret = afe_apr_send_pkt(afe, &stop, &port->wait);
+	if (ret)
+		dev_err(afe->dev, "AFE close failed %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(q6afe_port_stop);
+
+/**
+ * q6afe_set_dai_data() - set dai private data
+ *
+ * @dev: Pointer to afe device.
+ * @data: dai private data
+ *
+ */
+void q6afe_set_dai_data(struct device *dev, void *data)
+{
+	struct q6afe *afe = dev_get_drvdata(dev);
+
+	afe->dai_data = data;
+}
+EXPORT_SYMBOL_GPL(q6afe_set_dai_data);
+
+/**
+ * q6afe_get_dai_data() - get dai private data
+ *
+ * @dev: Pointer to afe device.
+ *
+ * Return: pointer to dai private data
+ */
+void *q6afe_get_dai_data(struct device *dev)
+{
+	struct q6afe *afe = dev_get_drvdata(dev);
+
+	return afe->dai_data;
+}
+EXPORT_SYMBOL_GPL(q6afe_get_dai_data);
+
+/**
+ * q6afe_hdmi_port_prepare() - Prepare hdmi afe port.
+ *
+ * @port: Instance of afe port
+ * @cfg: HDMI configuration for the afe port
+ *
+ */
+void q6afe_hdmi_port_prepare(struct q6afe_port *port,
+			     struct q6afe_hdmi_cfg *cfg)
+{
+	union afe_port_config *pcfg = &port->port_cfg;
+
+	pcfg->hdmi_multi_ch.hdmi_cfg_minor_version =
+					AFE_API_VERSION_HDMI_CONFIG;
+	pcfg->hdmi_multi_ch.datatype = cfg->datatype;
+	pcfg->hdmi_multi_ch.channel_allocation = cfg->channel_allocation;
+	pcfg->hdmi_multi_ch.sample_rate = cfg->sample_rate;
+	pcfg->hdmi_multi_ch.bit_width = cfg->bit_width;
+}
+EXPORT_SYMBOL_GPL(q6afe_hdmi_port_prepare);
+
+/**
+ * q6afe_port_start() - Start a afe port
+ *
+ * @port: Instance of port to start
+ *
+ * Return: Will be an negative on packet size on success.
+ */
+int q6afe_port_start(struct q6afe_port *port)
+{
+	return afe_port_start(port, &port->port_cfg);
+}
+EXPORT_SYMBOL_GPL(q6afe_port_start);
+
+/**
+ * q6afe_port_get_from_id() - Get port instance from a port id
+ *
+ * @dev: Pointer to afe child device.
+ * @id: port id
+ *
+ * Return: Will be an error pointer on error or a valid afe port
+ * on success.
+ */
+struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
+{
+	int port_id;
+	struct q6afe *afe = dev_get_drvdata(dev);
+	struct q6afe_port *port;
+	int cfg_type;
+
+	if (id < 0 || id > AFE_PORT_MAX) {
+		dev_err(dev, "AFE port token[%d] invalid!\n", id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	port_id = port_maps[id].port_id;
+
+	switch (port_id) {
+	case AFE_PORT_ID_MULTICHAN_HDMI_RX:
+		cfg_type = AFE_PARAM_ID_HDMI_CONFIG;
+		break;
+	default:
+		dev_err(dev, "Invalid port id 0x%x\n", port_id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return ERR_PTR(-ENOMEM);
+
+	init_waitqueue_head(&port->wait);
+
+	port->token = id;
+	port->id = port_id;
+	port->afe = afe;
+	port->cfg_type = cfg_type;
+
+	spin_lock(&afe->port_list_lock);
+	list_add_tail(&port->node, &afe->port_list);
+	spin_unlock(&afe->port_list_lock);
+
+	return port;
+
+}
+EXPORT_SYMBOL_GPL(q6afe_port_get_from_id);
+
+/**
+ * q6afe_port_put() - Release port reference
+ *
+ * @port: Instance of port to put
+ */
+void q6afe_port_put(struct q6afe_port *port)
+{
+	struct q6afe *afe = port->afe;
+
+	spin_lock(&afe->port_list_lock);
+	list_del(&port->node);
+	spin_unlock(&afe->port_list_lock);
+}
+EXPORT_SYMBOL_GPL(q6afe_port_put);
+
+static int q6afev2_probe(struct apr_device *adev)
+{
+	struct q6afe *afe;
+	struct device *dev = &adev->dev;
+
+	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
+	if (!afe)
+		return -ENOMEM;
+
+	afe->apr = adev;
+	mutex_init(&afe->lock);
+	afe->dev = dev;
+	INIT_LIST_HEAD(&afe->port_list);
+	spin_lock_init(&afe->port_list_lock);
+
+	dev_set_drvdata(dev, afe);
+
+	return q6afe_dai_dev_probe(dev);
+}
+
+static int q6afev2_remove(struct apr_device *adev)
+{
+	return q6afe_dai_dev_remove(&adev->dev);
+}
+
+static const struct of_device_id q6afe_device_id[]  = {
+	{ .compatible = "qcom,q6afe" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6afe_device_id);
+
+static struct apr_driver qcom_q6afe_driver = {
+	.probe = q6afev2_probe,
+	.remove = q6afev2_remove,
+	.callback = afe_callback,
+	.driver = {
+		.name = "qcom-q6afe",
+		.of_match_table = of_match_ptr(q6afe_device_id),
+
+	},
+};
+
+module_apr_driver(qcom_q6afe_driver);
+MODULE_DESCRIPTION("Q6 Audio Front End");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
new file mode 100644
index 000000000000..43df524f01bb
--- /dev/null
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __Q6AFE_H__
+#define __Q6AFE_H__
+
+#include <dt-bindings/sound/qcom,q6afe.h>
+
+#define AFE_PORT_MAX		9
+
+#define MSM_AFE_PORT_TYPE_RX 0
+#define MSM_AFE_PORT_TYPE_TX 1
+#define AFE_MAX_PORTS AFE_PORT_MAX
+
+struct q6afe_hdmi_cfg {
+	u16                  datatype;
+	u16                  channel_allocation;
+	u32                  sample_rate;
+	u16                  bit_width;
+};
+
+struct q6afe_port_config {
+	struct q6afe_hdmi_cfg hdmi;
+};
+
+struct q6afe_port;
+void q6afe_set_dai_data(struct device *dev, void *data);
+void *q6afe_get_dai_data(struct device *dev);
+
+struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id);
+int q6afe_port_start(struct q6afe_port *port);
+int q6afe_port_stop(struct q6afe_port *port);
+void q6afe_port_put(struct q6afe_port *port);
+int q6afe_get_port_id(int index);
+void q6afe_hdmi_port_prepare(struct q6afe_port *port,
+			    struct q6afe_hdmi_cfg *cfg);
+
+#endif /* __Q6AFE_H__ */
-- 
2.15.1
