Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424A9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34FF205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfANWFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:05:13 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:35544 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfANWEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:04:44 -0500
Received: by mail-io1-f70.google.com with SMTP id x12so466638ioj.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/dFectUEGTzRisaFpNKI9P3LVpb5KWI9ycbf3pVCEP4=;
        b=cijAgwH98BWboiucI5XBIeVExHwetXvqbfK+BzDvuCyT//JpjNzhYC2q0IYyV/kNf/
         bevAeJVUccxSS4/eKKBM5w9cd5Dm/e9/p/phA3S8XZ5X6DWsiRS55rLisRJ7XSrityF3
         47k678xMsjhxcOVwdiETS0lgTGJRO6+xBVOaxquNIWJ7f5DRbdKYKFZCbTquI6mkXWSs
         2UBuf3XxSGMbapwxy91nO7aSLSSFLb6eEhGyAsNId6rmkS3sCivkJ6GNShmxtSlkrlLi
         iQAb1WPn9UJvDBBXTOMO4M4xhZArti7S9gvgLd3e9oWucdu27+Hu0OLhArhP3ZjwFwxQ
         Mhdw==
X-Gm-Message-State: AJcUukeVGbRhVvYp19v/Kh3WKQKXdWj3VD42g4lr/9gUpKq9rPUEa4OB
        a6Jw/CM6YMwG2nkZV5NqtvtNkjfSpWS0xMVpz0Ya0hLu+TCBwcVdddKwIkPPi8DRDH1IjL+V4vO
        UTo9ZNIvzOIqCUdFc4wq4zMKjsiUqgyYXezycnh+QP9XVPC8RVSwkbpktR8//MxWY6bdbgaTmTe
        U=
X-Google-Smtp-Source: ALg8bN4cAYwUCu503I4essgL4UFNwOBVMHN9niPx7joL0VEt9xc19zkTPH8fFTA44RJ7SrZHfES77G+Uwt4+dK2X
X-Received: by 2002:a24:1d01:: with SMTP id 1mr741489itj.39.1547503483260;
 Mon, 14 Jan 2019 14:04:43 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:03:54 -0700
In-Reply-To: <20190114220356.108916-1-ncrews@google.com>
Message-Id: <20190114220356.108916-8-ncrews@google.com>
Mime-Version: 1.0
References: <20190114220356.108916-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v2 7/9] platform/chrome: Add EC properties
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, dlaurie@chromium.org,
        Nick Crews <ncrews@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A Property is typically a data item that is stored to NVRAM.
Each of these data items has an index associated with it
known as the Property ID (PID). The Property ID is
used by the system BIOS (and EC) to refer to the Property.
Properties may have variable lengths. Many features are
implemented primarily by EC Firmware with system BIOS
just supporting user configuration via BIOS SETUP and/or
SMBIOS changes. In order to implement many of these types of
features the user configuration information is saved to and
retrieved from the EC. The EC stores this configuration
information to NVRAM and then can use it while the system
BIOS is not running or during early boot. Although this
is a typical scenario there may be other reasons to store
information in the EC NVRAM instead of the System NVRAM.
Most of the property services do not have a valid failure
condition, so this field can be ignored. For items that
are write once, a failure is returned when a second
write is attempted.

Add a get and set interface for EC properties.
properties live within the "properties" directory.
Most of the added properties are boolean, but this also
provides the interface for non-boolean properties,
which will be used late for scheduling power routines.

The wilco_ec_sysfs_util.h stuff will be used for
future attributes as well.

> cd /sys/bus/platform/devices/GOOG000C\:00/
> echo 0 > properties/global_mic_mute_led
[mic mute led on keyboard turns off]
> cat
0
> echo 1 > properties/global_mic_mute_led
[mic mute led on keyboard turns on]
> cat properties/global_mic_mute_led
1
> cat properties/wireless_sw_wlan
cat: wireless_sw_wlan: Permission denied
[Good, that is supposed to be write-only]
> echo 0 > properties/wireless_sw_wlan

