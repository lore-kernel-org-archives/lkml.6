Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7469BC43614
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34378217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QzVod8Y5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeLZHyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 02:54:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40963 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeLZHyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 02:54:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so7574018pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=de9pAuJXTk+5HxjiuJcx0vVB6qsUL6K6wkIiqDXHsGw=;
        b=QzVod8Y5UuvBBxz/V6pyf/J0pbQExBGxgUGLYEvaP1uldiTE1JqRz03gUPQjoDzWeF
         h6NURpxGir3GlY5NKGosmmGmona05f8XqzdBMN0VBopNW51gAylLouW8ZnvBMz1NTrIO
         t7dICKuFEhkYM0J+TU/H+AHH0DwCUdIEm+tSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=de9pAuJXTk+5HxjiuJcx0vVB6qsUL6K6wkIiqDXHsGw=;
        b=HEtI5FBZSHr23bDzr01h+eKE0MKUbRdrU0hu1sdZzESBeaiazoZvWVQCkkEUKdNraw
         ebQ4WmeSwb1+nYHUPk9ah2NAugFHbEJP/V0ITjXceGyiEajQ00GqUa6KofaiUF26xLMM
         +Qg37Q6Ot7bK85ZA3/r04aa5H7BNtIvr07XVp3QjZFxlrIKt/q+H7nlx1nmAzIH8ZnmU
         WSRG12+kdWT07a0uWcr4tsz7udUCqdDiH+ol6aXJTe6APODr325a9SSfAbLurQDqWkyc
         misBbsAh+qddFmWe3iK4aJpwIZbFTXMXrGFauEllgdxwxqtvmloM/vCUfl9CjEXuF/Rp
         q1/g==
X-Gm-Message-State: AA+aEWZRrxkpYtH49Ae70nsiulLbl4d5WjtVvve2OLrYzxz5qvj140BU
        /20BQSTBYGB7kU3+ohaSAuznvg==
X-Google-Smtp-Source: AFSGD/VNPXhbUu04KKUHwpZ8aj566zxbdHHZcoEAhpeGbX+9DtJisk4Ht64Hm0bj1HqkH8hSzCAK8A==
X-Received: by 2002:a62:5716:: with SMTP id l22mr19692830pfb.16.1545810860409;
        Tue, 25 Dec 2018 23:54:20 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 84sm107392395pfa.115.2018.12.25.23.54.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 23:54:19 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC,5/5] mfd: cros_ec: add EC host command support using rpmsg.
Date:   Wed, 26 Dec 2018 15:53:13 +0800
Message-Id: <20181226075330.82462-6-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181226075330.82462-1-pihsun@chromium.org>
References: <20181226075330.82462-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EC host command support through rpmsg.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/mfd/cros_ec_dev.c               |   9 ++
 drivers/platform/chrome/Kconfig         |   8 ++
 drivers/platform/chrome/Makefile        |   1 +
 drivers/platform/chrome/cros_ec_rpmsg.c | 164 ++++++++++++++++++++++++
 include/linux/mfd/cros_ec.h             |   1 +
 include/linux/mfd/cros_ec_commands.h    |   2 +
 6 files changed, 185 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_rpmsg.c

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 2d0fee488c5aa8..67983853413d07 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -414,6 +414,15 @@ static int ec_device_probe(struct platform_device *pdev)
 	device_initialize(&ec->class_dev);
 	cdev_init(&ec->cdev, &fops);
 
+	if (cros_ec_check_features(ec, EC_FEATURE_SCP)) {
+		dev_info(dev, "SCP detected.\n");
+		/*
+		 * Help userspace differentiating ECs from SCP,
+		 * regardless of the probing order.
+		 */
+		ec_platform->ec_name = CROS_EC_DEV_SCP_NAME;
+	}
+
 	/*
 	 * Add the class device
 	 * Link to the character device for creating the /dev entry
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 16b1615958aa2d..b03d68eb732177 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -72,6 +72,14 @@ config CROS_EC_SPI
 	  response time cannot be guaranteed, we support ignoring
 	  'pre-amble' bytes before the response actually starts.
 
+config CROS_EC_RPMSG
+	tristate "ChromeOS Embedded Controller (rpmsg)"
+	depends on MFD_CROS_EC && RPMSG
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
index 00000000000000..f123ca6d1c029c
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_rpmsg.c
@@ -0,0 +1,164 @@
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
+	struct rpmsg_device *rpdev = ec_dev->priv;
+	int len;
+	u8 sum;
+	int ret;
+	int i;
+
+	ec_msg->result = 0;
+	len = cros_ec_prepare_tx(ec_dev, ec_msg);
+	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
+
+	// TODO: This currently relies on that mtk_rpmsg send actually blocks
+	// until ack. Should do the wait here instead.
+	ret = rpmsg_send(rpdev->ept, ec_dev->dout, len);
+
+	if (ret) {
+		dev_err(ec_dev->dev, "rpmsg send failed\n");
+		return ret;
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
+
+	if (len > ec_dev->din_size) {
+		dev_warn(ec_dev->dev,
+			 "ipi received length %d > din_size, truncating", len);
+		len = ec_dev->din_size;
+	}
+
+	memcpy(ec_dev->din, data, len);
+
+	return 0;
+}
+
+static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct device *dev = &rpdev->dev;
+
+	struct cros_ec_device *ec_dev;
+	int ret;
+
+	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
+	if (!ec_dev)
+		return -ENOMEM;
+
+	ec_dev->dev = dev;
+	ec_dev->priv = rpdev;
+	ec_dev->cmd_xfer = cros_ec_cmd_xfer_rpmsg;
+	ec_dev->pkt_xfer = cros_ec_pkt_xfer_rpmsg;
+	ec_dev->phys_name = dev_name(&rpdev->dev);
+	ec_dev->din_size = sizeof(struct ec_host_response) +
+			   sizeof(struct ec_response_get_protocol_info);
+	ec_dev->dout_size = sizeof(struct ec_host_request);
+	dev_set_drvdata(dev, ec_dev);
+
+	ret = cros_ec_register(ec_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void cros_ec_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(&rpdev->dev);
+
+	cros_ec_remove(ec_dev);
+}
+
+static const struct rpmsg_device_id cros_ec_rpmsg_device_id[] = {
+	{ .name = "cros-ec-rpmsg", },
+	{ /* sentinel */ },
+};
+
+static struct rpmsg_driver cros_ec_driver_rpmsg = {
+	.drv.name       = KBUILD_MODNAME,
+	.id_table       = cros_ec_rpmsg_device_id,
+	.probe		= cros_ec_rpmsg_probe,
+	.remove		= cros_ec_rpmsg_remove,
+	.callback	= cros_ec_rpmsg_callback,
+};
+
+module_rpmsg_driver(cros_ec_driver_rpmsg);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ChromeOS EC multi function device (rpmsg)");
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index de8b588c8776da..fd297cf8f97295 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -24,6 +24,7 @@
 
 #define CROS_EC_DEV_NAME "cros_ec"
 #define CROS_EC_DEV_PD_NAME "cros_pd"
+#define CROS_EC_DEV_SCP_NAME "cros_scp"
 
 /*
  * The EC is unresponsive for a time after a reboot command.  Add a
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index fc91082d4c357b..3e5da6e93b2f42 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -856,6 +856,8 @@ enum ec_feature_code {
 	EC_FEATURE_RTC = 27,
 	/* EC supports CEC commands */
 	EC_FEATURE_CEC = 35,
+	/* The MCU exposes a SCP */
+	EC_FEATURE_SCP = 39,
 };
 
 #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
-- 
2.20.1.415.g653613c723-goog

