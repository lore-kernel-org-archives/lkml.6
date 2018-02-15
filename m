Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226NAwFIA5RaV/St+MDUdQlvELrAI7VeumHkPgaA5hoJ2IoQJFcHvxB0CHExszZg/QQ2fCap
ARC-Seal: i=1; a=rsa-sha256; t=1518708842; cv=none;
        d=google.com; s=arc-20160816;
        b=AohUwAqynNVHz9H04mIL+Qrtc2hZQaEN5nNGMgyTIKrtYoaLf0lygqWgyrQjbPYlHW
         jQFXAHGJPIf2Bqaqzxd1IXK3y21BvrrZml3IvjTZTJlQzksKuRx5aICbm3enkelfwdy6
         dAllVaxJ6gb+w67ucmSyYT+WDa/UG0cuDMENAr2DVC9VywJ8BACElIOPgFaY5mXUvCrS
         /GUsgt5+E2IZ7zoxsmtDy0XRgmirrL429SpPaLwuqo64eS2uAWZ3v1mt3v9bYTH1ez9i
         GIktrT/RNvFglrzMXImrGSFsYWfCQ2LrESlUJCak4VYUGbWf4oPjEOmFsr6MaInPmH5r
         D/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ar+JU5WhEMotKjvx6B1N9M4/4zX/XqfcXgZwmALeFc4=;
        b=b/o6OZOVmb/TY7lbqwH7Qn03dWwY0oTt3s4fhGtaHuKB75mqXZ14G5L/+U7PjjKnDi
         nk4friOFF/CA+Jzz6GQHEmPm7NMvJ2jx6kDV5CRzQKHqNXd6kufpwCzpeWZk34uslAlQ
         otZkwoZmSeYB42bfculCA0H00/BfuT1Gz+4IBA/wchLuDoVP58PDmwo1HpMPbZBjBdTQ
         i5ER8dauT/QPU78fVSWPtkLfyqjVNA5gDJVw58IlA3yjPyJPYS1GY6CTCxRCa6bRKHrT
         0db1TBo4kW98LmqUjEFB96S6cNhjcSfaEgDOIS2+rMdV46DM9tpF2tsc2SpqN4OsqHbF
         l8pw==
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
Subject: [PATCH 4.14 101/195] ubi: block: Fix locking for idr_alloc/idr_remove
Date: Thu, 15 Feb 2018 16:16:32 +0100
Message-Id: <20180215151710.748564324@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480969135641331?=
X-GMAIL-MSGID: =?utf-8?q?1592481643338470796?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