Signed-off-by: Nick Crews <ncrews@google.com>
---

Changes in v2:
- rm license boiler plate
- rm "wilco_ec_properties -" prefix from docstring
- Add documentation

 .../ABI/testing/sysfs-platform-wilcoec        |  48 +++
 drivers/platform/chrome/wilco_ec/Makefile     |   2 +-
 drivers/platform/chrome/wilco_ec/properties.c | 344 ++++++++++++++++++
 drivers/platform/chrome/wilco_ec/properties.h | 179 +++++++++
 drivers/platform/chrome/wilco_ec/sysfs.c      |  55 ++-
 drivers/platform/chrome/wilco_ec/util.h       |  38 ++
 6 files changed, 664 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.c
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.h
 create mode 100644 drivers/platform/chrome/wilco_ec/util.h

diff --git a/Documentation/ABI/testing/sysfs-platform-wilcoec b/Documentation/ABI/testing/sysfs-platform-wilcoec
index cac2cf11835f..b09e2473f948 100644
--- a/Documentation/ABI/testing/sysfs-platform-wilcoec
+++ b/Documentation/ABI/testing/sysfs-platform-wilcoec
@@ -45,3 +45,51 @@ Description:
 		// included after the raw hex.
 		$ cat raw
 		00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  .12/21/18.8...
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/properties/global_mic_mute_led
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Read/write the microphone mute led on the keyboard on and off.
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/properties/fn_lock
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Fn Toggle - main feature enable/disable setting.
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/properties/nic
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Enable NIC (network interface card) on the dock.
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/properties/ext_usb_port_en
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		External USB port enable.
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/wireless_sw_wlan
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Wireless switch - WLAN.
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/properties/auto_boot_on_trinity_dock_attach
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Enable wake when dock is attached to the system.
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/properties/ich_azalia_en
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Enable Audio in the Dock.
+
+What:		/sys/bus/platform/devices/GOOG000C\:00/properties/sign_of_life_kbbl
+Date:		January 2019
+KernelVersion:	4.19
+Description:
+		Enable early Keyboard BackLight at boot.
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 57ef68ac1dd7..9c9e67171652 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 wilco_ec-objs				:= core.o mailbox.o sysfs.o legacy.o \
-					   event.o
+					   event.o properties.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec/properties.c b/drivers/platform/chrome/wilco_ec/properties.c
new file mode 100644
index 000000000000..e9d096c7d632
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/properties.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Add ability to set/get properties of Wilco Embedded Controller
+ *
+ * Copyright 2018 Google LLC
+ *
+ * A Property is typically a data item that is stored to NVRAM.
+ * Each of these data items has an index associated with it
+ * known as the Property ID (PID). The Property ID is
+ * used by the system BIOS (and EC) to refer to the Property.
+ * Properties may have variable lengths. Many features are
+ * implemented primarily by EC Firmware with system BIOS
+ * just supporting user configuration via BIOS SETUP and/or
+ * SMBIOS changes. In order to implement many of these types of
+ * features the user configuration information is saved to and
+ * retrieved from the EC. The EC stores this configuration
+ * information to NVRAM and then can use it while the system
+ * BIOS is not running or during early boot. Although this
+ * is a typical scenario there may be other reasons to store
+ * information in the EC NVRAM instead of the System NVRAM.
+ * Most of the property services do not have a valid failure
+ * condition, so this field can be ignored. For items that
+ * are write once, a failure is returned when a second
+ * write is attempted.
+ *
+ * Add a get and set interface for EC properties.
+ * properties live within the "properties" directory.
+ * Most of the added properties are boolean, but this also
+ * provides the interface for non-boolean properties,
+ * which will be used late for scheduling power routines.
+ */
+
+#include <linux/device.h>
+#include <linux/platform_data/wilco-ec.h>
+
+#include "properties.h"
+#include "util.h"
+
+/* Payload length for get/set properties */
+#define PROPERTY_DATA_MAX_LENGTH 4
+
+struct ec_property_get_request {
+	u32 property_id;
+	u8 length;
+} __packed;
+
+struct ec_property_set_request {
+	u32 property_id;
+	u8 length;
+	u8 data[PROPERTY_DATA_MAX_LENGTH];
+} __packed;
+
+struct ec_property_response {
+	u8 status;
+	u8 sub_function;
+	u32 property_id;
+	u8 length;
+	u8 data[PROPERTY_DATA_MAX_LENGTH];
+} __packed;
+
+/* Store a 32 bit property ID into an array or a field in a struct, LSB first */
+static inline void fill_property_id(u32 property_id, u8 field[])
+{
+	field[0] =  property_id        & 0xff;
+	field[1] = (property_id >> 8)  & 0xff;
+	field[2] = (property_id >> 16) & 0xff;
+	field[3] = (property_id >> 24) & 0xff;
+}
+
+/* Extract 32 bit property ID from an array or a field in a struct, LSB first */
+static inline u32 extract_property_id(u8 field[])
+{
+	return (uint32_t)field[0]	|
+	       (uint32_t)field[1] << 8  |
+	       (uint32_t)field[2] << 16 |
+	       (uint32_t)field[3] << 24;
+}
+
+/**
+ * check_property_response() - Verify that the response from the EC is valid.
+ * @ec: EC device
+ * @rs: bytes sent back from the EC, filled into struct
+ * @op: Which of [SET, GET, SYNC] we are responding to
+ * @expected_property_id: Property ID that we were trying to read
+ * @expected_length: Number of bytes of actual payload we expected
+ * @expected_data: What we expect the EC to echo back for a SET. For GETting
+ *		   or SYNCing, we don't know the response, so use NULL to ignore
+ *
+ * Return: 0 on success, -EBADMSG on failure.
+ */
+static int check_property_response(struct wilco_ec_device *ec,
+				   struct ec_property_response *rs,
+				   enum get_set_sync_op op,
+				   u32 expected_property_id, u8 expected_length,
+				   const u8 expected_data[])
+{
+	u32 received_property_id;
+	int i;
+
+	/* check for success/failure flag */
+	if (rs->status) {
+		dev_err(ec->dev, "EC reports failure to get property");
+		return -EBADMSG;
+	}
+
+	/* Which subcommand is the EC responding to? */
+	if (rs->sub_function != op) {
+		dev_err(ec->dev, "For SET/GET/SYNC, EC replied %d, expected %d",
+			rs->sub_function, op);
+		return -EBADMSG;
+	}
+
+	/* Check that returned property_id is what we expect */
+	received_property_id = extract_property_id((u8 *)&rs->property_id);
+	if (received_property_id != expected_property_id) {
+		dev_err(ec->dev,
+			"EC responded to property_id 0x%08x, expected 0x%08x",
+			received_property_id, expected_property_id);
+		return -EBADMSG;
+	}
+
+	/* Did we get the correct number of bytes as a payload? */
+	if (rs->length != expected_length) {
+		dev_err(ec->dev, "EC returned %d bytes when we expected %d",
+			rs->length, expected_length);
+		return -EBADMSG;
+	}
+
+	/* Check that the actual data returned was what we expected */
+	if (expected_length < 1 || !expected_data)
+		return 0;
+	for (i = 0; i < expected_length; i++) {
+		if (rs->data[i] != expected_data[i]) {
+			dev_err(ec->dev, "returned[%d]=%2x != expected[%d]=%2x",
+				i, rs->data[i], i, expected_data[i]);
+			return -EBADMSG;
+		}
+	}
+
+	return 0;
+}
+
+static inline int check_get_property_response(struct wilco_ec_device *ec,
+					      struct ec_property_response *rs,
+					      u32 expected_property_id,
+					      u8 expected_length)
+{
+	return check_property_response(ec, rs, OP_GET, expected_property_id,
+				       expected_length, NULL);
+}
+
+static inline int check_set_property_response(struct wilco_ec_device *ec,
+					      struct ec_property_response *rs,
+					      enum get_set_sync_op op,
+					      u32 expected_property_id,
+					      u8 expected_length,
+					      const u8 expected_data[])
+{
+	return check_property_response(ec, rs, op, expected_property_id,
+				       expected_length, expected_data);
+}
+
+ssize_t wilco_ec_get_property(struct wilco_ec_device *ec, u32 property_id,
+			      u8 result_length, u8 *result)
+{
+	int ret, response_valid;
+	struct ec_property_get_request rq;
+	struct ec_property_response rs;
+	struct wilco_ec_message msg = {
+		.type = WILCO_EC_MSG_PROPERTY,
+		.flags = WILCO_EC_FLAG_RAW,
+		.command = OP_GET,
+		.request_data = &rq,
+		.request_size = sizeof(rq),
+		.response_data = &rs,
+		.response_size = sizeof(rs),
+	};
+
+	/* Create the request struct */
+	if (result_length < 1) {
+		dev_err(ec->dev,
+			"Requested %d bytes when getting property, min is 0\n",
+			result_length);
+		return -EINVAL;
+	}
+	if (result_length > PROPERTY_DATA_MAX_LENGTH) {
+		dev_err(ec->dev,
+			"Requested %d bytes when getting property, max is %d\n",
+			result_length, PROPERTY_DATA_MAX_LENGTH);
+		return -EINVAL;
+	}
+	fill_property_id(property_id, (u8 *)&(rq.property_id));
+	rq.length = 0;
+
+	/* send and receive */
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0) {
+		dev_err(ec->dev, "Get Property 0x%08x command failed\n",
+			property_id);
+		return ret;
+	}
+
+	/* verify that the response was valid */
+	response_valid = check_get_property_response(ec, &rs, property_id,
+						     result_length);
+	if (response_valid < 0)
+		return response_valid;
+
+	memcpy(result, &rs.data, result_length);
+	return ret;
+}
+
+ssize_t wilco_ec_set_property(struct wilco_ec_device *ec,
+			      enum get_set_sync_op op, u32 property_id,
+			      u8 length, const u8 *data)
+{
+	int ret;
+	struct ec_property_set_request rq;
+	struct ec_property_response rs;
+	u8 request_length = sizeof(rq) - PROPERTY_DATA_MAX_LENGTH + length;
+	struct wilco_ec_message msg = {
+		.type = WILCO_EC_MSG_PROPERTY,
+		.flags = WILCO_EC_FLAG_RAW,
+		.command = op,
+		.request_data = &rq,
+		.request_size = request_length,
+		.response_data = &rs,
+		.response_size = sizeof(rs),
+	};
+
+	/* make request */
+	if (op != OP_SET && op != OP_SYNC) {
+		dev_err(ec->dev, "Set op must be OP_SET | OP_SYNC, got %d", op);
+		return -EINVAL;
+	}
+	if (length < 1) {
+		dev_err(ec->dev,
+			"Sending %d bytes when setting property, min is 1",
+			length);
+		return -EINVAL;
+	}
+	if (length > PROPERTY_DATA_MAX_LENGTH) {
+		dev_err(ec->dev,
+			"Sending %d bytes when setting property, max is %d",
+			length, PROPERTY_DATA_MAX_LENGTH);
+		return -EINVAL;
+	}
+	fill_property_id(property_id, (u8 *)&(rq.property_id));
+	rq.length = length;
+	memcpy(rq.data, data, length);
+
+	/* send and receive */
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0) {
+		dev_err(ec->dev, "Set Property 0x%08x command failed\n",
+			property_id);
+		return ret;
+	}
+
+	/* verify that the response was valid, EC echoing back stored value */
+	ret = check_set_property_response(ec, &rs, op, property_id,
+						     length, data);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+ssize_t wilco_ec_get_bool_prop(struct device *dev, u32 property_id,
+			       char *result)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	int ret;
+
+	ret = wilco_ec_get_property(ec, property_id, 1, result);
+	if (ret < 0)
+		return ret;
+
+	/* convert the raw byte response into ascii */
+	switch (result[0]) {
+	case 0:
+		result[0] = '0';
+		break;
+	case 1:
+		result[0] = '1';
+		break;
+	default:
+		dev_err(ec->dev, "Expected 0 or 1 as response, got %02x",
+			result[0]);
+		return -EBADMSG;
+	}
+
+	/* Tack on a newline */
+	result[1] = '\n';
+	return 2;
+}
+
+ssize_t wilco_ec_set_bool_prop(struct device *dev, enum get_set_sync_op op,
+			       u32 property_id, const char *buf, size_t count)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	bool enable;
+	u8 param;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret) {
+		dev_err(dev, "Unable to parse '%s' to a bool", buf);
+		return ret;
+	}
+	param = enable;
+
+	ret = wilco_ec_set_property(ec, op, property_id, 1, &param);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+ssize_t wilco_ec_bool_prop_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	struct property_attribute *prop_attr;
+	struct device *dev;
+
+	prop_attr = container_of(attr, struct property_attribute, kobj_attr);
+	dev = device_from_kobject(kobj);
+
+	return wilco_ec_get_bool_prop(dev, prop_attr->pid, buf);
+}
+
+ssize_t wilco_ec_bool_prop_store(struct kobject *kobj,
+				 struct kobj_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct property_attribute *prop_attr;
+	struct device *dev;
+
+	prop_attr = container_of(attr, struct property_attribute, kobj_attr);
+	dev = device_from_kobject(kobj);
+
+	return wilco_ec_set_bool_prop(dev, prop_attr->op, prop_attr->pid, buf,
+				      count);
+}
diff --git a/drivers/platform/chrome/wilco_ec/properties.h b/drivers/platform/chrome/wilco_ec/properties.h
new file mode 100644
index 000000000000..b95dbaf624f6
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/properties.h
@@ -0,0 +1,179 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Add ability to set/get properties of Wilco Embedded Controller
+ *
+ * Copyright 2018 Google LLC
+ *
+ * A Property is typically a data item that is stored to NVRAM.
+ * Each of these data items has an index associated with it
+ * known as the Property ID (PID). The Property ID is
+ * used by the system BIOS (and EC) to refer to the Property.
+ * Properties may have variable lengths. Many features are
+ * implemented primarily by EC Firmware with system BIOS
+ * just supporting user configuration via BIOS SETUP and/or
+ * SMBIOS changes. In order to implement many of these types of
+ * features the user configuration information is saved to and
+ * retrieved from the EC. The EC stores this configuration
+ * information to NVRAM and then can use it while the system
+ * BIOS is not running or during early boot. Although this
+ * is a typical scenario there may be other reasons to store
+ * information in the EC NVRAM instead of the System NVRAM.
+ * Most of the property services do not have a valid failure
+ * condition, so this field can be ignored. For items that
+ * are write once, a failure is returned when a second
+ * write is attempted.
+ *
+ * Add a get and set interface for EC properties.
+ * properties live within the "properties" directory.
+ * Most of the added properties are boolean, but this also
+ * provides the interface for non-boolean properties,
+ * which will be used late for scheduling power routines.
+ */
+
+#ifndef WILCO_EC_PROPERTIES_H
+#define WILCO_EC_PROPERTIES_H
+
+#include <linux/ctype.h>
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/sysfs.h>
+
+#define PID_GLOBAL_MIC_MUTE_LED			0x0676
+#define PID_FN_LOCK				0x067b
+#define PID_NIC					0x04ea
+#define PID_EXT_USB_PORT_EN			0x0612
+#define PID_WIRELESS_SW_WLAN			0x0620
+#define PID_AUTO_BOOT_ON_TRINITY_DOCK_ATTACH	0x0725
+#define PID_ICH_AZALIA_EN			0x0a07
+#define PID_SIGN_OF_LIFE_KBBL			0x058f
+
+/**
+ * enum get_set_sync_op - three different subcommands for WILCO_EC_MSG_PROPERTY.
+ *
+ * OP_GET requests the property from the EC. OP_SET and OP_SYNC do the exact
+ * same thing from our perspective: save a property. Only one of them works for
+ * a given property, so each property uses either OP_GET and OP_SET, or
+ * OP_GET and OP_SYNC
+ */
+enum get_set_sync_op {
+	OP_GET = 0,
+	OP_SET = 1,
+	OP_SYNC = 4
+};
+
+/**
+ * struct property_attribute - A attribute representing an EC property
+ * @kobj_attr: The underlying kobj_attr that is registered with sysfs
+ * @pid: Property ID of this property
+ * @op: Either OP_SET or OP_SYNC, whichever this property uses
+ */
+struct property_attribute {
+	struct kobj_attribute kobj_attr;
+	u32 pid;
+	enum get_set_sync_op op;
+};
+
+/**
+ * wilco_ec_get_property() - Query a property from the EC
+ * @ec: EC device to query
+ * @property_id: Property ID
+ * @result_length: Number of bytes expected in result
+ * @result: Destination buffer for result, needs to be able to hold at least
+ *	    @result_length bytes
+ *
+ * Return: Number of bytes received from EC (AKA @result_length),
+ *	   negative error code on failure.
+ */
+ssize_t wilco_ec_get_property(struct wilco_ec_device *ec, u32 property_id,
+			      u8 result_length, u8 *result);
+
+/**
+ * wilco_ec_set_property() - Set a property on EC
+ * @ec: EC device to use
+ * @op: either OP_SET or OP_SYNC
+ * @property_id: Property ID
+ * @length: Number of bytes in input buffer @data
+ * @data: Input buffer
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+ssize_t wilco_ec_set_property(struct wilco_ec_device *ec,
+			      enum get_set_sync_op op, u32 property_id,
+			      u8 length, const u8 *data);
+
+/**
+ * wilco_ec_get_bool_prop() - Get a boolean property from EC.
+ * @dev: EC device to use
+ * @property_id: Property ID
+ * @result: Destination buffer to be filled, needs to be able to hold at least
+ *	    two bytes. Will be filled with either "0\n" or "1\n" in ASCII
+ *
+ * Return: Number of bytes copied into result (AKA 2),
+ *	   or negative error code on failure.
+ */
+ssize_t wilco_ec_get_bool_prop(struct device *dev, u32 property_id,
+			       char *result);
+
+/**
+ * wilco_ec_set_bool_prop() - Set a boolean property on EC
+ * @dev: EC device to use
+ * @op: either OP_SET or OP_SYNC
+ * @property_id: Property ID
+ * @buf: Source buffer of ASCII string, parseable by kstrtobool()
+ * @count: Number of bytes in input buffer
+ *
+ * Return: Number of bytes consumed from input buffer (AKA @count),
+ *         or negative error code on failure.
+ */
+ssize_t wilco_ec_set_bool_prop(struct device *dev, enum get_set_sync_op op,
+			       u32 property_id, const char *buf, size_t count);
+
+/**
+ * wilco_ec_bool_prop_show() - Get a boolean property from the EC
+ * @kobj: Kobject representing the directory this attribute lives within
+ * @attr: Attribute stored within relevant "struct property_attribute"
+ * @buf: Destination buffer to be filled, needs to be able to hold at least
+ *	 two bytes. Will be filled with either "0\n" or "1\n" in ASCII
+ *
+ * Return: Number of bytes placed into output buffer (AKA 2),
+ *	   or negative error code on failure.
+ */
+ssize_t wilco_ec_bool_prop_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf);
+
+/**
+ * wilco_ec_bool_prop_store() - Store a boolean property on the EC
+ * @kobj: Kobject representing the directory this attribute lives within
+ * @attr: Attribute stored within relevant "struct property_attribute"
+ * @buf: Source buffer of ASCII string, parseable by kstrtobool()
+ * @count: Number of bytes in input buffer
+ *
+ * Return: Number bytes consumed from input buf (AKA @count),
+ *	   or negative error code on failure.
+ */
+ssize_t wilco_ec_bool_prop_store(struct kobject *kobj,
+				 struct kobj_attribute *attr, const char *buf,
+				 size_t count);
+
+#define BOOL_PROP_KOBJ_ATTR_RW(_name)					\
+__ATTR(_name, 0644, wilco_ec_bool_prop_show, wilco_ec_bool_prop_store)
+
+#define BOOL_PROP_KOBJ_ATTR_WO(_name)					\
+__ATTR(_name, 0200, NULL, wilco_ec_bool_prop_store)
+
+#define BOOLEAN_PROPERTY_RW_ATTRIBUTE(_op, _var, _name, _pid)	\
+struct property_attribute _var = {					\
+	.kobj_attr = BOOL_PROP_KOBJ_ATTR_RW(_name),			\
+	.pid = _pid,							\
+	.op = _op,							\
+}
+
+#define BOOLEAN_PROPERTY_WO_ATTRIBUTE(_op, _var, _name, _pid)	\
+struct property_attribute _var = {					\
+	.kobj_attr = BOOL_PROP_KOBJ_ATTR_WO(_name),			\
+	.pid = _pid,							\
+	.op = _op,							\
+}
+
+#endif /* WILCO_EC_PROPERTIES_H */
diff --git a/drivers/platform/chrome/wilco_ec/sysfs.c b/drivers/platform/chrome/wilco_ec/sysfs.c
index 0611a73fcdce..b81f251f78fc 100644
--- a/drivers/platform/chrome/wilco_ec/sysfs.c
+++ b/drivers/platform/chrome/wilco_ec/sysfs.c
@@ -15,6 +15,7 @@
 #include <linux/sysfs.h>
 
 #include "legacy.h"
