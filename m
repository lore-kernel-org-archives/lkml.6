Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1234C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9725220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9725220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbeGXGjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:39:11 -0400
Received: from gate.crashing.org ([63.228.1.57]:58163 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388146AbeGXGjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:39:11 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6O55JLI028169;
        Tue, 24 Jul 2018 00:05:27 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/5] fsi: sbefifo: Convert to use the new chardev
Date:   Tue, 24 Jul 2018 15:05:16 +1000
Message-Id: <20180724050519.31920-3-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180724050519.31920-1-benh@kernel.crashing.org>
References: <20180724050519.31920-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts FSI sbefifo to use the new fsi-core controlled
chardev allocator and use a real cdev instead of a miscdev.

One side effect is to fix the object lifetime by removing
the use of devm_kzalloc() for something that contains kobjects,
and using proper reference counting.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-sbefifo.c | 84 +++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 29 deletions(-)

diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
index 33a5d9a43a07..8a185f53c9d8 100644
--- a/drivers/fsi/fsi-sbefifo.c
+++ b/drivers/fsi/fsi-sbefifo.c
@@ -17,9 +17,8 @@
 #include <linux/fs.h>
 #include <linux/fsi.h>
 #include <linux/fsi-sbefifo.h>
-#include <linux/idr.h>
 #include <linux/kernel.h>
-#include <linux/miscdevice.h>
+#include <linux/cdev.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -118,11 +117,11 @@ struct sbefifo {
 	uint32_t		magic;
 #define SBEFIFO_MAGIC		0x53424546 /* "SBEF" */
 	struct fsi_device	*fsi_dev;
-	struct miscdevice	mdev;
+	struct device		dev;
+	struct cdev		cdev;
 	struct mutex		lock;
-	char			name[32];
-	int			idx;
 	bool			broken;
+	bool			dead;
 	bool			async_ffdc;
 };
 
@@ -133,9 +132,9 @@ struct sbefifo_user {
 	size_t			pending_len;
 };
 
-static DEFINE_IDA(sbefifo_ida);
 static DEFINE_MUTEX(sbefifo_ffdc_mutex);
 
