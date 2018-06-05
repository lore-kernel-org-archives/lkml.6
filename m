Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeFESqN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:46:13 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:59782 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbeFESqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:46:07 -0400
X-AuditID: 0a3aad16-be7ff70000000413-47-5b16da6972f9
From: Mark Jonas <mark.jonas@de.bosch.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>, <yi.zhu5@cn.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH 3/5] char: implement companion-char driver
Date: Tue, 5 Jun 2018 20:43:58 +0200
Message-ID: <1528224240-30786-4-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sb0wTZxzHee6u1+Pk5vUK9Wc7nLuZkDnRCsw0zi1ke0ET2cYb4yZZ5gEn
        vUhb1isdGOe6gWY6ZJhBpAUZY/6bf+JGBpRhk1EXRKM1gWAoU9yiLvxTx5gCW3S7o2D7Yu9+
        z/f7+9z3eb45Cue6tUZKcrhFl0Mo4UmaoDeeTU2Xhg355pvTpCVw4xZuOTVTj1sGfmwiLeda
        6whLb4vBcmykS5NNWpv9fYR1qv8XZP3isdk63bYij9hGbyoSSySP6Fr32nba9tUPA5rScGH5
        jWAj4UUDbx5AiRSwWRCcCuMHEE1xbAMGt+9FtNFDEMHp3/4lo4cOBJ3XzhMqQrKrIdIXwNU5
        md0CjXf3EeoSzn6L4O6Jq5hq6NmNMDZ8nFRngl0FHaf3zQMMmwO9/nZtNHsFRML75/VE1gr/
        7L0/r3PKTrgtTET3dXDJd2d+xlmAntFRvBYt9cdZ/jirBWGnUIosmT32DLMlY62rQJR3mdev
        LXTa21C0UUMAVfYUhRBLIT6Jmewx5HMawSNX2EPoZQrjU5g1rYr0TIGzqMImyLb3XWUloswb
        GZSQkMDpn8pyWYFdkmXJ6QghoHA+mRH6FY4pEip2iS5nFAshE0Xwy5g72X9s49hiwS3uFMVS
        0bXovkJRPDDWiALqXGKxWL5DKnEv2nxqNNMQ78THYlRiCGVSSUp27ZCaLZcKdlkqXsCXR3Fu
        UY2hl9Eb1JMHddU4RzicDtG4jCHUK7Dqpq3M8fQGxmeZI5eS87mUOCP2lXE0iJQO9cxKFU5S
        ftxYNjABfdO7nG5BjEEZXysMO2eC4SEGRh6YwD8lwf2WPdB2qArB0UgjgsZb/QiaAw8RjM7O
        IJi7V4/B1MQ5DCYj3RiM3WwiYLrqJAFD410E1IR6CWgI7tXAkPdLDfRN1pFQdfBvEv46e0YL
        Y74JSsVoGKyfoGH2yiMauvr+XAJnfD8z0LW/dSmED1/TwZOGI3o42dSsB19Nu35cKRVTSv29
        XK+W6hbc/1Pqghp7mdGLsOuixzmy+dAFb+qm7PTn5mAmZ09ed/pHJuvsr+/UlLsvvJiWpmtf
        Vdn/Sa731W++v/05lnv+4tvatM9eyhl8L7vT58v7dEOn5/mD1blzH17ZnfkB3Xs08zv/9p+y
        1ryVX/iCvWNgHZ+1c+Vyk1D5sXfw4Uzthq0Fk0t6Hm+pfr05iB0mr/OEbBPWr8ZdsvAfpX3E
        ok4EAAA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yi <yi.zhu5@cn.bosch.com>

The upper level companion-char driver provides character device
interface to userspace for communicate IO messages with the
companion processor.

Signed-off-by: Zhu Yi <yi.zhu5@cn.bosch.com>
Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
---
 drivers/char/Kconfig          |   7 +
 drivers/char/Makefile         |   2 +
 drivers/char/companion-char.c | 367 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 376 insertions(+)
 create mode 100644 drivers/char/companion-char.c

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
index 7dc3abe..dfe4fc1 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -60,3 +60,5 @@ js-rtc-y = rtc.o
 obj-$(CONFIG_TILE_SROM)		+= tile-srom.o
 obj-$(CONFIG_XILLYBUS)		+= xillybus/
 obj-$(CONFIG_POWERNV_OP_PANEL)	+= powernv-op-panel.o
+
+obj-$(CONFIG_COMPANION_CHAR)	+= companion-char.o
diff --git a/drivers/char/companion-char.c b/drivers/char/companion-char.c
new file mode 100644
index 0000000..3c198f2
--- /dev/null
+++ b/drivers/char/companion-char.c
@@ -0,0 +1,367 @@
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
+#define DRIVER_NAME "bosch,companion-char"
+
+/*TODO: get from protocol.h*/
+#define COMPANION_PACKET_SIZE 16
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
+                                   char __user *buf,
+                                   size_t       count,
+                                   loff_t      *offset)
+{
+	unsigned int                 number = MINOR(file_inode(filp)->i_rdev);
+	struct companion_char_priv  *priv   = filp->private_data;
+	struct companion_char_minor *minor  = &priv->minors[number];
+	int                          status;
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
+		                     !companion_io_rxq_is_empty(priv->parent)))
+			return -ERESTARTSYS;
+		if (mutex_lock_interruptible(&minor->readlock))
+			return -ERESTARTSYS;
+	}
+
+	status = companion_do_io_rx(priv->parent, buf, count);
+	mutex_unlock(&minor->readlock);
+	return status;
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
+                                    const char __user *buf,
+                                    size_t             count,
+                                    loff_t            *offset)
+{
+	unsigned int                 number = MINOR(file_inode(filp)->i_rdev);
+	struct companion_char_priv  *priv   = filp->private_data;
+	struct companion_char_minor *minor  = &priv->minors[number];
+	int                          status;
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
+	status = companion_do_io_tx(priv->parent, buf, count);
+	mutex_unlock(&minor->writelock);
+	return status;
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
+	                                        inode->i_cdev,
+	                                        struct companion_char_priv,
+	                                        cdev);
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
+	                            &pdev->dev,
+	                            MKDEV(MAJOR(devt), 0),
+	                            priv,
+	                            "companion%d",
+	                            0);
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
+	                                &companion_char_io_ops,
+	                                priv);
+	if (err) {
+		dev_err(&pdev->dev, "companion_io_ops_register() failed: %d\n",
+		        err);
+		goto on_error;
+	}
+	return 0;
+
+on_error:
+	device_destroy(companion_char_class, MKDEV(MAJOR(devt), 0));
+	cdev_del(&priv->cdev);
+	return err;
+
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
+	{ .compatible = DRIVER_NAME, .data = NULL, },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, companion_char_of_match);
+
+static struct platform_driver companion_char_driver = {
+	.driver = {
+		.name           = DRIVER_NAME,
+		.owner          = THIS_MODULE,
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
+		printk("companion:alloc_chrdev_region() failed: %d\n", err);
+		class_destroy(companion_char_class);
+		return err;
+	}
+
+	err = platform_driver_register(&companion_char_driver);
+	if (err) {
+		printk("companion:platform_driver_register() failed: %d\n",
+		       err);
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
