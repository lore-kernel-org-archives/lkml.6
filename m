Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeEFDoP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 23:44:15 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:57614 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeEFDoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 23:44:12 -0400
X-Google-Smtp-Source: AB8JxZrPBokhavNcjM4Vf4z1NThrdY3uT/p65+qOvckXbBr/me9b0ElYUeIjZZbGkCNsHoGX6dWgrQ==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: 3w-9xxx: fix a missing-check bug
Date: Sat,  5 May 2018 22:43:13 -0500
Message-Id: <1525578221-16283-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In twa_chrdev_ioctl(), the ioctl driver command is firstly copied from the
userspace pointer 'argp' and saved to the kernel object 'driver_command'.
Then a security check is performed on the data buffer size indicated by
'driver_command', which is 'driver_command.buffer_length'. If the security
check is passed, the entire ioctl command is copied again from the 'argp'
pointer and saved to the kernel object 'tw_ioctl'. Then, various operations
are performed on 'tw_ioctl' according to the 'cmd'. Given that the 'argp'
pointer resides in userspace, a malicious userspace process can race to
change the buffer size between the two copies. This way, the user can
bypass the security check and inject invalid data buffer size. This can
cause potential security issues in the following execution.

This patch checks the buffer size obtained in the second copy. An error
code -EINVAL will be returned if it is not same as the original one in the
first copy.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/scsi/3w-9xxx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index b42c9c4..8bc43db 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -684,6 +684,12 @@ static long twa_chrdev_ioctl(struct file *file, unsigned int cmd, unsigned long
 	if (copy_from_user(tw_ioctl, argp, driver_command.buffer_length + sizeof(TW_Ioctl_Buf_Apache) - 1))
 		goto out3;
 
+	if (tw_ioctl->driver_command.buffer_length
+		 != driver_command.buffer_length) {
+		retval = TW_IOCTL_ERROR_OS_EINVAL;
+		goto out3;
+	}
+
 	/* See which ioctl we are doing */
 	switch (cmd) {
 	case TW_IOCTL_FIRMWARE_PASS_THROUGH:
-- 
2.7.4
