Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45764C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29882146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OXmBKvt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfBHBYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:24:15 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35032 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbfBHBYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:24:10 -0500
Received: by mail-it1-f193.google.com with SMTP id r6so5212809itk.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 17:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vmfgm8mhUsljcjRir7ZmQK9ZozYLHytIzzC/VEubSlk=;
        b=OXmBKvt9nrhh7L409e7goMhLQSkKIIKwOcH0b9Fucsk0Wp5o3pCutka7nAzxJUvke5
         0EZnPdErmwmOWRnzW4Dga+vZEwyAGOnFanStS/9mdlE9AYbFRiO0Zhp6SQgF467E/C/a
         RmcocFygg1wORc30zf/eAeIgK5UBevKXdcdMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vmfgm8mhUsljcjRir7ZmQK9ZozYLHytIzzC/VEubSlk=;
        b=KnmImKQHxNKPe6dPlwSUmzcCnWx8NvG36mNsiAqvfEM4GzAm00ot+C4GakYVpHz5qh
         0xJ+HSUzFnePHoIlH5D0xmd3M9PMPVSHm0ySuMbrOVOYFMoJOXL0Mv8VRFlZ0IfsQ6dD
         gj2faPbXJhoy+aEyJxy90lvel3jHAhsR/2S9FfKSePKC8vcasuqqdDE7PImobZxnMf86
         OlCcGgmUNvcjXOCJSrQWllbn6ePiAJdQSSi73Ad4Ouno+rhhFTg6+MQ+jhV5sgmqxIlo
         aklb0ctpH+j4SoG0jiX1LN5QvOa/BzJLpgfFrfgEdnoUxS5s23b7nNFfFT9mndl199Sv
         6dCw==
X-Gm-Message-State: AHQUAuYoDvUao6pDRvO8HwwfMTDWPLqZSyw/rFDFAqV16yE+tearmz34
        pibG+FbYQEFnup+pMjRd27YvxTpsXN4=
X-Google-Smtp-Source: AHgI3Ibim3mwSiVnLfafe9rwcVU6BCY3QcOoR7RCpjsgHJh6WNamje/nQz18kBiDDC3XrLJHPz0vPw==
X-Received: by 2002:a24:1947:: with SMTP id b68mr6850309itb.70.1549589048237;
        Thu, 07 Feb 2019 17:24:08 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id c133sm519969itc.24.2019.02.07.17.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 17:24:07 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     alexandre.belloni@bootlin.com, eballetbo@gmail.com,
        sjg@chromium.org, dmitry.torokhov@gmail.com, groeck@chromium.org,
        dlaurie@chromium.org, Nick Crews <ncrews@chromium.org>,
        Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH v6 3/4] platform/chrome: Add support for raw commands in debugfs
Date:   Thu,  7 Feb 2019 18:23:11 -0700
Message-Id: <20190208012312.105259-4-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
In-Reply-To: <20190208012312.105259-1-ncrews@chromium.org>
References: <20190208012312.105259-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debugfs attribute that allows sending raw commands to the EC.
This is useful for development and debug but should not be enabled
in a production environment.

To test:
Get the EC firmware build date
First send the request command
> echo 00 f0 38 00 03 00 > raw
Then read the result. "12/21/18" is in the middle of the response
> cat raw
00 31 32 2f 32 31 2f 31 38 00 00 0f 01 00 01 00  .12/21/18.......

Get the EC firmware build date
First send the request command
> echo 00 f0 38 00 03 00 > raw
Then read the result. "12/21/18" is in the middle of the response
> cat raw
00 31 32 2f 32 31 2f 31 38 00 00 0f 01 00 01 00  .12/21/18.......

Signed-off-by: Duncan Laurie <dlaurie@google.com>
Signed-off-by: Nick Crews <ncrews@chromium.org>
---

Changes in v6:
- s/4.19/5.1/ for kernel version in documentation, since that is
  the version this patch should land in.
- Instead of requiring at least 3 bytes for msg type and command,
  now just require two for msg type. We can skip the command.
- Fixed error checking in probe() so that errors are hidden, without
  causing more errors or unextpected behavior.
- Some comment polishing.
- In the core, actually unregister the debugfs child platform_device

Changes in v5:
- core now always continues regardless of debugfs failure
- mv documentation to file header
- Check for OOM
- rm unneeded check if debug_info is allocqated
- rm bogus comment
- add space around "+"
- rm WILCO_EC_FLAG_EXTENDED_DATA, that is already obvious from
  wilco_ec_message.response_size

