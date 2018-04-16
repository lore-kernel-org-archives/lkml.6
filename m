Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbeDPOCn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:02:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55517 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755241AbeDPOCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:02:42 -0400
To: ebiggers3@gmail.com, dvyukov@google.com
Cc: syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in blkdev_reread_part
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <001a11446e86e97ceb055cf07f4e@google.com> <CACT4Y+bGjnajib6P4a0SxYkNUJpg_x8abEkec8AR+oBmC=-QUQ@mail.gmail.com> <CACT4Y+bGjnajib6P4a0SxYkNUJpg_x8abEkec8AR+oBmC=-QUQ@mail.gmail.com>
In-Reply-To: <20171105201834.GA8126@zzz.localdomain>
Message-Id: <201804162302.GBI43737.OLFSOFQHVJMFtO@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Mon, 16 Apr 2018 23:02:29 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Biggers wrote:
> Here's a simplified reproducer:
> 
>   #include <fcntl.h>
>   #include <linux/loop.h>
>   #include <sys/ioctl.h>
>   #include <unistd.h>
> 
>   int main()
>   {
>           int loopfd, fd;
>           struct loop_info info = { .lo_flags = LO_FLAGS_PARTSCAN };
> 
>           loopfd = open("/dev/loop0", O_RDWR);
> 
>           fd = open("/bin/ls", O_RDONLY);
> 
>           ioctl(loopfd, LOOP_SET_FD, fd);
> 
>           ioctl(loopfd, LOOP_SET_STATUS, &info);
>   }
> 
> It still needs to be compiled with -m32.  The reason is that lo_ioctl() has:
> 
>   mutex_lock_nested(&lo->lo_ctl_mutex, 1);
> 
> but lo_compat_ioctl() has:
> 
>   mutex_lock(&lo->lo_ctl_mutex);
> 
> But ->lo_ctl_mutex isn't actually being nested under itself, so I don't think
> the "nested" annotation is actually appropriate.

Yes, I think we should try

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c9d0449..70d6736 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1366,7 +1366,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
-	err = mutex_lock_killable_nested(&lo->lo_ctl_mutex, 1);
+	err = mutex_lock_killable(&lo->lo_ctl_mutex);
 	if (err)
 		goto out_unlocked;
 

and check what the lockdep says. Use of "_nested" version could be the cause of
various hung up without lockdep warning.

> 
> It seems that ->bd_mutex is held while opening and closing block devices, which
> should rank it above both ->lo_ctl_mutex and loop_index_mutex (see lo_open() and
> lo_release()).
> 
> But blkdev_reread_part(), which takes ->bd_mutex, is called from some of the
> ioctls while ->lo_ctl_mutex is held.
> 
> Perhaps we should call blkdev_reread_part() at the end of the ioctls, after
> ->lo_ctl_mutex has been dropped?  But it looks like that can do I/O to the
> device, which probably could race with loop_clr_fd()...
> 
> Or perhaps we should just take both locks for the ioctls, in the order
> ->bd_mutex, then ->lo_ctl_mutex -- and then use __blkdev_reread_part()?

But do we really need ->lo_ctl_mutex ? What is the purpose of ->lo_ctl_mutex ?
If the purpose of ->lo_ctl_mutex is to serialize ioctl() request against each
loop device when multiple threads opened the same loop device, I feel that

  There is no need to use ->lo_ctl_mutex which the lockdep will check and
  complain, provided that ioctl() request cannot recurse into ioctl() request.
  Instead, we can use simple flag variable whether an ioctl() is in progress.
 
  There is no need to use ->lo_ctl_mutex from __lo_release(), for it is
  guaranteed that there is no in-flight ioctl() request when __lo_release()
  is called, and loop_index_mutex is blocking further open() requests.

and simplify like below.

Also, what is wrong with not using LO_FLAGS_AUTOCLEAR when ->lo_refcnt > 1?
As long as each ioctl() are serialized, I feel there should be no problem.
I think it is strange to fail below case just because somebody else (not
limited to blkid command) opened the same device.

  #include <fcntl.h>
  #include <linux/loop.h>
  #include <sys/ioctl.h>
  #include <unistd.h>
  int main(int argc, char *argv[])
  {
    int fd = open("/dev/loop0", O_RDWR);
    int fd2 = open("/bin/ls", O_RDONLY);
    int fd3 = open("/bin/cat", O_RDONLY);
    ioctl(fd, LOOP_SET_FD, fd2);
    ioctl(fd, LOOP_CLR_FD, fd2);
    ioctl(fd, LOOP_SET_FD, fd3); /* <= 0 or EBUSY depending on whether somebody else is opening /dev/loop0 */
    ioctl(fd, LOOP_CLR_FD, fd3);
    return 0;
  }

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c9d0449..3910e5b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -993,6 +993,38 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	return err;
 }
 
