Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D92BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4DF206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeLOATm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:19:42 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:43757 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbeLOATl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:19:41 -0500
Received: by mail-io1-f72.google.com with SMTP id k4so6169754ioc.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:19:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oHIjrWYdWUIOPjWBmyume+K21w61CX+Pn1BWk7Be/OY=;
        b=VQi5a+y119/9jcNyv8x/uHbE7G0KvWJvC1TE9MTsz7RuQJ5bxzBXDed37NAKSy4abC
         U676OVWz3ksRbDzEqDFLW7Ya30VhlXzCKZAclQXt6fA+zYRMEgKvfHtSGHxe+Dg3wRzj
         Icn/5RyDXCTfdiAmKCLPc+6W0JZqQfV4bLiKakXyJ6HIDi8MXsYMhNODKzmyftAi+/Jq
         WzcAx+IzWnfY73olgv04EJwFdAMn3JG8S8EmZ7CKCYI9BikHKDS6GJjnn59ohdwkFSze
         wp9h/VmdS3G2gIbGlyyOhakFtovv+SK260avCgCqJXgoOcEwCuoq3+zSyDDgwMWua7vR
         32Fg==
X-Gm-Message-State: AA+aEWaRI1O3hvb2nXHr0/Z37kxamfC2kZnVecXhw4amPZSqYX+m5RpS
        xCBRxQTLCxJn8Nrxo1HKe1kEHaqTDiOYY04rLiXBOCbbCgBNd9iFAbkI60o79LH5GN0B2ctYd5W
        LWgsdAhArH1sL84CMdXKwnxdBJwKpW3I4qKkChNljZY2ebd5sUWfBCIpx6mh0MWalLsEkQ1014A
        4=
X-Google-Smtp-Source: AFSGD/UCQ0UZcNRWkXAoCY1BCDkuLGAKHlydARewMZSBLwBY0j5UGF6RZG58BhUxM7fGATLU4xWgFXyhnhzNC/QH
X-Received: by 2002:a24:6209:: with SMTP id d9mr4712330itc.6.1544833179821;
 Fri, 14 Dec 2018 16:19:39 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:18:37 -0700
In-Reply-To: <20181215001843.62404-1-ncrews@google.com>
Message-Id: <20181215001843.62404-5-ncrews@google.com>
Mime-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [RFC PATCH 04/10] CHROMIUM: wilco_ec: Add support for raw commands in sysfs
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

Add a sysfs attribute that allows sending raw commands to the EC.
This is useful for development and debug but should not be enabled
in a production environment.

> echo 00 f0 38 00 03 00 > /sys/bus/platform/devices/GOOG000C\:00/raw
> cat /sys/bus/platform/devices/GOOG000C\:00/raw
00 37 33 38 65 64 00...

Signed-off-by: Duncan Laurie <dlaurie@google.com>
Signed-off-by: Nick Crews <ncrews@google.com>
---

 drivers/platform/chrome/Kconfig            |  10 ++
 drivers/platform/chrome/wilco_ec.h         |   6 +
 drivers/platform/chrome/wilco_ec_mailbox.c |   6 -
 drivers/platform/chrome/wilco_ec_sysfs.c   | 126 +++++++++++++++++++++
 4 files changed, 142 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 4168d5e6bedc..05c6d9a00395 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -61,6 +61,16 @@ config WILCO_EC
 	  To compile this driver as a module, choose M here: the
 	  module will be called wilco_ec.
 
+config WILCO_EC_SYSFS_RAW
+	bool "Enable raw access to EC via sysfs"
+	depends on WILCO_EC
+	default n
+	help
+	  If you say Y here, you get support for sending raw commands to
+	  the Wilco EC via sysfs.  These commands do not do any byte
+	  manipulation and allow for testing arbitrary commands.  This
+	  interface is intended for debug only and is disabled by default.
+
 config CROS_EC_CTL
         tristate
 
