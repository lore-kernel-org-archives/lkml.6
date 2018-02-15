Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720231-2-14049902056037654857
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720230; b=kYLivwtWnTcPl/ebcePC3ngxoo0uwLCrEsPt2LYrzcBi56g
    7KKnV0swYkDNI60nCxL9C6LVlG+FBKHSdnTad91fMKod1dCZl47mQ0vh5KymK/q4
    jriwS3USpQwYjoJIv2QWpvOPS3wJx7POTuBZSu/V4zjj3EmjD2se8PnnbW21SAdM
    phBiZh8PsfXNOOJH+Red0W0n/y/qxj14WHPOeVFpGHAXmPrOQAPz2of6NKLO8Zx3
    i3mKKyWBxC5G8VOJwwCvfukY+ZKBMFpBf/UKXHuNOe4YN4FQsELAlI9qhQkoFgsU
    73ynK22EqM50FSpxhpKCm9o6S3uKXcERimdLyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720230; bh=TiKHeoS8PcePWiy7fwkXQ+mz+K
    JgBEZ0EQO6jP83OaU=; b=ZrVJcyHXGT7z2CY/QMGON9Ub1UPU2WRvPva+CiCc6E
    BdIhfBkZMy2ULxD44r77HrPzIALjaqYmobgTeDUfEYbLBgdQVYzbEqnvBYVMeJG2
    xF90IgU4Dt7h60FKZrcMop/n5EEkC3AkoMuSIKpCE42HKkfMvG246PvnDStu6U1T
    sWECsLxbL5sUDKnvbaTOJbZYPAhOxWJOjjkb4HaIVu/GclpALrEYBg/y6SsMNHCr
    Sy1g08jfvtB2fD6ma26i/e9VsrIUssJHjuErNCqSAkN6sdQOZqgt++mn1GO8/dhc
    xEbq0w15HY91D/O7zBWBiBCzjRuQmU29ryEcv8l2m1Vg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162627AbeBOSne (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:43:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162622AbeBOPXS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bradley Bolen <bradleybolen@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.4 058/108] ubi: block: Fix locking for idr_alloc/idr_remove
Date: Thu, 15 Feb 2018 16:16:55 +0100
Message-Id: <20180215151230.542409737@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bradley Bolen <bradleybolen@gmail.com>

commit 7f29ae9f977bcdc3654e68bc36d170223c52fd48 upstream.

This fixes a race with idr_alloc where gd->first_minor can be set to the
same value for two simultaneous calls to ubiblock_create.  Each instance
calls device_add_disk with the same first_minor.  device_add_disk calls
bdi_register_owner which generates several warnings.

WARNING: CPU: 1 PID: 179 at kernel-source/fs/sysfs/dir.c:31
sysfs_warn_dup+0x68/0x88
sysfs: cannot create duplicate filename '/devices/virtual/bdi/252:2'

WARNING: CPU: 1 PID: 179 at kernel-source/lib/kobject.c:240
kobject_add_internal+0x1ec/0x2f8
kobject_add_internal failed for 252:2 with -EEXIST, don't try to
register things with the same name in the same directory

WARNING: CPU: 1 PID: 179 at kernel-source/fs/sysfs/dir.c:31
sysfs_warn_dup+0x68/0x88
sysfs: cannot create duplicate filename '/dev/block/252:2'

However, device_add_disk does not error out when bdi_register_owner
returns an error.  Control continues until reaching blk_register_queue.
It then BUGs.

kernel BUG at kernel-source/fs/sysfs/group.c:113!
[<c01e26cc>] (internal_create_group) from [<c01e2950>]
(sysfs_create_group+0x20/0x24)
[<c01e2950>] (sysfs_create_group) from [<c00e3d38>]
(blk_trace_init_sysfs+0x18/0x20)
[<c00e3d38>] (blk_trace_init_sysfs) from [<c02bdfbc>]
(blk_register_queue+0xd8/0x154)
[<c02bdfbc>] (blk_register_queue) from [<c02cec84>]
(device_add_disk+0x194/0x44c)
[<c02cec84>] (device_add_disk) from [<c0436ec8>]
(ubiblock_create+0x284/0x2e0)
[<c0436ec8>] (ubiblock_create) from [<c0427bb8>]
(vol_cdev_ioctl+0x450/0x554)
[<c0427bb8>] (vol_cdev_ioctl) from [<c0189110>] (vfs_ioctl+0x30/0x44)
[<c0189110>] (vfs_ioctl) from [<c01892e0>] (do_vfs_ioctl+0xa0/0x790)
[<c01892e0>] (do_vfs_ioctl) from [<c0189a14>] (SyS_ioctl+0x44/0x68)
[<c0189a14>] (SyS_ioctl) from [<c0010640>] (ret_fast_syscall+0x0/0x34)

