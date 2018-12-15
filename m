Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA745C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7C8206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbeLOATu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:19:50 -0500
Received: from mail-yb1-f199.google.com ([209.85.219.199]:47855 "EHLO
        mail-yb1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbeLOATr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:19:47 -0500
Received: by mail-yb1-f199.google.com with SMTP id i13-v6so4040050ybe.14
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=alwqyQK8M+wJvaYcwBS5ojP7h5UFJX0a9I/9Lze8BT4=;
        b=YRnkq0Bv7k4Jk0eS7HGSc5M79INc9WXRA+xHUd3K+449+A4WjGbiRr8wVkOvmJsHuo
         zB5GxbnM0qzMSDmNEIjBHjK1H0cU++inBMFe5gWZKU39miiFQBCKLOlLklbVqdz7k6w4
         gQF/jIYieioRXLEms/5S4kNqf5za3P4ZtoF8QYtx/7Q0mbKDJxAb3LBKUpuQUtHFES7W
         EX3qquefZlU7wynYOhyzD4xZ7jfPQy9HTDR80qOFjMLrUagd8kXCuth52f7l6j9OSbbk
         8k6i94UsFDAGUBXvK88Ql/33XwQRWsrbFb53Uosci8IhnsZb6Mk/Qo+Fq8bKYAdjYu86
         TMrw==
X-Gm-Message-State: AA+aEWYvKfc3Z72D/TDNKqrszK6KFVx8NPtZc7OCS8WTGZVhYQtr0Jfg
        94uH5JntERr05L+X4cQXvmayd+mJFmMbnUky4K4MxaW9eYjd5OR+zUrXEQ20oL0r/pIDx9NWMYQ
        E5+e5wa+a1X+41Q6Qnn7zdt8qICi+jjC1idkLtqpERX7m9Cju6leeTrE1ZXpNGGPNFgMGF+ywvL
        c=
X-Google-Smtp-Source: AFSGD/X4OSPV2FaPDQXUQ0RNnrcqH/PXou4khM0VRHIeLddKhOgxI6LvAZLW9b/RBCHQY0DfI4PWN+L2wGjOJ2hT
X-Received: by 2002:a5b:b08:: with SMTP id z8-v6mr3110220ybp.7.1544833185389;
 Fri, 14 Dec 2018 16:19:45 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:18:40 -0700
In-Reply-To: <20181215001843.62404-1-ncrews@google.com>
Message-Id: <20181215001843.62404-8-ncrews@google.com>
Mime-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [RFC PATCH 07/10] CHROMIUM: wilco_ec: Move legacy attributes to
 separate file
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nick Crews <ncrews@google.com>, Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Legacy attributes are EC properties that are non-chromebook specific,
ones which existed before the EC was modified for Chromebooks (as I
understand it at least). This adds no new behavior, but just refactors
the existing legacy attributes so adding more attributes in the future
will work in an elegant way.

wilco_sysfs.c should just contain the information you need to understand
how to use the sysfs interface. It will only specify the names of the
attributes and their location within the directory structure.
The API and the implementation for all the attributes will be located
in individual external files, so if you want to see how to use an
attribute, you can look that that specific file. This should help
with the problem of this sysfs file becoming way too big to understand.

With this new structure, it should be easy to add new attributes by
making new implementation files, #include-ing them in wilco_ec_sysfs.c,
and then defining where to actually place the attributes in
wilco_ec_sysfs.c

Signed-off-by: Nick Crews <ncrews@google.com>
---

 drivers/platform/chrome/Makefile          |   3 +-
 drivers/platform/chrome/wilco_ec_legacy.c | 204 ++++++++++++++++++
 drivers/platform/chrome/wilco_ec_legacy.h |  96 +++++++++
 drivers/platform/chrome/wilco_ec_sysfs.c  | 248 ++++------------------
 4 files changed, 343 insertions(+), 208 deletions(-)
 create mode 100644 drivers/platform/chrome/wilco_ec_legacy.c
 create mode 100644 drivers/platform/chrome/wilco_ec_legacy.h

diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index 60b19190dba1..56c39de8e5f5 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
 obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o
 
 wilco_ec-objs				:= wilco_ec_mailbox.o wilco_ec_event.o \
-					   wilco_ec_rtc.o wilco_ec_sysfs.o
+					   wilco_ec_rtc.o wilco_ec_legacy.o \
+					   wilco_ec_sysfs.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
diff --git a/drivers/platform/chrome/wilco_ec_legacy.c b/drivers/platform/chrome/wilco_ec_legacy.c
new file mode 100644
index 000000000000..6110117af024
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec_legacy.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * wilco_ec_legacy - Legacy sysfs attributes for Wilco EC
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
+#include <linux/ctype.h>
+#include <linux/device.h>
+
+#include "wilco_ec.h"
+#include "wilco_ec_legacy.h"
+
+#ifdef CONFIG_WILCO_EC_SYSFS_RAW
+
+/* Raw data buffer, large enough to hold extended responses */
+static size_t raw_response_size;
+static u8 raw_response_data[EC_MAILBOX_DATA_SIZE_EXTENDED];
+
+ssize_t wilco_ec_raw_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct wilco_ec_message msg;
+	u8 raw_request_data[EC_MAILBOX_DATA_SIZE];
+	int in_offset = 0;
+	int out_offset = 0;
+	int ret;
+
+	while (in_offset < count) {
+		char word_buf[EC_MAILBOX_DATA_SIZE];
+		u8 byte;
+		int start_offset = in_offset;
+		int end_offset;
+
+		/* Find the start of the byte */
+		while (buf[start_offset] && isspace(buf[start_offset]))
+			start_offset++;
+		if (!buf[start_offset])
+			break;
+
+		/* Find the start of the next byte, if any */
+		end_offset = start_offset;
+		while (buf[end_offset] && !isspace(buf[end_offset]))
+			end_offset++;
+		if (start_offset > count || end_offset > count)
+			break;
+		if (start_offset > EC_MAILBOX_DATA_SIZE ||
+		    end_offset > EC_MAILBOX_DATA_SIZE)
+			break;
+
+		/* Copy to a new NULL terminated string */
+		memcpy(word_buf, buf + start_offset, end_offset - start_offset);
+		word_buf[end_offset - start_offset] = '\0';
+
+		/* Convert from hex string */
+		ret = kstrtou8(word_buf, 16, &byte);
+		if (ret)
+			break;
+
+		/* Fill this byte into the request buffer */
+		raw_request_data[out_offset++] = byte;
+		if (out_offset >= EC_MAILBOX_DATA_SIZE)
+			break;
+
+		in_offset = end_offset;
+	}
+	if (out_offset == 0)
+		return -EINVAL;
+
+	/* Clear response data buffer */
+	memset(raw_response_data, '\0', EC_MAILBOX_DATA_SIZE_EXTENDED);
+
+	msg.type = raw_request_data[0] << 8 | raw_request_data[1];
+	msg.flags = WILCO_EC_FLAG_RAW;
+	msg.command = raw_request_data[2];
+	msg.request_data = raw_request_data + 3;
+	msg.request_size = out_offset - 3;
+	msg.response_data = raw_response_data;
+	msg.response_size = EC_MAILBOX_DATA_SIZE;
+
+	/* Telemetry commands use extended response data */
+	if (msg.type == WILCO_EC_MSG_TELEMETRY) {
+		msg.flags |= WILCO_EC_FLAG_EXTENDED_DATA;
+		msg.response_size = EC_MAILBOX_DATA_SIZE_EXTENDED;
+	}
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+	raw_response_size = ret;
+	return count;
+}
+
+ssize_t wilco_ec_raw_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	ssize_t count = 0;
+
+	if (raw_response_size) {
+		int i;
+
+		for (i = 0; i < raw_response_size; ++i)
+			count += scnprintf(buf + count, PAGE_SIZE - count,
+					   "%02x ", raw_response_data[i]);
+
+		count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
+
+		/* Only return response the first time it is read */
+		raw_response_size = 0;
+	}
+
+	return count;
+}
+
+#endif /* CONFIG_WILCO_EC_SYSFS_RAW */
+
+struct ec_info {
+	u8 index;
+	const char *label;
+};
+
+static ssize_t wilco_ec_show_info(struct wilco_ec_device *ec, char *buf,
+				  ssize_t count, struct ec_info *info)
+{
+	char result[EC_INFO_SIZE];
+	struct wilco_ec_message msg = {
+		.type = WILCO_EC_MSG_LEGACY,
+		.command = EC_COMMAND_EC_INFO,
+		.request_data = &info->index,
+		.request_size = sizeof(info->index),
+		.response_data = result,
+		.response_size = EC_INFO_SIZE,
+	};
+	int ret;
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret != EC_INFO_SIZE)
+		return scnprintf(buf + count, PAGE_SIZE - count,
+				 "%-12s : ERROR %d\n", info->label, ret);
+
+	return scnprintf(buf + count, PAGE_SIZE - count,
+			 "%-12s : %s\n", info->label, result);
+}
+
+ssize_t wilco_ec_version_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	struct ec_info wilco_ec_info[] = {
+		{ 0, "Label" },
+		{ 1, "SVN Revision" },
+		{ 2, "Model Number" },
+		{ 3, "Build Date" },
+		{ 0xff, NULL },
+	};
+	struct ec_info *info = wilco_ec_info;
+	ssize_t c = 0;
+
+	for (info = wilco_ec_info; info->label; info++)
+		c += wilco_ec_show_info(ec, buf, c, info);
+
+	return c;
+}
+
+ssize_t wilco_ec_stealth_mode_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(dev);
+	u8 param;
+	struct wilco_ec_message msg = {
+		.type = WILCO_EC_MSG_LEGACY,
+		.command = EC_COMMAND_STEALTH_MODE,
+		.request_data = &param,
+		.request_size = sizeof(param),
+	};
+	int ret;
+	bool enable;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret) {
+		dev_err(dev, "Unable to parse '%s' to bool", buf);
+		return ret;
+	}
+
+	/* Invert input parameter, EC expects 0=on and 1=off */
+	param = enable ? 0 : 1;
+
+	ret = wilco_ec_mailbox(ec, &msg);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
diff --git a/drivers/platform/chrome/wilco_ec_legacy.h b/drivers/platform/chrome/wilco_ec_legacy.h
new file mode 100644
index 000000000000..dc9a838d6138
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec_legacy.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * wilco_ec_legacy - Legacy (non-Chrome-specific) sysfs attributes for Wilco EC
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
+#ifndef WILCO_EC_LEGACY_H
+#define WILCO_EC_LEGACY_H
+
+#include <linux/device.h>
+
+#define EC_COMMAND_EC_INFO		0x38
+#define EC_INFO_SIZE			 9
+#define EC_COMMAND_STEALTH_MODE		0xfc
+
+#ifdef CONFIG_WILCO_EC_SYSFS_RAW
+
+/**
+ * raw_store() - Write a raw command to EC, store the result to view later
+ * @dev: Device representing the EC
+ * @attr: The attribute in question
+ * @buf: Input buffer, format explained below
+ * @count: Number of bytes in input buffer
+ *
+ * Bytes 0-1 indicate the message type:
+ *  00 F0 = Execute Legacy Command
+ *  00 F2 = Read/Write NVRAM Property
+ * Byte 2 provides the command code
+ * Bytes 3+ consist of the data passed in the request
+ *
+ * example: read the EC info type 1:
+ *  # echo 00 f0 38 00 01 00 > raw
+ *
+ * After calling this function, read the result by using raw_show()
+ *
+ * Return: Number of bytes consumed from input, negative error code on failure
+ */
+ssize_t wilco_ec_raw_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count);
+
+/**
+ * raw_show() - Show result from previous call to raw_store()
+ * @dev: Device representing the EC
+ * @attr: The attribute in question
+ * @buf: Output buffer to be filled
+ *
+ * Example usage:
+ *	// Call raw_store(), read EC info type 1
+ *	# echo 00 f0 38 00 01 00 > raw
+ *	// Call this function, view the result
+ *	# cat raw
+ *	00 38 31 34 34 66 00 00 00 00 00 00 00 00 00 00 00...
+ *
+ * Return: Number of bytes written to output, negative error code on failure
+ */
+ssize_t wilco_ec_raw_show(struct device *dev, struct device_attribute *attr,
+			  char *buf);
+
+#endif /* CONFIG_WILCO_EC_SYSFS_RAW */
+
+/**
+ * version_show() - Display Wilco Embedded Controller version info
+ *
+ * Output will be similar to the example below:
+ * Label        : 95.00.06
+ * SVN Revision : 5960a.06
+ * Model Number : 08;8
+ * Build Date   : 11/29/18
+ */
+ssize_t wilco_ec_version_show(struct device *dev, struct device_attribute *attr,
+			      char *buf);
+/**
+ * stealth_mode_store() - Turn stealth_mode on or off on EC
+ * @dev: Device representing the EC
+ * @attr: The attribute in question
+ * @buf: Input buffer, should be parseable by kstrtobool(). Anything parsed to
+ *	 True means enable stealth mode (turn off screen, etc)
+ * @count: Number of bytes in input buffer
+ *
+ * Return: Number of bytes consumed from input, negative error code on failure
+ */
+ssize_t wilco_ec_stealth_mode_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count);
+
+#endif /* WILCO_EC_LEGACY_H */
diff --git a/drivers/platform/chrome/wilco_ec_sysfs.c b/drivers/platform/chrome/wilco_ec_sysfs.c
index eeebd4ba4a39..d11e577f7ff0 100644
--- a/drivers/platform/chrome/wilco_ec_sysfs.c
+++ b/drivers/platform/chrome/wilco_ec_sysfs.c
@@ -18,230 +18,64 @@
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 #include "wilco_ec.h"
+#include "wilco_ec_legacy.h"
 
