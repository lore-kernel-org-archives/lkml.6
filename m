Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754975AbeCHACu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 19:02:50 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40857 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754553AbeCHACs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 19:02:48 -0500
X-Google-Smtp-Source: AG47ELu90hi0spP11XKzdAwr8FC7AvDIsIKrefqBhNOk854kkxMQhCKPmfafJ4maJqI79a1ll9s8nw==
From: Brian Belleville <bbellevi@uci.edu>
To: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Cc: Brian Belleville <bbellevi@uci.edu>
Subject: [PATCH] floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl
Date: Wed,  7 Mar 2018 16:02:45 -0800
Message-Id: <1520467365-7194-1-git-send-email-bbellevi@uci.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final field of a floppy_struct is the field "name", which is a
pointer to a string in kernel memory. The kernel pointer should not be
copied to user memory. The FDGETPRM ioctl copies a floppy_struct to
user memory, including the "name" field. This pointer cannot be used
by the user, and it will leak a kernel address to user-space, which
will reveal the location of kernel code and data and undermine KASLR
protection. Instead, copy the floppy_struct except for the "name"
field.

Signed-off-by: Brian Belleville <bbellevi@uci.edu>
---
 drivers/block/floppy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index eae484a..4d4a422 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3470,6 +3470,7 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 					  (struct floppy_struct **)&outparam);
 		if (ret)
 			return ret;
+		size = offsetof(struct floppy_struct, name);
 		break;
 	case FDMSGON:
 		UDP->flags |= FTD_MSG;
-- 
2.7.4
