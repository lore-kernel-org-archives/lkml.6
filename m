Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2243PhYPoH2sPkhNJhuTmRfanlXZpzj7I4F8WFfb8mgRPAkIFy2IK9lQl4Lw0Jh3KbZdnTlw
ARC-Seal: i=1; a=rsa-sha256; t=1518709370; cv=none;
        d=google.com; s=arc-20160816;
        b=qaJL+RXW5pYd8/Q5VIH2ZGgn4AukRCVI/XiJfkbM2g3QkAn9XKA1Bxxs0Q8dfGJZfm
         2YQVuI1aLACrVnb4CZIQjPY5iAb6nEPhSGFDjYpjhMyhqsDq8S1x7RyFkR6BLYCWyjC+
         tSvaYrv4LzNtS92B1vzPu4wF/uod79b6Oye8KahilHiY3Ka5mnQTc1dmkfP9ItLw2+1C
         OOOTgQgjCjfNB7Jjhj9z5b6f3wPeplywueKgmSftAgZ86BwIX7HqpoGNjnBhZOignj/3
         Henw63mwbayQvZGZ8zV7uSkKgKg0zSO+Qd86SA8vi6aLJerej3yi+hBnJBWztnD4nyii
         Zeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J8+4sDIhICT0REfbeucIHleNRaoSNkLyfTV9Mv5k7ao=;
        b=LaV7ZIx5qEi2MC1lyxXbgMHY8IwsR9SizelGcU0ckVpzJNcoPN2AnTAms8VzPck9mC
         toXELC/Hz9JV6wVD1uZ8wbfS6scoJjHMVOO8wh89KC+m68Guinx+KjkgESmiKa7+xhSt
         CLkGxu3AMztwARUI3fRafFS6ar7ryNdSkr0iSQsuLNufd/8aGcn8o08dLktziHvS+FXh
         +xMzi5UXt0loOI5qbJK0mdE5ayUYwld258lT5dlrxqZR8ht+VmyvfIKpYrjqcUgU+l0P
         DgibWzhuYXqN5uxsphEsrbloi6B8QQ5SsEPtLakiv4LqILKpGFzU7uljW/kUZwrnCx8K
         b1HA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bradley Bolen <bradleybolen@gmail.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 4.15 094/202] ubi: block: Fix locking for idr_alloc/idr_remove
Date: Thu, 15 Feb 2018 16:16:34 +0100
Message-Id: <20180215151718.310891276@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480969135641331?=
X-GMAIL-MSGID: =?utf-8?q?1592482196631051743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -351,8 +353,6 @@ static const struct blk_mq_ops ubiblock_
 	.init_request	= ubiblock_init_request,
 };
 
-static DEFINE_IDR(ubiblock_minor_idr);
-
 int ubiblock_create(struct ubi_volume_info *vi)
 {
 	struct ubiblock *dev;
@@ -365,14 +365,15 @@ int ubiblock_create(struct ubi_volume_in
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
 
@@ -437,14 +438,13 @@ int ubiblock_create(struct ubi_volume_in
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
@@ -457,6 +457,8 @@ out_put_disk:
 	put_disk(dev->gd);
 out_free_dev:
 	kfree(dev);
+out_unlock:
+	mutex_unlock(&devices_mutex);
 
 	return ret;
 }
@@ -478,30 +480,36 @@ static void ubiblock_cleanup(struct ubib
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
@@ -630,6 +638,7 @@ static void ubiblock_remove_all(void)
 	struct ubiblock *next;
 	struct ubiblock *dev;
 
+	mutex_lock(&devices_mutex);
 	list_for_each_entry_safe(dev, next, &ubiblock_devices, list) {
 		/* The module is being forcefully removed */
 		WARN_ON(dev->desc);
@@ -638,6 +647,7 @@ static void ubiblock_remove_all(void)
 		ubiblock_cleanup(dev);
 		kfree(dev);
 	}
+	mutex_unlock(&devices_mutex);
 }
 
 int __init ubiblock_init(void)