Changes in v4:
- Change debugfs driver to be a separate module
- Change me email to @chromium.org from @google.com
- Change CONFIG_WILCO_EC_SYSFS_RAW to
  CONFIG_WILCO_EC_DEBUGFS

Changes in v3:
- Move the attribute to the debugfs system
- Move the implementation to debugfs.c
- Improve the raw hex parsing
- Encapsulate global variables in one object
- Add safety check when passing less than 3 bytes
- Move documentation to debugfs-wilco-ec

Changes in v2:
- Add sysfs documentation
- rm duplicate EC_MAILBOX_DATA_SIZE defs
- Make docstrings follow kernel style
- Fix tags in commit msg
- Move Kconfig to subdirectory
- Reading raw now includes ASCII translation

 Documentation/ABI/testing/debugfs-wilco-ec |  23 ++
 drivers/platform/chrome/wilco_ec/Kconfig   |  10 +
 drivers/platform/chrome/wilco_ec/Makefile  |   2 +
 drivers/platform/chrome/wilco_ec/core.c    |  14 ++
 drivers/platform/chrome/wilco_ec/debugfs.c | 238 +++++++++++++++++++++
 include/linux/platform_data/wilco-ec.h     |   2 +
 6 files changed, 289 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-wilco-ec
 create mode 100644 drivers/platform/chrome/wilco_ec/debugfs.c

diff --git a/Documentation/ABI/testing/debugfs-wilco-ec b/Documentation/ABI/testing/debugfs-wilco-ec
new file mode 100644
index 000000000000..f814f112e213
--- /dev/null
+++ b/Documentation/ABI/testing/debugfs-wilco-ec
@@ -0,0 +1,23 @@
+What:		/sys/kernel/debug/wilco_ec/raw
+Date:		January 2019
+KernelVersion:	5.1
+Description:
+		Write and read raw mailbox commands to the EC.
+
+		For writing:
+		Bytes 0-1 indicate the message type:
+			00 F0 = Execute Legacy Command
+			00 F2 = Read/Write NVRAM Property
+		Byte 2 provides the command code
+		Bytes 3+ consist of the data passed in the request
+
+		At least three bytes are required, for the msg type and command,
+		with additional bytes optional for additional data.
+
+		Example:
+		// Request EC info type 3 (EC firmware build date)
+		$ echo 00 f0 38 00 03 00 > raw
+		// View the result. The decoded ASCII result "12/21/18" is
+		// included after the raw hex.
+		$ cat raw
+		00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  .12/21/18.8...
diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index 20945a301ec6..fb6d9ff33e41 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -9,3 +9,13 @@ config WILCO_EC
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called wilco_ec.
+
+config WILCO_EC_DEBUGFS
+	tristate "Enable raw access to EC via debugfs"
+	depends on WILCO_EC
+	help
+	  If you say Y here, you get support for sending raw commands to
+	  the Wilco EC via debugfs.  These commands do not do any byte
+	  manipulation and allow for testing arbitrary commands.  This
+	  interface is intended for debug only and will not be present
+	  on production devices.
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 03b32301dc61..063e7fb4ea17 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -2,3 +2,5 @@
 
 wilco_ec-objs				:= core.o mailbox.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
+wilco_ec_debugfs-objs			:= debugfs.o
+obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 20ecc580d108..ae86cae216fd 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -69,11 +69,25 @@ static int wilco_ec_probe(struct platform_device *pdev)
 	cros_ec_lpc_mec_init(ec->io_packet->start,
 			     ec->io_packet->start + EC_MAILBOX_DATA_SIZE);
 
