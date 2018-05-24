Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZphCgJC/Dzy0RoeJVQAyi+ntRqa+ZjXZdMrf/rkVk2K/NAPgqCwTyhbFqe1EwPzzRJBGNET
ARC-Seal: i=1; a=rsa-sha256; t=1527156161; cv=none;
        d=google.com; s=arc-20160816;
        b=fZixA9OmXvRnUE9R6V6yI0LTnjNtkVqLXd9uqsUuREGFinjq3pUPpQY7CQMmh8nf9X
         tteyHSq+HWaBL/qWPDY0QgRpPCQPgpgYBaKv2NQpCAlCUocSgpfBq8Xhh8wwIE1K1f2y
         SRH7rdt8oYy/j4XOrgRo9SQWQJfX+AwxHI4ctRz6aZFqJGSOX2AKtsfSnxTQqXtpsRk2
         DPOvupTuPGcsdoAv6rgSrntm0FhAjzjPNdlTAyhnvbMh6mYJSNB68YjpfePcKe3rAUlM
         yILneW5Gj4fYSzE2Z0WMBPHUVjCkZNMlZbJvwZbIuaBiKpQ9S7dGDTQdfunlHmIIo+35
         rasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=wr6oDSkdNCsUmM4/Mqs8/Pbg71No6yAhLSs9ZbX1pl0=;
        b=n/rgPxsqKfNKHEn1UH5LPZplI2FASFau7SBMlJVsP0MDwmuzg7aHzBMfcaQD8BKxtn
         a2EKJyUbo1zic8RvI19E6tI1LAVYp7RD6mFnLVxZtYATdFQCekJcjnbA/rvsPzrxZD7T
         wpkV0yOn/nO4b8tEpY5Hphxvq9pWV1Wyb7lsWMeuyQsnMlu7pTJyaxfvC1246O+vYfrf
         cJcw1PQuwI8BwyIrkFImPogu+ycHhKx5EOnrrdhZ8iNBJciTjRmrQaBfKjQ8p1ZOiIUg
         LF11bpeaJm8qDEFAi2auQPu0YVGkKQPvjfaMakUzEar2ciH/e8G6V0sedD3WupYIbZ3Q
         Dg2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LuOOpETs;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LuOOpETs;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 085/161] loop: dont call into filesystem while holding lo_ctl_mutex
Date: Thu, 24 May 2018 11:38:30 +0200
Message-Id: <20180524093028.668538813@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338712721159846?=
X-GMAIL-MSGID: =?utf-8?q?1601339299126316949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

commit 2d1d4c1e591fd40bd7dafd868a249d7d00e215d5 upstream.

We hit an issue where a loop device on NFS was stuck in
loop_get_status() doing vfs_getattr() after the NFS server died, which
caused a pile-up of uninterruptible processes waiting on lo_ctl_mutex.
There's no reason to hold this lock while we wait on the filesystem;
let's drop it so that other processes can do their thing. We need to
grab a reference on lo_backing_file while we use it, and we can get rid
of the check on lo_device, which has been unnecessary since commit
a34c0ae9ebd6 ("[PATCH] loop: remove the bio remapping capability") in
the linux-history tree.

Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1171,21 +1171,17 @@ loop_set_status(struct loop_device *lo,
 static int
 loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 {
-	struct file *file = lo->lo_backing_file;
+	struct file *file;
 	struct kstat stat;
-	int error;
+	int ret;
 
-	if (lo->lo_state != Lo_bound)
+	if (lo->lo_state != Lo_bound) {
+		mutex_unlock(&lo->lo_ctl_mutex);
 		return -ENXIO;
-	error = vfs_getattr(&file->f_path, &stat,
-			    STATX_INO, AT_STATX_SYNC_AS_STAT);
-	if (error)
-		return error;
+	}
+
 	memset(info, 0, sizeof(*info));
 	info->lo_number = lo->lo_number;
-	info->lo_device = huge_encode_dev(stat.dev);
-	info->lo_inode = stat.ino;
-	info->lo_rdevice = huge_encode_dev(lo->lo_device ? stat.rdev : stat.dev);
 	info->lo_offset = lo->lo_offset;
 	info->lo_sizelimit = lo->lo_sizelimit;
 	info->lo_flags = lo->lo_flags;
@@ -1198,7 +1194,19 @@ loop_get_status(struct loop_device *lo,
 		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
 		       lo->lo_encrypt_key_size);
 	}
-	return 0;
+
+	/* Drop lo_ctl_mutex while we call into the filesystem. */
+	file = get_file(lo->lo_backing_file);
+	mutex_unlock(&lo->lo_ctl_mutex);
+	ret = vfs_getattr(&file->f_path, &stat, STATX_INO,
+			  AT_STATX_SYNC_AS_STAT);
+	if (!ret) {
+		info->lo_device = huge_encode_dev(stat.dev);
+		info->lo_inode = stat.ino;
+		info->lo_rdevice = huge_encode_dev(stat.rdev);
+	}
+	fput(file);
+	return ret;
 }
 
 static void
@@ -1378,7 +1386,8 @@ static int lo_ioctl(struct block_device
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_old(lo, (struct loop_info __user *) arg);
-		break;
+		/* loop_get_status() unlocks lo_ctl_mutex */
+		goto out_unlocked;
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1387,7 +1396,8 @@ static int lo_ioctl(struct block_device
 		break;
 	case LOOP_GET_STATUS64:
 		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
-		break;
+		/* loop_get_status() unlocks lo_ctl_mutex */
+		goto out_unlocked;
 	case LOOP_SET_CAPACITY:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1548,7 +1558,7 @@ static int lo_compat_ioctl(struct block_
 		mutex_lock(&lo->lo_ctl_mutex);
 		err = loop_get_status_compat(
 			lo, (struct compat_loop_info __user *) arg);
-		mutex_unlock(&lo->lo_ctl_mutex);
+		/* loop_get_status() unlocks lo_ctl_mutex */
 		break;
 	case LOOP_SET_CAPACITY:
 	case LOOP_CLR_FD:
