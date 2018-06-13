Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 62727C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044B7208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="L9Eexou2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044B7208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935943AbeFMOjn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:39:43 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:33662 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935815AbeFMOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:38:17 -0400
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 415TrR612Jz1XLFYq;
        Wed, 13 Jun 2018 16:38:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528900695;
        bh=xKWvSJAExCFYwQPkF9cpeARYs1KgGM4+MQ0/Lt2hetU=; l=10;
        h=From:From:Reply-To:Sender;
        b=L9Eexou2SEqSzfQnYDeyVUSs/i2QSsgFVskCSKzJs0NJnsO/dHJXkVYYKXGJA0rMh
         1Ct/cvyXHYNXI3UgR13fagg83L4oNbDslVVftKM77RBTfXZbIgA/pwLDERXdrQiBNS
         3g0v+geWHxgNA4MAp0xGtZGOM4tUWyqMenyAFZGY=
Received: from si0vm2083.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 415TrR5LPlz1Cd;
        Wed, 13 Jun 2018 16:38:15 +0200 (CEST)
X-AuditID: 0a3aad17-513ff70000000e32-da-5b212c585488
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm2083.rbesz01.com (SMG Outbound) with SMTP id 8C.4A.03634.85C212B5; Wed, 13 Jun 2018 16:38:16 +0200 (CEST)
Received: from SI-HUB1000.de.bosch.com (si-hub1000.de.bosch.com [10.4.103.106])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 415TrR2wDBzBpBV;
        Wed, 13 Jun 2018 16:38:15 +0200 (CEST)
Received: from luchador.grb-fir.grb.de.bosch.com (10.19.187.97) by
 SI-HUB1000.de.bosch.com (10.4.103.106) with Microsoft SMTP Server id
 14.3.319.2; Wed, 13 Jun 2018 16:38:15 +0200
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>,
        <yi.zhu5@cn.bosch.com>, <petar.petrovic2@de.bosch.com>,
        <stephan.baetge@de.bosch.com>, <andy.shevchenko@gmail.com>,
        <socketcan@hartkopp.net>, <o.rempel@pengutronix.de>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH v2 3/5] char: implement companion-char driver
Date:   Wed, 13 Jun 2018 16:37:19 +0200
Message-ID: <1528900641-18677-4-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
 <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sf0xbVRTHuX2v7WvludcW1rMi071ki2G/OubMU4dBTbSby2Zctsw1uj3G
        k1b7g/QVhMXMGqmkuDGWgbaFETZdRpYtZCCxZUJipYBiMKLMdrgSHUsKzE1ks4gBfY/C2j/8
        79zzPZ/zPffcS2DqYbmOMNucnMPGWmiZElc+fTl344ENa4z6rv7tzETd14gJ/DKGMRcTDRjz
        Y1eTjGk7V48zfS0rmfEYYiKTC3LmfCwoLVQYmv0DuCHovyE3TA+PIsMH//bKDSfn9YaZ9tWv
        yA4qtxdzFnM559j87GGl6WTiJ7zU9UZF981OzIU8u2qQggDqCZgfiuBirKa8Erg2v6MGKYW4
        G8H0WBQlD18gCPfGpGKVjMqD6EAAE+Msah803voQF4swqkcCo90fIVHQUAXgfv/KIoBTayF2
        /cKiBUm9BGeq/5EkrVdDdMiz2EhBGaCzqxklx3AjGAnvT9ar4Bvf+CKLUQBfxeNYHVrhT5P8
        aVILklxE2bxZX27N1zNbNzmKOP6ofsumI3ZrO0ouWhtA966wIUQRiM4k33t0jVEtZcv5SmsI
        bSMkdDa5u+4xo/rhIntxpYnlTYccZRaOp3UkysjIUGsepPmyIquZ5812WwgBgdFZ5O64wJHF
        bOVRzmFPYiGUQ+C0ljxe/O5BNVXCOrm3Oa6UcyyrzxAEDSS/XphB5eBKuIo3zRbnskznJj1X
        pivpthJCEUJbiUzBu0dsQfKlrJU3lyzhq5K4ejmbQr9FLxALd+uPY2rcZrdxOi3ZlyfwlFhp
        KrM9mED3CGn8XLhUdpqQ6jKJRpCwQw05KMKZwn9OeQMZ0DS9plYtJVNQ/lmBoXpy4HqEhNjd
        HPBPm+FOyzFoP1WF4LNoI4LGsWEEzYH7COKzCeEPTrVJ4Hb0qgQmbjThMFPVikNkMohDbagP
        B2+3WwoR12kpDNyul0HViTkZTPimCGg/MaoQMSWMNEwpYfa7v5QQHPjzIbjk6yXBe22GhKDn
        3AoY+uR7FSx4z2igtalZA77aTs2ksFSJsNRwWHxQ3sk6/2epS9nUzXQu9OlM/825tj92UPEN
        dQWPF+xd/3vteOXLO6/+vfP1F+9VF6oSLe6w/Ni6rOnB57TbVrFa1nCnAw3Sty7593nyS/DE
        832+8RpFza8FT1Zbyc2XLd7IkUHjqdMbC7PP57564cuuip+f8g43VGs/nr3vXtijdb1FHD7k
        eae17beOH87u7+ifo3HexG7Jwxw8+x9mGJFdZQQAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

