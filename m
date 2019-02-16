Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DF4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE23222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHlDzH74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfBPTiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 14:38:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40004 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732839AbfBPTiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 14:38:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id u9so2897027pgo.7;
        Sat, 16 Feb 2019 11:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ej3ldC2HNLoBFAGyYVx3I8ETyJoB90qa6HCx5Dplbh8=;
        b=gHlDzH74kHxYnqN2z759F0HWGdp/0qm48nKH6CapyULeD0aEFQh/Q0m7PUyC3/CCTw
         f69pZkFoqseTwaPuq25/4eg12YPvaGamlBpoySxWPf5L3Q91RRD00QsqwS9pSnhhW7IS
         SHavSRKNYzw+EFqzz552iZZApyirxZfErZdzei2rtpJ5NWNIKghsUhfjIw1djD3Ymdxe
         yjhg/S5SLqoxZ9dKgA9VEB6zAPCMlU+t4tAi8epK1+IwNTwlinwd5o9gsDJpOvqCehBD
         OcQB4VYp8PW152dOUjfKJ5qmbpEINbfNT0EUfcfA4XHfnR5PeKUUNeOnF+qUKdGNQowP
         jOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ej3ldC2HNLoBFAGyYVx3I8ETyJoB90qa6HCx5Dplbh8=;
        b=o2jorPprApteGvkxbbFzt4XrrJ+nE1i89lc2DYcYX+YrJetb5wN3fGDqN5Im2JXAIO
         7CB4gcPT0lktpmBumezftNUZUOhtO+RmPzpX9Ns5AwvjiDHY4myyQ3kCSMV0K8EW5r/v
         YJdExT4kc/Mu4a/nmJHfRAI4mQ4sXOhO9YmzUZPXM5Jas0VHXBLJiO61C4bq0n/NmWUK
         hkzsRMVA0i9Qhjs60nCcT/BOOEpF6DFwv0RhZ4qvS6xOy8Bz+txZYEUnZseBMjCrLxrc
         KYVL1I3P1o5T3fH0NW4malpZPQrERVpqip1Gfgxo3YarkevCmuBJMih8wr389JEbpioP
         yZKw==
X-Gm-Message-State: AHQUAuYxKzX3C0ZQmbSVrBr8dooDw6RTq/4tUtm7O/s4zFRGPTreMpZX
        DvOy/UgVNAILbOIq5+g1eCw=
X-Google-Smtp-Source: AHgI3IYxfHUvVGAtfXxy+fgQpDM1Z2zYq0a4T3bLZEJXflT/W2xS84YLoxrOCKbBE9aV46pDY7OApQ==
X-Received: by 2002:a63:1723:: with SMTP id x35mr11094129pgl.364.1550345878851;
        Sat, 16 Feb 2019 11:37:58 -0800 (PST)
Received: from localhost.localdomain ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id k19sm9255725pfi.126.2019.02.16.11.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Feb 2019 11:37:58 -0800 (PST)
From:   Xiang Xiao <xiaoxiang781216@gmail.com>
X-Google-Original-From: Xiang Xiao <xiaoxiang@xiaomi.com>
To:     Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wendy.liang@xilinx.com, Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yanlin Zhu <zhuyanlin@pinecone.net>
Subject: [PATCH] rpmsg: add clock API redirection driver
Date:   Sun, 17 Feb 2019 03:37:47 +0800
Message-Id: <1550345867-25762-1-git-send-email-xiaoxiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanlin Zhu <zhuyanlin@pinecone.net>

which could redirect clk API from remote to the kernel

Signed-off-by: Yanlin Zhu <zhuyanlin@pinecone.net>
---
 drivers/rpmsg/Kconfig     |  10 ++
 drivers/rpmsg/Makefile    |   1 +
 drivers/rpmsg/rpmsg_clk.c | 284 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+)
 create mode 100644 drivers/rpmsg/rpmsg_clk.c

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index 13ead55..ed04cb9 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -15,6 +15,16 @@ config RPMSG_CHAR
 	  in /dev. They make it possible for user-space programs to send and
 	  receive rpmsg packets.
 
+config RPMSG_CLK
+	tristate "RPMSG clock API redirection"
+	depends on COMMON_CLK
+	depends on RPMSG
+	help
+	  Say Y here to redirect clock API from the remote processor.
+	  With this driver, the remote processor could:
+	  1.Reuse the clock driver in the kernel side, or
+	  2.Form a hybrid(kernel plus RTOS) clock tree.
+
 config RPMSG_SYSLOG
 	tristate "RPMSG syslog redirection"
 	depends on RPMSG
diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
index bfd22df..0d777b1 100644
--- a/drivers/rpmsg/Makefile
+++ b/drivers/rpmsg/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
 obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
+obj-$(CONFIG_RPMSG_CLK)		+= rpmsg_clk.o
 obj-$(CONFIG_RPMSG_SYSLOG)	+= rpmsg_syslog.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
 obj-$(CONFIG_RPMSG_QCOM_GLINK_NATIVE) += qcom_glink_native.o
