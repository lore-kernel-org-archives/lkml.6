Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D0AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B7B21934
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giO4e9e6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405502AbfBNGDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:03:11 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33263 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfBNGDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:03:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so2535663pfb.0;
        Wed, 13 Feb 2019 22:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fDGSKKjkgTqWZGlp2msjo61PAHm3xoZKlLK0LTss/Y4=;
        b=giO4e9e6B8l3SYVWbNSoIrzNryyIpUuzRPAUOivFxChVH/B9PkMWAijKnNQrmQnRAE
         BfeFBGOv7erdR/iVi0Fp+5ApGcmFc6snbRCpcFVF0cyX4/mVRC0+DFab1TQtMjwd4ptg
         7gFjlC0MlAm89pDiYRmzVw1AKc5oM3rm4ubORNkqSwP/0R787MJ89VpKpY1buw5gee/M
         XvmxTvMVAnPWKYFpw7iFJY7T9K6S7/TLrDMYlYPdkQUdQOOpmURa5vIiG4glm5uDHVWl
         O5bJAqAWMCo8L/vS/2c3vhziLeP5XNS2SD5p0Ta+ytAeiM8J9zAP17+4t26h9JiD+5It
         KxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fDGSKKjkgTqWZGlp2msjo61PAHm3xoZKlLK0LTss/Y4=;
        b=eh3givY3cJhtjv3NqTYW4Yq3CuHXy0/ixQ7kDXwwOQehFET7zDEvJtzNuIRrK/se4j
         +StJf4SSs+CcVB5ecybWeKfvHBFJrJfvRDfuBPn2KvI4p4fc4vx8LtKEmPuBwm8+qEoO
         QutIjCUZ7KnkHOZzhWYbeZ6kOhRSdvwlhma5rWDWucU02lsKIfv0fcpE40PHCLg90xj9
         T5qyT+JZQgOkDswHMEwwCbLT5JsxXAknJ32b5yjQL2LlPEAR/MUayE8cMoXBAdMO2w8+
         9dulirqEB87e/ZeHuGR3BTPMnKLIuWxztU7vkBxG66Bn04P32jlIgg7Ppiud4NHZdsFE
         1xyg==
X-Gm-Message-State: AHQUAubT+8u3aziYn/ubGhSLSQqJzu3QoMiqlemHGZWkLjlO07T512Tr
        RW8oaDe6PMdPrLLz3Ypufr0=
X-Google-Smtp-Source: AHgI3Ib3kHsSDlQfPwtnoYQzRGz5oqouU75KBVa9KHvktZEIfBEE1uqKxTBfXQP+sSvjp84WCEa+SQ==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr2193520pgh.164.1550124187251;
        Wed, 13 Feb 2019 22:03:07 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id c23sm1269211pgh.73.2019.02.13.22.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 22:03:06 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     rdunlap@infradead.org, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, ohad@wizery.com,
        bjorn.andersson@linaro.org, wendy.liang@xilinx.com,
        arnaud.pouliquen@st.com, kumar.gala@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guiding Li <liguiding@pinecone.net>
Subject: [PATCH V2 2/2] rpmsg: add syslog redirection driver
Date:   Thu, 14 Feb 2019 14:02:38 +0800
Message-Id: <1550124158-1111-2-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550124158-1111-1-git-send-email-xiaoxiang@xiaomi.com>
References: <1550124158-1111-1-git-send-email-xiaoxiang@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guiding Li <liguiding@pinecone.net>

This driver allows the remote processor to redirect the output of
syslog or printf into the kernel log, which is very useful to see
what happen in the remote side.

Signed-off-by: Guiding Li <liguiding@pinecone.net>
---
 drivers/rpmsg/Kconfig        |  12 ++++
 drivers/rpmsg/Makefile       |   1 +
 drivers/rpmsg/rpmsg_syslog.c | 163 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 drivers/rpmsg/rpmsg_syslog.c

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d0322b4..13ead55 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -15,6 +15,18 @@ config RPMSG_CHAR
 	  in /dev. They make it possible for user-space programs to send and
 	  receive rpmsg packets.
 
+config RPMSG_SYSLOG
+	tristate "RPMSG syslog redirection"
+	depends on RPMSG
+	help
+	  Say Y here to redirect the syslog/printf from remote processor into
+	  the kernel log which is very useful to see what happened in the remote
+	  side.
+
+	  If the remote processor hangs during bootup or panics during runtime,
+	  we can even cat /sys/kernel/debug/remoteproc/remoteprocX/trace0 to
+	  get the last log which hasn't been output yet.
+
 config RPMSG_QCOM_GLINK_NATIVE
 	tristate
 	select RPMSG
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index 9aa8595..bfd22df 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
 obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