diff --git a/drivers/platform/chrome/wilco_ec.h b/drivers/platform/chrome/wilco_ec.h
index 699f4cf744dc..0b3dec4e2830 100644
--- a/drivers/platform/chrome/wilco_ec.h
+++ b/drivers/platform/chrome/wilco_ec.h
@@ -20,6 +20,12 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 
+/* Normal commands have a maximum 32 bytes of data */
+#define EC_MAILBOX_DATA_SIZE		32
+
+/* Extended commands have 256 bytes of response data */
+#define EC_MAILBOX_DATA_SIZE_EXTENDED	256
+
 #define WILCO_EC_FLAG_NO_RESPONSE	BIT(0) /* EC does not respond */
 #define WILCO_EC_FLAG_EXTENDED_DATA	BIT(1) /* EC returns 256 data bytes */
 #define WILCO_EC_FLAG_RAW_REQUEST	BIT(2) /* Do not trim request data */
diff --git a/drivers/platform/chrome/wilco_ec_mailbox.c b/drivers/platform/chrome/wilco_ec_mailbox.c
index 414ea0a8ad03..1cb34b7280fd 100644
--- a/drivers/platform/chrome/wilco_ec_mailbox.c
+++ b/drivers/platform/chrome/wilco_ec_mailbox.c
@@ -44,12 +44,6 @@
 /* Version of EC protocol */
 #define EC_MAILBOX_PROTO_VERSION	3
 
-/* Normal commands have a maximum 32 bytes of data */
-#define EC_MAILBOX_DATA_SIZE		32
-
-/* Extended commands have 256 bytes of response data */
-#define EC_MAILBOX_DATA_SIZE_EXTENDED	256
-
 /* Number of header bytes to be counted as data bytes */
 #define EC_MAILBOX_DATA_EXTRA		2
 
diff --git a/drivers/platform/chrome/wilco_ec_sysfs.c b/drivers/platform/chrome/wilco_ec_sysfs.c
index f9ae6cef6169..eeebd4ba4a39 100644
--- a/drivers/platform/chrome/wilco_ec_sysfs.c
+++ b/drivers/platform/chrome/wilco_ec_sysfs.c
@@ -23,6 +23,126 @@
 #define EC_INFO_SIZE			 9
 #define EC_COMMAND_STEALTH_MODE		0xfc
 
+#ifdef CONFIG_WILCO_EC_SYSFS_RAW
+
+/* Raw data buffer, large enough to hold extended responses */
+static size_t raw_response_size;
+static u8 raw_response_data[EC_MAILBOX_DATA_SIZE_EXTENDED];
+
+/*
+ * raw: write a raw command and return the result
+ *
+ * Bytes 0-1 indicate the message type:
+ *  00 F0 = Execute Legacy Command
+ *  00 F2 = Read/Write NVRAM Property
+ * Byte 2 provides the command code
+ * Bytes 3+ consist of the data passed in the request
+ *
+ * example: read the EC info type 1:
+ *  # echo 00 f0 38 00 01 00 > raw
+ *  # cat raw
+ *  00 38 31 34 34 66 00 00 00 00 00 00 00 00 00 00 00...
+ */
+
+static ssize_t raw_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
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
+static ssize_t raw_store(struct device *dev,
+			 struct device_attribute *attr,
+			 const char *buf, size_t count)
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
+		/* Copy to a new nul-terminated string */
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
+	memset(raw_response_data, 0, EC_MAILBOX_DATA_SIZE_EXTENDED);
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
+#endif /* CONFIG_WILCO_EC_SYSFS_RAW */
+
 struct ec_info {
 	u8 index;
 	const char *label;
@@ -102,10 +222,16 @@ static ssize_t stealth_mode_store(struct device *dev,
 
 static DEVICE_ATTR_RO(version);
 static DEVICE_ATTR_WO(stealth_mode);
+#ifdef CONFIG_WILCO_EC_SYSFS_RAW
+static DEVICE_ATTR_RW(raw);
+#endif
 
 static struct attribute *wilco_ec_attrs[] = {
 	&dev_attr_version.attr,
 	&dev_attr_stealth_mode.attr,
+#ifdef CONFIG_WILCO_EC_SYSFS_RAW
+	&dev_attr_raw.attr,
+#endif
 	NULL
 };
 ATTRIBUTE_GROUPS(wilco_ec);
-- 
2.20.0.405.gbc1bbc6f85-goog

