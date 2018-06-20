Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BDAC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394D9205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394D9205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754183AbeFTCdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:33:39 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:59191 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbeFTCdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:33:38 -0400
X-Originating-IP: 70.80.172.8
Received: from localhost (modemcable008.172-80-70.mc.videotron.ca [70.80.172.8])
        (Authenticated sender: hle@owl.eu.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8C5D0240004;
        Wed, 20 Jun 2018 02:33:36 +0000 (UTC)
Date:   Tue, 19 Jun 2018 22:33:26 -0400
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] staging: pi433: fix race condition in pi433_open
Message-ID: <20180620023326.GA30440@hle-laptop.local>
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
Changes in v2:
    - Remove useless users counter.
    - Remove unneeded TODO entry in ioctl().
    - Move rx buffer {de,}allocation to probe() and remove().
---
diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 94e0bfcec991..a5aa9c5bc6fd 100644
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
 
@@ -1178,6 +1152,11 @@ static int pi433_probe(struct spi_device *spi)
 	device->tx_active = false;
 	device->interrupt_rx_allowed = false;
 
+	/* init rx buffer */
+	device->rx_buffer = kmalloc(MAX_MSG_SIZE, GFP_KERNEL);
+	if (!device->rx_buffer)
+		return -ENOMEM;
+
 	/* init wait queues */
 	init_waitqueue_head(&device->tx_wait_queue);
 	init_waitqueue_head(&device->rx_wait_queue);
@@ -1280,6 +1259,7 @@ static int pi433_probe(struct spi_device *spi)
 minor_failed:
 	free_gpio(device);
 GPIO_failed:
+	kfree(device->rx_buffer);
 	kfree(device);
 
 	return retval;
@@ -1303,8 +1283,8 @@ static int pi433_remove(struct spi_device *spi)
 
 	pi433_free_minor(device);
 
-	if (device->users == 0)
-		kfree(device);
+	kfree(device->rx_buffer);
+	kfree(device);
 
 	return 0;
 }
-- 
2.17.1