+#include "properties.h"
 
 #define WILCO_EC_ATTR_RO(_name)						\
 __ATTR(_name, 0444, wilco_ec_##_name##_show, NULL)
@@ -41,6 +42,38 @@ static struct attribute *wilco_ec_toplevel_attrs[] = {
 };
 ATTRIBUTE_GROUPS(wilco_ec_toplevel);
 
+/* Make property attributes, which will live inside GOOG000C:00/properties/  */
+BOOLEAN_PROPERTY_RW_ATTRIBUTE(OP_SET, bool_prop_attr_global_mic_mute_led,
+			      global_mic_mute_led, PID_GLOBAL_MIC_MUTE_LED);
+BOOLEAN_PROPERTY_RW_ATTRIBUTE(OP_SET, bool_prop_attr_fn_lock, fn_lock,
+			      PID_FN_LOCK);
+BOOLEAN_PROPERTY_RW_ATTRIBUTE(OP_SET, bool_prop_attr_nic, nic, PID_NIC);
+BOOLEAN_PROPERTY_RW_ATTRIBUTE(OP_SET, bool_prop_attr_ext_usb_port_en,
+			      ext_usb_port_en, PID_EXT_USB_PORT_EN);
+BOOLEAN_PROPERTY_WO_ATTRIBUTE(OP_SYNC, bool_prop_attr_wireless_sw_wlan,
+			      wireless_sw_wlan, PID_WIRELESS_SW_WLAN);
+BOOLEAN_PROPERTY_RW_ATTRIBUTE(OP_SET,
+			      bool_prop_attr_auto_boot_on_trinity_dock_attach,
+			      auto_boot_on_trinity_dock_attach,
+			      PID_AUTO_BOOT_ON_TRINITY_DOCK_ATTACH);
+BOOLEAN_PROPERTY_RW_ATTRIBUTE(OP_SET, bool_prop_attr_ich_azalia_en,
+			      ich_azalia_en, PID_ICH_AZALIA_EN);
+BOOLEAN_PROPERTY_RW_ATTRIBUTE(OP_SET, bool_prop_attr_sign_of_life_kbbl,
+			      sign_of_life_kbbl, PID_SIGN_OF_LIFE_KBBL);
+struct attribute *wilco_ec_property_attrs[] = {
+	&bool_prop_attr_global_mic_mute_led.kobj_attr.attr,
+	&bool_prop_attr_fn_lock.kobj_attr.attr,
+	&bool_prop_attr_nic.kobj_attr.attr,
+	&bool_prop_attr_ext_usb_port_en.kobj_attr.attr,
+	&bool_prop_attr_wireless_sw_wlan.kobj_attr.attr,
+	&bool_prop_attr_auto_boot_on_trinity_dock_attach.kobj_attr.attr,
+	&bool_prop_attr_ich_azalia_en.kobj_attr.attr,
+	&bool_prop_attr_sign_of_life_kbbl.kobj_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(wilco_ec_property);
+struct kobject *prop_dir_kobj;
+
 /**
  * wilco_ec_sysfs_init() - Initialize the sysfs directories and attributes
  * @dev: The device representing the EC
@@ -58,9 +91,27 @@ int wilco_ec_sysfs_init(struct wilco_ec_device *ec)
 	/* add the top-level attributes */
 	ret = sysfs_create_groups(&dev->kobj, wilco_ec_toplevel_groups);
 	if (ret)
-		return -ENOMEM;
+		goto err;
+
+	/* add the directory for properties */
+	prop_dir_kobj = kobject_create_and_add("properties", &dev->kobj);
+	if (!prop_dir_kobj)
+		goto rm_toplevel_attrs;
+
+	/* add the property attributes into the properties directory */
+	ret = sysfs_create_groups(prop_dir_kobj, wilco_ec_property_groups);
+	if (ret)
+		goto rm_properties_dir;
 
 	return 0;
+
+/* Go upwards through the directory structure, cleaning up */
+rm_properties_dir:
+	kobject_put(prop_dir_kobj);
+rm_toplevel_attrs:
+	sysfs_remove_groups(&dev->kobj, wilco_ec_toplevel_groups);
+err:
+	return -ENOMEM;
 }
 
 void wilco_ec_sysfs_remove(struct wilco_ec_device *ec)
@@ -68,5 +119,7 @@ void wilco_ec_sysfs_remove(struct wilco_ec_device *ec)
 	struct device *dev = ec->dev;
 
 	/* go upwards through the directory structure */
+	sysfs_remove_groups(prop_dir_kobj, wilco_ec_property_groups);
+	kobject_put(prop_dir_kobj);
 	sysfs_remove_groups(&dev->kobj, wilco_ec_toplevel_groups);
 }
