Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B301C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8538218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J1LXG/sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfAaJcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:32:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39143 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731267AbfAaJcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:32:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so1219321pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 01:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BakVyP3L/pLlOufG/DBli2IVC5MfnYy8IdEPPT2ki98=;
        b=J1LXG/sbD4fVUqOkOev+apV7oKclyTtt0L/VoirZEHXA+7ublxyH0bMOGT3zKof9FZ
         1liIKKuwSGCrXSPpzQ6sBAasaRLACIkadXNiDIYpcdWfOTvkkDgCYQxXtHlTNzkGrxnj
         xi4VJxiBD2nA9ozpdzz9yHec+Z47MUHkhg018=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BakVyP3L/pLlOufG/DBli2IVC5MfnYy8IdEPPT2ki98=;
        b=EpBfr/0caslSAzY9Q3XQcdLV9xo1b2KnAF9+3HJPfeILalRlaOWWuMJNKuERRCc62Y
         MPcT8tUI95D534mv3pc/Qn71mR3a5zgl/HWtJw26GRy/rZdQNq8Fw4o1iyj6HN1O6ZJt
         JxQaG4fiu9mbJetJeaK8LHPQGE7Qqf1H7MyJ/LswMsbUYTd6EZljSmygFarcJFKvUy9A
         ngDoRdQ8jW+rB9bpPGX9XRA4xEJK2VwDYUXczbsRNMxg6Z1qbhIjpvJs3oHl6qOiafSC
         W4e20NT8DCUs+mpe/NMwyCBq69nIHrODyMcgbewGcFtLPYlr3sNIbSvXnfWf7Ptskrb6
         ngFg==
X-Gm-Message-State: AJcUukfwXW/vCFiUL6JjNb5GyEpJ0MWjAeGtYZ7QSRDI3ZytszhvVElk
        zJF0ou8CCZK85izUSSABmMxdKg==
X-Google-Smtp-Source: ALg8bN7AMYQmUT9rvoi3+r+vkF8M/kWDZq+Ek9vPLakvqCGX2ebVPxjWtCFtftORthCAEy6qfkz3yQ==
X-Received: by 2002:a63:e101:: with SMTP id z1mr30938070pgh.310.1548927120366;
        Thu, 31 Jan 2019 01:32:00 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id w184sm4531197pgd.34.2019.01.31.01.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 01:31:59 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>, Erin Lo <erin.lo@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/6] mfd: add EC host command support using rpmsg.
Date:   Thu, 31 Jan 2019 17:31:29 +0800
Message-Id: <20190131093131.245531-5-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.611.gfbb209baf1-goog
In-Reply-To: <20190131093131.245531-1-pihsun@chromium.org>
References: <20190131093131.245531-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EC host command / host event support through rpmsg.

Cc: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
This patch depends on https://lore.kernel.org/patchwork/patch/1024376/

Changes from v3:
 - Add host event support by adding an extra bytes at the start of IPC
   message to indicate the type of the message (host event or host
   command), since there's no additional irq that can be used for host
   event.

Changes from v2:
 - Wait for ipi ack instead of depends on the behavior in mtk-rpmsg.

Changes from v1:
 - Code format fix based on feedback for cros_ec_rpmsg.c.
 - Extract feature detection for SCP into separate patch (Patch 6).
---
 drivers/platform/chrome/Kconfig         |   9 +
 drivers/platform/chrome/Makefile        |   1 +
 drivers/platform/chrome/cros_ec_rpmsg.c | 240 ++++++++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 16b1615958aa2d..f18b4586a7ad5d 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -72,6 +72,15 @@ config CROS_EC_SPI
 	  response time cannot be guaranteed, we support ignoring
 	  'pre-amble' bytes before the response actually starts.
 
+config CROS_EC_RPMSG
+	tristate "ChromeOS Embedded Controller (rpmsg)"
+	depends on MFD_CROS_EC && RPMSG && OF
+	help
+	  If you say Y here, you get support for talking to the ChromeOS EC
+	  through rpmsg. This uses a simple byte-level protocol with a
+	  checksum. Also since there's no addition EC-to-host interrupt, this
+	  use a byte in message to distinguish host event from host command.
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
index 00000000000000..51ba64305b487b
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -0,0 +1,240 @@
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
+#include <linux/workqueue.h>
+
+#define EC_MSG_TIMEOUT_MS 200
+#define HOST_COMMAND_MARK 1
+#define HOST_EVENT_MARK 2
+
+struct cros_ec_rpmsg_response {
+	uint8_t type;
+	uint8_t data[];
+};
+
+struct cros_ec_rpmsg {
+	struct rpmsg_device *rpdev;
+
+	wait_queue_head_t xfer_ack_wq;
+	bool xfer_acked;
+
+	struct work_struct host_event_work;
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
+static void
+cros_ec_rpmsg_host_event_function(struct work_struct *host_event_work)
+{
+	struct cros_ec_rpmsg *ec_rpmsg = container_of(
+		host_event_work, struct cros_ec_rpmsg, host_event_work);
+	struct cros_ec_device *ec_dev = dev_get_drvdata(&ec_rpmsg->rpdev->dev);
+	bool wake_event = true;
+	int ret;
+
+	ret = cros_ec_get_next_event(ec_dev, &wake_event);
+
+	/*
+	 * Signal only if wake host events or any interrupt if
+	 * cros_ec_get_next_event() returned an error (default value for
+	 * wake_event is true)
+	 */
+	if (wake_event && device_may_wakeup(ec_dev->dev))
+		pm_wakeup_event(ec_dev->dev, 0);
+
+	if (ret > 0)
+		blocking_notifier_call_chain(&ec_dev->event_notifier,
+					     0, ec_dev);
+}
+
+static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
+				  int len, void *priv, u32 src)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(&rpdev->dev);
+	struct cros_ec_rpmsg *ec_rpmsg = ec_dev->priv;
+	struct cros_ec_rpmsg_response *resp;
+
+	if (!len) {
+		dev_warn(ec_dev->dev, "rpmsg received empty response");
+		return -EINVAL;
+	}
+
+	resp = data;
+	len--;
+	if (resp->type == HOST_COMMAND_MARK) {
+		if (len > ec_dev->din_size) {
+			dev_warn(
+				ec_dev->dev,
+				"received length %d > din_size %d, truncating",
+				len, ec_dev->din_size);
+			len = ec_dev->din_size;
+		}
+
+		memcpy(ec_dev->din, resp->data, len);
+		ec_rpmsg->xfer_acked = true;
+		wake_up(&ec_rpmsg->xfer_ack_wq);
+	} else if (resp->type == HOST_EVENT_MARK) {
+		schedule_work(&ec_rpmsg->host_event_work);
+	} else {
+		dev_warn(ec_dev->dev, "rpmsg received invalid type = %d",
+			 resp->type);
+		return -EINVAL;
+	}
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
+	INIT_WORK(&ec_rpmsg->host_event_work,
+		  cros_ec_rpmsg_host_event_function);
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
2.20.1.611.gfbb209baf1-goog

