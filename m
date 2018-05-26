Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032462AbeEZVT6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 17:19:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47041 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032377AbeEZVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 17:19:56 -0400
X-Google-Smtp-Source: ADUXVKLRD6GQ0iKE8DVWwb5lV9uIF+XTK/addcoKh6+ptRd/M6b9K0WhuQfW4+sc0FZOuonbBc1VOw==
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v2 1/3] usb: gadget: ccid: add support for USB CCID Gadget Device
Date: Sat, 26 May 2018 23:19:38 +0200
Message-Id: <20180526211940.25474-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Card Interface Device (CCID) protocol is a USB protocol that
allows a smartcard device to be connected to a computer via a card
reader using a standard USB interface, without the need for each manufacturer
of smartcards to provide its own reader or protocol.

This gadget driver makes Linux show up as a CCID device to the host and let a
userspace daemon act as the smartcard.

This is useful when the Linux gadget itself should act as a cryptographic
device or forward APDUs to an embedded smartcard device.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/usb/gadget/Kconfig           |  17 +
 drivers/usb/gadget/function/Makefile |   1 +
 drivers/usb/gadget/function/f_ccid.c | 988 +++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/function/f_ccid.h |  91 ++++
 include/uapi/linux/usb/ccid.h        |  93 ++++
 5 files changed, 1190 insertions(+)
 create mode 100644 drivers/usb/gadget/function/f_ccid.c
 create mode 100644 drivers/usb/gadget/function/f_ccid.h
 create mode 100644 include/uapi/linux/usb/ccid.h

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 31cce7805eb2..bdebdf1ffa2b 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -149,6 +149,9 @@ config USB_LIBCOMPOSITE
 config USB_F_ACM
 	tristate
 
+config USB_F_CCID
+	tristate
+
 config USB_F_SS_LB
 	tristate
 
@@ -248,6 +251,20 @@ config USB_CONFIGFS_ACM
 	  ACM serial link.  This function can be used to interoperate with
 	  MS-Windows hosts or with the Linux-USB "cdc-acm" driver.
 
+config USB_CONFIGFS_CCID
+	bool "Chip Card Interface Device (CCID)"
+	depends on USB_CONFIGFS
+	select USB_F_CCID
+	help
+	  The CCID function driver provides generic emulation of a
+	  Chip Card Interface Device (CCID).
+
+	  You will need a user space server talking to /dev/ccidg*,
+	  since the kernel itself does not implement CCID/TPDU/APDU
+	  protocol.
+
+	  For more information, see Documentation/usb/gadget_ccid.rst.
+
 config USB_CONFIGFS_OBEX
 	bool "Object Exchange Model (CDC OBEX)"
 	depends on USB_CONFIGFS
diff --git a/drivers/usb/gadget/function/Makefile b/drivers/usb/gadget/function/Makefile
index 5d3a6cf02218..629851009e1a 100644
--- a/drivers/usb/gadget/function/Makefile
+++ b/drivers/usb/gadget/function/Makefile
@@ -9,6 +9,7 @@ ccflags-y			+= -I$(srctree)/drivers/usb/gadget/udc/
 # USB Functions
 usb_f_acm-y			:= f_acm.o
 obj-$(CONFIG_USB_F_ACM)		+= usb_f_acm.o
+obj-$(CONFIG_USB_F_CCID)	+= f_ccid.o
 usb_f_ss_lb-y			:= f_loopback.o f_sourcesink.o
 obj-$(CONFIG_USB_F_SS_LB)	+= usb_f_ss_lb.o
 obj-$(CONFIG_USB_U_SERIAL)	+= u_serial.o
