Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A5DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5752173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfADLVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:21:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:52510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727625AbfADLVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:21:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 125B9AEEB;
        Fri,  4 Jan 2019 11:21:46 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S. Miller" <davem@davemloft.net>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org
Subject: [RFC lora-next 5/5] HACK: net: lora: sx130x: Add PicoCell gateway shim for cdc-acm
Date:   Fri,  4 Jan 2019 12:21:31 +0100
Message-Id: <20190104112131.14451-6-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190104112131.14451-1-afaerber@suse.de>
References: <20190104112131.14451-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore our device in cdc-acm probing and add a new driver for it,
dispatching to cdc-acm for the actual implementation.

WARNING: It is likely that this VID/PID is in use for unrelated devices.
Only the Product string hints what this really is in current v0.2.1.
Previous code v0.2.0 was using a Semtech VID/PID, but no card shipping
with such firmware is known to me.

While this may seem unorthodox, no internals of the driver are accessed,
just the set of driver callbacks is duplicated as shim.

Use this shim construct to fake DT nodes for serdev on probe.
For testing purposes these nodes do not have a parent yet.
This results in two "Error -2 creating of_node link" warnings on probe.

Cc: Johan Hovold <johan@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/Makefile   |   2 +
 drivers/net/lora/picogw.c   | 337 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/class/cdc-acm.c |   4 +
 3 files changed, 343 insertions(+)
 create mode 100644 drivers/net/lora/picogw.c

diff --git a/drivers/net/lora/Makefile b/drivers/net/lora/Makefile
index 5fef38abf5ed..bdcf7560dd65 100644
--- a/drivers/net/lora/Makefile
+++ b/drivers/net/lora/Makefile
@@ -27,6 +27,8 @@ lora-sx130x-y := sx130x.o
 lora-sx130x-y += sx130x_radio.o
 obj-$(CONFIG_LORA_SX130X) += lora-sx130x-picogw.o
 lora-sx130x-picogw-y := sx130x_picogw.o
+obj-$(CONFIG_LORA_SX130X) += lora-picogw.o
+lora-picogw-y := picogw.o
 
 obj-$(CONFIG_LORA_USI) += lora-usi.o
 lora-usi-y := usi.o