+static int loop_lock_for_ioctl(struct loop_device *lo)
+{
+	while (1) {
+		int err = mutex_lock_killable(&lo->lo_ctl_mutex);
+		if (err)
+			return err;
+		if (!lo->ioctl_in_progress) {
+			lo->ioctl_in_progress = true;
+			mutex_unlock(&lo->lo_ctl_mutex);
+			return 0;
+		}
+		mutex_unlock(&lo->lo_ctl_mutex);
+		schedule_timeout_killable(1);
+	}
+}
+
+static void loop_lock_wait_for_ioctl_completion(struct loop_device *lo)
+{
+	while (1) {
+		mutex_lock(&lo->lo_ctl_mutex);
+		if (!lo->ioctl_in_progress)
+			return;
+		mutex_unlock(&lo->lo_ctl_mutex);
+		schedule_timeout_uninterruptible(1);
+	}
+}
+
+static void loop_unlock_for_ioctl(struct loop_device *lo)
+{
+	lo->ioctl_in_progress = false;
+}
+
 static int loop_clr_fd(struct loop_device *lo)
 {
 	struct file *filp = lo->lo_backing_file;
@@ -1002,22 +1034,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
-	/*
-	 * If we've explicitly asked to tear down the loop device,
-	 * and it has an elevated reference count, set it for auto-teardown when
-	 * the last reference goes away. This stops $!~#$@ udev from
-	 * preventing teardown because it decided that it needs to run blkid on
-	 * the loopback device whenever they appear. xfstests is notorious for
-	 * failing tests because blkid via udev races with a losetup
-	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
-	 * command to fail with EBUSY.
-	 */
-	if (atomic_read(&lo->lo_refcnt) > 1) {
-		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		mutex_unlock(&lo->lo_ctl_mutex);
-		return 0;
-	}
-
 	if (filp == NULL)
 		return -EINVAL;
 
@@ -1066,7 +1082,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
 	loop_unprepare_queue(lo);
-	mutex_unlock(&lo->lo_ctl_mutex);
 	/*
 	 * Need not hold lo_ctl_mutex to fput backing file.
 	 * Calling fput holding lo_ctl_mutex triggers a circular
@@ -1175,10 +1190,8 @@ static int loop_clr_fd(struct loop_device *lo)
 	struct kstat stat;
 	int ret;
 
-	if (lo->lo_state != Lo_bound) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
-	}
 
 	memset(info, 0, sizeof(*info));
 	info->lo_number = lo->lo_number;
@@ -1197,7 +1210,6 @@ static int loop_clr_fd(struct loop_device *lo)
 
 	/* Drop lo_ctl_mutex while we call into the filesystem. */
 	file = get_file(lo->lo_backing_file);
-	mutex_unlock(&lo->lo_ctl_mutex);
 	ret = vfs_getattr(&file->f_path, &stat, STATX_INO,
 			  AT_STATX_SYNC_AS_STAT);
 	if (!ret) {
@@ -1289,10 +1301,8 @@ static int loop_clr_fd(struct loop_device *lo)
 	struct loop_info64 info64;
 	int err;
 
-	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+	if (!arg)
 		return -EINVAL;
-	}
 	err = loop_get_status(lo, &info64);
 	if (!err)
 		err = loop_info64_to_old(&info64, &info);
@@ -1307,10 +1317,8 @@ static int loop_clr_fd(struct loop_device *lo)
 	struct loop_info64 info64;
 	int err;
 
-	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+	if (!arg)
 		return -EINVAL;
-	}
 	err = loop_get_status(lo, &info64);
 	if (!err && copy_to_user(arg, &info64, sizeof(info64)))
 		err = -EFAULT;
@@ -1366,9 +1374,9 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
-	err = mutex_lock_killable_nested(&lo->lo_ctl_mutex, 1);
+	err = loop_lock_for_ioctl(lo);
 	if (err)
