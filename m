Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E853C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50772222CF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAPzk9WT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405546AbfBNDsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:48:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41370 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387562AbfBNDsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:48:36 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so2296560pgq.8;
        Wed, 13 Feb 2019 19:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x2IAgkervfuMLk7yMqPGZTbwjg3ZFYDfObRSN9ZzJXg=;
        b=IAPzk9WTHAFbDRLMwjdpRwHyRtkFGQSf/jbcncFxYL2IHeY+palCdlvAYwt3dmwQIL
         RLtR59lBEVKTYkvLrleJQocwlNMloRvawsQ2d3jjiRKFPnP8sT2UMYDXHmcTSDwCPA/f
         vDDuTgMRkxuq3Jo6RHKzeo0utbDXwZMv6ijoW6nKp7b0nQeoD57OUlhiG2sTX3xPhlJ7
         IstoVqMduHVOI7JOanzzpojO0pD/UUUyE8bzPT27saiWMequlr1K0iifs8oDkJcJzMtm
         iCgJ3lS9Rxjw+BHSiaA+Hlztaupupap3z+w+PkgOaHDYMerrZ+NMvb+xTeg1sL8A9qTr
         QjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x2IAgkervfuMLk7yMqPGZTbwjg3ZFYDfObRSN9ZzJXg=;
        b=bzuVzjb0JfyuyrRfANg1WpEFk5aIg4v6gyWGE9+J6f4MlbSCOoY2hLfONQGJXlk7ft
         8z+14msUnFm4cH+z27zbM1q0otzW6QPH0eznMIH3aRwhjgb9VM3uDPqWohYWGGLVViuG
         Tvj1LFqYpKhbbtCuoty3Tx6h1FE/LWXbCRbyGbz4g3cs76Rw71DCcDDdxTPK9lSntski
         hzhStA6HMdW3A2JwImrS5rdiOMPKHZvtnJ5mbCT90FPTBGYgWldOY8UXaVXL0xRnfBqn
         cg1ArByyxwSJo5YTZL1n26VKlNA0POKUdP3x24cWTWcBVLFAFzrUg6Qkdd8bTqugyOeJ
         Dbhw==
X-Gm-Message-State: AHQUAuawthVh4BxMiDIwGYVuWUoGsD8EdsPTpKkNBC72QXPDQ7sLuT1c
        XGpYH7s8VSqwYVWM4JuGeP4=
X-Google-Smtp-Source: AHgI3IYLPMvHogKgywfCm8gDSZP5Kyhcz/FQuCK0Tf+gL3zDy9k4sDO2sDjA6dBIn9ezCU/0sGi/Xg==
X-Received: by 2002:a63:2bcd:: with SMTP id r196mr1646748pgr.355.1550116114609;
        Wed, 13 Feb 2019 19:48:34 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id g7sm969962pfi.187.2019.02.13.19.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 19:48:34 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
        andriy.shevchenko@linux.intel.com, ohad@wizery.com,
        bjorn.andersson@linaro.org, wendy.liang@xilinx.com,
        arnaud.pouliquen@st.com, kumar.gala@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Guiding Li <liguiding@pinecone.net>
Subject: [PATCH 2/2] rpmsg: add syslog redirection driver
Date:   Thu, 14 Feb 2019 11:48:17 +0800
Message-Id: <1550116097-29710-2-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550116097-29710-1-git-send-email-xiaoxiang@xiaomi.com>
References: <1550116097-29710-1-git-send-email-xiaoxiang@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guiding Li <liguiding@pinecone.net>

This driver allows the remote processor redirect the output of
syslog/printf into the kernel log, which is very useful to see
what happen in the remote side.

Signed-off-by: Guiding Li <liguiding@pinecone.net>
---
 drivers/rpmsg/Kconfig        |  12 ++++
 drivers/rpmsg/Makefile       |   1 +
 drivers/rpmsg/rpmsg_syslog.c | 163 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 drivers/rpmsg/rpmsg_syslog.c

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d0322b4..d701614 100644
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
+	  the kernel log which is very useful to see what happen in the remote
+	  side.
+
+	  If the remote processor hang during bootup or panic at the runtime,
+	  We can even cat /sys/kernel/debug/remoteproc/remoteprocX/trace0 to
+	  get the last log which doesn't output yet.
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