diff --git a/drivers/platform/chrome/wilco_ec/util.h b/drivers/platform/chrome/wilco_ec/util.h
new file mode 100644
index 000000000000..708de8fd96b5
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/util.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * wilco_ec_sysfs_util - helpers for sysfs attributes of Wilco EC
+ *
+ * Copyright (C) 2018 Google LLC
+ */
+
+#ifndef WILCO_EC_SYSFS_UTIL_H
+#define WILCO_EC_SYSFS_UTIL_H
+
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include <linux/string.h>
+
+/**
+ * device_from_kobject() - Get EC device from subdirectory's kobject.
+ * @kobj: kobject associated with a subdirectory
+ *
+ * When we place attributes within directories within the sysfs filesystem,
+ * at each callback we get a reference to the kobject representing the directory
+ * that that attribute is in. Somehow we need to get a pointer to the EC device.
+ * This goes up the directory structure a number of levels until reaching the
+ * top level for the EC device, and then finds the device from the root kobject.
+ *
+ * Example: for attribute GOOG000C:00/properties/peakshift/sunday,
+ * we would go up two levels, from peakshift to properties and then from
+ * properties to GOOG000C:00
+ *
+ * Return: a pointer to the device struct representing the EC.
+ */
+static inline struct device *device_from_kobject(struct kobject *kobj)
+{
+	while (strcmp(kobj->name, "GOOG000C:00") != 0)
+		kobj = kobj->parent;
+	return container_of(kobj, struct device, kobj);
+}
+
+#endif
-- 
2.20.1.97.g81188d93c3-goog