diff --git a/drivers/net/lora/picogw.c b/drivers/net/lora/picogw.c
new file mode 100644
index 000000000000..aa5b83d21bb3
--- /dev/null
+++ b/drivers/net/lora/picogw.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Semtech PicoCell gateway USB interface
+ *
+ * Copyright (c) 2018-2019 Andreas Färber
+ */
+
+#define pr_fmt(fmt) "picocell: " fmt
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/serial.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/usb.h>
+#include <linux/usb/cdc.h>
+
+#define PICO_VID 0x0483
+#define PICO_PID 0x5740
+
+static struct usb_driver *picogw_get_acm_driver(struct usb_interface *iface)
+{
+	struct device_driver *drv;
+
+	drv = driver_find("cdc_acm", iface->dev.bus);
+	if (!drv)
+		return NULL;
+
+	return to_usb_driver(drv);
+}
+
+static void picogw_kobj_release(struct kobject *kobj)
+{
+	struct device_node *node = container_of(kobj, struct device_node, kobj);
+	struct property *prop;
+
+	prop = node->properties;
+	while (prop) {
+		struct property *next = prop->next;
+		kfree(prop);
+		prop = next;
+	}
+
+	kfree(node);
+}
+
+static struct kobj_type picogw_kobj_type = {
+	.release = picogw_kobj_release,
+};
+
+static u32 picogw_radio_a_reg = cpu_to_be32(0);
+static u32 picogw_radio_b_reg = cpu_to_be32(1);
+
+static int picogw_fake_of_nodes(struct device *dev)
+{
+	struct device_node *node = NULL;
+	struct device_node *child, *spi, *radio_a, *radio_b;
+	struct property *prop;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+	node->name = "<NULL>";
+	node->full_name = "usb0483,5740";
+	node->type = "<NULL>";
+	kobject_init(&node->kobj, &picogw_kobj_type);
+	node->fwnode.ops = &of_fwnode_ops;
+
+	child = kzalloc(sizeof(*child), GFP_KERNEL);
+	if (!child) {
+		of_node_put(node);
+		return -ENOMEM;
+	}
+	child->name = "lora";
+	child->full_name = "lora";
+	child->type = "<NULL>";
+	child->parent = node;
+	kobject_init(&child->kobj, &picogw_kobj_type);
+	child->fwnode.ops = &of_fwnode_ops;
+	node->child = child;
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop) {
+		of_node_put(child);
+		of_node_put(node);
+		return -ENOMEM;
+	}
+	prop->name = "compatible";
+	prop->value = "semtech,lora-picocell";
+	prop->length = 22;
+	child->properties = prop;
+
+	spi = kzalloc(sizeof(*spi), GFP_KERNEL);
+	if (!spi) {
+		of_node_put(child);
+		of_node_put(node);
+		return -ENOMEM;
+	}
+	spi->name = "radio-spi";
+	spi->full_name = "radio-spi";
+	spi->type = "<NULL>";
+	spi->parent = child;
+	kobject_init(&spi->kobj, &picogw_kobj_type);
+	spi->fwnode.ops = &of_fwnode_ops;
+	child->child = spi;
+
+	radio_a = kzalloc(sizeof(*radio_a), GFP_KERNEL);
+	if (!radio_a) {
+		of_node_put(spi);
+		of_node_put(child);
+		of_node_put(node);
+		return -ENOMEM;
+	}
+	radio_a->name = "lora@0";
+	radio_a->full_name = "lora@0";
+	radio_a->type = "<NULL>";
+	radio_a->parent = spi;
+	kobject_init(&radio_a->kobj, &picogw_kobj_type);
+	radio_a->fwnode.ops = &of_fwnode_ops;
+	spi->child = radio_a;
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop) {
+		of_node_put(radio_a);
+		of_node_put(spi);
+		of_node_put(child);
+		of_node_put(node);
+		return -ENOMEM;
+	}
+	prop->name = "compatible";
+	prop->value = "semtech,sx1257";
+	prop->length = 15;
+	radio_a->properties = prop;
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop) {
+		of_node_put(radio_a);
+		of_node_put(spi);
+		of_node_put(child);
+		of_node_put(node);
+		return -ENOMEM;
+	}
+	prop->name = "reg";
+	prop->value = &picogw_radio_a_reg;
+	prop->length = 4;
+	radio_a->properties->next = prop;
+
+	radio_b = kzalloc(sizeof(*radio_b), GFP_KERNEL);
+	if (!radio_b) {
+		of_node_put(radio_a);
+		of_node_put(spi);
+		of_node_put(child);
+		of_node_put(node);
+		return -ENOMEM;
+	}
+	radio_b->name = "lora@1";
+	radio_b->full_name = "Lora@1";
+	radio_b->type = "<NULL>";
+	radio_b->parent = spi;
+	kobject_init(&radio_b->kobj, &picogw_kobj_type);
+	radio_b->fwnode.ops = &of_fwnode_ops;
+	radio_a->sibling = radio_b;
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop) {
+		of_node_put(radio_b);
+		of_node_put(radio_a);
+		of_node_put(spi);
+		of_node_put(child);
+		of_node_put(node);
+		return -ENOMEM;
+	}
+	prop->name = "compatible";
+	prop->value = "semtech,sx1257";
+	prop->length = 15;
+	radio_b->properties = prop;
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop) {
+		of_node_put(radio_a);
+		of_node_put(spi);
+		of_node_put(child);
+		of_node_put(node);
+		return -ENOMEM;
+	}
+	prop->name = "reg";
+	prop->value = &picogw_radio_b_reg;
+	prop->length = 4;
+	radio_b->properties->next = prop;
+
+	dev->of_node = node;
+
+	return 0;
+}
+
+static void picogw_cleanup_of_nodes(struct device *dev)
+{
+	if (dev->of_node->parent)
+		return;
+
+	of_node_put(dev->of_node->child->child->child->sibling); /* lora@1 */
+	of_node_put(dev->of_node->child->child->child); /* lora@0 */
+	of_node_put(dev->of_node->child->child); /* radio-spi*/
+	of_node_put(dev->of_node->child); /* serdev */
+	of_node_put(dev->of_node); /* usb */
+	dev->of_node = NULL;
+}
+
+static int picogw_probe(struct usb_interface *interface,
+	const struct usb_device_id *id)
+{
+	struct usb_driver *drv;
+	int ret;
+
+	drv = picogw_get_acm_driver(interface);
+	if (!drv) {
+		dev_err(&interface->dev, "driver_find failed\n");
+		return -EPROBE_DEFER;
+	}
+
+	if (!interface->dev.of_node) {
+		dev_dbg(&interface->dev, "no of_node\n");
+		ret = picogw_fake_of_nodes(&interface->dev);
+		if (ret)
+			return ret;
+	}
+
+	ret = drv->probe(interface, id);
+	if (ret) {
+		picogw_cleanup_of_nodes(&interface->dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void picogw_disconnect(struct usb_interface *intf)
+{
+	struct usb_driver *drv = picogw_get_acm_driver(intf);
+
+	if (drv)
+		drv->disconnect(intf);
+	else
+		dev_warn(&intf->dev, "%s: failed to get cdc_acm driver\n", __func__);
+
+	picogw_cleanup_of_nodes(&intf->dev);
+}
+
+static int picogw_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct usb_driver *drv = picogw_get_acm_driver(intf);
+
+	if (!drv) {
+		dev_err(&intf->dev, "%s: failed to get cdc_acm driver\n", __func__);
+		return -ENODEV;
+	}
+
+	return drv->suspend(intf, message);
+}
+
+static int picogw_resume(struct usb_interface *intf)
+{
+	struct usb_driver *drv = picogw_get_acm_driver(intf);
+
+	if (!drv) {
+		dev_err(&intf->dev, "%s: failed to get cdc_acm driver\n", __func__);
+		return -ENODEV;
+	}
+
+	return drv->resume(intf);
+}
+
+static int picogw_reset_resume(struct usb_interface *intf)
+{
+	struct usb_driver *drv = picogw_get_acm_driver(intf);
+
+	if (!drv) {
+		dev_err(&intf->dev, "%s: failed to get cdc_acm driver\n", __func__);
+		return -ENODEV;
+	}
+
+	return drv->reset_resume(intf);
+}
+
+static int picogw_pre_reset(struct usb_interface *intf)
+{
+	struct usb_driver *drv = picogw_get_acm_driver(intf);
+
+	if (!drv) {
+		dev_err(&intf->dev, "%s: failed to get cdc_acm driver\n", __func__);
+		return -ENODEV;
+	}
+
+	return drv->pre_reset(intf);
+}
+
+static const struct usb_device_id picogw_usb_id_table[] = {
+	{ USB_DEVICE_AND_INTERFACE_INFO(PICO_VID, PICO_PID,
+	  USB_CLASS_COMM, USB_CDC_SUBCLASS_ACM, USB_CDC_ACM_PROTO_AT_V25TER) },
+	{}
+};
+MODULE_DEVICE_TABLE(usb, picogw_usb_id_table);
+
+static struct usb_driver picogw_usb_driver = {
+	.name = "lora-picogw-usb",
+	.probe = picogw_probe,
+	.disconnect = picogw_disconnect,
+	.suspend = picogw_suspend,
+	.resume = picogw_resume,
+	.reset_resume = picogw_reset_resume,
+	.pre_reset = picogw_pre_reset,
+	.id_table = picogw_usb_id_table,
+	.supports_autosuspend = 1,
+	.disable_hub_initiated_lpm = 1,
+};
+
+static int __init picogw_init(void)
+{
+	int ret;
+
+	ret = usb_register(&picogw_usb_driver);
+	if (ret < 0){
+		pr_err("usb_register failed (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+module_init(picogw_init);
+
+static void __exit picogw_exit(void)
+{
+	usb_deregister(&picogw_usb_driver);
+}
+module_exit(picogw_exit);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index c225a586c524..541c23b4fbfe 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1865,6 +1865,10 @@ static const struct usb_device_id acm_ids[] = {
 	.driver_info = IGNORE_DEVICE,
 	},
 
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0483, 0x5740,
+		USB_CLASS_COMM, USB_CDC_SUBCLASS_ACM, USB_CDC_ACM_PROTO_AT_V25TER),
+	.driver_info = IGNORE_DEVICE },
+
 	/* control interfaces without any protocol set */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ACM,
 		USB_CDC_PROTO_NONE) },
-- 
2.16.4