diff --git a/drivers/usb/gadget/function/f_ccid.c b/drivers/usb/gadget/function/f_ccid.c
new file mode 100644
index 000000000000..9ff8615ca303
--- /dev/null
+++ b/drivers/usb/gadget/function/f_ccid.c
@@ -0,0 +1,988 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * f_ccid.c -- Chip Card Interface Device (CCID) function Driver
+ *
+ * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
+ *
+ */
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/usb/composite.h>
+#include <uapi/linux/usb/ccid.h>
+
+#include "f_ccid.h"
+#include "u_f.h"
+
+/* Number of tx requests to allocate */
+#define N_TX_REQS 4
+
+/* Maximum number of devices */
+#define CCID_MINORS 4
+
+struct ccidg_bulk_dev {
+	atomic_t is_open;
+	atomic_t rx_req_busy;
+	wait_queue_head_t read_wq;
+	wait_queue_head_t write_wq;
+	struct usb_request *rx_req;
+	atomic_t rx_done;
+	struct list_head tx_idle;
+};
+
+struct f_ccidg {
+	struct usb_function_instance	func_inst;
+	struct usb_function function;
+	spinlock_t lock;
+	atomic_t online;
+
+	/* Character device */
+	struct cdev cdev;
+	int minor;
+
+	/* Dynamic attributes */
+	u32 features;
+	u32 protocols;
+	u8 pinsupport;
+	u8 nslots;
+	u8 lcdlayout;
+
+	/* Endpoints */
+	struct usb_ep *in;
+	struct usb_ep *out;
+	struct ccidg_bulk_dev bulk_dev;
+};
+
+/* Interface Descriptor: */
+static struct usb_interface_descriptor ccid_interface_desc = {
+	.bLength =		USB_DT_INTERFACE_SIZE,
+	.bDescriptorType =	USB_DT_INTERFACE,
+	.bNumEndpoints =	2,
+	.bInterfaceClass =	USB_CLASS_CSCID,
+	.bInterfaceSubClass =	0,
+	.bInterfaceProtocol =	0,
+};
+
+/* CCID Class Descriptor */
+static struct ccid_class_descriptor ccid_class_desc = {
+	.bLength =		sizeof(ccid_class_desc),
+	.bDescriptorType =	CCID_DECRIPTOR_TYPE,
+	.bcdCCID =		CCID1_10,
+	/* .bMaxSlotIndex =	DYNAMIC */
+	.bVoltageSupport =	CCID_VOLTS_3_0,
+	/* .dwProtocols =	DYNAMIC */
+	.dwDefaultClock =	3580,
+	.dwMaximumClock =	3580,
+	.bNumClockSupported =	0,
+	.dwDataRate =		9600,
+	.dwMaxDataRate =	9600,
+	.bNumDataRatesSupported = 0,
+	.dwMaxIFSD =		0,
+	.dwSynchProtocols =	0,
+	.dwMechanical =		0,
+	/* .dwFeatures =	DYNAMIC */
+
+	/* extended APDU level Message Length */
+	.dwMaxCCIDMessageLength = 0x200,
+	.bClassGetResponse =	0x0,
+	.bClassEnvelope =	0x0,
+	/* .wLcdLayout =	DYNAMIC */
+	/* .bPINSupport =	DYNAMIC */
+	.bMaxCCIDBusySlots =	1
+};
+
+/* Full speed support: */
+static struct usb_endpoint_descriptor ccid_fs_in_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+	.bEndpointAddress =	USB_DIR_IN,
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize   =	cpu_to_le16(64),
+};
+
+static struct usb_endpoint_descriptor ccid_fs_out_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+	.bEndpointAddress =	USB_DIR_OUT,
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize   =	 cpu_to_le16(64),
+};
+
+static struct usb_descriptor_header *ccid_fs_descs[] = {
+	(struct usb_descriptor_header *) &ccid_interface_desc,
+	(struct usb_descriptor_header *) &ccid_class_desc,
+	(struct usb_descriptor_header *) &ccid_fs_in_desc,
+	(struct usb_descriptor_header *) &ccid_fs_out_desc,
+	NULL,
+};
+
+/* High speed support: */
+static struct usb_endpoint_descriptor ccid_hs_in_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+	.bEndpointAddress =	USB_DIR_IN,
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =	cpu_to_le16(512),
+};
+
+static struct usb_endpoint_descriptor ccid_hs_out_desc = {
+	.bLength =		USB_DT_ENDPOINT_SIZE,
+	.bDescriptorType =	USB_DT_ENDPOINT,
+	.bEndpointAddress =	USB_DIR_OUT,
+	.bmAttributes =		USB_ENDPOINT_XFER_BULK,
+	.wMaxPacketSize =	cpu_to_le16(512),
+};
+
+static struct usb_descriptor_header *ccid_hs_descs[] = {
+	(struct usb_descriptor_header *) &ccid_interface_desc,
+	(struct usb_descriptor_header *) &ccid_class_desc,
+	(struct usb_descriptor_header *) &ccid_hs_in_desc,
+	(struct usb_descriptor_header *) &ccid_hs_out_desc,
+	NULL,
+};
+
+static DEFINE_IDA(ccidg_ida);
+static int major;
+static DEFINE_MUTEX(ccidg_ida_lock); /* protects access to ccidg_ida */
+static struct class *ccidg_class;
+
+static inline struct f_ccidg_opts *to_f_ccidg_opts(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct f_ccidg_opts,
+			    func_inst.group);
+}
+
+static inline struct f_ccidg *func_to_ccidg(struct usb_function *f)
+{
+	return container_of(f, struct f_ccidg, function);
+}
+
+static inline int ccidg_get_minor(void)
+{
+	int ret;
+
+	ret = ida_simple_get(&ccidg_ida, 0, 0, GFP_KERNEL);
+	if (ret >= CCID_MINORS) {
+		ida_simple_remove(&ccidg_ida, ret);
+		ret = -ENODEV;
+	}
+
+	return ret;
+}
+
+static inline void ccidg_put_minor(int minor)
+{
+	ida_simple_remove(&ccidg_ida, minor);
+}
+
+static int ccidg_setup(void)
+{
+	int ret;
+	dev_t dev;
+
+	ccidg_class = class_create(THIS_MODULE, "ccidg");
+	if (IS_ERR(ccidg_class)) {
+		ccidg_class = NULL;
+		return PTR_ERR(ccidg_class);
+	}
+
+	ret = alloc_chrdev_region(&dev, 0, CCID_MINORS, "ccidg");
+	if (ret) {
+		class_destroy(ccidg_class);
+		ccidg_class = NULL;
+		return ret;
+	}
+
+	major = MAJOR(dev);
+
+	return 0;
+}
+
+static void ccidg_cleanup(void)
+{
+	if (major) {
+		unregister_chrdev_region(MKDEV(major, 0), CCID_MINORS);
+		major = 0;
+	}
+
+	class_destroy(ccidg_class);
+	ccidg_class = NULL;
+}
+
+static void ccidg_attr_release(struct config_item *item)
+{
+	struct f_ccidg_opts *opts = to_f_ccidg_opts(item);
+
+	usb_put_function_instance(&opts->func_inst);
+}
+
+static struct configfs_item_operations ccidg_item_ops = {
+	.release	= ccidg_attr_release,
+};
+
+#define F_CCIDG_OPT(name, prec, limit)					\
+static ssize_t f_ccidg_opts_##name##_show(struct config_item *item, char *page)\
+{									\
+	struct f_ccidg_opts *opts = to_f_ccidg_opts(item);		\
+	int result;							\
+									\
+	mutex_lock(&opts->lock);					\
+	result = sprintf(page, "%x\n", opts->name);			\
+	mutex_unlock(&opts->lock);					\
+									\
+	return result;							\
+}									\
+									\
+static ssize_t f_ccidg_opts_##name##_store(struct config_item *item,	\
+					 const char *page, size_t len)	\
+{									\
+	struct f_ccidg_opts *opts = to_f_ccidg_opts(item);		\
+	int ret;							\
+	u##prec num;							\
+									\
+	mutex_lock(&opts->lock);					\
+	if (opts->refcnt) {						\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	ret = kstrtou##prec(page, 0, &num);				\
+	if (ret)							\
+		goto end;						\
+									\
+	if (num > limit) {						\
+		ret = -EINVAL;						\
+		goto end;						\
+	}								\
+	opts->name = num;						\
+	ret = len;							\
+									\
+end:									\
+	mutex_unlock(&opts->lock);					\
+	return ret;							\
+}									\
+									\
+CONFIGFS_ATTR(f_ccidg_opts_, name)
+
+F_CCIDG_OPT(features, 32, 0xffffffff);
+F_CCIDG_OPT(protocols, 32, 0x03);
+F_CCIDG_OPT(pinsupport, 8, 0x03);
+F_CCIDG_OPT(lcdlayout, 16, 0xffff);
+F_CCIDG_OPT(nslots, 8, 0xff);
+
+static struct configfs_attribute *ccidg_attrs[] = {
+	&f_ccidg_opts_attr_features,
+	&f_ccidg_opts_attr_protocols,
+	&f_ccidg_opts_attr_pinsupport,
+	&f_ccidg_opts_attr_lcdlayout,
+	&f_ccidg_opts_attr_nslots,
+	NULL,
+};
+
+static struct config_item_type ccidg_func_type = {
+	.ct_item_ops	= &ccidg_item_ops,
+	.ct_attrs	= ccidg_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static void ccidg_req_put(struct f_ccidg *ccidg, struct list_head *head,
+		struct usb_request *req)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ccidg->lock, flags);
+	list_add_tail(&req->list, head);
+	spin_unlock_irqrestore(&ccidg->lock, flags);
+}
+
+static struct usb_request *ccidg_req_get(struct f_ccidg *ccidg,
+					struct list_head *head)
+{
+	unsigned long flags;
+	struct usb_request *req = NULL;
+
+	spin_lock_irqsave(&ccidg->lock, flags);
+	if (!list_empty(head)) {
+		req = list_first_entry(head, struct usb_request, list);
+		list_del(&req->list);
+	}
+	spin_unlock_irqrestore(&ccidg->lock, flags);
+
+	return req;
+}
+
+static void ccidg_bulk_complete_tx(struct usb_ep *ep, struct usb_request *req)
+{
+	struct f_ccidg *ccidg = (struct f_ccidg *)ep->driver_data;
+	struct ccidg_bulk_dev *bulk_dev = &ccidg->bulk_dev;
+	struct usb_composite_dev *cdev	= ccidg->function.config->cdev;
+
+	switch (req->status) {
+	default:
+		VDBG(cdev, "ccid: tx err %d\n", req->status);
+		/* FALLTHROUGH */
+	case -ECONNRESET:		/* unlink */
+	case -ESHUTDOWN:		/* disconnect etc */
+		break;
+	case 0:
+		break;
+	}
+
+	ccidg_req_put(ccidg, &bulk_dev->tx_idle, req);
+	wake_up(&bulk_dev->write_wq);
+}
+
+static void ccidg_bulk_complete_rx(struct usb_ep *ep, struct usb_request *req)
+{
+	struct f_ccidg *ccidg = (struct f_ccidg *)ep->driver_data;
+	struct ccidg_bulk_dev *bulk_dev = &ccidg->bulk_dev;
+	struct usb_composite_dev *cdev	= ccidg->function.config->cdev;
+
+	switch (req->status) {
+
+	/* normal completion */
+	case 0:
+		/* We only cares about packets with nonzero length */
+		if (req->actual > 0)
+			atomic_set(&bulk_dev->rx_done, 1);
+		break;
+
+	/* software-driven interface shutdown */
+	case -ECONNRESET:		/* unlink */
+	case -ESHUTDOWN:		/* disconnect etc */
+		VDBG(cdev, "ccid: rx shutdown, code %d\n", req->status);
+		break;
+
+	/* for hardware automagic (such as pxa) */
+	case -ECONNABORTED:		/* endpoint reset */
+		DBG(cdev, "ccid: rx %s reset\n", ep->name);
+		break;
+
+	/* data overrun */
+	case -EOVERFLOW:
+		/* FALLTHROUGH */
+	default:
+		DBG(cdev, "ccid: rx status %d\n", req->status);
+		break;
+	}
+
+	wake_up(&bulk_dev->read_wq);
+}
+
+static struct usb_request *
+ccidg_request_alloc(struct usb_ep *ep, unsigned int len)
+{
+	struct usb_request *req;
+
+	req = usb_ep_alloc_request(ep, GFP_ATOMIC);
+	if (!req)
+		return ERR_PTR(-ENOMEM);
+
+	req->length = len;
+	req->buf = kmalloc(len, GFP_ATOMIC);
+	if (req->buf == NULL) {
+		usb_ep_free_request(ep, req);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return req;
+}
+
+static void ccidg_request_free(struct usb_request *req, struct usb_ep *ep)
+{
+	if (req) {
+		kfree(req->buf);
+		usb_ep_free_request(ep, req);
+	}
+}
+
+static int ccidg_function_setup(struct usb_function *f,
+		const struct usb_ctrlrequest *ctrl)
+{
+	struct f_ccidg *ccidg = container_of(f, struct f_ccidg, function);
+	struct usb_composite_dev *cdev	= f->config->cdev;
+	struct usb_request *req		= cdev->req;
+	int ret				= -EOPNOTSUPP;
+	u16 w_index			= le16_to_cpu(ctrl->wIndex);
+	u16 w_value			= le16_to_cpu(ctrl->wValue);
+	u16 w_length			= le16_to_cpu(ctrl->wLength);
+
+	if (!atomic_read(&ccidg->online))
+		return -ENOTCONN;
+
+	switch (ctrl->bRequestType & USB_TYPE_MASK) {
+	case USB_TYPE_CLASS:
+		{
+		switch (ctrl->bRequest) {
+		case CCIDGENERICREQ_GET_CLOCK_FREQUENCIES:
+			*(u32 *) req->buf = cpu_to_le32(ccid_class_desc.dwDefaultClock);
+			ret = min_t(u32, w_length,
+					sizeof(ccid_class_desc.dwDefaultClock));
+			break;
+
+		case CCIDGENERICREQ_GET_DATA_RATES:
+			*(u32 *) req->buf = cpu_to_le32(ccid_class_desc.dwDataRate);
+			ret = min_t(u32, w_length, sizeof(ccid_class_desc.dwDataRate));
+			break;
+
+		default:
+			VDBG(f->config->cdev,
+				"ccid: invalid control req%02x.%02x v%04x i%04x l%d\n",
+				ctrl->bRequestType, ctrl->bRequest,
+				w_value, w_index, w_length);
+		}
+		}
+	}
+
+	/* responded with data transfer or status phase? */
+	if (ret >= 0) {
+		VDBG(f->config->cdev, "ccid: req%02x.%02x v%04x i%04x l%d\n",
+			ctrl->bRequestType, ctrl->bRequest,
+			w_value, w_index, w_length);
+
+		req->length = ret;
+		ret = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
+		if (ret < 0)
+			ERROR(f->config->cdev,
+				"ccid: ep0 enqueue err %d\n", ret);
+	}
+
+	return ret;
+}
+
+static void ccidg_function_disable(struct usb_function *f)
+{
+	struct f_ccidg *ccidg = func_to_ccidg(f);
+	struct ccidg_bulk_dev *bulk_dev = &ccidg->bulk_dev;
+	struct usb_request *req;
+
+	/* Disable endpoints */
+	usb_ep_disable(ccidg->in);
+	usb_ep_disable(ccidg->out);
+
+	/* Free endpoint related requests */
+	if (!atomic_read(&bulk_dev->rx_req_busy))
+		ccidg_request_free(bulk_dev->rx_req, ccidg->out);
+	while ((req = ccidg_req_get(ccidg, &bulk_dev->tx_idle)))
+		ccidg_request_free(req, ccidg->in);
+
+	atomic_set(&ccidg->online, 0);
+
+	/* Wake up threads */
+	wake_up(&bulk_dev->write_wq);
+	wake_up(&bulk_dev->read_wq);
+}
+
+int ccidg_start_ep(struct f_ccidg *ccidg, struct usb_function *f,
+			struct usb_ep *ep)
+{
+	struct usb_composite_dev *cdev = f->config->cdev;
+	int ret;
+
+	usb_ep_disable(ep);
+
+	ret = config_ep_by_speed(cdev->gadget, f, ep);
+	if (ret) {
+		ERROR(cdev, "ccid: can't configure %s: %d\n", ep->name, ret);
+		return ret;
+	}
+
+	ret = usb_ep_enable(ep);
+	if (ret) {
+		ERROR(cdev, "ccid: can't start %s: %d\n", ep->name, ret);
+		return ret;
+	}
+
+	ep->driver_data = ccidg;
+
+	return ret;
+}
+
+static int ccidg_function_set_alt(struct usb_function *f,
+		unsigned int intf, unsigned int alt)
+{
+	struct f_ccidg *ccidg		= func_to_ccidg(f);
+	struct usb_composite_dev *cdev	= f->config->cdev;
+	struct ccidg_bulk_dev *bulk_dev	= &ccidg->bulk_dev;
+	struct usb_request *req;
+	int ret;
+	int i;
+
+	/* Allocate requests for our endpoints */
+	req = ccidg_request_alloc(ccidg->out,
+			sizeof(struct ccidg_bulk_out_header));
+	if (IS_ERR(req)) {
+		ERROR(cdev, "ccid: uname to allocate memory for out req\n");
+		return PTR_ERR(req);
+	}
+	req->complete = ccidg_bulk_complete_rx;
+	req->context = ccidg;
+	bulk_dev->rx_req = req;
+
+	/* Allocate bunch of in requests */
+	for (i = 0; i < N_TX_REQS; i++) {
+		req = ccidg_request_alloc(ccidg->in,
+				sizeof(struct ccidg_bulk_in_header));
+
+		if (IS_ERR(req)) {
+			ret = PTR_ERR(req);
+			ERROR(cdev,
+				"ccid: uname to allocate memory for in req\n");
+			goto free_bulk_out;
+		}
+		req->complete = ccidg_bulk_complete_tx;
+		req->context = ccidg;
+		ccidg_req_put(ccidg, &bulk_dev->tx_idle, req);
+	}
+
+	/* choose the descriptors and enable endpoints */
+	ret = ccidg_start_ep(ccidg, f, ccidg->in);
+	if (ret)
+		goto free_bulk_in;
+
+	ret = ccidg_start_ep(ccidg, f, ccidg->out);
+	if (ret)
+		goto disable_ep_in;
+
+	atomic_set(&ccidg->online, 1);
+	return ret;
+
+disable_ep_in:
+	usb_ep_disable(ccidg->in);
+free_bulk_in:
+	while ((req = ccidg_req_get(ccidg, &bulk_dev->tx_idle)))
+		ccidg_request_free(req, ccidg->in);
+free_bulk_out:
+	ccidg_request_free(bulk_dev->rx_req, ccidg->out);
+	return ret;
+}
+
+static int ccidg_bulk_open(struct inode *inode, struct file *file)
+{
+	struct f_ccidg *ccidg;
+	struct ccidg_bulk_dev *bulk_dev;
+
+	ccidg = container_of(inode->i_cdev, struct f_ccidg, cdev);
+	bulk_dev = &ccidg->bulk_dev;
+
+	if (!atomic_read(&ccidg->online)) {
+		DBG(ccidg->function.config->cdev, "ccid: device not online\n");
+		return -ENODEV;
+	}
+
+	if (atomic_read(&bulk_dev->is_open)) {
+		DBG(ccidg->function.config->cdev,
+				"ccid: device already opened\n");
+		return -EBUSY;
+	}
+
+	atomic_set(&bulk_dev->is_open, 1);
+
+	file->private_data = ccidg;
+
+	return 0;
+}
+
+static int ccidg_bulk_release(struct inode *inode, struct file *file)
+{
+	struct f_ccidg *ccidg =  file->private_data;
+	struct ccidg_bulk_dev *bulk_dev = &ccidg->bulk_dev;
+
+	atomic_set(&bulk_dev->is_open, 0);
+	return 0;
+}
+
+static ssize_t ccidg_bulk_read(struct file *file, char __user *buf,
+				size_t count, loff_t *pos)
+{
+	struct f_ccidg *ccidg =  file->private_data;
+	struct ccidg_bulk_dev *bulk_dev = &ccidg->bulk_dev;
+	struct usb_request *req;
+	int r = count, xfer;
+	int ret;
+
+	/* Make sure we have enough space for a whole package */
+	if (count < sizeof(struct ccidg_bulk_out_header)) {
+		DBG(ccidg->function.config->cdev,
+				"ccid: too small buffer size. %i provided, need at least %i\n",
+				count, sizeof(struct ccidg_bulk_out_header));
+		return -ENOMEM;
+	}
+
+	if (!atomic_read(&ccidg->online))
+		return -ENODEV;
+
+	/* queue a request */
+	req = bulk_dev->rx_req;
+	req->length = count;
+	atomic_set(&bulk_dev->rx_done, 0);
+
+	ret = usb_ep_queue(ccidg->out, req, GFP_KERNEL);
+	if (ret < 0) {
+		ERROR(ccidg->function.config->cdev,
+				"ccid: usb ep queue failed\n");
+		return -EIO;
+	}
+
+	if (!atomic_read(&bulk_dev->rx_done) &&
+			file->f_flags & (O_NONBLOCK | O_NDELAY))
+		return -EAGAIN;
+
+	/* wait for a request to complete */
+	ret = wait_event_interruptible(bulk_dev->read_wq,
+			atomic_read(&bulk_dev->rx_done) ||
+			!atomic_read(&ccidg->online));
+	if (ret < 0) {
+		usb_ep_dequeue(ccidg->out, req);
+		return -ERESTARTSYS;
+	}
+
+	/* Still online? */
+	if (!atomic_read(&ccidg->online))
+		return -ENODEV;
+
+	atomic_set(&bulk_dev->rx_req_busy, 1);
+	xfer = (req->actual < count) ? req->actual : count;
+
+	if (copy_to_user(buf, req->buf, xfer))
+		r = -EFAULT;
+
+	atomic_set(&bulk_dev->rx_req_busy, 0);
+	if (!atomic_read(&ccidg->online)) {
+		ccidg_request_free(bulk_dev->rx_req, ccidg->out);
+		return -ENODEV;
+	}
+
+	return xfer;
+}
+
+static ssize_t ccidg_bulk_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *pos)
+{
+	struct f_ccidg *ccidg =  file->private_data;
+	struct ccidg_bulk_dev *bulk_dev = &ccidg->bulk_dev;
+	struct usb_request *req = 0;
+	int ret;
+
+	/* Are we online? */
+	if (!atomic_read(&ccidg->online))
+		return -ENODEV;
+
+	/* Avoid Zero Length Packets (ZLP) */
+	if (!count)
+		return 0;
+
+	/* Make sure we have enough space for a whole package */
+	if (count > sizeof(struct ccidg_bulk_out_header)) {
+		DBG(ccidg->function.config->cdev,
+				"ccid: too much data. %i provided, but we can only handle %i\n",
+				count, sizeof(struct ccidg_bulk_out_header));
+		return -ENOMEM;
+	}
+
+	if (list_empty(&bulk_dev->tx_idle) &&
+			file->f_flags & (O_NONBLOCK | O_NDELAY))
+		return -EAGAIN;
+
+	/* get an idle tx request to use */
+	ret = wait_event_interruptible(bulk_dev->write_wq,
+		((req = ccidg_req_get(ccidg, &bulk_dev->tx_idle))));
+
+	if (ret < 0)
+		return -ERESTARTSYS;
+
+	if (copy_from_user(req->buf, buf, count)) {
+		if (!atomic_read(&ccidg->online)) {
+			ccidg_request_free(req, ccidg->in);
+			return -ENODEV;
+		} else {
+			ccidg_req_put(ccidg, &bulk_dev->tx_idle, req);
+			return -EFAULT;
+		}
+	}
+
+	req->length = count;
+	ret = usb_ep_queue(ccidg->in, req, GFP_KERNEL);
+	if (ret < 0) {
+		ccidg_req_put(ccidg, &bulk_dev->tx_idle, req);
+
+		if (!atomic_read(&ccidg->online)) {
+			/* Free up all requests if we are not online */
+			while ((req = ccidg_req_get(ccidg, &bulk_dev->tx_idle)))
+				ccidg_request_free(req, ccidg->in);
+
+			return -ENODEV;
+		}
+		return -EIO;
+	}
+
+	return count;
+}
+
+static __poll_t ccidg_bulk_poll(struct file *file, poll_table * wait)
+{
+	struct f_ccidg *ccidg =  file->private_data;
+	struct ccidg_bulk_dev *bulk_dev = &ccidg->bulk_dev;
+	__poll_t	ret = 0;
+
+	poll_wait(file, &bulk_dev->read_wq, wait);
+	poll_wait(file, &bulk_dev->write_wq, wait);
+
+	if (list_empty(&bulk_dev->tx_idle))
+		ret |= EPOLLOUT | EPOLLWRNORM;
+
+	if (atomic_read(&bulk_dev->rx_done))
+		ret |= EPOLLIN | EPOLLRDNORM;
+
+	return ret;
+}
+
+static const struct file_operations f_ccidg_fops = {
+	.owner = THIS_MODULE,
+	.read = ccidg_bulk_read,
+	.write = ccidg_bulk_write,
+	.open = ccidg_bulk_open,
+	.poll = ccidg_bulk_poll,
+	.release = ccidg_bulk_release,
+};
+
+static int ccidg_bulk_device_init(struct f_ccidg *dev)
+{
+	struct ccidg_bulk_dev *bulk_dev = &dev->bulk_dev;
+
+	init_waitqueue_head(&bulk_dev->read_wq);
+	init_waitqueue_head(&bulk_dev->write_wq);
+	INIT_LIST_HEAD(&bulk_dev->tx_idle);
+
+	return 0;
+}
+
+static void ccidg_function_free(struct usb_function *f)
+{
+	struct f_ccidg *ccidg;
+	struct f_ccidg_opts *opts;
+
+	ccidg = func_to_ccidg(f);
+	opts = container_of(f->fi, struct f_ccidg_opts, func_inst);
+
+	kfree(ccidg);
+	mutex_lock(&opts->lock);
+	--opts->refcnt;
+	mutex_unlock(&opts->lock);
+}
+
+static void ccidg_function_unbind(struct usb_configuration *c,
+					struct usb_function *f)
+{
+	struct f_ccidg *ccidg = func_to_ccidg(f);
+
+	device_destroy(ccidg_class, MKDEV(major, ccidg->minor));
+	cdev_del(&ccidg->cdev);
+
+	/* disable/free request and end point */
+	usb_free_all_descriptors(f);
+}
+
+static int ccidg_function_bind(struct usb_configuration *c,
+					struct usb_function *f)
+{
+	struct f_ccidg *ccidg = func_to_ccidg(f);
+	struct usb_ep *ep;
+	struct usb_composite_dev *cdev = c->cdev;
+	struct device *device;
+	dev_t dev;
+	int ifc_id;
+	int ret;
+
+	/* allocate instance-specific interface IDs, and patch descriptors */
+	ifc_id = usb_interface_id(c, f);
+	if (ifc_id < 0) {
+		ERROR(cdev, "ccid: unable to allocate ifc id, err:%d\n",
+				ifc_id);
+		return ifc_id;
+	}
+	ccid_interface_desc.bInterfaceNumber = ifc_id;
+
+	/* allocate instance-specific endpoints */
+	ep = usb_ep_autoconfig(cdev->gadget, &ccid_fs_in_desc);
+	if (!ep) {
+		ERROR(cdev, "ccid: usb epin autoconfig failed\n");
+		ret = -ENODEV;
+		goto ep_auto_in_fail;
+	}
+	ccidg->in = ep;
+	ep->driver_data = ccidg;
+
+	ep = usb_ep_autoconfig(cdev->gadget, &ccid_fs_out_desc);
+	if (!ep) {
+		ERROR(cdev, "ccid: usb epout autoconfig failed\n");
+		ret = -ENODEV;
+		goto ep_auto_out_fail;
+	}
+	ccidg->out = ep;
+	ep->driver_data = ccidg;
+
+	/* set descriptor dynamic values */
+	ccid_class_desc.dwFeatures	= cpu_to_le32(ccidg->features);
+	ccid_class_desc.bPINSupport	= ccidg->pinsupport;
+	ccid_class_desc.wLcdLayout	= cpu_to_le16(ccidg->lcdlayout);
+	ccid_class_desc.bMaxSlotIndex	= ccidg->nslots;
+	ccid_class_desc.dwProtocols	= cpu_to_le32(ccidg->protocols);
+
+	if (ccidg->protocols == CCID_PROTOCOL_NOT_SEL) {
+		ccidg->protocols = CCID_PROTOCOL_T0 | CCID_PROTOCOL_T1;
+		INFO(ccidg->function.config->cdev,
+			"ccid: No protocol selected. Support both T0 and T1.\n");
+	}
+
+
+	ccid_hs_in_desc.bEndpointAddress =
+			ccid_fs_in_desc.bEndpointAddress;
+	ccid_hs_out_desc.bEndpointAddress =
+			ccid_fs_out_desc.bEndpointAddress;
+
+	ret  = usb_assign_descriptors(f, ccid_fs_descs,
+			ccid_hs_descs, NULL, NULL);
+	if (ret)
+		goto ep_auto_out_fail;
+
+	/* create char device */
+	cdev_init(&ccidg->cdev, &f_ccidg_fops);
+	dev = MKDEV(major, ccidg->minor);
+	ret = cdev_add(&ccidg->cdev, dev, 1);
+	if (ret)
+		goto fail_free_descs;
+
+	device = device_create(ccidg_class, NULL, dev, NULL,
+			       "%s%d", "ccidg", ccidg->minor);
+	if (IS_ERR(device)) {
+		ret = PTR_ERR(device);
+		goto del;
+	}
+
+	return 0;
+
+del:
+	cdev_del(&ccidg->cdev);
+fail_free_descs:
+	usb_free_all_descriptors(f);
+ep_auto_out_fail:
+	ccidg->out->driver_data = NULL;
+	ccidg->out = NULL;
+ep_auto_in_fail:
+	ccidg->in->driver_data = NULL;
+	ccidg->in = NULL;
+	ERROR(f->config->cdev, "ccidg_bind FAILED\n");
+
+	return ret;
+}
+
+static struct usb_function *ccidg_alloc(struct usb_function_instance *fi)
+{
+	struct f_ccidg *ccidg;
+	struct f_ccidg_opts *opts;
+	int ret;
+
+	ccidg = kzalloc(sizeof(*ccidg), GFP_KERNEL);
+	if (!ccidg)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&ccidg->lock);
+
+	ret = ccidg_bulk_device_init(ccidg);
+	if (ret) {
+		kfree(ccidg);
+		return ERR_PTR(ret);
+	}
+
+	opts = container_of(fi, struct f_ccidg_opts, func_inst);
+
+	mutex_lock(&opts->lock);
+	++opts->refcnt;
+
+	ccidg->minor = opts->minor;
+	ccidg->features = opts->features;
+	ccidg->protocols = opts->protocols;
+	ccidg->pinsupport = opts->pinsupport;
+	ccidg->nslots = opts->nslots;
+	mutex_unlock(&opts->lock);
+
+	ccidg->function.name	= "ccid";
+	ccidg->function.bind	= ccidg_function_bind;
+	ccidg->function.unbind	= ccidg_function_unbind;
+	ccidg->function.set_alt	= ccidg_function_set_alt;
+	ccidg->function.disable	= ccidg_function_disable;
+	ccidg->function.setup	= ccidg_function_setup;
+	ccidg->function.free_func = ccidg_function_free;
+
+	return &ccidg->function;
+}
+
+static void ccidg_free_inst(struct usb_function_instance *f)
+{
+	struct f_ccidg_opts *opts;
+
+	opts = container_of(f, struct f_ccidg_opts, func_inst);
+	mutex_lock(&ccidg_ida_lock);
+
+	ccidg_put_minor(opts->minor);
+	if (ida_is_empty(&ccidg_ida))
+		ccidg_cleanup();
+
+	mutex_unlock(&ccidg_ida_lock);
+
+	kfree(opts);
+}
+
+static struct usb_function_instance *ccidg_alloc_inst(void)
+{
+	struct f_ccidg_opts *opts;
+	struct usb_function_instance *ret;
+	int status = 0;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&opts->lock);
+	opts->func_inst.free_func_inst = ccidg_free_inst;
+	ret = &opts->func_inst;
+
+	mutex_lock(&ccidg_ida_lock);
+
+	if (ida_is_empty(&ccidg_ida)) {
+		status = ccidg_setup();
+		if (status)  {
+			ret = ERR_PTR(status);
+			kfree(opts);
+			goto unlock;
+		}
+	}
+
+	opts->minor = ccidg_get_minor();
+	if (opts->minor < 0) {
+		ret = ERR_PTR(opts->minor);
+		kfree(opts);
+		if (ida_is_empty(&ccidg_ida))
+			ccidg_cleanup();
+		goto unlock;
+	}
+
+	config_group_init_type_name(&opts->func_inst.group,
+			"", &ccidg_func_type);
+
+unlock:
+	mutex_unlock(&ccidg_ida_lock);
+	return ret;
+}
+
+DECLARE_USB_FUNCTION_INIT(ccid, ccidg_alloc_inst, ccidg_alloc);
+
+MODULE_DESCRIPTION("USB CCID Gadget driver");
+MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/usb/gadget/function/f_ccid.h b/drivers/usb/gadget/function/f_ccid.h
new file mode 100644
index 000000000000..9dc182d1f819
--- /dev/null
+++ b/drivers/usb/gadget/function/f_ccid.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
+ */
+
+#ifndef F_CCID_H
+#define F_CCID_H
+
+#define CCID1_10                0x0110
+#define CCID_DECRIPTOR_TYPE     0x21
+#define ABDATA_SIZE		512
+#define SMART_CARD_DEVICE_CLASS	0x0B
+
+/* CCID Class Specific Request */
+#define CCIDGENERICREQ_ABORT                    0x01
+#define CCIDGENERICREQ_GET_CLOCK_FREQUENCIES    0x02
+#define CCIDGENERICREQ_GET_DATA_RATES           0x03
+
+/* Supported voltages */
+#define CCID_VOLTS_AUTO                             0x00
+#define CCID_VOLTS_5_0                              0x01
+#define CCID_VOLTS_3_0                              0x02
+#define CCID_VOLTS_1_8                              0x03
+
+struct f_ccidg_opts {
+	struct usb_function_instance func_inst;
+	int	minor;
+	__u32	features;
+	__u32	protocols;
+	__u8	pinsupport;
+	__u8	nslots;
+	__u8	lcdlayout;
+
+	/*
+	 * Protect the data form concurrent access by read/write
+	 * and create symlink/remove symlink.
+	 */
+	struct mutex	lock;
+	int		refcnt;
+};
+
+struct ccidg_bulk_in_header {
+	__u8	bMessageType;
+	__u32	wLength;
+	__u8	bSlot;
+	__u8	bSeq;
+	__u8	bStatus;
+	__u8	bError;
+	__u8	bSpecific;
+	__u8	abData[ABDATA_SIZE];
+	__u8	bSizeToSend;
+} __packed;
+
+struct ccidg_bulk_out_header {
+	__u8	 bMessageType;
+	__u32	 wLength;
+	__u8	 bSlot;
+	__u8	 bSeq;
+	__u8	 bSpecific_0;
+	__u8	 bSpecific_1;
+	__u8	 bSpecific_2;
+	__u8	 APDU[ABDATA_SIZE];
+} __packed;
+
+struct ccid_class_descriptor {
+	__u8	bLength;
+	__u8	bDescriptorType;
+	__u16	bcdCCID;
+	__u8	bMaxSlotIndex;
+	__u8	bVoltageSupport;
+	__u32	dwProtocols;
+	__u32	dwDefaultClock;
+	__u32	dwMaximumClock;
+	__u8	bNumClockSupported;
+	__u32	dwDataRate;
+	__u32	dwMaxDataRate;
+	__u8	bNumDataRatesSupported;
+	__u32	dwMaxIFSD;
+	__u32	dwSynchProtocols;
+	__u32	dwMechanical;
+	__u32	dwFeatures;
+	__u32	dwMaxCCIDMessageLength;
+	__u8	bClassGetResponse;
+	__u8	bClassEnvelope;
+	__u16	wLcdLayout;
+	__u8	bPINSupport;
+	__u8	bMaxCCIDBusySlots;
+} __packed;
+
+
+#endif
diff --git a/include/uapi/linux/usb/ccid.h b/include/uapi/linux/usb/ccid.h
new file mode 100644
index 000000000000..517897201563
--- /dev/null
+++ b/include/uapi/linux/usb/ccid.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
+ *
+ * This file holds USB constants defined by the CCID Specification.
+ */
+
+#ifndef CCID_H
+#define CCID_H
+
+/* Slot error register when bmCommandStatus = 1 */
+#define CCID_CMD_ABORTED                            0xFF
+#define CCID_ICC_MUTE                               0xFE
+#define CCID_XFR_PARITY_ERROR                       0xFD
+#define CCID_XFR_OVERRUN                            0xFC
+#define CCID_HW_ERROR                               0xFB
+#define CCID_BAD_ATR_TS                             0xF8
+#define CCID_BAD_ATR_TCK                            0xF7
+#define CCID_ICC_PROTOCOL_NOT_SUPPORTED             0xF6
+#define CCID_ICC_CLASS_NOT_SUPPORTED                0xF5
+#define CCID_PROCEDURE_BYTE_CONFLICT                0xF4
+#define CCID_DEACTIVATED_PROTOCOL                   0xF3
+#define CCID_BUSY_WITH_AUTO_SEQUENCE                0xF2
+#define CCID_PIN_TIMEOUT                            0xF0
+#define CCID_PIN_CANCELLED                          0xEF
+#define CCID_CMD_SLOT_BUSY                          0xE0
+
+/* PC to RDR messages (bulk out) */
+#define CCID_PC_TO_RDR_ICCPOWERON                   0x62
+#define CCID_PC_TO_RDR_ICCPOWEROFF                  0x63
+#define CCID_PC_TO_RDR_GETSLOTSTATUS                0x65
+#define CCID_PC_TO_RDR_XFRBLOCK                     0x6F
+#define CCID_PC_TO_RDR_GETPARAMETERS                0x6C
+#define CCID_PC_TO_RDR_RESETPARAMETERS              0x6D
+#define CCID_PC_TO_RDR_SETPARAMETERS                0x61
+#define CCID_PC_TO_RDR_ESCAPE                       0x6B
+#define CCID_PC_TO_RDR_ICCCLOCK                     0x6E
+#define CCID_PC_TO_RDR_T0APDU                       0x6A
+#define CCID_PC_TO_RDR_SECURE                       0x69
+#define CCID_PC_TO_RDR_MECHANICAL                   0x71
+#define CCID_PC_TO_RDR_ABORT                        0x72
+#define CCID_PC_TO_RDR_SETDATARATEANDCLOCKFREQUENCY 0x73
+
+/* RDR to PC messages (bulk in) */
+#define CCID_RDR_TO_PC_DATABLOCK                    0x80
+#define CCID_RDR_TO_PC_SLOTSTATUS                   0x81
+#define CCID_RDR_TO_PC_PARAMETERS                   0x82
+#define CCID_RDR_TO_PC_ESCAPE                       0x83
+#define CCID_RDR_TO_PC_DATARATEANDCLOCKFREQUENCY    0x84
+
+/* Class Features */
+
+/* No special characteristics */
+#define CCID_FEATURES_NADA       0x00000000
+/* Automatic parameter configuration based on ATR data */
+#define CCID_FEATURES_AUTO_PCONF 0x00000002
+/* Automatic activation of ICC on inserting */
+#define CCID_FEATURES_AUTO_ACTIV 0x00000004
+/* Automatic ICC voltage selection */
+#define CCID_FEATURES_AUTO_VOLT  0x00000008
+/* Automatic ICC clock frequency change */
+#define CCID_FEATURES_AUTO_CLOCK 0x00000010
+/* Automatic baud rate change */
+#define CCID_FEATURES_AUTO_BAUD  0x00000020
+/*Automatic parameters negotiation made by the CCID */
+#define CCID_FEATURES_AUTO_PNEGO 0x00000040
+/* Automatic PPS made by the CCID according to the active parameters */
+#define CCID_FEATURES_AUTO_PPS   0x00000080
+/* CCID can set ICC in clock stop mode */
+#define CCID_FEATURES_ICCSTOP    0x00000100
+/* NAD value other than 00 accepted (T=1 protocol in use) */
+#define CCID_FEATURES_NAD        0x00000200
+/* Automatic IFSD exchange as first exchange (T=1 protocol in use) */
+#define CCID_FEATURES_AUTO_IFSD  0x00000400
+/* TPDU level exchanges with CCID */
+#define CCID_FEATURES_EXC_TPDU   0x00010000
+/* Short APDU level exchange with CCID */
+#define CCID_FEATURES_EXC_SAPDU  0x00020000
+/* Short and Extended APDU level exchange with CCID */
+#define CCID_FEATURES_EXC_APDU   0x00040000
+/* USB Wake up signaling supported on card insertion and removal */
+#define CCID_FEATURES_WAKEUP	0x00100000
+
+/* Supported protocols */
+#define CCID_PROTOCOL_NOT_SEL	0x00
+#define CCID_PROTOCOL_T0	0x01
+#define CCID_PROTOCOL_T1	0x02
+
+#define CCID_PINSUPOORT_NONE		0x00
+#define CCID_PINSUPOORT_VERIFICATION	(1 << 1)
+#define CCID_PINSUPOORT_MODIFICATION	(1 << 2)
+
+#endif
-- 
2.16.2