Locking idr_alloc/idr_remove removes the race and keeps gd->first_minor
unique.

Fixes: 2bf50d42f3a4 ("UBI: block: Dynamically allocate minor numbers")
Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/ubi/block.c |   42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -99,6 +99,8 @@ struct ubiblock {
 
 /* Linked list of all ubiblock instances */
 static LIST_HEAD(ubiblock_devices);
+static DEFINE_IDR(ubiblock_minor_idr);
+/* Protects ubiblock_devices and ubiblock_minor_idr */
 static DEFINE_MUTEX(devices_mutex);
 static int ubiblock_major;
 
@@ -354,8 +356,6 @@ static struct blk_mq_ops ubiblock_mq_ops
 	.map_queue      = blk_mq_map_queue,
 };
 
-static DEFINE_IDR(ubiblock_minor_idr);
-
 int ubiblock_create(struct ubi_volume_info *vi)
 {
 	struct ubiblock *dev;
@@ -368,14 +368,15 @@ int ubiblock_create(struct ubi_volume_in
 	/* Check that the volume isn't already handled */
 	mutex_lock(&devices_mutex);
 	if (find_dev_nolock(vi->ubi_num, vi->vol_id)) {
-		mutex_unlock(&devices_mutex);
-		return -EEXIST;
+		ret = -EEXIST;
+		goto out_unlock;
 	}
-	mutex_unlock(&devices_mutex);
 
 	dev = kzalloc(sizeof(struct ubiblock), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
+	if (!dev) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
 
 	mutex_init(&dev->dev_mutex);
 
@@ -440,14 +441,13 @@ int ubiblock_create(struct ubi_volume_in
 		goto out_free_queue;
 	}
 
-	mutex_lock(&devices_mutex);
 	list_add_tail(&dev->list, &ubiblock_devices);
-	mutex_unlock(&devices_mutex);
 
 	/* Must be the last step: anyone can call file ops from now on */
 	add_disk(dev->gd);
 	dev_info(disk_to_dev(dev->gd), "created from ubi%d:%d(%s)",
 		 dev->ubi_num, dev->vol_id, vi->name);
+	mutex_unlock(&devices_mutex);
 	return 0;
 
 out_free_queue:
@@ -460,6 +460,8 @@ out_put_disk:
 	put_disk(dev->gd);
 out_free_dev:
 	kfree(dev);
+out_unlock:
+	mutex_unlock(&devices_mutex);
 
 	return ret;
 }
@@ -481,30 +483,36 @@ static void ubiblock_cleanup(struct ubib
 int ubiblock_remove(struct ubi_volume_info *vi)
 {
 	struct ubiblock *dev;
+	int ret;
 
 	mutex_lock(&devices_mutex);
 	dev = find_dev_nolock(vi->ubi_num, vi->vol_id);
 	if (!dev) {
-		mutex_unlock(&devices_mutex);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_unlock;
 	}
 
 	/* Found a device, let's lock it so we can check if it's busy */
 	mutex_lock(&dev->dev_mutex);
 	if (dev->refcnt > 0) {
-		mutex_unlock(&dev->dev_mutex);
-		mutex_unlock(&devices_mutex);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out_unlock_dev;
 	}
 
 	/* Remove from device list */
 	list_del(&dev->list);
-	mutex_unlock(&devices_mutex);
-
 	ubiblock_cleanup(dev);
 	mutex_unlock(&dev->dev_mutex);
+	mutex_unlock(&devices_mutex);
+
 	kfree(dev);
 	return 0;
+
+out_unlock_dev:
+	mutex_unlock(&dev->dev_mutex);
+out_unlock:
+	mutex_unlock(&devices_mutex);
+	return ret;
 }
 
 static int ubiblock_resize(struct ubi_volume_info *vi)
@@ -633,6 +641,7 @@ static void ubiblock_remove_all(void)
 	struct ubiblock *next;
 	struct ubiblock *dev;
 
+	mutex_lock(&devices_mutex);
 	list_for_each_entry_safe(dev, next, &ubiblock_devices, list) {
 		/* The module is being forcefully removed */
 		WARN_ON(dev->desc);
@@ -641,6 +650,7 @@ static void ubiblock_remove_all(void)
 		ubiblock_cleanup(dev);
 		kfree(dev);
 	}
+	mutex_unlock(&devices_mutex);
 }
 
 int __init ubiblock_init(void)
