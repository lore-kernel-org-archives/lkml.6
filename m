Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC38AC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B997220879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078624;
	bh=hyXqKx7g0AZxMhbu5m9cyNRjFasu+C8dDe6dQLa8CjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D4NuXBmkyI1vPGPwplamshvycDI1lFoX3JNDg3RtQtGD+bhQnNbEAm3ZZaNbjglw9
	 knmH0RxLr75pMyGTAPUxo0QVKpP7eU8LgXe6iBic1rkRxWkQO59ZMO7wuseAv68ohL
	 rUz/pdI8cQWwRXaqBXk9nlMVQY8ulnBbubECQfnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbfAUNuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:32880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730520AbfAUNuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084D12063F;
        Mon, 21 Jan 2019 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078619;
        bh=hyXqKx7g0AZxMhbu5m9cyNRjFasu+C8dDe6dQLa8CjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AYEc2ugtaLHPw0MbT20qV/qlKYEkbSbfcKtx12duEUf53Dmh0TUQCkHLERqnH9Gl+
         XHfUk+Dy33h3PTt2j1TJ0qORgYghV2jMCHu4n0dd/TGQnX2/8c0bM076+Zb2CLAPK4
         rVixj1Xee/WSO8ZPTOUL5xQIwCe9cbxaKwIRnECA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.20 096/111] loop: Get rid of loop_index_mutex
Date:   Mon, 21 Jan 2019 14:43:30 +0100
Message-Id: <20190121122506.497422699@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 0a42e99b58a208839626465af194cfe640ef9493 upstream.

Now that loop_ctl_mutex is global, just get rid of loop_index_mutex as
there is no good reason to keep these two separate and it just
complicates the locking.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -83,7 +83,6 @@
 #include <linux/uaccess.h>
 
 static DEFINE_IDR(loop_index_idr);
-static DEFINE_MUTEX(loop_index_mutex);
 static DEFINE_MUTEX(loop_ctl_mutex);
 
 static int max_part;
@@ -1626,9 +1625,11 @@ static int lo_compat_ioctl(struct block_
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo;
-	int err = 0;
+	int err;
 
-	mutex_lock(&loop_index_mutex);
+	err = mutex_lock_killable(&loop_ctl_mutex);
+	if (err)
+		return err;
 	lo = bdev->bd_disk->private_data;
 	if (!lo) {
 		err = -ENXIO;
@@ -1637,7 +1638,7 @@ static int lo_open(struct block_device *
 
 	atomic_inc(&lo->lo_refcnt);
 out:
-	mutex_unlock(&loop_index_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 	return err;
 }
 
@@ -1646,12 +1647,11 @@ static void lo_release(struct gendisk *d
 	struct loop_device *lo;
 	int err;
 
-	mutex_lock(&loop_index_mutex);
+	mutex_lock(&loop_ctl_mutex);
 	lo = disk->private_data;
 	if (atomic_dec_return(&lo->lo_refcnt))
-		goto unlock_index;
+		goto out_unlock;
 
-	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		/*
 		 * In autoclear mode, stop the loop thread
@@ -1659,7 +1659,7 @@ static void lo_release(struct gendisk *d
 		 */
 		err = loop_clr_fd(lo);
 		if (!err)
-			goto unlock_index;
+			return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,
@@ -1669,9 +1669,8 @@ static void lo_release(struct gendisk *d
 		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
 
+out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
-unlock_index:
-	mutex_unlock(&loop_index_mutex);
 }
 
 static const struct block_device_operations lo_fops = {
@@ -1972,7 +1971,7 @@ static struct kobject *loop_probe(dev_t
 	struct kobject *kobj;
 	int err;
 
-	mutex_lock(&loop_index_mutex);
+	mutex_lock(&loop_ctl_mutex);
 	err = loop_lookup(&lo, MINOR(dev) >> part_shift);
 	if (err < 0)
 		err = loop_add(&lo, MINOR(dev) >> part_shift);
@@ -1980,7 +1979,7 @@ static struct kobject *loop_probe(dev_t
 		kobj = NULL;
 	else
 		kobj = get_disk_and_module(lo->lo_disk);
-	mutex_unlock(&loop_index_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 
 	*part = 0;
 	return kobj;
@@ -1990,9 +1989,13 @@ static long loop_control_ioctl(struct fi
 			       unsigned long parm)
 {
 	struct loop_device *lo;
-	int ret = -ENOSYS;
+	int ret;
 
-	mutex_lock(&loop_index_mutex);
+	ret = mutex_lock_killable(&loop_ctl_mutex);
+	if (ret)
+		return ret;
+
+	ret = -ENOSYS;
 	switch (cmd) {
 	case LOOP_CTL_ADD:
 		ret = loop_lookup(&lo, parm);
@@ -2006,9 +2009,6 @@ static long loop_control_ioctl(struct fi
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
-		ret = mutex_lock_killable(&loop_ctl_mutex);
-		if (ret)
-			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
 			mutex_unlock(&loop_ctl_mutex);
@@ -2020,7 +2020,6 @@ static long loop_control_ioctl(struct fi
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
-		mutex_unlock(&loop_ctl_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
 		break;
@@ -2030,7 +2029,7 @@ static long loop_control_ioctl(struct fi
 			break;
 		ret = loop_add(&lo, -1);
 	}
-	mutex_unlock(&loop_index_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 
 	return ret;
 }
@@ -2114,10 +2113,10 @@ static int __init loop_init(void)
 				  THIS_MODULE, loop_probe, NULL, NULL);
 
 	/* pre-create number of devices given by config or max_loop */
-	mutex_lock(&loop_index_mutex);
+	mutex_lock(&loop_ctl_mutex);
 	for (i = 0; i < nr; i++)
 		loop_add(&lo, i);
-	mutex_unlock(&loop_index_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 
 	printk(KERN_INFO "loop: module loaded\n");
 	return 0;