The upper level companion-char driver provides character device
interface to userspace for communicate IO messages with the
companion processor.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/char/Kconfig     |   7 +
 drivers/char/Makefile    |   3 +
 drivers/char/companion.c | 360 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 370 insertions(+)
 create mode 100644 drivers/char/companion.c

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index c28dca0..e878d56 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -588,5 +588,12 @@ config TILE_SROM
 
 source "drivers/char/xillybus/Kconfig"
 
+config COMPANION_CHAR
+	tristate "Character device for companion communication (Bosch)"
+	depends on COMPANION_SPI
+	help
+	  The character device allows the userspace to exchange IO messages
+	  with the Bosch companion processor via the companion SPI driver.
+
 endmenu
 
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 7dc3abe..0dae572 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -60,3 +60,6 @@ js-rtc-y = rtc.o
 obj-$(CONFIG_TILE_SROM)		+= tile-srom.o
 obj-$(CONFIG_XILLYBUS)		+= xillybus/
 obj-$(CONFIG_POWERNV_OP_PANEL)	+= powernv-op-panel.o
+
+obj-$(CONFIG_COMPANION_CHAR)	+= companion-char.o
+companion-char-objs := companion.o
diff --git a/drivers/char/companion.c b/drivers/char/companion.c
new file mode 100644
index 0000000..2e26f01
--- /dev/null
+++ b/drivers/char/companion.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Companion upper level character device
+ *
+ * Copyright (C) 2015-2018 Bosch Sicherheitssysteme GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cdev.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/poll.h>
+#include <linux/companion.h>
+
+#define DRIVER_NAME "companion-char"
+
+static struct class *companion_char_class;
+static dev_t         devt;
+
+/**
+ * struct companion_char_minor - companion-char minor structure
+ * @dev:       address of the associated device
+ * @writelock: mutex to protect write
+ * @readlock:  mutex to protect read
+ * @writewait: wait queue head of write
+ * @readwait:  wait queue head of read
+ */
+struct companion_char_minor {
+	struct device    *dev;
+	struct mutex      writelock;
+	struct mutex      readlock;
+	wait_queue_head_t writewait;
+	wait_queue_head_t readwait;
+};
+
+/**
+ * struct companion_char_priv - companion-char private data structure
+ * @cdev:   char device
+ * @parent: address of the associated parent device
+ * @minors: address of the companion-char minor
+ */
+struct companion_char_priv {
+	struct cdev                  cdev;
+	struct device               *parent;
+	struct companion_char_minor *minors;
+};
+
+/**
+ * companion_char_read() - read callback
+ * @filp:   address of the associated virtual file
+ * @buf:    address of the user space buffer to receive
+ * @count:  number of bytes to read
+ * @offset: address of the read offset
+ */
+static ssize_t companion_char_read(struct file *filp,
+				   char __user *buf,
+				   size_t       count,
+				   loff_t      *offset)
+{
+	unsigned int                 number = MINOR(file_inode(filp)->i_rdev);
+	struct companion_char_priv  *priv   = filp->private_data;
+	struct companion_char_minor *minor  = &priv->minors[number];
+	int                          err;
+
+	if (count != COMPANION_PACKET_SIZE)
+		return -EMSGSIZE;
+
+	if (mutex_lock_interruptible(&minor->readlock))
+		return -ERESTARTSYS;
+
+	while (companion_io_rxq_is_empty(priv->parent)) {
+		mutex_unlock(&minor->readlock);
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		if (wait_event_interruptible(minor->readwait,
+				!companion_io_rxq_is_empty(priv->parent)))
+			return -ERESTARTSYS;
+		if (mutex_lock_interruptible(&minor->readlock))
+			return -ERESTARTSYS;
+	}
+
+	err = companion_do_io_rx(priv->parent, buf, count);
+	mutex_unlock(&minor->readlock);
+	return err;
+}
+
+/**
+ * companion_char_write() - write callback
+ * @filp:   address of the associated virtual file
+ * @buf:    address of the user space buffer to transfer
+ * @count:  number of bytes to write
+ * @offset: address of the write offset
+ */
+static ssize_t companion_char_write(struct file       *filp,
+				    const char __user *buf,
+				    size_t             count,
+				    loff_t            *offset)
+{
+	unsigned int                 number = MINOR(file_inode(filp)->i_rdev);
+	struct companion_char_priv  *priv   = filp->private_data;
+	struct companion_char_minor *minor  = &priv->minors[number];
+	int                          err;
+
+	if (count != COMPANION_PACKET_SIZE)
+		return -EMSGSIZE;
+
+	if (mutex_lock_interruptible(&minor->writelock))
+		return -ERESTARTSYS;
+
+	while (companion_io_txq_is_full(priv->parent)) {
+		mutex_unlock(&minor->writelock);
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+		if (wait_event_interruptible(minor->writewait,
+				!companion_io_txq_is_full(priv->parent)))
+			return -ERESTARTSYS;
+		if (mutex_lock_interruptible(&minor->writelock))
+			return -ERESTARTSYS;
+	}
+
+	err = companion_do_io_tx(priv->parent, buf, count);
+	mutex_unlock(&minor->writelock);
+	return err;
+}
+
+/**
+ * companion_char_poll() - poll callback
+ * @filp: address of the associated virtual file
+ * @wait: address of the associated poll table
+ */
+static unsigned int companion_char_poll(struct file *filp, poll_table *wait)
+{
+	unsigned int                 number = MINOR(file_inode(filp)->i_rdev);
+	struct companion_char_priv  *priv   = filp->private_data;
+	struct companion_char_minor *minor  = &priv->minors[number];
+	unsigned int                 mask   = 0;
+
+	poll_wait(filp, &minor->writewait, wait);
+	poll_wait(filp, &minor->readwait,  wait);
+
+	mutex_lock(&minor->writelock);
+	if (!companion_io_txq_is_full(priv->parent))
+		mask |= POLLOUT | POLLWRNORM;
+	mutex_unlock(&minor->writelock);
+
+	mutex_lock(&minor->readlock);
+	if (!companion_io_rxq_is_empty(priv->parent))
+		mask |= POLLIN | POLLRDNORM;
+	mutex_unlock(&minor->readlock);
+
+	return mask;
+}
+
+/**
+ * companion_char_open() - open callback
+ * @inode: address of the associated inode
+ * @filp:  address of the associated virtual file
+ */
+static int companion_char_open(struct inode *inode, struct file *filp)
+{
+	struct companion_char_priv *priv = container_of(
+						inode->i_cdev,
+						struct companion_char_priv,
+						cdev);
+
+	filp->private_data = priv;
+	nonseekable_open(inode, filp);
+	return 0;
+}
+
+/**
+ * companion_char_release() - release callback
+ * @inode: address of the associated inode
+ * @filp:  address of the associated virtual file
+ */
+static int companion_char_release(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations companion_char_ops = {
+	.owner   = THIS_MODULE,
+	.llseek  = no_llseek,
+	.read    = companion_char_read,
+	.write   = companion_char_write,
+	.poll    = companion_char_poll,
+	.open    = companion_char_open,
+	.release = companion_char_release,
+};
+
+/**
+ * companion_char_on_tx_done() - tx done callback
+ * @data: address of user supplied callback data
+ */
+static void companion_char_on_tx_done(void *data)
+{
+	struct companion_char_priv  *priv = data;
+	struct companion_char_minor *minor = &priv->minors[0];
+
+	wake_up_interruptible(&minor->writewait);
+}
+
+/**
+ * companion_char_on_rx_done() - rx done callback
+ * @data: address of user supplied callback data
+ */
+static void companion_char_on_rx_done(void *data)
+{
+	struct companion_char_priv  *priv  = data;
+	struct companion_char_minor *minor = &priv->minors[0];
+
+	wake_up_interruptible(&minor->readwait);
+}
+
+static struct companion_io_ops companion_char_io_ops = {
+	.on_tx_done = companion_char_on_tx_done,
+	.on_rx_done = companion_char_on_rx_done,
+};
+
+/**
+ * companion_char_probe() - probe callback
+ * @pdev: address of the platform device
+ */
+static int companion_char_probe(struct platform_device *pdev)
+{
+	struct companion_char_priv  *priv;
+	struct companion_char_minor *minors;
+	int                          err;
+
+	if (!pdev->dev.parent) {
+		dev_err(&pdev->dev, "no parent device found\n");
+		return -ENODEV;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->parent = pdev->dev.parent;
+
+	minors = devm_kzalloc(&pdev->dev, sizeof(*minors), GFP_KERNEL);
+	if (!minors)
+		return -ENOMEM;
+
+	minors->dev = device_create(companion_char_class,
+				    &pdev->dev,
+				    MKDEV(MAJOR(devt), 0),
+				    priv,
+				    "companion%d",
+				    0);
+	if (IS_ERR_OR_NULL(minors->dev))
+		return PTR_ERR_OR_ZERO(minors->dev);
+	priv->minors = minors;
+
+	mutex_init(&minors->writelock);
+	mutex_init(&minors->readlock);
+	init_waitqueue_head(&minors->writewait);
+	init_waitqueue_head(&minors->readwait);
+
+	cdev_init(&priv->cdev, &companion_char_ops);
+	err = cdev_add(&priv->cdev, MKDEV(MAJOR(devt), 0), 1);
+	if (err) {
+		dev_err(&pdev->dev, "cdev_add() failed: %d\n", err);
+		goto on_error;
+	}
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	err = companion_io_ops_register(priv->parent,
+					&companion_char_io_ops,
+					priv);
+	if (err) {
+		dev_err(&pdev->dev, "companion_io_ops_register() failed: %d\n",
+			err);
+		goto on_error;
+	}
+	return 0;
+
+on_error:
+	device_destroy(companion_char_class, MKDEV(MAJOR(devt), 0));
+	cdev_del(&priv->cdev);
+	return err;
+}
+
+/**
+ * companion_char_remove() - remove callback
+ * @pdev: address of the platform device
+ */
+static int companion_char_remove(struct platform_device *pdev)
+{
+	struct companion_char_priv *priv = dev_get_drvdata(&pdev->dev);
+
+	companion_io_ops_unregister(priv->parent);
+	device_destroy(companion_char_class, MKDEV(MAJOR(devt), 0));
+	cdev_del(&priv->cdev);
+	return 0;
+}
+
+static const struct of_device_id companion_char_of_match[] = {
+	{ .compatible = "bosch,companion-char", .data = NULL, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, companion_char_of_match);
+
+static struct platform_driver companion_char_driver = {
+	.driver = {
+		.name           = DRIVER_NAME,
+		.of_match_table = of_match_ptr(companion_char_of_match),
+	},
+	.probe  = companion_char_probe,
+	.remove = companion_char_remove,
+};
+
+/**
+ * companion_char_init() - module init
+ */
+static int __init companion_char_init(void)
+{
+	int err;
+
+	companion_char_class = class_create(THIS_MODULE, DRIVER_NAME);
+	if (IS_ERR_OR_NULL(companion_char_class))
+		return PTR_ERR_OR_ZERO(companion_char_class);
+
+	err = alloc_chrdev_region(&devt, 0, 1, DRIVER_NAME);
+	if (err) {
+		class_destroy(companion_char_class);
+		return err;
+	}
+
+	err = platform_driver_register(&companion_char_driver);
+	if (err) {
+		class_destroy(companion_char_class);
+		unregister_chrdev_region(devt, 1);
+	}
+
+	return err;
+}
+
+/**
+ * companion_char_exit() - module exit
+ */
+static void __exit companion_char_exit(void)
+{
+	platform_driver_unregister(&companion_char_driver);
+	class_destroy(companion_char_class);
+	unregister_chrdev_region(devt, 1);
+}
+
+module_init(companion_char_init);
+module_exit(companion_char_exit);
+
+MODULE_AUTHOR("Zhu Yi <yi.zhu5@cn.bosch.com>");
+MODULE_DESCRIPTION("Companion upper level character device");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

