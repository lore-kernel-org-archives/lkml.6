Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F437C31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1729F2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KBNxFH2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfAUHTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:19:08 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46981 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbfAUHTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:19:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so9352186ply.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QYGFEnvjFQAMrjPLkNAED/R+KCNaZk6NFcNF4N4LDfM=;
        b=KBNxFH2+rGwGuyq7CY8tHConLp8G/PYkA/vYf/PpzxXKcG80ygDlA57J2Ty0zetMZy
         iCe/BaxZqlUCuwA+QVLDS+KPIfrQ6muBLnifJmK2PTgpVYjhrWaX5LbwgptCF/9/mTrb
         BL8EA06sPhEbWAFfoTVhrR7aH4StvK/fj5BdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QYGFEnvjFQAMrjPLkNAED/R+KCNaZk6NFcNF4N4LDfM=;
        b=Aeff+Bs8rigWtuPT8WHSVLr+dhR1ClYrOOSg4L5GjTWxxTCss+Y6x7Oe0LvQyW9KaX
         N9bZfPwqhg6htvgOr71M95jHPmmn2hds5Hj1OUuqZ1xE7TUU9H58ihIirEO60zedXueX
         lwOIb1SVs8054R3IrEGn9wRUEsGtdizvKMQv0cLmla5cpeXUrvvY+hK079RoQTA550bi
         e08euFmhANcKl6mzCow4kvYYWEKDnYKOv66FkBn3mi2hC02JtT5yrABu4jUlNj+Ey2n8
         NISR8SlxKWYViKsESYpGUn6JUp4TTFzGWKoZhlCHmupSu+vqj9Ggt7CReqV7LGLATgFr
         PJ8A==
X-Gm-Message-State: AJcUukcI9031SAv8GP4V8HW4WmNh00Bj4J+csHG3oM3b3QKEkzI8mfr9
        D/TPzGp1OMzK180o069pKKGE5g==
X-Google-Smtp-Source: ALg8bN7NBB9TzsbQ9tgnF6MMNFTVi/bRwwREXz+NLHA9nMKUrzNF3jJTy7KeOFGpg4Nh1OgjKiWIOg==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31mr29215773plz.75.1548055144635;
        Sun, 20 Jan 2019 23:19:04 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id v15sm14941843pfn.94.2019.01.20.23.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 23:19:04 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v3 4/5] mfd: add EC host command support using rpmsg.
Date:   Mon, 21 Jan 2019 15:18:32 +0800
Message-Id: <20190121071833.43443-5-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190121071833.43443-1-pihsun@chromium.org>
References: <20190121071833.43443-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EC host command support through rpmsg.

Cc: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
Changes from v2:
 - Wait for ipi ack instead of depends on the behavior in mtk-rpmsg.

Changes from v1:
 - Code format fix based on feedback for cros_ec_rpmsg.c.
 - Extract feature detection for SCP into separate patch (Patch 6).
---
 drivers/platform/chrome/Kconfig         |   8 +
 drivers/platform/chrome/Makefile        |   1 +
 drivers/platform/chrome/cros_ec_rpmsg.c | 186 ++++++++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 16b1615958aa2d..e3f63f3d67711b 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -72,6 +72,14 @@ config CROS_EC_SPI
 	  response time cannot be guaranteed, we support ignoring
 	  'pre-amble' bytes before the response actually starts.
 
+config CROS_EC_RPMSG
+	tristate "ChromeOS Embedded Controller (rpmsg)"
+	depends on MFD_CROS_EC && RPMSG && OF
+	help
+	  If you say Y here, you get support for talking to the ChromeOS EC
+	  through rpmsg. This uses a simple byte-level protocol with a
+	  checksum.
+
 config CROS_EC_LPC
         tristate "ChromeOS Embedded Controller (LPC)"
         depends on MFD_CROS_EC && ACPI && (X86 || COMPILE_TEST)
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index cd591bf872bbe9..3e3190af2b50f4 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -8,6 +8,7 @@ cros_ec_ctl-objs			:= cros_ec_sysfs.o cros_ec_lightbar.o \
 obj-$(CONFIG_CROS_EC_CTL)		+= cros_ec_ctl.o
 obj-$(CONFIG_CROS_EC_I2C)		+= cros_ec_i2c.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
+obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_reg.o
 cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC)	+= cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