-#define EC_COMMAND_EC_INFO		0x38
-#define EC_INFO_SIZE			 9
-#define EC_COMMAND_STEALTH_MODE		0xfc
+#define WILCO_EC_ATTR_RO(_name)						\
+__ATTR(_name, 0444, wilco_ec_##_name##_show, NULL)
 
-#ifdef CONFIG_WILCO_EC_SYSFS_RAW
-
-/* Raw data buffer, large enough to hold extended responses */
-static size_t raw_response_size;
-static u8 raw_response_data[EC_MAILBOX_DATA_SIZE_EXTENDED];
-
-/*
- * raw: write a raw command and return the result
- *
- * Bytes 0-1 indicate the message type:
- *  00 F0 = Execute Legacy Command
- *  00 F2 = Read/Write NVRAM Property
- * Byte 2 provides the command code
- * Bytes 3+ consist of the data passed in the request
- *
- * example: read the EC info type 1:
- *  # echo 00 f0 38 00 01 00 > raw
- *  # cat raw
- *  00 38 31 34 34 66 00 00 00 00 00 00 00 00 00 00 00...
- */
-
-static ssize_t raw_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	ssize_t count = 0;
-
-	if (raw_response_size) {
-		int i;
-
-		for (i = 0; i < raw_response_size; ++i)
-			count += scnprintf(buf + count, PAGE_SIZE - count,
-					   "%02x ", raw_response_data[i]);
-
-		count += scnprintf(buf + count, PAGE_SIZE - count, "\n");
-
-		/* Only return response the first time it is read */
-		raw_response_size = 0;
-	}
-
-	return count;
-}
-
-static ssize_t raw_store(struct device *dev,
-			 struct device_attribute *attr,
-			 const char *buf, size_t count)
-{
-	struct wilco_ec_device *ec = dev_get_drvdata(dev);
-	struct wilco_ec_message msg;
-	u8 raw_request_data[EC_MAILBOX_DATA_SIZE];
-	int in_offset = 0;
-	int out_offset = 0;
-	int ret;
-
-	while (in_offset < count) {
-		char word_buf[EC_MAILBOX_DATA_SIZE];
-		u8 byte;
-		int start_offset = in_offset;
-		int end_offset;
-
-		/* Find the start of the byte */
-		while (buf[start_offset] && isspace(buf[start_offset]))
-			start_offset++;
-		if (!buf[start_offset])
-			break;
-
-		/* Find the start of the next byte, if any */
-		end_offset = start_offset;
-		while (buf[end_offset] && !isspace(buf[end_offset]))
-			end_offset++;
-		if (start_offset > count || end_offset > count)
-			break;
-		if (start_offset > EC_MAILBOX_DATA_SIZE ||
-		    end_offset > EC_MAILBOX_DATA_SIZE)
-			break;
-
-		/* Copy to a new nul-terminated string */
-		memcpy(word_buf, buf + start_offset, end_offset - start_offset);
-		word_buf[end_offset - start_offset] = '\0';
-
-		/* Convert from hex string */
-		ret = kstrtou8(word_buf, 16, &byte);
-		if (ret)
-			break;
-
-		/* Fill this byte into the request buffer */
-		raw_request_data[out_offset++] = byte;
-		if (out_offset >= EC_MAILBOX_DATA_SIZE)
-			break;
-
-		in_offset = end_offset;
-	}
-	if (out_offset == 0)
-		return -EINVAL;
-
-	/* Clear response data buffer */
-	memset(raw_response_data, 0, EC_MAILBOX_DATA_SIZE_EXTENDED);
-
-	msg.type = raw_request_data[0] << 8 | raw_request_data[1];
-	msg.flags = WILCO_EC_FLAG_RAW;
-	msg.command = raw_request_data[2];
-	msg.request_data = raw_request_data + 3;
-	msg.request_size = out_offset - 3;
-	msg.response_data = raw_response_data;
-	msg.response_size = EC_MAILBOX_DATA_SIZE;
-
-	/* Telemetry commands use extended response data */
-	if (msg.type == WILCO_EC_MSG_TELEMETRY) {
-		msg.flags |= WILCO_EC_FLAG_EXTENDED_DATA;
-		msg.response_size = EC_MAILBOX_DATA_SIZE_EXTENDED;
-	}
+#define WILCO_EC_ATTR_WO(_name)						\
+__ATTR(_name, 0200, NULL, wilco_ec_##_name##_store)
 
-	ret = wilco_ec_mailbox(ec, &msg);
-	if (ret < 0)
-		return ret;
-	raw_response_size = ret;
-	return count;
-}
-
-#endif /* CONFIG_WILCO_EC_SYSFS_RAW */
-
-struct ec_info {
-	u8 index;
-	const char *label;
-};
-
-static ssize_t wilco_ec_show_info(struct wilco_ec_device *ec, char *buf,
-				  ssize_t count, struct ec_info *info)
-{
-	char result[EC_INFO_SIZE];
-	struct wilco_ec_message msg = {
-		.type = WILCO_EC_MSG_LEGACY,
-		.command = EC_COMMAND_EC_INFO,
-		.request_data = &info->index,
-		.request_size = sizeof(info->index),
-		.response_data = result,
-		.response_size = EC_INFO_SIZE,
-	};
-	int ret;
-
-	ret = wilco_ec_mailbox(ec, &msg);
-	if (ret != EC_INFO_SIZE)
-		return scnprintf(buf + count, PAGE_SIZE - count,
-				 "%-12s : ERROR %d\n", info->label, ret);
+#define WILCO_EC_ATTR_RW(_name)						\
+__ATTR(_name, 0644, wilco_ec_##_name##_show, wilco_ec_##_name##_store)
 
-	return scnprintf(buf + count, PAGE_SIZE - count,
-			 "%-12s : %s\n", info->label, result);
-}
-
-static ssize_t version_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	struct wilco_ec_device *ec = dev_get_drvdata(dev);
-	struct ec_info wilco_ec_info[] = {
-		{ 0, "Label" },
-		{ 1, "SVN Revision" },
-		{ 2, "Model Number" },
-		{ 3, "Build Date" },
-		{ 0xff, NULL },
-	};
-	struct ec_info *info = wilco_ec_info;
-	ssize_t c = 0;
-
-	for (info = wilco_ec_info; info->label; info++)
-		c += wilco_ec_show_info(ec, buf, c, info);
+/* Make top-level attributes, which will live inside GOOG000C:00/ */
 
-	return c;
-}
-
-static ssize_t stealth_mode_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	struct wilco_ec_device *ec = dev_get_drvdata(dev);
-	u8 param;
-	struct wilco_ec_message msg = {
-		.type = WILCO_EC_MSG_LEGACY,
-		.command = EC_COMMAND_STEALTH_MODE,
-		.request_data = &param,
-		.request_size = sizeof(param),
-	};
-	int ret;
-	bool enable;
-
-	ret = kstrtobool(buf, &enable);
-	if (ret)
-		return ret;
-
-	/* Invert input parameter, EC expects 0=on and 1=off */
-	param = enable ? 0 : 1;
-
-	ret = wilco_ec_mailbox(ec, &msg);
-	if (ret < 0)
-		return ret;
-
-	return count;
-}
-
-static DEVICE_ATTR_RO(version);
-static DEVICE_ATTR_WO(stealth_mode);
+static struct device_attribute version_attr = WILCO_EC_ATTR_RO(version);
+static struct device_attribute stealth_attr = WILCO_EC_ATTR_WO(stealth_mode);
 #ifdef CONFIG_WILCO_EC_SYSFS_RAW