-		goto out_unlocked;
+		return err;
 
 	switch (cmd) {
 	case LOOP_SET_FD:
@@ -1378,10 +1386,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		err = loop_change_fd(lo, bdev, arg);
 		break;
 	case LOOP_CLR_FD:
-		/* loop_clr_fd would have unlocked lo_ctl_mutex on success */
 		err = loop_clr_fd(lo);
-		if (!err)
-			goto out_unlocked;
 		break;
 	case LOOP_SET_STATUS:
 		err = -EPERM;
@@ -1391,8 +1396,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_old(lo, (struct loop_info __user *) arg);
-		/* loop_get_status() unlocks lo_ctl_mutex */
-		goto out_unlocked;
+		break;
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1401,8 +1405,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	case LOOP_GET_STATUS64:
 		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
-		/* loop_get_status() unlocks lo_ctl_mutex */
-		goto out_unlocked;
+		break;
 	case LOOP_SET_CAPACITY:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1421,9 +1424,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
-	mutex_unlock(&lo->lo_ctl_mutex);
-
-out_unlocked:
+	loop_unlock_for_ioctl(lo);
 	return err;
 }
 
@@ -1537,10 +1538,8 @@ struct compat_loop_info {
 	struct loop_info64 info64;
 	int err;
 
-	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+	if (!arg)
 		return -EINVAL;
-	}
 	err = loop_get_status(lo, &info64);
 	if (!err)
 		err = loop_info64_to_compat(&info64, arg);
@@ -1555,20 +1554,20 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = mutex_lock_killable(&lo->lo_ctl_mutex);
-		if (!err) {
-			err = loop_set_status_compat(lo,
-						     (const struct compat_loop_info __user *)arg);
-			mutex_unlock(&lo->lo_ctl_mutex);
-		}
+		err = loop_lock_for_ioctl(lo);
+		if (err)
+			return err;
+		err = loop_set_status_compat(lo,
+					     (const struct compat_loop_info __user *)arg);
+		loop_unlock_for_ioctl(lo);
 		break;
 	case LOOP_GET_STATUS:
-		err = mutex_lock_killable(&lo->lo_ctl_mutex);
-		if (!err) {
-			err = loop_get_status_compat(lo,
-						     (struct compat_loop_info __user *)arg);
-			/* loop_get_status() unlocks lo_ctl_mutex */
-		}
+		err = loop_lock_for_ioctl(lo);
+		if (err)
+			return err;
+		err = loop_get_status_compat(lo,
+					     (struct compat_loop_info __user *)arg);
+		loop_unlock_for_ioctl(lo);
 		break;
 	case LOOP_SET_CAPACITY:
 	case LOOP_CLR_FD:
@@ -1612,7 +1611,11 @@ static void __lo_release(struct loop_device *lo)
 	if (atomic_dec_return(&lo->lo_refcnt))
 		return;
 
-	mutex_lock(&lo->lo_ctl_mutex);
+	/*
+	 * lo->lo_refcnt won't become 0 while ioctl() is in progress.
+	 * lo->lo_refcnt will remain 0 because loop_index_mutex is held.
+	 * Therefore, we do not need to lock for exclusion control here, do we?
+	 */
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		/*
 		 * In autoclear mode, stop the loop thread
@@ -1629,8 +1632,6 @@ static void __lo_release(struct loop_device *lo)
 		blk_mq_freeze_queue(lo->lo_queue);
 		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
-
-	mutex_unlock(&lo->lo_ctl_mutex);
 }
 
 static void lo_release(struct gendisk *disk, fmode_t mode)
@@ -1676,7 +1677,7 @@ static int unregister_transfer_cb(int id, void *ptr, void *data)
 	struct loop_device *lo = ptr;
 	struct loop_func_table *xfer = data;
 
-	mutex_lock(&lo->lo_ctl_mutex);
+	loop_lock_wait_for_ioctl_completion(lo);
 	if (lo->lo_encryption == xfer)
 		loop_release_xfer(lo);
 	mutex_unlock(&lo->lo_ctl_mutex);
@@ -1973,21 +1974,21 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
-		ret = mutex_lock_killable(&lo->lo_ctl_mutex);
+		ret = loop_lock_for_ioctl(lo);
 		if (ret)
 			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
-			mutex_unlock(&lo->lo_ctl_mutex);
+			loop_unlock_for_ioctl(lo);
 			break;
 		}
 		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
-			mutex_unlock(&lo->lo_ctl_mutex);
+			loop_unlock_for_ioctl(lo);
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
-		mutex_unlock(&lo->lo_ctl_mutex);
+		loop_unlock_for_ioctl(lo);
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
 		break;
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 0f45416..c27d88b 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -58,6 +58,7 @@ struct loop_device {
 	struct kthread_worker	worker;
 	struct task_struct	*worker_task;
 	bool			use_dio;
+	bool			ioctl_in_progress; 
 
 	struct request_queue	*lo_queue;
 	struct blk_mq_tag_set	tag_set;
