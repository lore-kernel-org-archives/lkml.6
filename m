Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520648865; cv=none;
        d=google.com; s=arc-20160816;
        b=Et6pl5fG9BzjkQ4XKy+gcffAgLwtMurEWwXFdWoxHG9NuQZZVn3XCqAOIxd/f0QQFH
         oMRRjSyP1MpFeUDnjzvkH9lj3x94SaXsV9IsSnVFoCZBagCJz4Hp6pLURtHgN3l9t4FR
         xb5mti8sFWCiCsFmao1NhLRwIO2d96mkm77gwC3cqDxtOb0G65f3aPFDDMjVGnwt5l42
         hA+1Z7YTqUR+ZEPkcRMa+K7hLTqKOrFVkKa0O92gevFif7TdjgwyWUXL1bN79EqrASxj
         tpZYlb2GNgzIdw8wV9fCz3XhJC4O7rxCN+EvhhI8B3Sde2XnJGC1SAv0x0NOqw4yUzg0
         oJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ilP90eHaJXeYp6vICJe+A6YWCWp+N5+KT8I8sFYNtac=;
        b=k8wrEepKKAeFmfTSfW1zFOdT7sdDMnbKlRWxXo5lGb4nGZLuma2vVEL3jsqH1byktx
         XJXrX+JkMGUr96lNo85XduMSXBWgI6DxwNMcntoxltahWYFkU0x/E9MkiyDnFuGj/9Xh
         Rjy8q29kKJkBVI08sAJEK0cuZkPESA1gGW7NbkQhzmkqzcsM0vSYjKuPjkoxJ9hDCEAw
         LxiKPEuJpMFpwYgdL3Cq1rEAwgXbavhBfWZhwkrCzBmK0S7E1oEj3xipwI44wMXDg7Ms
         el8FugByEVmJiHSZ4azx+NGFuLP+EdvDJMSc3zbV7UpO+O8878MoNtY4A7g+ywDcn7Na
         iuXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Yp82MUdd;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Yp82MUdd;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELt/g081Xg48TgkJLfGH2XxKk/gzevQNFbuiKZhlrBpzBDi0B3PmjMmCgw/ia+GyJOcUQyylmg==
From: srinivas.kandagatla@linaro.org
To: andy.gross@linaro.org,
	broonie@kernel.org,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org,
	david.brown@linaro.org,
	mark.rutland@arm.com,
	lgirdwood@gmail.com,
	plai@codeaurora.org,
	bgoswami@codeaurora.org,
	tiwai@suse.com,
	perex@perex.cz,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rohkumar@qti.qualcomm.com,
	spatakok@qti.qualcomm.com,
	srinivas.kandagatla@linaro.org
Subject: [PATCH v4 02/24] soc: qcom: Add APR bus driver
Date: Sat, 10 Mar 2018 02:24:34 +0000
Message-Id: <20180310022456.26739-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515904810713812?=
X-GMAIL-MSGID: =?utf-8?q?1594515904810713812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support toi APR bus (Asynchronous Packet Router) driver.
ARP driver is made as a bus driver so that the apr devices can added removed
more dynamically depending on the state of the services on the dsp.
APR is used for communication between application processor and QDSP to
use services on QDSP like Audio and others.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soc/qcom/Kconfig        |   9 +
 drivers/soc/qcom/Makefile       |   1 +
 drivers/soc/qcom/apr.c          | 379 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h |  11 ++
 include/linux/soc/qcom/apr.h    | 131 ++++++++++++++
 5 files changed, 531 insertions(+)
 create mode 100644 drivers/soc/qcom/apr.c
 create mode 100644 include/linux/soc/qcom/apr.h

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 7a729eee13a0..26a8332276e6 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -115,4 +115,13 @@ config QCOM_WCNSS_CTRL
 	  Client driver for the WCNSS_CTRL SMD channel, used to download nv
 	  firmware to a newly booted WCNSS chip.
 
