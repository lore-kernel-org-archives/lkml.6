Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EECC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D4C21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISC7tnyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D4C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbeKVBmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:42:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33023 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731269AbeKVBmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:42:22 -0500
Received: by mail-io1-f65.google.com with SMTP id f12-v6so4298838iog.0;
        Wed, 21 Nov 2018 07:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GBKo96zBI+ZQctKqIEzTLwEZ12K6JbgFDDyDuZuqsBc=;
        b=ISC7tnykYJE4lwRuvV9P6A5tNt2GgH7zZr4kA32leKGrUIkLErTEiFFKyfMqH4b863
         BRCJrRVAUPuplCS/JcUIL/+VlssPjn7/g6QdiON/uGJs1Nub5ZL/jhcrojI252LBkjyo
         h+g85Yu+Nsio35XPfohlfU25anDlv8qTpw+e1tHBhPPRqR8NivNnI0k0llvPw5DefLMK
         tQmeiqkkqvarob/kaJ3KAHjXIQthlnjP/P77PUh8SncqaIeZ7IM6lSwXG4/2GCD37xEB
         brHsH9Kx56QhliHXhSoYpgBvhwdWIMN5XpGxBFLPV5cEIRpNxNDO9/snDeghP+SQ8SZh
         dsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GBKo96zBI+ZQctKqIEzTLwEZ12K6JbgFDDyDuZuqsBc=;
        b=FHojuG17sYIg6oulggPY1yEzknEs1bAQ0oVokS6xBwcG5gtBvMT2zHEIOKCUEbrqAX
         W8SUSzYDWekGAUXEku+9LAkef/agK1gvzL/m6HF4Y/AqZ+w1UsOc4CC5V0R3vJ2woOI2
         Hui6qenYqSZtSX6axUMkvGqK9e8/QvCsuBxLW4RJaM6P2Nj18HxrNgTGj2DkUdz/cviu
         uy7/h5Sbp9LQiFgVXdAcvVo92ABju3ER9aURTgevEOb5sVSgWSVncJSi4DebWF1Xsdm3
         tZnvljhnviicr73uexseZPnUBuAnsbtjB1TMpMcmV5/eBR7CIyEBpF1/qo5zMklYjxYg
         qVMg==
X-Gm-Message-State: AA+aEWan4PiCWEnf0tJfXrMupIjlAi7T0ccK4MoclXAAxzFCgyqT8hya
        mta3DeQvPYwYwKQx1xzBhmE=
X-Google-Smtp-Source: AFSGD/VkKORL0HdyT11uv1WoHBY0036ZuZT9bZPtc6l3h++Xn3Dy71ZxoXhuH0drA+Mk4XeIk3Bg2w==
X-Received: by 2002:a6b:c402:: with SMTP id y2mr5457457ioa.77.1542812853097;
        Wed, 21 Nov 2018 07:07:33 -0800 (PST)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id c3sm5113119ioi.2.2018.11.21.07.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 07:07:31 -0800 (PST)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH anybus v4 7/7] fieldbus_dev: support HMS Profinet IRT industrial controller
Date:   Wed, 21 Nov 2018 10:07:09 -0500
Message-Id: <20181121150709.6030-8-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121150709.6030-1-TheSven73@googlemail.com>
References: <20181121150709.6030-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Anybus-S PROFINET IRT communication module provides instant integration
to any Ethernet based LAN via SMTP, FTP, HTTP as well as PROFINET and
Modbus-TCP. Additional protocols can be implemented on top of TCP/IP
or UDP using the transparent socket interface.

Official documentation:
https://www.anybus.com/docs/librariesprovider7/default-document-library
/manuals-design-guides/hms-hmsi-168-52.pdf

This implementation is an Anybus-S client driver, designed to be
instantiated by the Anybus-S bus driver when it discovers the Profinet
card.

If loaded successfully, the driver registers itself as a fieldbus_dev,
and userspace can access it through the fieldbus_dev interface.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/fieldbus/Kconfig        |  17 +++
 drivers/fieldbus/Makefile       |   1 +
 drivers/fieldbus/hms-profinet.c | 223 ++++++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/fieldbus/hms-profinet.c

diff --git a/drivers/fieldbus/Kconfig b/drivers/fieldbus/Kconfig
index 00a163a2cbe6..12b0fef591fb 100644
--- a/drivers/fieldbus/Kconfig
+++ b/drivers/fieldbus/Kconfig
@@ -36,4 +36,21 @@ config HMS_ANYBUSS_HOST
 	  typically provide fieldbus and industrial ethernet
 	  functionality.
 
