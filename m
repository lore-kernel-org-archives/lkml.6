Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A34CC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6842087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276844;
	bh=B/PUPY5A2pq2iECcyYkQEBiGrF9GKC3lThMY2nXtTLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mO+KY6Nf4LqDU1/4WprlN13TJBtq6iI9pTRo9GRMiuvi/M7trfIYjaJthpGALSY3m
	 Gob17q8iRRvrrAuddBfqwIOCT5IxhI0f4uG9tgyG1TbtOuXh7B3OwHKZqh1tf89dTw
	 eacVWPMY3Ioh2aVesm/8eJu2rx/okhXEtT3QiFzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfBDKkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:40:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730043AbfBDKkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B6182087C;
        Mon,  4 Feb 2019 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276832;
        bh=B/PUPY5A2pq2iECcyYkQEBiGrF9GKC3lThMY2nXtTLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6uqfUhZAfmi662skBFc6f+3MEWhweT7xSJK/zQ45Fzr5fu6vq2IrYMxaQO4ZD6Tu
         nhkpnTTJ4yCXcn3f/a4esUwTlccZm+QrEZbpiUHbL9D0H0//b1RcIexdpHrqauKqx+
         KfM2NwrgcYsDC/sX5wQatJv7WmZtD/frnj/fsyKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 30/65] Revert "loop: Get rid of loop_index_mutex"
Date:   Mon,  4 Feb 2019 11:36:23 +0100
Message-Id: <20190204103615.879470556@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 611f77199cd763e6b7c0462c2f199ddb3a089750 which is
commit 0a42e99b58a208839626465af194cfe640ef9493 upstream.

It is not needed in the 4.4.y tree at this time.

Reported-by: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/loop.c |   39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -81,6 +81,7 @@
 #include <asm/uaccess.h>
 
 static DEFINE_IDR(loop_index_idr);
+static DEFINE_MUTEX(loop_index_mutex);
 static DEFINE_MUTEX(loop_ctl_mutex);
 
 static int max_part;
@@ -1570,11 +1571,9 @@ static int lo_compat_ioctl(struct block_
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo;
-	int err;
+	int err = 0;
 
-	err = mutex_lock_killable(&loop_ctl_mutex);
-	if (err)
-		return err;
+	mutex_lock(&loop_index_mutex);
 	lo = bdev->bd_disk->private_data;
 	if (!lo) {
 		err = -ENXIO;
@@ -1583,7 +1582,7 @@ static int lo_open(struct block_device *
 
 	atomic_inc(&lo->lo_refcnt);
 out:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&loop_index_mutex);
 	return err;
 }
 
@@ -1592,11 +1591,12 @@ static void lo_release(struct gendisk *d
 	struct loop_device *lo;
 	int err;
 
-	mutex_lock(&loop_ctl_mutex);
+	mutex_lock(&loop_index_mutex);
 	lo = disk->private_data;
 	if (atomic_dec_return(&lo->lo_refcnt))
-		goto out_unlock;
+		goto unlock_index;
 
+	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		/*
 		 * In autoclear mode, stop the loop thread
@@ -1604,7 +1604,7 @@ static void lo_release(struct gendisk *d
 		 */
 		err = loop_clr_fd(lo);
 		if (!err)
-			return;
+			goto unlock_index;
 	} else {
 		/*
 		 * Otherwise keep thread (if running) and config,
@@ -1613,8 +1613,9 @@ static void lo_release(struct gendisk *d
 		loop_flush(lo);
 	}
 
-out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
+unlock_index:
+	mutex_unlock(&loop_index_mutex);
 }
 
 static const struct block_device_operations lo_fops = {
@@ -1896,7 +1897,7 @@ static struct kobject *loop_probe(dev_t
 	struct kobject *kobj;
 	int err;
 
-	mutex_lock(&loop_ctl_mutex);
+	mutex_lock(&loop_index_mutex);
 	err = loop_lookup(&lo, MINOR(dev) >> part_shift);
 	if (err < 0)
 		err = loop_add(&lo, MINOR(dev) >> part_shift);
@@ -1904,7 +1905,7 @@ static struct kobject *loop_probe(dev_t
 		kobj = NULL;
 	else
 		kobj = get_disk(lo->lo_disk);
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&loop_index_mutex);
 
 	*part = 0;
 	return kobj;
@@ -1914,13 +1915,9 @@ static long loop_control_ioctl(struct fi
 			       unsigned long parm)
 {
 	struct loop_device *lo;
-	int ret;
-
-	ret = mutex_lock_killable(&loop_ctl_mutex);
-	if (ret)
-		return ret;
+	int ret = -ENOSYS;
 
-	ret = -ENOSYS;
+	mutex_lock(&loop_index_mutex);
 	switch (cmd) {
 	case LOOP_CTL_ADD:
 		ret = loop_lookup(&lo, parm);
@@ -1934,6 +1931,7 @@ static long loop_control_ioctl(struct fi
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
+		mutex_lock(&loop_ctl_mutex);
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
 			mutex_unlock(&loop_ctl_mutex);
@@ -1945,6 +1943,7 @@ static long loop_control_ioctl(struct fi
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
+		mutex_unlock(&loop_ctl_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
 		break;
@@ -1954,7 +1953,7 @@ static long loop_control_ioctl(struct fi
 			break;
 		ret = loop_add(&lo, -1);
 	}
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&loop_index_mutex);
 
 	return ret;
 }
@@ -2037,10 +2036,10 @@ static int __init loop_init(void)
 				  THIS_MODULE, loop_probe, NULL, NULL);
 
 	/* pre-create number of devices given by config or max_loop */
-	mutex_lock(&loop_ctl_mutex);
+	mutex_lock(&loop_index_mutex);
 	for (i = 0; i < nr; i++)
 		loop_add(&lo, i);
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&loop_index_mutex);
 
 	printk(KERN_INFO "loop: module loaded\n");
 	return 0;


