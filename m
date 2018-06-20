Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D6EC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB02D20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB02D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754099AbeFTNhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:37:25 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:54237 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbeFTNhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:37:24 -0400
X-Originating-IP: 208.88.110.46
Received: from localhost (mtl.savoirfairelinux.net [208.88.110.46])
        (Authenticated sender: hle@owl.eu.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A5D591BF203;
        Wed, 20 Jun 2018 13:37:29 +0000 (UTC)
Date:   Wed, 20 Jun 2018 09:37:19 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3] staging: pi433: fix race condition in pi433_open
Message-ID: <20180620133719.GA17525@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device structure contains a useless non-atomic users counter which
is subject to race conditions. It has probably been created to handle
the case where remove is executed while operations are still executing
on open fds but this will never happen because of reference counts.

Drop the users counter and move rx buffer {de,}allocation to probe()
and remove(). Remove associated dead code from open() and release().
Remove related TODO entry from ioctl().

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
Changes in v3:
    - add missing free call in probe() (in case of failure during
      memory allocation for rx buffer).
---
diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 94e0bfcec991..0638fd5f14d9 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -78,7 +78,6 @@ struct pi433_device {
 	struct device		*dev;
 	struct cdev		*cdev;
 	struct spi_device	*spi;
-	unsigned int		users;
 
 	/* irq related values */
 	struct gpio_desc	*gpiod[NUM_DIO];
@@ -887,9 +886,6 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (_IOC_TYPE(cmd) != PI433_IOC_MAGIC)
 		return -ENOTTY;
 
-	/* TODO? guard against device removal before, or while,
-	 * we issue this ioctl. --> device_get()
-	 */
 	instance = filp->private_data;
 	device = instance->device;
 
@@ -963,19 +959,9 @@ static int pi433_open(struct inode *inode, struct file *filp)
 		return -ENODEV;
 	}
 
-	if (!device->rx_buffer) {
-		device->rx_buffer = kmalloc(MAX_MSG_SIZE, GFP_KERNEL);
-		if (!device->rx_buffer)
-			return -ENOMEM;
-	}
-
-	device->users++;
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
-	if (!instance) {
-		kfree(device->rx_buffer);
-		device->rx_buffer = NULL;
+	if (!instance)
 		return -ENOMEM;
-	}
 
 	/* setup instance data*/
 	instance->device = device;
@@ -992,23 +978,11 @@ static int pi433_open(struct inode *inode, struct file *filp)
 static int pi433_release(struct inode *inode, struct file *filp)
 {
 	struct pi433_instance	*instance;
-	struct pi433_device	*device;
 
 	instance = filp->private_data;
-	device = instance->device;
 	kfree(instance);
 	filp->private_data = NULL;
 
-	/* last close? */
-	device->users--;
-
-	if (!device->users) {
-		kfree(device->rx_buffer);
-		device->rx_buffer = NULL;
-		if (!device->spi)
-			kfree(device);
-	}
-
 	return 0;
 }
 
@@ -1178,6 +1152,13 @@ static int pi433_probe(struct spi_device *spi)
 	device->tx_active = false;
 	device->interrupt_rx_allowed = false;
 
+	/* init rx buffer */
+	device->rx_buffer = kmalloc(MAX_MSG_SIZE, GFP_KERNEL);
+	if (!device->rx_buffer) {
+		retval = -ENOMEM;
+		goto RX_failed;
+	}
+
 	/* init wait queues */
 	init_waitqueue_head(&device->tx_wait_queue);
 	init_waitqueue_head(&device->rx_wait_queue);
@@ -1280,6 +1261,8 @@ static int pi433_probe(struct spi_device *spi)
 minor_failed:
 	free_gpio(device);
 GPIO_failed:
+	kfree(device->rx_buffer);
+RX_failed:
 	kfree(device);
 
 	return retval;
@@ -1303,8 +1286,8 @@ static int pi433_remove(struct spi_device *spi)
 
 	pi433_free_minor(device);
 
-	if (device->users == 0)
-		kfree(device);
+	kfree(device->rx_buffer);
+	kfree(device);
 
 	return 0;
 }
-- 
2.17.1
