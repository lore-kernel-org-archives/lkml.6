Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F58AC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3076C21736
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3076C21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbeHNUSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:18:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387619AbeHNUSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:18:45 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4814140B;
        Tue, 14 Aug 2018 17:30:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.17 10/97] scsi: sr: Avoid that opening a CD-ROM hangs with runtime power management enabled
Date:   Tue, 14 Aug 2018 19:16:22 +0200
Message-Id: <20180814171433.582794439@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/sr.c |   29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -523,18 +523,26 @@ static int sr_init_command(struct scsi_c
 static int sr_block_open(struct block_device *bdev, fmode_t mode)
 {
 	struct scsi_cd *cd;
+	struct scsi_device *sdev;
 	int ret = -ENXIO;
 
+	cd = scsi_cd_get(bdev->bd_disk);
+	if (!cd)
+		goto out;
+
+	sdev = cd->device;
+	scsi_autopm_get_device(sdev);
 	check_disk_change(bdev);
 
 	mutex_lock(&sr_mutex);
-	cd = scsi_cd_get(bdev->bd_disk);
-	if (cd) {
-		ret = cdrom_open(&cd->cdi, bdev, mode);
-		if (ret)
-			scsi_cd_put(cd);
-	}
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
 
@@ -562,6 +570,8 @@ static int sr_block_ioctl(struct block_d
 	if (ret)
 		goto out;
 
+	scsi_autopm_get_device(sdev);
+
 	/*
 	 * Send SCSI addressing ioctls directly to mid level, send other
 	 * ioctls to cdrom/block level.
@@ -570,15 +580,18 @@ static int sr_block_ioctl(struct block_d
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
 
 	ret = scsi_ioctl(sdev, cmd, argp);
 
+put:
+	scsi_autopm_put_device(sdev);
+
 out:
 	mutex_unlock(&sr_mutex);
 	return ret;