+config HMS_PROFINET
+	tristate "HMS Profinet IRT Controller (Anybus-S)"
+	depends on FIELDBUS_DEV
+	select HMS_ANYBUSS_HOST
+	help
+	 If you say yes here you get support for the HMS Industrial
+	 Networks Profinet IRT Controller.
+
+	 It will be registered with the kernel as a fieldbus_dev,
+	 so userspace can interact with it via the fieldbus_dev userspace
+	 interface(s).
+
+	 This driver can also be built as a module. If so, the module
+	 will be called hms-profinet.
+
+	 If unsure, say N.
+
 endif
diff --git a/drivers/fieldbus/Makefile b/drivers/fieldbus/Makefile
index c47a4bd416f6..c3161c5ce0f1 100644
--- a/drivers/fieldbus/Makefile
+++ b/drivers/fieldbus/Makefile
@@ -9,3 +9,4 @@ fieldbus_dev_core-y		:= dev_core.o
 # Devices
 obj-$(CONFIG_ARCX_ANYBUS_BRIDGE) += anybus-bridge.o
 obj-$(CONFIG_HMS_ANYBUSS_HOST)	+= anybuss-host.o
+obj-$(CONFIG_HMS_PROFINET)	+= hms-profinet.o
diff --git a/drivers/fieldbus/hms-profinet.c b/drivers/fieldbus/hms-profinet.c
new file mode 100644
index 000000000000..434437829339
--- /dev/null
+++ b/drivers/fieldbus/hms-profinet.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HMS Profinet Client Driver
+ *
+ * Copyright (C) 2018 Arcx Inc
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/fieldbus_dev.h>
+#include <linux/anybuss-client.h>
+
+#define PROFI_DPRAM_SIZE	512
+
+/*
+ * ---------------------------------------------------------------
+ * Anybus Profinet mailbox messages - definitions
+ * ---------------------------------------------------------------
+ * note that we're depending on the layout of these structures being
+ * exactly as advertised.
+ */
+
+struct msgMacAddr {
+	u8 addr[6];
+};
+
+struct profi_priv {
+	struct fieldbus_dev fbdev;
+	struct anybuss_client *client;
+	struct mutex enable_lock;
+	bool power_on;
+};
+
+static ssize_t
+profi_read_area(struct fieldbus_dev *fbdev, char __user *buf, size_t size,
+			loff_t *offset)
+{
+	struct profi_priv *priv = container_of(fbdev, struct profi_priv, fbdev);
+
+	return anybuss_read_output(priv->client, buf, size, offset);
+}
+
+static ssize_t
+profi_write_area(struct fieldbus_dev *fbdev, const char __user *buf,
+			size_t size, loff_t *offset)
+{
+	struct profi_priv *priv = container_of(fbdev, struct profi_priv, fbdev);
+
+	return anybuss_write_input(priv->client, buf, size, offset);
+}
+
+static int profi_id_get(struct fieldbus_dev *fbdev, char *buf,
+				size_t max_size)
+{
+	struct profi_priv *priv = container_of(fbdev, struct profi_priv, fbdev);
+	struct msgMacAddr response;
+	int ret;
+
+	ret = anybuss_recv_msg(priv->client, 0x0010, &response,
+						sizeof(response));
+	if (ret < 0)
+		return ret;
+	return snprintf(buf, max_size, "%02X:%02X:%02X:%02X:%02X:%02X\n",
+		response.addr[0], response.addr[1],
+		response.addr[2], response.addr[3],
+		response.addr[4], response.addr[5]);
+}
+
+static bool profi_enable_get(struct fieldbus_dev *fbdev)
+{
+	struct profi_priv *priv = container_of(fbdev, struct profi_priv, fbdev);
+	bool power_on;
+
+	mutex_lock(&priv->enable_lock);
+	power_on = priv->power_on;
+	mutex_unlock(&priv->enable_lock);
+
+	return power_on;
+}
+
+static int __profi_enable(struct profi_priv *priv)
+{
+	int ret;
+	struct anybuss_client *client = priv->client;
+	/* Initialization Sequence, Generic Anybus Mode */
+	const struct anybuss_memcfg mem_cfg = {
+		.input_io = 220,
+		.input_dpram = PROFI_DPRAM_SIZE,
+		.input_total = PROFI_DPRAM_SIZE,
+		.output_io = 220,
+		.output_dpram = PROFI_DPRAM_SIZE,
+		.output_total = PROFI_DPRAM_SIZE,
+		.offl_mode = AB_OFFL_MODE_CLEAR,
+	};
+
+	/*
+	 * switch anybus off then on, this ensures we can do a complete
+	 * configuration cycle in case anybus was already on.
+	 */
+	anybuss_set_power(client, false);
+	ret = anybuss_set_power(client, true);
+	if (ret)
+		goto err;
+	ret = anybuss_start_init(client, &mem_cfg);
+	if (ret)
+		goto err;
+	ret = anybuss_finish_init(client);
+	if (ret)
+		goto err;
+	priv->power_on = true;
+	return 0;
+
+err:
+	anybuss_set_power(client, false);
+	priv->power_on = false;
+	return ret;
+}
+
+static int __profi_disable(struct profi_priv *priv)
+{
+	struct anybuss_client *client = priv->client;
+
+	anybuss_set_power(client, false);
+	priv->power_on = false;
+	return 0;
+}
+
+static int profi_simple_enable(struct fieldbus_dev *fbdev, bool enable)
+{
+	int ret;
+	struct profi_priv *priv = container_of(fbdev, struct profi_priv, fbdev);
+
+	mutex_lock(&priv->enable_lock);
+	if (enable)
+		ret = __profi_enable(priv);
+	else
+		ret = __profi_disable(priv);
+	mutex_unlock(&priv->enable_lock);
+
+	return ret;
+}
+
+static void profi_on_area_updated(struct anybuss_client *client)
+{
+	struct profi_priv *priv = anybuss_get_drvdata(client);
+
+	fieldbus_dev_area_updated(&priv->fbdev);
+}
+
+static void profi_on_online_changed(struct anybuss_client *client, bool online)
+{
+	struct profi_priv *priv = anybuss_get_drvdata(client);
+
+	fieldbus_dev_online_changed(&priv->fbdev, online);
+}
+
+static int profinet_probe(struct anybuss_client *client)
+{
+	struct profi_priv *priv;
+	struct device *dev = &client->dev;
+	int err;
+
+	client->on_area_updated = profi_on_area_updated;
+	client->on_online_changed = profi_on_online_changed;
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	mutex_init(&priv->enable_lock);
+	priv->client = client;
+	priv->fbdev.read_area_sz = priv->fbdev.write_area_sz = PROFI_DPRAM_SIZE;
+	priv->fbdev.card_name = "HMS Profinet IRT (Anybus-S)";
+	priv->fbdev.fieldbus_type = FIELDBUS_DEV_TYPE_PROFINET;
+	priv->fbdev.read_area = profi_read_area;
+	priv->fbdev.write_area = profi_write_area;
+	priv->fbdev.fieldbus_id_get = profi_id_get;
+	priv->fbdev.enable_get = profi_enable_get;
+	priv->fbdev.simple_enable_set = profi_simple_enable;
+	priv->fbdev.parent = dev;
+	err = fieldbus_dev_register(&priv->fbdev);
+	if (err < 0)
+		return err;
+	dev_info(dev, "card detected, registered as %s",
+				dev_name(priv->fbdev.dev));
+	anybuss_set_drvdata(client, priv);
+
+	return 0;
+}
+
+static int profinet_remove(struct anybuss_client *client)
+{
+	struct profi_priv *priv = anybuss_get_drvdata(client);
+
+	fieldbus_dev_unregister(&priv->fbdev);
+	return 0;
+}
+
+static struct anybuss_client_driver profinet_driver = {
+	.probe = profinet_probe,
+	.remove = profinet_remove,
+	.driver		= {
+		.name   = "hms-profinet",
+		.owner	= THIS_MODULE,
+	},
+	.fieldbus_type = 0x0089,
+};
+
+static int __init profinet_init(void)
+{
+	return anybuss_client_driver_register(&profinet_driver);
+}
+module_init(profinet_init);
+
+static void __exit profinet_exit(void)
+{
+	return anybuss_client_driver_unregister(&profinet_driver);
+}
+module_exit(profinet_exit);
+
+MODULE_AUTHOR("Sven Van Asbroeck <svendev@arcx.com>");
+MODULE_DESCRIPTION("HMS Profinet IRT Driver (Anybus-S)");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