+
 static void __sbefifo_dump_ffdc(struct device *dev, const __be32 *ffdc,
 				size_t ffdc_sz, bool internal)
 {
@@ -667,6 +666,9 @@ static int __sbefifo_submit(struct sbefifo *sbefifo,
 	struct device *dev = &sbefifo->fsi_dev->dev;
 	int rc;
 
+	if (sbefifo->dead)
+		return -ENODEV;
+
 	if (cmd_len < 2 || be32_to_cpu(command[0]) != cmd_len) {
 		dev_vdbg(dev, "Invalid command len %zd (header: %d)\n",
 			 cmd_len, be32_to_cpu(command[0]));
@@ -751,8 +753,7 @@ EXPORT_SYMBOL_GPL(sbefifo_submit);
  */
 static int sbefifo_user_open(struct inode *inode, struct file *file)
 {
-	struct sbefifo *sbefifo = container_of(file->private_data,
-					       struct sbefifo, mdev);
+	struct sbefifo *sbefifo = container_of(inode->i_cdev, struct sbefifo, cdev);
 	struct sbefifo_user *user;
 
 	user = kzalloc(sizeof(struct sbefifo_user), GFP_KERNEL);
@@ -889,6 +890,14 @@ static const struct file_operations sbefifo_fops = {
 	.release	= sbefifo_user_release,
 };
 
+static void sbefifo_free(struct device *dev)
+{
+	struct sbefifo *sbefifo = container_of(dev, struct sbefifo, dev);
+
+	put_device(&sbefifo->fsi_dev->dev);
+	kfree(sbefifo);
+}
+
 /*
  * Probe/remove
  */
@@ -900,15 +909,23 @@ static int sbefifo_probe(struct device *dev)
 	struct device_node *np;
 	struct platform_device *child;
 	char child_name[32];
-	int rc, child_idx = 0;
+	int rc, didx, child_idx = 0;
 
 	dev_dbg(dev, "Found sbefifo device\n");
 
-	sbefifo = devm_kzalloc(dev, sizeof(*sbefifo), GFP_KERNEL);
+	sbefifo = kzalloc(sizeof(*sbefifo), GFP_KERNEL);
 	if (!sbefifo)
 		return -ENOMEM;
+
+	/* Grab a reference to the device (parent of our cdev), we'll drop it later */
+	if (!get_device(dev)) {
+		return -ENODEV;
+		kfree(sbefifo);
+	}
+
 	sbefifo->magic = SBEFIFO_MAGIC;
 	sbefifo->fsi_dev = fsi_dev;
+	dev_set_drvdata(dev, sbefifo);
 	mutex_init(&sbefifo->lock);
 
 	/*
@@ -919,28 +936,30 @@ static int sbefifo_probe(struct device *dev)
 	if (rc && rc != -ESHUTDOWN)
 		dev_err(dev, "Initial HW cleanup failed, will retry later\n");
 
-	sbefifo->idx = ida_simple_get(&sbefifo_ida, 1, INT_MAX, GFP_KERNEL);
-	snprintf(sbefifo->name, sizeof(sbefifo->name), "sbefifo%d",
-		 sbefifo->idx);
+	/* Create chardev for userspace access */
+	sbefifo->dev.type = &fsi_cdev_type;
+	sbefifo->dev.parent = dev;
+	sbefifo->dev.release = sbefifo_free;
+	device_initialize(&sbefifo->dev);
 
-	dev_set_drvdata(dev, sbefifo);
+	/* Allocate a minor in the FSI space */
+	rc = fsi_get_new_minor(fsi_dev, fsi_dev_sbefifo, &sbefifo->dev.devt, &didx);
+	if (rc)
+		goto err;
 
-	/* Create misc chardev for userspace access */
-	sbefifo->mdev.minor = MISC_DYNAMIC_MINOR;
-	sbefifo->mdev.fops = &sbefifo_fops;
-	sbefifo->mdev.name = sbefifo->name;
-	sbefifo->mdev.parent = dev;
-	rc = misc_register(&sbefifo->mdev);
+	dev_set_name(&sbefifo->dev, "sbefifo%d", didx);
+	cdev_init(&sbefifo->cdev, &sbefifo_fops);
+	rc = cdev_device_add(&sbefifo->cdev, &sbefifo->dev);
 	if (rc) {
-		dev_err(dev, "Failed to register miscdevice: %d\n", rc);
-		ida_simple_remove(&sbefifo_ida, sbefifo->idx);
-		return rc;
+		dev_err(dev, "Error %d creating char device %s\n",
+			rc, dev_name(&sbefifo->dev));
+		goto err_free_minor;
 	}
 
 	/* Create platform devs for dts child nodes (occ, etc) */
 	for_each_available_child_of_node(dev->of_node, np) {
 		snprintf(child_name, sizeof(child_name), "%s-dev%d",
-			 sbefifo->name, child_idx++);
+			 dev_name(&sbefifo->dev), child_idx++);
 		child = of_platform_device_create(np, child_name, dev);
 		if (!child)
 			dev_warn(dev, "failed to create child %s dev\n",
@@ -948,6 +967,11 @@ static int sbefifo_probe(struct device *dev)
 	}
 
 	return 0;
+ err_free_minor:
+	fsi_free_minor(sbefifo->dev.devt);
+ err:
+	put_device(&sbefifo->dev);
+	return rc;
 }
 
 static int sbefifo_unregister_child(struct device *dev, void *data)
@@ -967,10 +991,14 @@ static int sbefifo_remove(struct device *dev)
 
 	dev_dbg(dev, "Removing sbefifo device...\n");
 
-	misc_deregister(&sbefifo->mdev);
-	device_for_each_child(dev, NULL, sbefifo_unregister_child);
+	mutex_lock(&sbefifo->lock);
+	sbefifo->dead = true;
+	mutex_unlock(&sbefifo->lock);
 
-	ida_simple_remove(&sbefifo_ida, sbefifo->idx);
+	cdev_device_del(&sbefifo->cdev, &sbefifo->dev);
+	fsi_free_minor(sbefifo->dev.devt);
+	device_for_each_child(dev, NULL, sbefifo_unregister_child);
+	put_device(&sbefifo->dev);
 
 	return 0;
 }
@@ -1001,8 +1029,6 @@ static int sbefifo_init(void)
 static void sbefifo_exit(void)
 {
 	fsi_driver_unregister(&sbefifo_drv);
-
-	ida_destroy(&sbefifo_ida);
 }
 
 module_init(sbefifo_init);
-- 
2.17.1

