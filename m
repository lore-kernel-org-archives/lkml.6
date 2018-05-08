Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeEHAyY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:54:24 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:36360 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753184AbeEHAyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:54:21 -0400
X-Google-Smtp-Source: AB8JxZrDHwrcd3QW0/KiB+e6IHi/xwcE3BxUektDbHPFM2Khlek/oIFTZ6MJLDynsD33EFz68a3abQ==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] scsi: 3w-xxxx: fix a missing-check bug
Date: Mon,  7 May 2018 19:54:01 -0500
Message-Id: <1525740850-23737-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tw_chrdev_ioctl(), the length of the data buffer is firstly copied from
the userspace pointer 'argp' and saved to the kernel object
'data_buffer_length'. Then a security check is performed on it to make sure
that the length is not more than 'TW_MAX_IOCTL_SECTORS * 512'. Otherwise,
an error code -EINVAL is returned. If the security check is passed, the
entire ioctl command is copied again from the 'argp' pointer and saved to
the kernel object 'tw_ioctl'. Then, various operations are performed on
'tw_ioctl' according to the 'cmd'. Given that the 'argp' pointer resides in
userspace, a malicious userspace process can race to change the buffer
length between the two copies. This way, the user can bypass the security
check and inject invalid data buffer length. This can cause potential
security issues in the following execution.

This patch checks for capable(CAP_SYS_ADMIN) in tw_chrdev_open() to avoid
the above issues.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/scsi/3w-xxxx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 33261b6..f6179e3 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1033,6 +1033,9 @@ static int tw_chrdev_open(struct inode *inode, struct file *file)
 
 	dprintk(KERN_WARNING "3w-xxxx: tw_ioctl_open()\n");
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
 	minor_number = iminor(inode);
 	if (minor_number >= tw_device_extension_count)
 		return -ENODEV;
-- 
2.7.4