new file mode 100644
index 00000000000000..5354e56b362a0f
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2018 Google LLC.
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/cros_ec.h>
+#include <linux/mfd/cros_ec_commands.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rpmsg.h>
+#include <linux/slab.h>
+
+#define EC_MSG_TIMEOUT_MS 200
+
+struct cros_ec_rpmsg {
+	struct rpmsg_device *rpdev;
+
+	wait_queue_head_t xfer_ack_wq;
+	bool xfer_acked;
+};
+
+/**
+ * cros_ec_cmd_xfer_rpmsg - Transfer a message over rpmsg and receive the reply
+ *
+ * This is only used for old EC proto version, and is not supported for this
+ * driver.
+ *
+ * @ec_dev: ChromeOS EC device
+ * @ec_msg: Message to transfer
+ */
+static int cros_ec_cmd_xfer_rpmsg(struct cros_ec_device *ec_dev,
+				  struct cros_ec_command *ec_msg)
+{
+	return -EINVAL;
+}
+
+/**
+ * cros_ec_pkt_xfer_rpmsg - Transfer a packet over rpmsg and receive the reply
+ *
+ * @ec_dev: ChromeOS EC device
+ * @ec_msg: Message to transfer
+ */
+static int cros_ec_pkt_xfer_rpmsg(struct cros_ec_device *ec_dev,
+				  struct cros_ec_command *ec_msg)
+{
+	struct ec_host_response *response;
+	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
+	struct rpmsg_device *rpdev = ec_rpmsg->rpdev;
+	int len;
+	u8 sum;
+	int ret;
+	int i;
+	unsigned long timeout;
+
+	ec_msg->result = 0;
+	len = cros_ec_prepare_tx(ec_dev, ec_msg);
+	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
+
+	ec_rpmsg->xfer_acked = false;
+	ret = rpmsg_send(rpdev->ept, ec_dev->dout, len);
+	if (ret) {
+		dev_err(ec_dev->dev, "rpmsg send failed\n");
+		return ret;
+	}
+
+	timeout = msecs_to_jiffies(EC_MSG_TIMEOUT_MS);
+	ret = wait_event_timeout(ec_rpmsg->xfer_ack_wq, ec_rpmsg->xfer_acked,
+				 timeout);
+	if (!ret) {
+		dev_err(ec_dev->dev, "rpmsg send timeout\n");
+		return -EIO;
+	}
+
+	/* check response error code */
+	response = (struct ec_host_response *)ec_dev->din;
+	ec_msg->result = response->result;
+
+	ret = cros_ec_check_result(ec_dev, ec_msg);
+	if (ret)
+		goto exit;
+
+	if (response->data_len > ec_msg->insize) {
+		dev_err(ec_dev->dev, "packet too long (%d bytes, expected %d)",
+			response->data_len, ec_msg->insize);
+		ret = -EMSGSIZE;
+		goto exit;
+	}
+
+	/* copy response packet payload and compute checksum */
+	memcpy(ec_msg->data, ec_dev->din + sizeof(*response),
+	       response->data_len);
+
+	sum = 0;
+	for (i = 0; i < sizeof(*response) + response->data_len; i++)
+		sum += ec_dev->din[i];
+
+	if (sum) {
+		dev_err(ec_dev->dev, "bad packet checksum, calculated %x\n",
+			sum);
+		ret = -EBADMSG;
+		goto exit;
+	}
+
+	ret = response->data_len;
+exit:
+	if (ec_msg->command == EC_CMD_REBOOT_EC)
+		msleep(EC_REBOOT_DELAY_MS);
+
+	return ret;
+}
+
+static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
+				  int len, void *priv, u32 src)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(&rpdev->dev);
+	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
+
+	if (len > ec_dev->din_size) {
+		dev_warn(ec_dev->dev,
+			 "ipi received length %d > din_size, truncating", len);
+		len = ec_dev->din_size;
+	}
+
+	memcpy(ec_dev->din, data, len);
+	ec_rpmsg->xfer_acked = true;
+	wake_up(&ec_rpmsg->xfer_ack_wq);
+
+	return 0;
+}
+
+static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct device *dev = &rpdev->dev;
+	struct cros_ec_device *ec_dev;
+	struct cros_ec_rpmsg *ec_rpmsg;
+	int ret;
+
+	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
+	if (!ec_dev)
+		return -ENOMEM;
+
+	ec_rpmsg = devm_kzalloc(dev, sizeof(*ec_rpmsg), GFP_KERNEL);
+	if (!ec_rpmsg)
+		return -ENOMEM;
+
+	ec_dev->dev = dev;
+	ec_dev->priv = ec_rpmsg;
+	ec_dev->cmd_xfer = cros_ec_cmd_xfer_rpmsg;
+	ec_dev->pkt_xfer = cros_ec_pkt_xfer_rpmsg;
+	ec_dev->phys_name = dev_name(&rpdev->dev);
+	ec_dev->din_size = sizeof(struct ec_host_response) +
+			   sizeof(struct ec_response_get_protocol_info);
+	ec_dev->dout_size = sizeof(struct ec_host_request);
+	dev_set_drvdata(dev, ec_dev);
+
+	ec_rpmsg->rpdev = rpdev;
+	init_waitqueue_head(&ec_rpmsg->xfer_ack_wq);
+
+	ret = cros_ec_register(ec_dev);
+	if (ret) {
+		dev_err(dev, "cannot register EC\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct rpmsg_device_id cros_ec_rpmsg_device_id[] = {
+	{ .name = "cros-ec-rpmsg", },
+	{ }
+};
+MODULE_DEVICE_TABLE(rpmsg, cros_ec_rpmsg_device_id);
+
+static struct rpmsg_driver cros_ec_driver_rpmsg = {
+	.drv.name       = KBUILD_MODNAME,
+	.id_table       = cros_ec_rpmsg_device_id,
+	.probe		= cros_ec_rpmsg_probe,
+	.callback	= cros_ec_rpmsg_callback,
+};
+
+module_rpmsg_driver(cros_ec_driver_rpmsg);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ChromeOS EC multi function device (rpmsg)");
-- 
2.20.1.321.g9e740568ce-goog