+config QCOM_APR
+	tristate "Qualcomm APR Bus (Asynchronous Packet Router)"
+	depends on ARCH_QCOM
+	depends on RPMSG
+	help
+          Enable APR IPC protocol support between
+          application processor and QDSP6. APR is
+          used by audio driver to configure QDSP6
+          ASM, ADM and AFE modules.
 endmenu
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 7620b1416ee1..043da96e3b79 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_ARCH_MSM8996) +=	kryo-l2-accessors.o
+obj-$(CONFIG_QCOM_APR) += apr.o
diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
new file mode 100644
index 000000000000..56ed3fb1f2f9
--- /dev/null
+++ b/drivers/soc/qcom/apr.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2011-2017, The Linux Foundation
+// Copyright (c) 2018, Linaro Limited
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/of_device.h>
+#include <linux/soc/qcom/apr.h>
+#include <linux/rpmsg.h>
+#include <linux/of.h>
+
+struct apr {
+	struct rpmsg_endpoint *ch;
+	struct device *dev;
+	spinlock_t svcs_lock;
+	struct list_head svcs;
+	int dest_domain_id;
+};
+
+/**
+ * apr_send_pkt() - Send a apr message from apr device
+ *
+ * @adev: Pointer to previously registered apr device.
+ * @buf: Pointer to buffer to send
+ *
+ * Return: Will be an negative on packet size on success.
+ */
+int apr_send_pkt(struct apr_device *adev, void *buf)
+{
+	struct apr *apr = dev_get_drvdata(adev->dev.parent);
+	struct apr_hdr *hdr;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&adev->lock, flags);
+
+	hdr = (struct apr_hdr *)buf;
+	hdr->src_domain = APR_DOMAIN_APPS;
+	hdr->src_svc = adev->svc_id;
+	hdr->dest_domain = adev->domain_id;
+	hdr->dest_svc = adev->svc_id;
+
+	ret = rpmsg_send(apr->ch, buf, hdr->pkt_size);
+	if (ret) {
+		dev_err(&adev->dev, "Unable to send APR pkt %d\n",
+			hdr->pkt_size);
+	} else {
+		ret = hdr->pkt_size;
+	}
+
+	spin_unlock_irqrestore(&adev->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(apr_send_pkt);
+
+static void apr_dev_release(struct device *dev)
+{
+	struct apr_device *adev = to_apr_device(dev);
+
+	kfree(adev);
+}
+
+static int apr_callback(struct rpmsg_device *rpdev, void *buf,
+				  int len, void *priv, u32 addr)
+{
+	struct apr *apr = dev_get_drvdata(&rpdev->dev);
+	struct apr_client_message data;
+	struct apr_device *p, *c_svc = NULL;
+	struct apr_driver *adrv = NULL;
+	struct apr_hdr *hdr;
+	uint16_t hdr_size;
+	uint16_t msg_type;
+	uint16_t ver;
+	uint16_t svc;
+
+	if (len <= APR_HDR_SIZE) {
+		dev_err(apr->dev, "APR: Improper apr pkt received:%p %d\n",
+			buf, len);
+		return -EINVAL;
+	}
+
+	hdr = buf;
+	ver = APR_HDR_FIELD_VER(hdr->hdr_field);
+	if (ver > APR_PKT_VER + 1)
+		return -EINVAL;
+
+	hdr_size = APR_HDR_FIELD_SIZE_BYTES(hdr->hdr_field);
+	if (hdr_size < APR_HDR_SIZE) {
+		dev_err(apr->dev, "APR: Wrong hdr size:%d\n", hdr_size);
+		return -EINVAL;
+	}
+
+	if (hdr->pkt_size < APR_HDR_SIZE) {
+		dev_err(apr->dev, "APR: Wrong paket size\n");
+		return -EINVAL;
+	}
+
+	msg_type = APR_HDR_FIELD_MT(hdr->hdr_field);
+	if (msg_type >= APR_MSG_TYPE_MAX && msg_type != APR_BASIC_RSP_RESULT) {
+		dev_err(apr->dev, "APR: Wrong message type: %d\n", msg_type);
+		return -EINVAL;
+	}
+
+	if (hdr->src_domain >= APR_DOMAIN_MAX ||
+			hdr->dest_domain >= APR_DOMAIN_MAX ||
+			hdr->src_svc >= APR_SVC_MAX ||
+			hdr->dest_svc >= APR_SVC_MAX) {
+		dev_err(apr->dev, "APR: Wrong APR header\n");
+		return -EINVAL;
+	}
+
+	svc = hdr->dest_svc;
+	spin_lock(&apr->svcs_lock);
+	list_for_each_entry(p, &apr->svcs, node) {
+		if (svc == p->svc_id) {
+			c_svc = p;
+			if (c_svc->dev.driver)
+				adrv = to_apr_driver(c_svc->dev.driver);
+			break;
+		}
+	}
+	spin_unlock(&apr->svcs_lock);
+
+	if (!adrv) {
+		dev_err(apr->dev, "APR: service is not registered\n");
+		return -EINVAL;
+	}
+
+	data.payload_size = hdr->pkt_size - hdr_size;
+	data.opcode = hdr->opcode;
+	data.src_port = hdr->src_port;
+	data.dest_port = hdr->dest_port;
+	data.token = hdr->token;
+	data.msg_type = msg_type;
+
+	if (data.payload_size > 0)
+		data.payload = buf + hdr_size;
+
+	adrv->callback(c_svc, &data);
+
+	return 0;
+}
+
+static int apr_device_match(struct device *dev, struct device_driver *drv)
+{
+	struct apr_device *adev = to_apr_device(dev);
+	struct apr_driver *adrv = to_apr_driver(drv);
+	const struct apr_device_id *id = adrv->id_table;
+
+	/* Attempt an OF style match first */
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	if (!id)
+		return 0;
+
+	while (id->domain_id != 0 || id->svc_id != 0) {
+		if (id->domain_id == adev->domain_id &&
+		    id->svc_id == adev->svc_id)
+			return 1;
+		id++;
+	}
+
+	return 0;
+}
+
+static int apr_device_probe(struct device *dev)
+{
+	struct apr_device *adev = to_apr_device(dev);
+	struct apr_driver *adrv = to_apr_driver(dev->driver);
+
+	return adrv->probe(adev);
+}
+
+static int apr_device_remove(struct device *dev)
+{
+	struct apr_device *adev = to_apr_device(dev);
+	struct apr_driver *adrv;
+	struct apr *apr = dev_get_drvdata(adev->dev.parent);
+
+	if (dev->driver) {
+		adrv = to_apr_driver(dev->driver);
+		if (adrv->remove)
+			adrv->remove(adev);
+		spin_lock(&apr->svcs_lock);
+		list_del(&adev->node);
+		spin_unlock(&apr->svcs_lock);
+	}
+
+	return 0;
+}
+
+struct bus_type aprbus_type = {
+	.name		= "aprbus",
+	.match		= apr_device_match,
+	.probe		= apr_device_probe,
+	.remove		= apr_device_remove,
+	.force_dma	= true,
+};
+EXPORT_SYMBOL_GPL(aprbus_type);
+
+static int apr_add_device(struct device *dev, struct device_node *np,
+			  const struct apr_device_id *id, bool is_svc)
+{
+	struct apr *apr = dev_get_drvdata(dev);
+	struct apr_device *adev = NULL;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	spin_lock_init(&adev->lock);
+
+	if (is_svc) {
+		adev->svc_id = id->svc_id;
+		adev->domain_id = id->domain_id;
+		adev->version = id->svc_version;
+		dev_set_name(&adev->dev, "aprsvc:%s:%x:%x", id->name,
+			     id->domain_id, id->svc_id);
+	} else  {
+		dev_set_name(&adev->dev, "%s:%s", dev_name(dev), np->name);
+	}
+
+	adev->dev.bus = &aprbus_type;
+	adev->dev.parent = dev;
+	adev->dev.of_node = np;
+	adev->dev.release = apr_dev_release;
+	adev->dev.driver = NULL;
+
+	spin_lock(&apr->svcs_lock);
+	list_add_tail(&adev->node, &apr->svcs);
+	spin_unlock(&apr->svcs_lock);
+
+	dev_info(dev, "Adding APR dev: %s\n", dev_name(&adev->dev));
+
+	return device_register(&adev->dev);
+}
+
+static void of_register_apr_devices(struct device *dev)
+{
+	struct apr *apr = dev_get_drvdata(dev);
+	struct device_node *node;
+
+	for_each_child_of_node(dev->of_node, node) {
+		struct apr_device_id id = {0};
+		const char *svc_name;
+		bool is_svc = false;
+
+		if (of_find_property(node, "qcom,apr-svc-id", NULL) &&
+		    of_find_property(node, "qcom,apr-svc-name", NULL)) {
+			/* svc node */
+			of_property_read_u32(node, "qcom,apr-svc-id",
+					     &id.svc_id);
+			of_property_read_string(node, "qcom,apr-svc-name",
+						&svc_name);
+			id.domain_id = apr->dest_domain_id;
+
+			memcpy(id.name, svc_name, strlen(svc_name) + 1);
+			is_svc = true;
+		}
+
+		if (apr_add_device(dev, node, &id, is_svc))
+			dev_err(dev, "Failed to add arp %s svc\n", svc_name);
+	}
+}
+
+static int apr_probe(struct rpmsg_device *rpdev)
+{
+	struct device *dev = &rpdev->dev;
+	struct apr *apr;
+	int ret;
+
+	apr = devm_kzalloc(dev, sizeof(*apr), GFP_KERNEL);
+	if (!apr)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(dev->of_node, "qcom,apr-dest-domain-id",
+				   &apr->dest_domain_id);
+	if (ret) {
+		dev_err(dev, "APR Domain ID not specified in DT\n");
+		return ret;
+	}
+
+	dev_set_drvdata(dev, apr);
+	apr->ch = rpdev->ept;
+	apr->dev = dev;
+	INIT_LIST_HEAD(&apr->svcs);
+
+	of_register_apr_devices(dev);
+
+	return 0;
+}
+
+static int apr_remove_device(struct device *dev, void *null)
+{
+	struct apr_device *adev = to_apr_device(dev);
+
+	device_unregister(&adev->dev);
+
+	return 0;
+}
+
+static void apr_remove(struct rpmsg_device *rpdev)
+{
+	device_for_each_child(&rpdev->dev, NULL, apr_remove_device);
+}
+
+/*
+ * __apr_driver_register() - Client driver registration with aprbus
+ *
+ * @drv:Client driver to be associated with client-device.
+ * @owner: owning module/driver
+ *
+ * This API will register the client driver with the aprbus
+ * It is called from the driver's module-init function.
+ */
+int __apr_driver_register(struct apr_driver *drv, struct module *owner)
+{
+	drv->driver.bus = &aprbus_type;
+	drv->driver.owner = owner;
+
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(__apr_driver_register);
+
+/*
+ * apr_driver_unregister() - Undo effect of apr_driver_register
+ *
+ * @drv: Client driver to be unregistered
+ */
+void apr_driver_unregister(struct apr_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(apr_driver_unregister);
+
+static const struct of_device_id apr_of_match[] = {
+	{ .compatible = "qcom,apr"},
+	{ .compatible = "qcom,apr-v2"},
+	{}
+};
+
+static struct rpmsg_driver apr_driver = {
+	.probe = apr_probe,
+	.remove = apr_remove,
+	.callback = apr_callback,
+	.drv = {
+		.name = "qcom,apr",
+		.of_match_table = apr_of_match,
+	},
+};
+
+static int __init apr_init(void)
+{
+	int ret;
+
+	ret = bus_register(&aprbus_type);
+	if (!ret)
+		ret = register_rpmsg_driver(&apr_driver);
+
+	return ret;
+}
+
+static void __exit apr_exit(void)
+{
+	bus_unregister(&aprbus_type);
+	unregister_rpmsg_driver(&apr_driver);
+}
+
+subsys_initcall(apr_init);
+module_exit(apr_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Qualcomm APR Bus");
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 48fb2b43c35a..c05c89b5a99e 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -471,6 +471,17 @@ struct slim_device_id {
 	kernel_ulong_t driver_data;
 };
 
+#define APR_NAME_SIZE	32
+#define APR_MODULE_PREFIX "apr:"
+
+struct apr_device_id {
+	char name[APR_NAME_SIZE];
+	__u32 domain_id;
+	__u32 svc_id;
+	__u32 svc_version;
+	kernel_ulong_t driver_data;	/* Data private to the driver */
+};
+
 #define SPMI_NAME_SIZE	32
 #define SPMI_MODULE_PREFIX "spmi:"
 
diff --git a/include/linux/soc/qcom/apr.h b/include/linux/soc/qcom/apr.h
new file mode 100644
index 000000000000..dbc9efe185d1
--- /dev/null
+++ b/include/linux/soc/qcom/apr.h
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2011-2017, The Linux Foundation
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#ifndef __QCOM_APR_H_
+#define __QCOM_APR_H_
+
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <dt-bindings/soc/qcom,apr.h>
+
+#define APR_HDR_LEN(hdr_len) ((hdr_len)/4)
+
+/*
+ * HEADER field
+ * version:0:3
+ * header_size : 4:7
+ * message_type : 8:9
+ * reserved: 10:15
+ */
+#define APR_HDR_FIELD(msg_type, hdr_len, ver)\
+	(((msg_type & 0x3) << 8) | ((hdr_len & 0xF) << 4) | (ver & 0xF))
+
+#define APR_HDR_SIZE sizeof(struct apr_hdr)
+#define APR_SEQ_CMD_HDR_FIELD APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD, \
+					    APR_HDR_LEN(APR_HDR_SIZE), \
+					    APR_PKT_VER)
+/* Version */
+#define APR_PKT_VER		0x0
+
+/* Command and Response Types */
+#define APR_MSG_TYPE_EVENT	0x0
+#define APR_MSG_TYPE_CMD_RSP	0x1
+#define APR_MSG_TYPE_SEQ_CMD	0x2
+#define APR_MSG_TYPE_NSEQ_CMD	0x3
+#define APR_MSG_TYPE_MAX	0x04
+
+/* APR Basic Response Message */
+#define APR_BASIC_RSP_RESULT 0x000110E8
+#define APR_RSP_ACCEPTED     0x000100BE
+
+struct aprv2_ibasic_rsp_result_t {
+	uint32_t opcode;
+	uint32_t status;
+};
+
+/* hdr field Ver [0:3], Size [4:7], Message type [8:10] */
+#define APR_HDR_FIELD_VER(h)		(h & 0x000F)
+#define APR_HDR_FIELD_SIZE(h)		((h & 0x00F0) >> 4)
+#define APR_HDR_FIELD_SIZE_BYTES(h)	(((h & 0x00F0) >> 4) * 4)
+#define APR_HDR_FIELD_MT(h)		((h & 0x0300) >> 8)
+
+struct apr_hdr {
+	uint16_t hdr_field;
+	uint16_t pkt_size;
+	uint8_t src_svc;
+	uint8_t src_domain;
+	uint16_t src_port;
+	uint8_t dest_svc;
+	uint8_t dest_domain;
+	uint16_t dest_port;
+	uint32_t token;
+	uint32_t opcode;
+};
+
+struct apr_client_message {
+	uint16_t payload_size;
+	uint16_t hdr_len;
+	uint16_t msg_type;
+	uint16_t src;
+	uint16_t dest_svc;
+	uint16_t src_port;
+	uint16_t dest_port;
+	uint32_t token;
+	uint32_t opcode;
+	void *payload;
+};
+
+/* Bits 0 to 15 -- Minor version,  Bits 16 to 31 -- Major version */
+#define APR_SVC_MAJOR_VERSION(v)	((v >> 16) & 0xFF)
+#define APR_SVC_MINOR_VERSION(v)	(v & 0xFF)
+
+struct apr_device {
+	struct device	dev;
+	uint16_t	svc_id;
+	uint16_t	domain_id;
+	uint32_t	version;
+	spinlock_t	lock;
+	struct list_head node;
+};
+
+#define to_apr_device(d) container_of(d, struct apr_device, dev)
+
+struct apr_driver {
+	int	(*probe)(struct apr_device *sl);
+	int	(*remove)(struct apr_device *sl);
+	int	(*callback)(struct apr_device *a,
+			    struct apr_client_message *d);
+	struct device_driver		driver;
+	const struct apr_device_id	*id_table;
+};
+
+#define to_apr_driver(d) container_of(d, struct apr_driver, driver)
+
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE
+ */
+#define apr_driver_register(drv) __apr_driver_register(drv, THIS_MODULE)
+
+int __apr_driver_register(struct apr_driver *drv, struct module *owner);
+void apr_driver_unregister(struct apr_driver *drv);
+
+/**
+ * module_apr_driver() - Helper macro for registering a aprbus driver
+ * @__aprbus_driver: aprbus_driver struct
+ *
+ * Helper macro for aprbus drivers which do not do anything special in
+ * module init/exit. This eliminates a lot of boilerplate. Each module
+ * may only use this macro once, and calling it replaces module_init()
+ * and module_exit()
+ */
+#define module_apr_driver(__apr_driver) \
+	module_driver(__apr_driver, apr_driver_register, \
+			apr_driver_unregister)
+
+int apr_send_pkt(struct apr_device *adev, void *buf);
+
+#endif /* __QCOM_APR_H_ */
-- 
2.15.1
