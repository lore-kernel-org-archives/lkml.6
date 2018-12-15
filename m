Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7731C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B8E206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbeLOATw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:19:52 -0500
Received: from mail-qt1-f197.google.com ([209.85.160.197]:52659 "EHLO
        mail-qt1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbeLOATp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:19:45 -0500
Received: by mail-qt1-f197.google.com with SMTP id w15so7364410qtk.19
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8YHtOW9Sf0d3+xxK5TzPzt8C1EAaqAAq50WjWnt/9nE=;
        b=nEFxGuk17ufmgcWeNePjTFtRbvhuJymDj9d3bfdkgykiFgQy0Bvor5/e/uBF4uSN9Q
         Ju2w9GvtV1LXLArBV7L+aqaOmecd3bkyI13I8iG0Bjbbqn6T/n4fmmqpY+4UvoaiH2V/
         4b7HSm/rQvRM2ZhrN/No1YgFDiGu/N5EH6sV/Z31vGcJojhx1LVCj2JBXvJ2dveIRxJl
         68YCNEQTdwEliHNDBQU4dPg62rGbBZjk9w9jr+u3Ait3gthRuEB5CbfCOcQnDR4fr3TV
         +xbu5kvtzyD9epxhjAo017jEOafFmQ1ZQgUf5DnKlmx4cAXHAxS1t9BQ+fMMNZY03+xO
         Fu7Q==
X-Gm-Message-State: AA+aEWb1NizLX5RmylpLnM6RH8BK/1OCctEDNuzJ87plZtxyR8l+4eUf
        J5wxp12XaFDqHTah0lD8BiYUiVjlrpxIKLfKyCC3hduqW+p4/xSEz4o+b0+/1DoCajZRXPEl3nE
        wbGK2eeY+K90Fc+BhlZ+8ViHo/rgQFn//6PRCHyXfvT2DMzw4ki7eSUgDjqj3alSmIK8KLxS56q
        w=
X-Google-Smtp-Source: AFSGD/XwebMCG4019D0yUV1re7bHAnHpoXAjKDTKrbl9aJdZBvJ89+zxnSZZ9fHcSmXoiv+qpPCp4CSu6o/WDAm3
X-Received: by 2002:a0c:a8cd:: with SMTP id h13mr4927060qvc.54.1544833183592;
 Fri, 14 Dec 2018 16:19:43 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:18:39 -0700
In-Reply-To: <20181215001843.62404-1-ncrews@google.com>
Message-Id: <20181215001843.62404-7-ncrews@google.com>
Mime-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [RFC PATCH 06/10] CHROMIUM: wilco_ec: Add event handling
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

The Wilco Embedded Controller can return extended events that
are not handled by standard ACPI objects.  These events can
include hotkeys which map to standard functions like brightness
controls, or information about EC controlled features like the
charger or battery.

These events are triggered with an ACPI Notify(0x90) and the
event data buffer is read through an ACPI method provided by
the BIOS which reads the event buffer from EC RAM.

These events are then processed, with hotkey events being sent
to the input subsystem and other events put into a queue which
can be read by a userspace daemon via a sysfs attribute.

> evtest /dev/input/event6
Input driver version is 1.0.1
Input device ID: bus 0x19 vendor 0x0 product 0x0 version 0x0
Input device name: "Wilco EC hotkeys"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 224 (KEY_BRIGHTNESSDOWN)
    Event code 225 (KEY_BRIGHTNESSUP)
    Event code 240 (KEY_UNKNOWN)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
Properties:
Testing ... (interrupt to exit)
Event: type 4 (EV_MSC), code 4 (MSC_SCAN), value 57
Event: type 1 (EV_KEY), code 224 (KEY_BRIGHTNESSDOWN), value 1
Event: -------------- SYN_REPORT ------------
Event: type 1 (EV_KEY), code 224 (KEY_BRIGHTNESSDOWN), value 0
Event: -------------- SYN_REPORT ------------
Event: type 4 (EV_MSC), code 4 (MSC_SCAN), value 58
Event: type 1 (EV_KEY), code 225 (KEY_BRIGHTNESSUP), value 1
Event: -------------- SYN_REPORT ------------
Event: type 1 (EV_KEY), code 225 (KEY_BRIGHTNESSUP), value 0
Event: -------------- SYN_REPORT ------------

Signed-off-by: Duncan Laurie <dlaurie@google.com>
Signed-off-by: Nick Crews <ncrews@google.com>
---

 drivers/platform/chrome/Makefile           |   4 +-
 drivers/platform/chrome/wilco_ec.h         |  34 ++
 drivers/platform/chrome/wilco_ec_event.c   | 343 +++++++++++++++++++++
 drivers/platform/chrome/wilco_ec_mailbox.c |  11 +
 4 files changed, 390 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/chrome/wilco_ec_event.c

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 5ca484c2d0d7..60b19190dba1 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -13,6 +13,6 @@ cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
 
-wilco_ec-objs				:= wilco_ec_mailbox.o wilco_ec_rtc.o \
-					   wilco_ec_sysfs.o
+wilco_ec-objs				:= wilco_ec_mailbox.o wilco_ec_event.o \
+					   wilco_ec_rtc.o wilco_ec_sysfs.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec.h b/drivers/platform/chrome/wilco_ec.h
index eee5c514e720..6f084188faa1 100644
--- a/drivers/platform/chrome/wilco_ec.h
+++ b/drivers/platform/chrome/wilco_ec.h
@@ -18,7 +18,9 @@
 #define WILCO_EC_H
 
 #include <linux/device.h>
+#include <linux/input.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/rtc.h>
 
 /* Normal commands have a maximum 32 bytes of data */
@@ -46,6 +48,22 @@ enum wilco_ec_msg_type {
 	WILCO_EC_MSG_TELEMETRY = 0x00f5,
 };
 
+/**
+ * struct wilco_ec_event - EC extended events.
+ * @lock: Mutex to guard the list of events.
+ * @list: Queue of EC events to be provided to userspace.
+ * @attr: Sysfs attribute for userspace to read events.
+ * @count: Count of events in the queue.
+ * @input: Input device for hotkey events.
+ */
+struct wilco_ec_event {
+	struct mutex lock;
+	struct list_head list;
+	struct bin_attribute attr;
+	size_t count;
+	struct input_dev *input;
+};
+
 /**
  * struct wilco_ec_device - Wilco Embedded Controller handle.
  * @dev: Device handle.
@@ -57,6 +75,7 @@ enum wilco_ec_msg_type {
  *               is used to hold the request and the response.
  * @data_size: Size of the data buffer used for EC communication.
  * @rtc: RTC device handler.
+ * @event: EC extended event handler.
  */
 struct wilco_ec_device {
 	struct device *dev;
@@ -67,6 +86,7 @@ struct wilco_ec_device {
 	void *data_buffer;
 	size_t data_size;
 	struct rtc_device *rtc;
+	struct wilco_ec_event event;
 };
 
 /**
@@ -143,4 +163,18 @@ int wilco_ec_rtc_write(struct device *dev, struct rtc_time *tm);
  */
 int wilco_ec_rtc_sync(struct device *dev);
 
+/**
+ * wilco_ec_event_init() - Prepare to handle EC events.
+ * @ec: EC device.
+ *
+ * Return: 0 for success or negative error code on failure.
+ */
+int wilco_ec_event_init(struct wilco_ec_device *ec);
+
+/**
+ * wilco_ec_event_remove() - Remove EC event handler.
+ * @ec: EC device.
+ */
+void wilco_ec_event_remove(struct wilco_ec_device *ec);
+
 #endif /* WILCO_EC_H */
diff --git a/drivers/platform/chrome/wilco_ec_event.c b/drivers/platform/chrome/wilco_ec_event.c
new file mode 100644
index 000000000000..248f2ec095ab
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec_event.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * wilco_ec_event - Event handling for Wilco Embedded Controller
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
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+#include "wilco_ec.h"
+
+/* ACPI Notify event code indicating event data is available */
+#define EC_ACPI_NOTIFY_EVENT		0x90
+
+/* ACPI Method to execute to retrieve event data buffer from the EC */
+#define EC_ACPI_GET_EVENT		"^QSET"
+
+/* Maximum number of words in event data returned by the EC */
+#define EC_ACPI_MAX_EVENT_DATA		6
+
+/* Keep at most 100 events in the queue */
+#define EC_EVENT_QUEUE_MAX		100
+
+/**
+ * enum ec_event_type - EC event categories.
+ * @EC_EVENT_TYPE_HOTKEY: Hotkey event for handling special keys.
+ * @EC_EVENT_TYPE_NOTIFY: EC feature state changes.
+ * @EC_EVENT_TYPE_SYSTEM: EC system messages.
+ */
+enum ec_event_type {
+	EC_EVENT_TYPE_HOTKEY = 0x10,
+	EC_EVENT_TYPE_NOTIFY = 0x11,
+	EC_EVENT_TYPE_SYSTEM = 0x12,
+};
+
+/**
+ * struct ec_event - Extended event returned by the EC.
+ * @size: Number of words in structure after the size word.
+ * @type: Extended event type from &enum ec_event_type.
+ * @event: Event data words.  Max count is %EC_ACPI_MAX_EVENT_DATA.
+ */
+struct ec_event {
+	u16 size;
+	u16 type;
+	u16 event[0];
+} __packed;
+
+/**
+ * struct ec_event_entry - Event queue entry.
+ * @list: List node.
+ * @size: Number of bytes in event structure.
+ * @event: Extended event returned by the EC.  This should be the last
+ *         element because &struct ec_event includes a zero length array.
+ */
+struct ec_event_entry {
+	struct list_head list;
+	size_t size;
+	struct ec_event event;
+};
+
+static const struct key_entry wilco_ec_keymap[] = {
+	{ KE_KEY, 0x0057, { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY, 0x0058, { KEY_BRIGHTNESSUP } },
+	{ KE_END, 0 }
+};
+
+/**
+ * wilco_ec_handle_events() - Handle Embedded Controller events.
+ * @ec: EC device.
+ * @buf: Buffer of event data.
+ * @length: Length of event data buffer.
+ *
+ * Return: Number of events in queue or negative error code on failure.
+ *
+ * This function will handle EC extended events, sending hotkey events
+ * to the input subsystem and queueing others to be read by userspace.
+ */
+static int wilco_ec_handle_events(struct wilco_ec_device *ec,
+				  u8 *buf, u32 length)
+{
+	struct wilco_ec_event *queue = &ec->event;
+	struct ec_event *event;
+	struct ec_event_entry *entry;
+	size_t entry_size, num_words;
+	u32 offset = 0;
+
+	while (offset < length) {
+		event = (struct ec_event *)(buf + offset);
+		if (!event)
+			return -EINVAL;
+
+		dev_dbg(ec->dev, "EC event type 0x%02x size %d\n", event->type,
+			event->size);
+
+		/* Number of 16bit event data words is size - 1 */
+		num_words = event->size - 1;
+		entry_size = sizeof(*event) + (num_words * sizeof(u16));
+
+		if (num_words > EC_ACPI_MAX_EVENT_DATA) {
+			dev_err(ec->dev, "Invalid event word count: %d > %d\n",
+				num_words, EC_ACPI_MAX_EVENT_DATA);
+			return -EOVERFLOW;
+		};
+
+		/* Ensure event does not overflow the available buffer */
+		if ((offset + entry_size) > length) {
+			dev_err(ec->dev, "Event exceeds buffer: %d > %d\n",
+				offset + entry_size, length);
+			return -EOVERFLOW;
+		}
+
+		/* Point to the next event in the buffer */
+		offset += entry_size;
+
+		/* Hotkeys are sent to the input subsystem */
+		if (event->type == EC_EVENT_TYPE_HOTKEY) {
+			if (sparse_keymap_report_event(queue->input,
+						       event->event[0],
+						       1, true))
+				continue;
+
+			/* Unknown hotkeys are put into the event queue */
+			dev_dbg(ec->dev, "Unknown hotkey 0x%04x\n",
+				event->event[0]);
+		}
+
+		/* Prepare event for the queue */
+		entry = kzalloc(entry_size, GFP_KERNEL);
+		if (!entry)
+			return -ENOMEM;
+
+		/* Copy event data */
+		entry->size = entry_size;
+		memcpy(&entry->event, event, entry->size);
+
+		/* Add this event to the queue */
+		mutex_lock(&queue->lock);
+		list_add_tail(&entry->list, &queue->list);
+		queue->count++;
+		mutex_unlock(&queue->lock);
+	}
+
+	return queue->count;
+}
+
+/**
+ * wilco_ec_acpi_notify() - Handler called by ACPI subsystem for Notify.
+ * @device: EC ACPI device.
+ * @value: Value passed to Notify() in ACPI.
+ * @data: Private data, pointer to EC device.
+ */
+static void wilco_ec_acpi_notify(acpi_handle device, u32 value, void *data)
+{
+	struct wilco_ec_device *ec = data;
+	struct acpi_buffer event_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	int count;
+
+	/* Currently only handle event notifications */
+	if (value != EC_ACPI_NOTIFY_EVENT) {
+		dev_err(ec->dev, "Invalid event: 0x%08x\n", value);
+		return;
+	}
+
+	/* Execute ACPI method to get event data buffer */
+	status = acpi_evaluate_object(device, EC_ACPI_GET_EVENT,
+				      NULL, &event_buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_err(ec->dev, "Error executing ACPI method %s()\n",
+			 EC_ACPI_GET_EVENT);
+		return;
+	}
+
+	obj = (union acpi_object *)event_buffer.pointer;
+	if (!obj) {
+		dev_err(ec->dev, "Nothing returned from %s()\n",
+			EC_ACPI_GET_EVENT);
+		return;
+	}
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		dev_err(ec->dev, "Invalid object returned from %s()\n",
+			EC_ACPI_GET_EVENT);
+		kfree(obj);
+		return;
+	}
+	if (obj->buffer.length < sizeof(struct ec_event)) {
+		dev_err(ec->dev, "Invalid buffer length %d from %s()\n",
+			obj->buffer.length, EC_ACPI_GET_EVENT);
+		kfree(obj);
+		return;
+	}
+
+	/* Handle events and notify sysfs if any queued for userspace */
+	count = wilco_ec_handle_events(ec, obj->buffer.pointer,
+				       obj->buffer.length);
+
+	if (count > 0) {
+		dev_dbg(ec->dev, "EC event queue has %d entries\n", count);
+		sysfs_notify(&ec->dev->kobj, NULL, "event");
+	}
+
+	kfree(obj);
+}
+
+static ssize_t wilco_ec_event_read(struct file *filp, struct kobject *kobj,
+				   struct bin_attribute *attr,
+				   char *buf, loff_t off, size_t count)
+{
+	struct wilco_ec_device *ec = attr->private;
+	struct ec_event_entry *entry;
+
+	/* Only supports reading full events */
+	if (off != 0)
+		return -EINVAL;
+
+	/* Remove the first event and provide it to userspace */
+	mutex_lock(&ec->event.lock);
+	entry = list_first_entry_or_null(&ec->event.list,
+					 struct ec_event_entry, list);
+	if (entry) {
+		if (entry->size < count)
+			count = entry->size;
+		memcpy(buf, &entry->event, count);
+		list_del(&entry->list);
+		kfree(entry);
+		ec->event.count--;
+	} else {
+		count = 0;
+	}
+	mutex_unlock(&ec->event.lock);
+
+	return count;
+}
+
+static void wilco_ec_event_clear(struct wilco_ec_device *ec)
+{
+	struct ec_event_entry *entry, *next;
+
+	mutex_lock(&ec->event.lock);
+
+	/* Clear the event queue */
+	list_for_each_entry_safe(entry, next, &ec->event.list, list) {
+		list_del(&entry->list);
+		kfree(entry);
+		ec->event.count--;
+	}
+
+	mutex_unlock(&ec->event.lock);
+}
+
+int wilco_ec_event_init(struct wilco_ec_device *ec)
+{
+	struct wilco_ec_event *event = &ec->event;
+	struct device *dev = ec->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	acpi_status status;
+	int ret;
+
+	if (!adev) {
+		dev_err(dev, "Unable to find Wilco ACPI Device\n");
+		return -ENODEV;
+	}
+
+	INIT_LIST_HEAD(&event->list);
+	mutex_init(&event->lock);
+
+	/* Allocate input device for hotkeys */
+	event->input = input_allocate_device();
+	if (!event->input)
+		return -ENOMEM;
+	event->input->name = "Wilco EC hotkeys";
+	event->input->phys = "ec/input0";
+	event->input->id.bustype = BUS_HOST;
+	ret = sparse_keymap_setup(event->input, wilco_ec_keymap, NULL);
+	if (ret) {
+		dev_err(dev, "Unable to setup input device keymap\n");
+		input_free_device(event->input);
+		return ret;
+	}
+	ret = input_register_device(event->input);
+	if (ret) {
+		dev_err(dev, "Unable to register input device\n");
+		input_free_device(event->input);
+		return ret;
+	}
+
+	/* Create sysfs attribute for userspace event handling */
+	sysfs_bin_attr_init(&event->attr);
+	event->attr.attr.name = "event";
+	event->attr.attr.mode = 0400;
+	event->attr.read = wilco_ec_event_read;
+	event->attr.private = ec;
+	ret = device_create_bin_file(dev, &event->attr);
+	if (ret) {
+		dev_err(dev, "Failed to create event attribute in sysfs\n");
+		input_unregister_device(event->input);
+		return ret;
+	}
+
+	/* Install ACPI handler for Notify events */
+	status = acpi_install_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
+					     wilco_ec_acpi_notify, ec);
+
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Failed to register notifier %08x\n", status);
+		device_remove_bin_file(dev, &event->attr);
+		input_unregister_device(event->input);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+void wilco_ec_event_remove(struct wilco_ec_device *ec)
+{
+	struct acpi_device *adev = ACPI_COMPANION(ec->dev);
+
+	/* Stop new events */
+	if (adev)
+		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
+					   wilco_ec_acpi_notify);
+
+	/* Remove event interfaces */
+	device_remove_bin_file(ec->dev, &ec->event.attr);
+	input_unregister_device(ec->event.input);
+
+	/* Clear the event queue */
+	wilco_ec_event_clear(ec);
+}
diff --git a/drivers/platform/chrome/wilco_ec_mailbox.c b/drivers/platform/chrome/wilco_ec_mailbox.c
index 2f093a281a30..25c2c539c813 100644
--- a/drivers/platform/chrome/wilco_ec_mailbox.c
+++ b/drivers/platform/chrome/wilco_ec_mailbox.c
@@ -377,6 +377,14 @@ static int wilco_ec_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	/* Prepare to handle events */
+	if (wilco_ec_event_init(ec) < 0) {
+		dev_err(dev, "Failed to setup event handling\n");
+		wilco_ec_sysfs_remove(ec);
+		cros_ec_lpc_mec_destroy();
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
@@ -384,6 +392,9 @@ static int wilco_ec_remove(struct platform_device *pdev)
 {
 	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
 
+	/* Stop handling EC events */
+	wilco_ec_event_remove(ec);
+
 	/* Remove sysfs attributes */
 	wilco_ec_sysfs_remove(ec);
 
-- 
2.20.0.405.gbc1bbc6f85-goog

