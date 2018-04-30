Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755136AbeD3Q6A (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:58:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20729 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755102AbeD3Q56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:57:58 -0400
X-IronPort-AV: E=Sophos;i="5.49,346,1520870400";
   d="scan'208";a="173714669"
From: adam.manzanares@wdc.com
To: viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-abi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH 1/2] fs: add RWF_IOPRIO
Date: Mon, 30 Apr 2018 09:57:39 -0700
Message-Id: <20180430165740.2842-2-adam.manzanares@wdc.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180430165740.2842-1-adam.manzanares@wdc.com>
References: <20180430165740.2842-1-adam.manzanares@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adam Manzanares <adam.manzanares@wdc.com>

This is the per-I/O equivalent of the ioprio_set system call.

When the RWF_IOPRIO flag is set then the aio_reqprio field of the iocb
is interpreted as an I/O scheduling class and priority.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 include/linux/fs.h      | 4 ++++
 include/uapi/linux/fs.h | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 760d8da1b6c7..32614eb72a4a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -292,6 +292,7 @@ enum rw_hint {
 #define IOCB_SYNC		(1 << 5)
 #define IOCB_WRITE		(1 << 6)
 #define IOCB_NOWAIT		(1 << 7)
+#define IOCB_IOPRIO		(1 << 8)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -300,6 +301,7 @@ struct kiocb {
 	void			*private;
 	int			ki_flags;
 	enum rw_hint		ki_hint;
+	u16			ki_ioprio; /* See linux/ioprio.h */
 } __randomize_layout;
 
 static inline bool is_sync_kiocb(struct kiocb *kiocb)
@@ -3243,6 +3245,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 		ki->ki_flags |= (IOCB_DSYNC | IOCB_SYNC);
 	if (flags & RWF_APPEND)
 		ki->ki_flags |= IOCB_APPEND;
+	if (flags & RWF_IOPRIO)
+		ki->ki_flags |= IOCB_IOPRIO;
 	return 0;
 }
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index d2a8313fabd7..c8f69a00b566 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -380,8 +380,11 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* per-IO IOPRIO */
+#define RWF_IOPRIO	((__force __kernel_rwf_t)0x00000020)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_IOPRIO)
 
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.15.1