+	/*
+	 * Register a debugfs platform device that will get picked up by the
+	 * debugfs driver. Ignore failure.
+	 */
+	ec->debugfs_pdev = platform_device_register_data(dev,
+							 "wilco-ec-debugfs",
+							 PLATFORM_DEVID_AUTO,
+							 NULL, 0);
+
 	return 0;
 }
 
 static int wilco_ec_remove(struct platform_device *pdev)
 {
+	struct wilco_ec_device *ec = platform_get_drvdata(pdev);
+
+	if (ec->debugfs_pdev)
+		platform_device_unregister(ec->debugfs_pdev);
+
 	/* Teardown cros_ec interface */
 	cros_ec_lpc_mec_destroy();
 
diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
new file mode 100644
index 000000000000..8b324bfe42cd
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * debugfs attributes for Wilco EC
+ *
+ * Copyright 2019 Google LLC
+ *
+ * There is only one attribute used for debugging, called raw.
+ * You can write a hexadecimal sentence to raw, and that series of bytes
+ * will be sent to the EC. Then, you can read the bytes of response
+ * by reading from raw.
+ *
+ * For writing:
+ * Bytes 0-1 indicate the message type:
+ *         00 F0 = Execute Legacy Command
+ *         00 F2 = Read/Write NVRAM Property
+ * Byte 2 provides the command code
+ * Bytes 3+ consist of the data passed in the request
+ *
+ * When referencing the EC interface spec, byte 2 corresponds to MBOX[0],
+ * byte 3 corresponds to MBOX[1], etc.
+ *
+ * At least three bytes are required, for the msg type and command,
+ * with additional bytes optional for additional data.
+ *
+ * Example:
+ * // Request EC info type 3 (EC firmware build date)
+ * $ echo 00 f0 38 00 03 00 > raw
+ * // View the result. The decoded ASCII result "12/21/18" is
+ * // included after the raw hex.
+ * $ cat raw
+ * 00 31 32 2f 32 31 2f 31 38 00 38 00 01 00 2f 00  .12/21/18.8...
+ */
+
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/platform_data/wilco-ec.h>
+#include <linux/platform_device.h>
+
+#define DRV_NAME "wilco-ec-debugfs"
+
+/* The 256 raw bytes will take up more space when represented as a hex string */
+#define FORMATTED_BUFFER_SIZE (EC_MAILBOX_DATA_SIZE_EXTENDED * 4)
+
+struct wilco_ec_debugfs {
+	struct wilco_ec_device *ec;
+	struct dentry *dir;
+	size_t response_size;
+	u8 raw_data[EC_MAILBOX_DATA_SIZE_EXTENDED];
+	u8 formatted_data[FORMATTED_BUFFER_SIZE];
+};
+static struct wilco_ec_debugfs *debug_info;
+
+/**
+ * parse_hex_sentence() - Convert a ascii hex representation into byte array.
+ * @in: Input buffer of ascii.
+ * @isize: Length of input buffer.
+ * @out: Output buffer.
+ * @osize: Length of output buffer, e.g. max number of bytes to parse.
+ *
+ * An valid input is a series of ascii hexadecimal numbers, separated by spaces.
+ * An example valid input is
+ * "   00 f2 0    000076 6 0  ff"
+ *
+ * If an individual "word" within the hex sentence is longer than MAX_WORD_SIZE,
+ * then the sentence is illegal, and parsing will fail.
+ *
+ * Return: Number of bytes parsed, or negative error code on failure.
+ */
+static int parse_hex_sentence(const char *in, int isize, u8 *out, int osize)
+{
+	int n_parsed = 0;
+	int word_start = 0;
+	int word_end;
+	int word_len;
+	/* Temp buffer for holding a "word" of chars that represents one byte */
+	const static int MAX_WORD_SIZE = 16;
+	char tmp[MAX_WORD_SIZE + 1];
+	u8 byte;
+
+	while (word_start < isize && n_parsed < osize) {
+		/* Find the start of the next word */
+		while (word_start < isize && isspace(in[word_start]))
+			word_start++;
+		 /* reached the end of the input before next word? */
+		if (word_start >= isize)
+			break;
+
+		/* Find the end of this word */
+		word_end = word_start;
+		while (word_end < isize && !isspace(in[word_end]))
+			word_end++;
+
+		/* Copy to a tmp NULL terminated string */
+		word_len = word_end - word_start;
+		if (word_len > MAX_WORD_SIZE)
+			return -EINVAL;
+		memcpy(tmp, in + word_start, word_len);
+		tmp[word_len] = '\0';
+
+		/*
+		 * Convert from hex string, place in output. If fails to parse,
+		 * just return -EINVAL because specific error code is only
+		 * relevant for this one word, returning it would be confusing.
+		 */
+		if (kstrtou8(tmp, 16, &byte))
+			return -EINVAL;
+		out[n_parsed++] = byte;
+
+		word_start = word_end;
+	}
+	return n_parsed;
+}
+
+/* The message type takes up two bytes*/
+#define TYPE_AND_DATA_SIZE ((EC_MAILBOX_DATA_SIZE) + 2)
+
+static ssize_t raw_write(struct file *file, const char __user *user_buf,
+			 size_t count, loff_t *ppos)
+{
+	char *buf = debug_info->formatted_data;
+	struct wilco_ec_message msg;
+	u8 request_data[TYPE_AND_DATA_SIZE];
+	ssize_t kcount;
+	int ret;
+
+	if (count > FORMATTED_BUFFER_SIZE)
+		return -EINVAL;
+
+	kcount = simple_write_to_buffer(buf, FORMATTED_BUFFER_SIZE, ppos,
+					user_buf, count);
+	if (kcount < 0)
+		return kcount;
+
+	ret = parse_hex_sentence(buf, kcount, request_data, TYPE_AND_DATA_SIZE);
+	if (ret < 0)
+		return ret;
+	/* Need at least two bytes for message type */
+	if (ret < 2)
+		return -EINVAL;
+
+	/* Clear response data buffer */
+	memset(debug_info->raw_data, '\0', EC_MAILBOX_DATA_SIZE_EXTENDED);
+
+	msg.type = request_data[0] << 8 | request_data[1];
+	msg.flags = WILCO_EC_FLAG_RAW;
+	msg.command = ret > 2 ? request_data[2] : 0;
+	msg.request_data = ret > 3 ? request_data + 3 : 0;
+	msg.request_size = ret - 3;
+	msg.response_data = debug_info->raw_data;
+	msg.response_size = EC_MAILBOX_DATA_SIZE;
+
+	/* Telemetry commands use extended response data */
+	if (msg.type == WILCO_EC_MSG_TELEMETRY_LONG) {
+		msg.flags |= WILCO_EC_FLAG_EXTENDED_DATA;
+		msg.response_size = EC_MAILBOX_DATA_SIZE_EXTENDED;
+	}
+
+	ret = wilco_ec_mailbox(debug_info->ec, &msg);
+	if (ret < 0)
+		return ret;
+	debug_info->response_size = ret;
+
+	return count;
+}
+
+static ssize_t raw_read(struct file *file, char __user *user_buf, size_t count,
+			loff_t *ppos)
+{
+	int fmt_len = 0;
+
+	if (debug_info->response_size) {
+		fmt_len = hex_dump_to_buffer(debug_info->raw_data,
+					     debug_info->response_size,
+					     16, 1, debug_info->formatted_data,
+					     FORMATTED_BUFFER_SIZE, true);
+		/* Only return response the first time it is read */
+		debug_info->response_size = 0;
+	}
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       debug_info->formatted_data, fmt_len);
+}
+
+static const struct file_operations fops_raw = {
+	.owner = THIS_MODULE,
+	.read = raw_read,
+	.write = raw_write,
+	.llseek = no_llseek,
+};
+
+/**
+ * wilco_ec_debugfs_probe() - Create the debugfs node
+ * @pdev: The platform device, probably created in core.c
+ *
+ * Try to create a debugfs node. If it fails, then we don't want to change
+ * behavior at all, this is for debugging after all. Just fail silently.
+ *
+ * Return: 0 always.
+ */
+static int wilco_ec_debugfs_probe(struct platform_device *pdev)
+{
+	struct wilco_ec_device *ec = dev_get_drvdata(pdev->dev.parent);
+
+	debug_info = devm_kzalloc(&pdev->dev, sizeof(*debug_info), GFP_KERNEL);
+	if (!debug_info)
+		return 0;
+	debug_info->ec = ec;
+	debug_info->dir = debugfs_create_dir("wilco_ec", NULL);
+	if (!debug_info->dir)
+		return 0;
+	debugfs_create_file("raw", 0644, debug_info->dir, NULL, &fops_raw);
+
+	return 0;
+}
+
+static int wilco_ec_debugfs_remove(struct platform_device *pdev)
+{
+	debugfs_remove_recursive(debug_info->dir);
+
+	return 0;
+}
+
+static struct platform_driver wilco_ec_debugfs_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.probe = wilco_ec_debugfs_probe,
+	.remove = wilco_ec_debugfs_remove,
+};
+
+module_platform_driver(wilco_ec_debugfs_driver);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Wilco EC debugfs driver");
diff --git a/include/linux/platform_data/wilco-ec.h b/include/linux/platform_data/wilco-ec.h
index 0feb4b520a54..5344975afa1a 100644
--- a/include/linux/platform_data/wilco-ec.h
+++ b/include/linux/platform_data/wilco-ec.h
@@ -34,6 +34,7 @@
  * @data_buffer: Buffer used for EC communication.  The same buffer
  *               is used to hold the request and the response.
  * @data_size: Size of the data buffer used for EC communication.
+ * @debugfs_pdev: The child platform_device used by the debugfs sub-driver.
  */
 struct wilco_ec_device {
 	struct device *dev;
@@ -43,6 +44,7 @@ struct wilco_ec_device {
 	struct resource *io_packet;
 	void *data_buffer;
 	size_t data_size;
+	struct platform_device *debugfs_pdev;
 };
 
 /**
-- 
2.20.1.611.gfbb209baf1-goog

