Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC67AC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE1C20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE1C20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbeKLFsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50182 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730285AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000oJ-EK; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001or-Ux; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Bart Van Assche" <bart.vanassche@wdc.com>,
        "Johannes Thumshirn" <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Maurizio Lombardi" <mlombard@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.856369616@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 308/366] scsi: sr: Avoid that opening a CD-ROM hangs
 with runtime power management enabled
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 1214fd7b497400d200e3f4e64e2338b303a20949 upstream.

Surround scsi_execute() calls with scsi_autopm_get_device() and
scsi_autopm_put_device(). Note: removing sr_mutex protection from the
scsi_cd_get() and scsi_cd_put() calls is safe because the purpose of
sr_mutex is to serialize cdrom_*() calls.

This patch avoids that complaints similar to the following appear in the
kernel log if runtime power management is enabled:

INFO: task systemd-udevd:650 blocked for more than 120 seconds.
     Not tainted 4.18.0-rc7-dbg+ #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
systemd-udevd   D28176   650    513 0x00000104
Call Trace:
__schedule+0x444/0xfe0
schedule+0x4e/0xe0
schedule_preempt_disabled+0x18/0x30
__mutex_lock+0x41c/0xc70
mutex_lock_nested+0x1b/0x20
__blkdev_get+0x106/0x970
blkdev_get+0x22c/0x5a0
blkdev_open+0xe9/0x100
do_dentry_open.isra.19+0x33e/0x570
vfs_open+0x7c/0xd0
path_openat+0x6e3/0x1120
do_filp_open+0x11c/0x1c0
do_sys_open+0x208/0x2d0
__x64_sys_openat+0x59/0x70
do_syscall_64+0x77/0x230
entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Maurizio Lombardi <mlombard@redhat.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.16:
 - Update one extra "goto out" in sr_block_ioctl() and delete the unused
   label
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -521,16 +521,25 @@ static int sr_init_command(struct scsi_c
 static int sr_block_open(struct block_device *bdev, fmode_t mode)
 {
 	struct scsi_cd *cd;
+	struct scsi_device *sdev;
 	int ret = -ENXIO;
 
-	mutex_lock(&sr_mutex);
 	cd = scsi_cd_get(bdev->bd_disk);
-	if (cd) {
-		ret = cdrom_open(&cd->cdi, bdev, mode);
-		if (ret)
-			scsi_cd_put(cd);
-	}
+	if (!cd)
+		goto out;
+
+	sdev = cd->device;
+	scsi_autopm_get_device(sdev);
+
+	mutex_lock(&sr_mutex);
+	ret = cdrom_open(&cd->cdi, bdev, mode);
 	mutex_unlock(&sr_mutex);
+
+	scsi_autopm_put_device(sdev);
+	if (ret)
+		scsi_cd_put(cd);
+
+out:
 	return ret;
 }
 
@@ -553,6 +562,8 @@ static int sr_block_ioctl(struct block_d
 
 	mutex_lock(&sr_mutex);
 
+	scsi_autopm_get_device(sdev);
+
 	/*
 	 * Send SCSI addressing ioctls directly to mid level, send other
 	 * ioctls to cdrom/block level.
@@ -561,12 +572,12 @@ static int sr_block_ioctl(struct block_d
 	case SCSI_IOCTL_GET_IDLUN:
 	case SCSI_IOCTL_GET_BUS_NUMBER:
 		ret = scsi_ioctl(sdev, cmd, argp);
-		goto out;
+		goto put;
 	}
 
 	ret = cdrom_ioctl(&cd->cdi, bdev, mode, cmd, arg);
 	if (ret != -ENOSYS)
-		goto out;
+		goto put;
 
 	/*
 	 * ENODEV means that we didn't recognise the ioctl, or that we
@@ -577,10 +588,12 @@ static int sr_block_ioctl(struct block_d
 	ret = scsi_nonblockable_ioctl(sdev, cmd, argp,
 					(mode & FMODE_NDELAY) != 0);
 	if (ret != -ENODEV)
-		goto out;
+		goto put;
 	ret = scsi_ioctl(sdev, cmd, argp);
 
-out:
+put:
+	scsi_autopm_put_device(sdev);
+
 	mutex_unlock(&sr_mutex);
 	return ret;
 }