diff --git a/drivers/rpmsg/rpmsg_clk.c b/drivers/rpmsg/rpmsg_clk.c
new file mode 100644
index 0000000..0ec0241
--- /dev/null
+++ b/drivers/rpmsg/rpmsg_clk.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Pinecone Inc.
+ *
+ * redirect clk API from remote to the kernel.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/rpmsg.h>
+
+#define RPMSG_CLK_ENABLE	0
+#define RPMSG_CLK_DISABLE	1
+#define RPMSG_CLK_SETRATE	2
+#define RPMSG_CLK_SETPHASE	3
+#define RPMSG_CLK_GETPHASE	4
+#define RPMSG_CLK_GETRATE	5
+#define RPMSG_CLK_ROUNDRATE	6
+#define RPMSG_CLK_ISENABLED	7
+
+struct rpmsg_clk_header {
+	u32			command;
+	u32			response;
+	s64			result;
+	u64			cookie;
+} __packed;
+
+struct rpmsg_clk_enable {
+	struct rpmsg_clk_header	header;
+	char			name[0];
+} __packed;
+
+#define rpmsg_clk_disable	rpmsg_clk_enable
+#define rpmsg_clk_isenabled	rpmsg_clk_enable
+
+struct rpmsg_clk_setrate {
+	struct rpmsg_clk_header	header;
+	u64			rate;
+	char			name[0];
+} __packed;
+
+#define rpmsg_clk_getrate	rpmsg_clk_enable
+#define rpmsg_clk_roundrate	rpmsg_clk_setrate
+
+struct rpmsg_clk_setphase {
+	struct rpmsg_clk_header	header;
+	u32			degrees;
+	char			name[0];
+} __packed;
+
+#define rpmsg_clk_getphase	rpmsg_clk_enable
+
+struct rpmsg_clk_res {
+	struct clk		*clk;
+	atomic_t		count;
+};
+
+static void rpmsg_clk_release(struct device *dev, void *res)
+{
+	struct rpmsg_clk_res *clkres = res;
+	int count = atomic_read(&clkres->count);
+
+	while (count-- > 0)
+		clk_disable_unprepare(clkres->clk);
+
+	clk_put(clkres->clk);
+}
+
+static int rpmsg_clk_match(struct device *dev, void *res, void *data)
+{
+	struct rpmsg_clk_res *clkres = res;
+
+	return !strcmp(__clk_get_name(clkres->clk), data);
+}
+
+static struct rpmsg_clk_res *
+rpmsg_clk_get_res(struct rpmsg_device *rpdev, const char *name)
+{
+	struct rpmsg_clk_res *clkres;
+	struct clk *clk;
+
+	clkres = devres_find(&rpdev->dev, rpmsg_clk_release,
+			     rpmsg_clk_match, (void *)name);
+	if (clkres)
+		return clkres;
+
+	clkres = devres_alloc(rpmsg_clk_release, sizeof(*clkres), GFP_KERNEL);
+	if (!clkres)
+		return ERR_PTR(-ENOMEM);
+
+	clk = clk_get(&rpdev->dev, name);
+	if (IS_ERR(clk)) {
+		devres_free(clkres);
+		return ERR_CAST(clk);
+	}
+
+	clkres->clk = clk;
+	devres_add(&rpdev->dev, clkres);
+
+	return clkres;
+}
+
+static int rpmsg_clk_enable_handler(struct rpmsg_device *rpdev,
+				    void *data, int len, void *priv, u32 src)
+{
+	struct rpmsg_clk_enable *msg = data;
+	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
+
+	if (!IS_ERR(clkres)) {
+		msg->header.result = clk_prepare_enable(clkres->clk);
+		if (msg->header.result >= 0)
+			atomic_inc(&clkres->count);
+	} else {
+		msg->header.result = PTR_ERR(clkres);
+	}
+
+	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
+}
+
+static int rpmsg_clk_disable_handler(struct rpmsg_device *rpdev,
+				     void *data, int len, void *priv, u32 src)
+{
+	struct rpmsg_clk_disable *msg = data;
+	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
+
+	if (!IS_ERR(clkres)) {
+		msg->header.result = 0;
+		if (atomic_dec_return(&clkres->count) >= 0)
+			clk_disable_unprepare(clkres->clk);
+		else
+			atomic_inc(&clkres->count);
+	} else {
+		msg->header.result = PTR_ERR(clkres);
+	}
+
+	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
+}
+
+static int rpmsg_clk_getrate_handler(struct rpmsg_device *rpdev,
+				     void *data, int len, void *priv, u32 src)
+{
+	struct rpmsg_clk_getrate *msg = data;
+	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
+
+	if (!IS_ERR(clkres))
+		msg->header.result = clk_get_rate(clkres->clk);
+	else
+		msg->header.result = PTR_ERR(clkres);
+
+	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
+}
+
+static int rpmsg_clk_roundrate_handler(struct rpmsg_device *rpdev,
+				       void *data, int len, void *priv, u32 src)
+{
+	struct rpmsg_clk_roundrate *msg = data;
+	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
+
+	if (!IS_ERR(clkres))
+		msg->header.result = clk_round_rate(clkres->clk, msg->rate);
+	else
+		msg->header.result = PTR_ERR(clkres);
+
+	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
+}
+
+static int rpmsg_clk_setrate_handler(struct rpmsg_device *rpdev,
+				     void *data, int len, void *priv, u32 src)
+{
+	struct rpmsg_clk_setrate *msg = data;
+	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
+
+	if (!IS_ERR(clkres))
+		msg->header.result = clk_set_rate(clkres->clk, msg->rate);
+	else
+		msg->header.result = PTR_ERR(clkres);
+
+	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
+}
+
+static int rpmsg_clk_setphase_handler(struct rpmsg_device *rpdev,
+				      void *data, int len, void *priv, u32 src)
+{
+	struct rpmsg_clk_setphase *msg = data;
+	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
+
+	if (!IS_ERR(clkres))
+		msg->header.result = clk_set_phase(clkres->clk, msg->degrees);
+	else
+		msg->header.result = PTR_ERR(clkres);
+
+	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
+}
+
+static int rpmsg_clk_getphase_handler(struct rpmsg_device *rpdev,
+				      void *data, int len, void *priv, u32 src)
+{
+	struct rpmsg_clk_getphase *msg = data;
+	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
+
+	if (!IS_ERR(clkres))
+		msg->header.result = clk_get_phase(clkres->clk);
+	else
+		msg->header.result = PTR_ERR(clkres);
+
+	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
+}
+
+static int rpmsg_clk_isenabled_handler(struct rpmsg_device *rpdev,
+				       void *data, int len, void *priv, u32 src)
+{
+	struct rpmsg_clk_isenabled *msg = data;
+	struct rpmsg_clk_res *clkres = rpmsg_clk_get_res(rpdev, msg->name);
+
+	if (!IS_ERR(clkres))
+		msg->header.result = __clk_is_enabled(clkres->clk);
+	else
+		msg->header.result = PTR_ERR(clkres);
+
+	return rpmsg_send(rpdev->ept, msg, sizeof(*msg));
+}
+
+static const rpmsg_rx_cb_t rpmsg_clk_handler[] = {
+	[RPMSG_CLK_ENABLE]    = rpmsg_clk_enable_handler,
+	[RPMSG_CLK_DISABLE]   = rpmsg_clk_disable_handler,
+	[RPMSG_CLK_SETRATE]   = rpmsg_clk_setrate_handler,
+	[RPMSG_CLK_SETPHASE]  = rpmsg_clk_setphase_handler,
+	[RPMSG_CLK_GETPHASE]  = rpmsg_clk_getphase_handler,
+	[RPMSG_CLK_GETRATE]   = rpmsg_clk_getrate_handler,
+	[RPMSG_CLK_ROUNDRATE] = rpmsg_clk_roundrate_handler,
+	[RPMSG_CLK_ISENABLED] = rpmsg_clk_isenabled_handler,
+};
+
+static int rpmsg_clk_callback(struct rpmsg_device *rpdev,
+			      void *data, int len, void *priv, u32 src)
+{
+	struct rpmsg_clk_header *hdr = data;
+	u32 cmd = hdr->command;
+	int ret = -EINVAL;
+
+	if (cmd < ARRAY_SIZE(rpmsg_clk_handler)) {
+		hdr->response = 1;
+		ret = rpmsg_clk_handler[cmd](rpdev, data, len, priv, src);
+	} else {
+		dev_err(&rpdev->dev, "invalid command %u\n", cmd);
+	}
+
+	return ret;
+}
+
+static int rpmsg_clk_probe(struct rpmsg_device *rpdev)
+{
+	return 0;
+}
+
+static void rpmsg_clk_remove(struct rpmsg_device *rpdev)
+{
+}
+
+static const struct rpmsg_device_id rpmsg_clk_id_table[] = {
+	{ .name = "rpmsg-clk" },
+	{ }
+};
+MODULE_DEVICE_TABLE(rpmsg, rpmsg_clk_id_table);
+
+static struct rpmsg_driver rpmsg_clk_driver = {
+	.drv = {
+		.name	= "rpmsg_clk",
+		.owner	= THIS_MODULE,
+	},
+
+	.id_table	= rpmsg_clk_id_table,
+	.probe		= rpmsg_clk_probe,
+	.callback	= rpmsg_clk_callback,
+	.remove		= rpmsg_clk_remove,
+};
+
+module_rpmsg_driver(rpmsg_clk_driver);
+
+MODULE_ALIAS("rpmsg:rpmsg_clk");
+MODULE_AUTHOR("Yanlin Zhu <zhuyanlin@xiaomi.com>");
+MODULE_DESCRIPTION("rpmsg clock API redirection driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

