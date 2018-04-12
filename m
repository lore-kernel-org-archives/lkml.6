Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbeDLPJJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:09:09 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39370 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbeDLPJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:09:03 -0400
X-Google-Smtp-Source: AIpwx49at+pmMKEN2KD3r3oZxN5TZzXjphCVW1HiOFF31yIDftUC7TnXjQkDlEARNyPi32lbRsRykg==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 26/35] Revert "ovl: fix may_write_real() for overlayfs directories"
Date: Thu, 12 Apr 2018 17:08:17 +0200
Message-Id: <20180412150826.20988-27-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 954c736f865d6c0c68ae4263a2f3502ee7c447a3.

Overlayfs no longer relies on the vfs for checking writability of files.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9d1374ab6e06..9ec9bf74116b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -468,9 +468,7 @@ static inline int may_write_real(struct file *file)
 
 	/* File refers to upper, writable layer? */
 	upperdentry = d_real(dentry, NULL, 0, D_REAL_UPPER);
-	if (upperdentry &&
-	    (file_inode(file) == d_inode(upperdentry) ||
-	     file_inode(file) == d_inode(dentry)))
+	if (upperdentry && file_inode(file) == d_inode(upperdentry))
 		return 0;
 
 	/* Lower layer: can't write to real file, sorry... */
-- 
2.14.3
