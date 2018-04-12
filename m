Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeDLPX3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:23:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51186 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753296AbeDLPIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:08:40 -0400
X-Google-Smtp-Source: AIpwx48/+2BeJBgSjRqdg+LzoUIEzfokgjMK0YClUpuXO1zaXQMxe5jpVytkVs2dF8ym3Cy+PDwjdw==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/35] ovl: copy up file size as well
Date: Thu, 12 Apr 2018 17:07:58 +0200
Message-Id: <20180412150826.20988-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180412150826.20988-1-mszeredi@redhat.com>
References: <20180412150826.20988-1-mszeredi@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy i_size of the underlying inode to the overlay inode in ovl_copyattr().

This is in preparation for stacking I/O operations on overlay files.

This patch shouldn't have any observable effect.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/overlayfs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 265cb288417a..10f5f3bf9d96 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -9,6 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/uuid.h>
+#include <linux/fs.h>
 #include "ovl_entry.h"
 
 enum ovl_path_type {
@@ -355,6 +356,7 @@ static inline void ovl_copyattr(struct inode *from, struct inode *to)
 	to->i_atime = from->i_atime;
 	to->i_mtime = from->i_mtime;
 	to->i_ctime = from->i_ctime;
+	i_size_write(to, i_size_read(from));
 }
 
 static inline void ovl_copyflags(struct inode *from, struct inode *to)
-- 
2.14.3
