Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B78C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97650206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbeLOATi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:19:38 -0500
Received: from mail-yb1-f200.google.com ([209.85.219.200]:55095 "EHLO
        mail-yb1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeLOATg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:19:36 -0500
Received: by mail-yb1-f200.google.com with SMTP id a18so4019435ybg.21
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:19:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R9vVCtG1bOYqxhAtYHDrbbDLt+bVzk1eKRkkR9rMpyM=;
        b=YW+GR+DOR7l+Gqkzwg7jWxm5X64Kdq/Amuq8uSVhUDC5LkN4KsrqdvOU3qCmcVZiKz
         CahTqTxF6vyfa0Tee5S8DMw90LBRBMr2kvY+sV4D2KxyUvMvyRhThl5GfgxSTNIQjaPj
         RAeGk/+jIEMfKhM0scUjNJVPK8yVFXwPsBGNZkmy1K+8nIOeHx1GM5CagiPz4NF7TEdn
         uuBTmzT5tQ0KUCqtI9s/pU49CxNIzIORchNXnvkh3AZNShormKVRUl0pUclCtPKm1P4H
         zAro0QI6/HCt+5XJMadGJe9VA2/Cq8RjEA18Uati+cDZYJNJfcEWzyVSEEZs0VABjQzF
         DqLg==
X-Gm-Message-State: AA+aEWYg4dNz3hVvZpK0rigLjLaW2Qd2d47u1UdEphHUoitoYOq/Safq
        06pvQ0Tx6IiIa5XT24IuaLsbNw6FG968QShucYruq9ACk6o0PVwAEK8T9SuMYaUCEXgpdYS/WiK
        V2j6Lk6M7IOtVwJz4xqjAVkY4rhaIPigXKIuhrCcr7zyN+R2AQU0fPU5JFDDfauFUj4mxmECi1h
        0=
X-Google-Smtp-Source: AFSGD/UNI8hsp1nizfb8mMgO11g3Dvof3vWkyu35TxgncVr9dS3OfwPwjrgnrsZbQ8BBWAgfNlWQuvXthcQDfEl3
X-Received: by 2002:a25:8208:: with SMTP id q8mr2852593ybk.45.1544833175138;
 Fri, 14 Dec 2018 16:19:35 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:18:35 -0700
In-Reply-To: <20181215001843.62404-1-ncrews@google.com>
Message-Id: <20181215001843.62404-3-ncrews@google.com>
Mime-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [RFC PATCH 02/10] CHROMIUM: wilco_ec: Add new driver for Wilco EC
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Duncan Laurie <dlaurie@google.com>, Nick Crews <ncrews@google.com>,
        Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@google.com>

This EC is an incompatible variant of the typical Chrome OS embedded
controller.  It uses the same low-level communication and a similar
protocol with some significant differences.  The EC firmware does
not support the same mailbox commands so it is not registered as a
cros_ec device type.

Signed-off-by: Duncan Laurie <dlaurie@google.com>
Signed-off-by: Nick Crews <ncrews@google.com>
---

 drivers/platform/chrome/Kconfig            |  14 +-
 drivers/platform/chrome/Makefile           |   3 +
 drivers/platform/chrome/wilco_ec.h         |  97 +++++
 drivers/platform/chrome/wilco_ec_mailbox.c | 395 +++++++++++++++++++++
 4 files changed, 508 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/chrome/wilco_ec.h
 create mode 100644 drivers/platform/chrome/wilco_ec_mailbox.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 16b1615958aa..4168d5e6bedc 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -49,6 +49,18 @@ config CHROMEOS_TBMC
 	  To compile this driver as a module, choose M here: the
 	  module will be called chromeos_tbmc.
 
+config WILCO_EC
+	tristate "ChromeOS Wilco Embedded Controller"
+	depends on ACPI && (X86 || COMPILE_TEST)
+	select CROS_EC_LPC_MEC
+	help
+	  If you say Y here, you get support for talking to the Chrome OS
+	  Wilco EC over an eSPI bus. This uses a simple byte-level protocol
+	  with a checksum.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called wilco_ec.
+
 config CROS_EC_CTL
         tristate
 
@@ -86,7 +98,7 @@ config CROS_EC_LPC
 
 config CROS_EC_LPC_MEC
 	bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
-	depends on CROS_EC_LPC
+	depends on CROS_EC_LPC || WILCO_EC
 	default n
 	help
 	  If you say Y here, a variant LPC protocol for the Microchip EC
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index cd591bf872bb..b132ba5b3e3d 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -12,4 +12,7 @@ cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o
 cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
+
 obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
+wilco_ec-objs				:= wilco_ec_mailbox.o
+obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec.h b/drivers/platform/chrome/wilco_ec.h
new file mode 100644
index 000000000000..ba16fcff87c4
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * wilco_ec - Chrome OS Wilco Embedded Controller
+ *
+ * Copyright 2018 Google LLC
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef WILCO_EC_H
+#define WILCO_EC_H
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+
+#define WILCO_EC_FLAG_NO_RESPONSE	BIT(0) /* EC does not respond */
+#define WILCO_EC_FLAG_EXTENDED_DATA	BIT(1) /* EC returns 256 data bytes */
+#define WILCO_EC_FLAG_RAW_REQUEST	BIT(2) /* Do not trim request data */
+#define WILCO_EC_FLAG_RAW_RESPONSE	BIT(3) /* Do not trim response data */
+#define WILCO_EC_FLAG_RAW		(WILCO_EC_FLAG_RAW_REQUEST | \
+					 WILCO_EC_FLAG_RAW_RESPONSE)
+
+/**
+ * enum wilco_ec_msg_type - Message type to select a set of command codes.
+ * @WILCO_EC_MSG_LEGACY: Legacy EC messages for standard EC behavior.
+ * @WILCO_EC_MSG_PROPERTY: Get/Set/Sync EC controlled NVRAM property.
+ * @WILCO_EC_MSG_TELEMETRY: Telemetry data provided by the EC.
+ */
+enum wilco_ec_msg_type {
+	WILCO_EC_MSG_LEGACY = 0x00f0,
+	WILCO_EC_MSG_PROPERTY = 0x00f2,
+	WILCO_EC_MSG_TELEMETRY = 0x00f5,
+};
+
+/**
+ * struct wilco_ec_device - Wilco Embedded Controller handle.
+ * @dev: Device handle.
+ * @mailbox_lock: Mutex to ensure one mailbox command at a time.
+ * @io_command: I/O port for mailbox command.  Provided by ACPI.
+ * @io_data: I/O port for mailbox data.  Provided by ACPI.
+ * @io_packet: I/O port for mailbox packet data.  Provided by ACPI.
+ * @data_buffer: Buffer used for EC communication.  The same buffer
+ *               is used to hold the request and the response.
+ * @data_size: Size of the data buffer used for EC communication.
+ */
+struct wilco_ec_device {
+	struct device *dev;
+	struct mutex mailbox_lock;
+	struct resource *io_command;
+	struct resource *io_data;
+	struct resource *io_packet;
+	void *data_buffer;
+	size_t data_size;
+};
+
+/**
+ * struct wilco_ec_message - Request and response message.
+ * @type: Mailbox message type.
+ * @flags: Message flags.
+ * @command: Mailbox command code.
+ * @result: Result code from the EC.  Non-zero indicates an error.
+ * @request_size: Number of bytes to send to the EC.
+ * @request_data: Buffer containing the request data.
+ * @response_size: Number of bytes expected from the EC.
+ *                 This is 32 by default and 256 if the flag
+ *                 is set for %WILCO_EC_FLAG_EXTENDED_DATA
+ * @response_data: Buffer containing the response data, should be
+ *                 response_size bytes and allocated by caller.
+ */
+struct wilco_ec_message {
+	enum wilco_ec_msg_type type;
+	u8 flags;
+	u8 command;
+	u8 result;
+	size_t request_size;
+	void *request_data;
+	size_t response_size;
+	void *response_data;
+};
+
+/**
+ * wilco_ec_mailbox() - Send request to the EC and receive the response.
+ * @ec: Wilco EC device.
+ * @msg: Wilco EC message.
+ *
+ * Return: Number of bytes received or negative error code on failure.
+ */
+int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg);
+
+#endif /* WILCO_EC_H */
diff --git a/drivers/platform/chrome/wilco_ec_mailbox.c b/drivers/platform/chrome/wilco_ec_mailbox.c
new file mode 100644
index 000000000000..6613c18c2a82
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec_mailbox.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * wilco_ec_mailbox - Mailbox interface for Wilco Embedded Controller
+ *
+ * Copyright 2018 Google LLC
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/*
+ * The Wilco EC is similar to a typical Chrome OS embedded controller.
+ * It uses the same MEC based low-level communication and a similar
+ * protocol, but with some important differences.  The EC firmware does
+ * not support the same mailbox commands so it is not registered as a
+ * cros_ec device type.
+ *
+ * Most messages follow a standard format, but there are some exceptions
+ * and an interface is provided to do direct/raw transactions that do not
+ * make assumptions about byte placement.
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/mfd/cros_ec_lpc_mec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "wilco_ec.h"
+
+/* Version of mailbox interface */
+#define EC_MAILBOX_VERSION		0
+
+/* Command to start mailbox transaction */
+#define EC_MAILBOX_START_COMMAND	0xda
+
+/* Version of EC protocol */
+#define EC_MAILBOX_PROTO_VERSION	3
+
+/* Normal commands have a maximum 32 bytes of data */
+#define EC_MAILBOX_DATA_SIZE		32
+
+/* Extended commands have 256 bytes of response data */
+#define EC_MAILBOX_DATA_SIZE_EXTENDED	256
+
+/* Number of header bytes to be counted as data bytes */
+#define EC_MAILBOX_DATA_EXTRA		2
+
+/* Maximum timeout */
+#define EC_MAILBOX_TIMEOUT		HZ
+
+/* EC response flags */
+#define EC_CMDR_DATA		BIT(0)	/* Data ready for host to read */
+#define EC_CMDR_PENDING		BIT(1)	/* Write pending to EC */
+#define EC_CMDR_BUSY		BIT(2)	/* EC is busy processing a command */
+#define EC_CMDR_CMD		BIT(3)	/* Last host write was a command */
+
+/**
+ * struct wilco_ec_request - Mailbox request message format.
+ * @struct_version: Should be %EC_MAILBOX_PROTO_VERSION
+ * @checksum: Sum of all bytes must be 0.
+ * @mailbox_id: Mailbox identifier, specifies the command set.
+ * @mailbox_version: Mailbox interface version %EC_MAILBOX_VERSION
+ * @reserved: Set to zero.
+ * @data_size: Length of request, data + last 2 bytes of the header.
+ * @command: Mailbox command code, unique for each mailbox_id set.
+ * @reserved_raw: Set to zero for most commands, but is used by
+ *                some command types and for raw commands.
+ */
+struct wilco_ec_request {
+	u8 struct_version;
+	u8 checksum;
+	u16 mailbox_id;
+	u8 mailbox_version;
+	u8 reserved;
+	u16 data_size;
+	u8 command;
+	u8 reserved_raw;
+} __packed;
+
+/**
+ * struct wilco_ec_response - Mailbox response message format.
+ * @struct_version: Should be %EC_MAILBOX_PROTO_VERSION
+ * @checksum: Sum of all bytes must be 0.
+ * @result: Result code from the EC.  Non-zero indicates an error.
+ * @data_size: Length of the response data buffer.
+ * @reserved: Set to zero.
+ * @mbox0: EC returned data at offset 0 is unused (always 0) so this byte
+ *         is treated as part of the header instead of the data.
+ * @data: Response data buffer.  Max size is %EC_MAILBOX_DATA_SIZE_EXTENDED.
+ */
+struct wilco_ec_response {
+	u8 struct_version;
+	u8 checksum;
+	u16 result;
+	u16 data_size;
+	u8 reserved[2];
+	u8 mbox0;
+	u8 data[0];
+} __packed;
+
+/**
+ * wilco_ec_response_timed_out() - Wait for EC response.
+ * @ec: EC device.
+ *
+ * Return: true if EC timed out, false if EC did not time out.
+ */
+static bool wilco_ec_response_timed_out(struct wilco_ec_device *ec)
+{
+	unsigned long timeout = jiffies + EC_MAILBOX_TIMEOUT;
+
+	usleep_range(200, 300);
+	do {
+		if (!(inb(ec->io_command->start) &
+		      (EC_CMDR_PENDING | EC_CMDR_BUSY)))
+			return false;
+		usleep_range(100, 200);
+	} while (time_before(jiffies, timeout));
+
+	return true;
+}
+
+/**
+ * wilco_ec_checksum() - Compute 8bit checksum over data range.
+ * @data: Data to checksum.
+ * @size: Number of bytes to checksum.
+ *
+ * Return: 8bit checksum of provided data.
+ */
+static u8 wilco_ec_checksum(const void *data, size_t size)
+{
+	u8 *data_bytes = (u8 *)data;
+	u8 checksum = 0;
+	size_t i;
+
+	for (i = 0; i < size; i++)
+		checksum += data_bytes[i];
+
+	return checksum;
+}
+
+/**
+ * wilco_ec_prepare() - Prepare the request structure for the EC.
+ * @msg: EC message with request information.
+ * @rq: EC request structure to fill.
+ */
+static void wilco_ec_prepare(struct wilco_ec_message *msg,
+			     struct wilco_ec_request *rq)
+{
+	memset(rq, 0, sizeof(*rq));
+
+	/* Handle messages without trimming bytes from the request */
+	if (msg->request_size && msg->flags & WILCO_EC_FLAG_RAW_REQUEST) {
+		rq->reserved_raw = *(u8 *)msg->request_data;
+		msg->request_size--;
+		memmove(msg->request_data, msg->request_data + 1,
+			msg->request_size);
+	}
+
+	/* Fill in request packet */
+	rq->struct_version = EC_MAILBOX_PROTO_VERSION;
+	rq->mailbox_id = msg->type;
+	rq->mailbox_version = EC_MAILBOX_VERSION;
+	rq->data_size = msg->request_size + EC_MAILBOX_DATA_EXTRA;
+	rq->command = msg->command;
+
+	/* Checksum header and data */
+	rq->checksum = wilco_ec_checksum(rq, sizeof(*rq));
+	rq->checksum += wilco_ec_checksum(msg->request_data, msg->request_size);
+	rq->checksum = -rq->checksum;
+}
+
+/**
+ * wilco_ec_transfer() - Send EC request and receive EC response.
+ * @ec: EC device.
+ * @msg: EC message data for request and response.
+ *
+ * Return: 0 for success or negative error code on failure.
+ */
+static int wilco_ec_transfer(struct wilco_ec_device *ec,
+			     struct wilco_ec_message *msg)
+{
+	struct wilco_ec_request *rq;
+	struct wilco_ec_response *rs;
+	u8 checksum;
+	size_t size;
+
+	/* Prepare request packet */
+	rq = ec->data_buffer;
+	wilco_ec_prepare(msg, rq);
+
+	/* Write request header */
+	cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, 0, sizeof(*rq), (u8 *)rq);
+
+	/* Write request data */
+	cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, sizeof(*rq), msg->request_size,
+				 msg->request_data);
+
+	/* Start the command */
+	outb(EC_MAILBOX_START_COMMAND, ec->io_command->start);
+
+	/* Wait for it to complete */
+	if (wilco_ec_response_timed_out(ec)) {
+		dev_err(ec->dev, "response timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	/* Some commands will put the EC into a state where it cannot respond */
+	if (msg->flags & WILCO_EC_FLAG_NO_RESPONSE) {
+		dev_dbg(ec->dev, "EC does not respond to this command\n");
+		return 0;
+	}
+
+	/* Check result */
+	msg->result = inb(ec->io_data->start);
+	if (msg->result) {
+		dev_err(ec->dev, "bad response: 0x%02x\n", msg->result);
+		return -EIO;
+	}
+
+	if (msg->flags & WILCO_EC_FLAG_EXTENDED_DATA) {
+		/* Extended commands return 256 bytes of data */
+		size = EC_MAILBOX_DATA_SIZE_EXTENDED;
+	} else {
+		/* Otherwise EC commands return 32 bytes of data */
+		size = EC_MAILBOX_DATA_SIZE;
+	}
+
+	/* Read back response */
+	rs = ec->data_buffer;
+	checksum = cros_ec_lpc_io_bytes_mec(MEC_IO_READ, 0,
+					    sizeof(*rs) + size, (u8 *)rs);
+	if (checksum) {
+		dev_err(ec->dev, "bad packet checksum 0x%02x\n", rs->checksum);
+		return -EBADMSG;
+	}
+	msg->result = rs->result;
+
+	/* Check the returned data size, skipping the header */
+	if (rs->data_size != size) {
+		dev_err(ec->dev, "unexpected packet size (%u != %zu)",
+			rs->data_size, size);
+		return -EMSGSIZE;
+	}
+
+	/* Skip 1 response data byte unless specified */
+	size = (msg->flags & WILCO_EC_FLAG_RAW_RESPONSE) ? 0 : 1;
+
+	if (msg->response_size > rs->data_size - size) {
+		dev_err(ec->dev, "response data too short (%u > %zu)",
+			rs->data_size - size, msg->response_size);
+		return -EMSGSIZE;
+	}
+
+	/* Ignore response data bytes as requested */
+	memcpy(msg->response_data, rs->data + size, msg->response_size);
+
+	/* Return actual amount of data received */
+	return msg->response_size;
+}
+
+int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg)
+{
+	size_t size = EC_MAILBOX_DATA_SIZE;
+	int ret;
+
+	dev_dbg(ec->dev, "cmd=%02x type=%04x flags=%02x rslen=%d rqlen=%d\n",
+		msg->command, msg->type, msg->flags, msg->response_size,
+		msg->request_size);
+
+	if (msg->request_size > size) {
+		dev_err(ec->dev, "provided request too large: %zu > %zu\n",
+			msg->request_size, size);
+		return -EINVAL;
+	}
+
+	/* Check for extended size on response data if flag is set */
+	if (msg->flags & WILCO_EC_FLAG_EXTENDED_DATA)
+		size = EC_MAILBOX_DATA_SIZE_EXTENDED;
+
+	if (msg->response_size > size) {
+		dev_err(ec->dev, "expected response too large: %zu > %zu\n",
+			msg->response_size, size);
+		return -EINVAL;
+	}
+	if (msg->request_size && !msg->request_data) {
+		dev_err(ec->dev, "request data missing\n");
+		return -EINVAL;
+	}
+	if (msg->response_size && !msg->response_data) {
+		dev_err(ec->dev, "response data missing\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&ec->mailbox_lock);
+
+	ret = wilco_ec_transfer(ec, msg);
+	if (ret >= 0 && msg->result)
+		ret = -EBADMSG;
+
+	mutex_unlock(&ec->mailbox_lock);
+
+	return ret;
+}
+
+static struct resource *wilco_get_resource(struct platform_device *pdev,
+					   int index)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, index);
+	if (!res) {
+		dev_err(dev, "couldn't find IO resource %d\n", index);
+		return NULL;
+	}
+
+	if (!devm_request_region(dev, res->start, resource_size(res),
+				 dev_name(dev))) {
+		dev_err(dev, "couldn't reserve IO region %d\n", index);
+		return NULL;
+	}
+
+	return res;
+}
+
+static int wilco_ec_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct wilco_ec_device *ec;
+
+	ec = devm_kzalloc(dev, sizeof(*ec), GFP_KERNEL);
+	if (!ec)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, ec);
+	ec->dev = dev;
+	mutex_init(&ec->mailbox_lock);
+
+	/* Largest data buffer size requirement is extended data response */
+	ec->data_size = sizeof(struct wilco_ec_response) +
+		EC_MAILBOX_DATA_SIZE_EXTENDED;
+	ec->data_buffer = devm_kzalloc(dev, ec->data_size, GFP_KERNEL);
+	if (!ec->data_buffer)
+		return -ENOMEM;
+
+	/* Prepare access to IO regions provided by ACPI */
+	ec->io_data = wilco_get_resource(pdev, 0);	/* Host Data */
+	ec->io_command = wilco_get_resource(pdev, 1);	/* Host Command */
+	ec->io_packet = wilco_get_resource(pdev, 2);	/* MEC EMI */
+	if (!ec->io_data || !ec->io_command || !ec->io_packet)
+		return -ENODEV;
+
+	/* Initialize cros_ec register interface for communication */
+	cros_ec_lpc_mec_init(ec->io_packet->start,
+			     ec->io_packet->start + EC_MAILBOX_DATA_SIZE);
+
+	return 0;
+}
+
+static int wilco_ec_remove(struct platform_device *pdev)
+{
+	/* Teardown cros_ec interface */
+	cros_ec_lpc_mec_destroy();
+
+	return 0;
+}
+
+static const struct acpi_device_id wilco_ec_acpi_device_ids[] = {
+	{ "GOOG000C", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, wilco_ec_acpi_device_ids);
+
+static struct platform_driver wilco_ec_driver = {
+	.driver = {
+		.name = "wilco_ec",
+		.acpi_match_table = wilco_ec_acpi_device_ids,
+	},
+	.probe = wilco_ec_probe,
+	.remove = wilco_ec_remove,
+};
+
+module_platform_driver(wilco_ec_driver);
+
+MODULE_AUTHOR("Duncan Laurie <dlaurie@chromium.org>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Chrome OS Wilco Embedded Controller driver");
+MODULE_ALIAS("platform:wilco-ec");
-- 
2.20.0.405.gbc1bbc6f85-goog