-static DEVICE_ATTR_RW(raw);
+static struct device_attribute raw_attr = WILCO_EC_ATTR_RW(raw);
 #endif
 
-static struct attribute *wilco_ec_attrs[] = {
-	&dev_attr_version.attr,
-	&dev_attr_stealth_mode.attr,
+static struct attribute *wilco_ec_toplevel_attrs[] = {
+	&version_attr.attr,
+	&stealth_attr.attr,
 #ifdef CONFIG_WILCO_EC_SYSFS_RAW
-	&dev_attr_raw.attr,
+	&raw_attr.attr,
 #endif
 	NULL
 };
-ATTRIBUTE_GROUPS(wilco_ec);
 
+ATTRIBUTE_GROUPS(wilco_ec_toplevel);
+
+/**
+ * wilco_ec_sysfs_init() - Initialize the sysfs directories and attributes
+ * @dev: The device representing the EC
+ *
+ * Creates the sysfs directory structure and populates it with all attributes.
+ * If there is a problem it will clean up the entire filesystem.
+ *
+ * Return 0 on success, -ENOMEM on failure creating directories or attibutes.
+ */
 int wilco_ec_sysfs_init(struct wilco_ec_device *ec)
 {
-	return sysfs_create_groups(&ec->dev->kobj, wilco_ec_groups);
+	struct device *dev = ec->dev;
+	int ret;
+
+	// add the top-level attributes
+	ret = sysfs_create_groups(&dev->kobj, wilco_ec_toplevel_groups);
+	if (ret) {
+		dev_err(dev, "failed to create sysfs filesystem!");
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 void wilco_ec_sysfs_remove(struct wilco_ec_device *ec)
 {
-	sysfs_remove_groups(&ec->dev->kobj, wilco_ec_groups);
+	struct device *dev = ec->dev;
+
+	/* go upwards through the directory structure */
+	sysfs_remove_groups(&dev->kobj, wilco_ec_toplevel_groups);
 }
-- 
2.20.0.405.gbc1bbc6f85-goog