+obj-$(CONFIG_RPMSG_SYSLOG)	+= rpmsg_syslog.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_NATIVE) += qcom_glink_native.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
diff --git a/drivers/rpmsg/rpmsg_syslog.c b/drivers/rpmsg/rpmsg_syslog.c
new file mode 100644
index 0000000..b7a0d27
--- /dev/null
+++ b/drivers/rpmsg/rpmsg_syslog.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Pinecone Inc.
+ *
+ * redirect syslog/printf from remote to the kernel.
+ */
+
+#include <linux/module.h>
+#include <linux/rpmsg.h>
+#include <linux/slab.h>
+
+#define RPMSG_SYSLOG_TRANSFER		0
+#define RPMSG_SYSLOG_TRANSFER_DONE	1
+#define RPMSG_SYSLOG_SUSPEND		2
+#define RPMSG_SYSLOG_RESUME		3
+
+struct rpmsg_syslog_header {
+	u32				command;
+	s32				result;
+} __packed;
+
+struct rpmsg_syslog_transfer {
+	struct rpmsg_syslog_header	header;
+	u32				count;
+	char				data[0];
+} __packed;
+
+#define rpmsg_syslog_suspend		rpmsg_syslog_header
+#define rpmsg_syslog_resume		rpmsg_syslog_header
+#define rpmsg_syslog_transfer_done	rpmsg_syslog_header
+
+struct rpmsg_syslog {
+	char				*buf;
+	unsigned int			next;
+	unsigned int			size;
+};
+
+static int rpmsg_syslog_callback(struct rpmsg_device *rpdev,
+				 void *data, int len, void *priv_, u32 src)
+{
+	struct rpmsg_syslog *priv = dev_get_drvdata(&rpdev->dev);
+	struct rpmsg_syslog_transfer *msg = data;
+	struct rpmsg_syslog_transfer_done done;
+	unsigned int copied = msg->count;
+	unsigned int printed = 0;
+	const char *nl;
+
+	if (msg->header.command != RPMSG_SYSLOG_TRANSFER)
+		return -EINVAL;
+
+	/* output the message before '\n' to the kernel log */
+	nl = memrchr(msg->data, '\n', msg->count);
+	if (nl) {
+		printed = nl + 1 - msg->data;
+		copied = msg->count - printed;
+
+		if (priv->next) {
+			pr_info("%.*s%.*s", priv->next,
+				priv->buf, printed, msg->data);
+			priv->next = 0;
+		} else {
+			pr_info("%.*s", printed, msg->data);
+		}
+	}
+
+	/* append the message after '\n' to the buffer */
+	if (copied != 0) {
+		unsigned int newsize = priv->next + copied;
+
+		if (newsize > priv->size) {
+			char *newbuf;
+
+			newbuf = krealloc(priv->buf, newsize, GFP_KERNEL);
+			if (newbuf) {
+				priv->buf  = newbuf;
+				priv->size = newsize;
+			} else {
+				copied = priv->size - priv->next;
+			}
+		}
+
+		strncpy(priv->buf + priv->next, msg->data + printed, copied);
+		priv->next += copied;
+	}
+
+	done.command = RPMSG_SYSLOG_TRANSFER_DONE;
+	done.result  = printed + copied;
+	return rpmsg_send(rpdev->ept, &done, sizeof(done));
+}
+
+static int rpmsg_syslog_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_syslog *priv;
+
+	priv = devm_kzalloc(&rpdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(&rpdev->dev, priv);
+	return 0;
+}
+
+static void rpmsg_syslog_remove(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_syslog *priv = dev_get_drvdata(&rpdev->dev);
+
+	/* flush the buffered log if need */
+	if (priv->next)
+		pr_info("%.*s\n", priv->next, priv->buf);
+	kfree(priv->buf);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int rpmsg_syslog_dev_suspend(struct device *dev)
+{
+	struct rpmsg_device *rpdev = dev_get_drvdata(dev);
+	struct rpmsg_syslog_suspend msg = {
+		.command = RPMSG_SYSLOG_SUSPEND,
+	};
+
+	return rpmsg_send(rpdev->ept, &msg, sizeof(msg));
+}
+
+static int rpmsg_syslog_dev_resume(struct device *dev)
+{
+	struct rpmsg_device *rpdev = dev_get_drvdata(dev);
+	struct rpmsg_syslog_resume msg = {
+		.command = RPMSG_SYSLOG_RESUME,
+	};
+
+	return rpmsg_send(rpdev->ept, &msg, sizeof(msg));
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(rpmsg_syslog_pm,
+			rpmsg_syslog_dev_suspend,
+			rpmsg_syslog_dev_resume);
+
+static const struct rpmsg_device_id rpmsg_syslog_id_table[] = {
+	{ .name = "rpmsg-syslog" },
+	{ },
+};
+MODULE_DEVICE_TABLE(rpmsg, rpmsg_syslog_id_table);
+
+static struct rpmsg_driver rpmsg_syslog_driver = {
+	.drv = {
+		.name  = "rpmsg_syslog",
+		.owner = THIS_MODULE,
+		.pm    = &rpmsg_syslog_pm,
+	},
+
+	.id_table = rpmsg_syslog_id_table,
+	.probe    = rpmsg_syslog_probe,
+	.callback = rpmsg_syslog_callback,
+	.remove   = rpmsg_syslog_remove,
+};
+
+module_rpmsg_driver(rpmsg_syslog_driver);
+
+MODULE_ALIAS("rpmsg:rpmsg_syslog");
+MODULE_AUTHOR("Guiding Li <liguiding@pinecone.net>");
+MODULE_DESCRIPTION("rpmsg syslog redirection driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

