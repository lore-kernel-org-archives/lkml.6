Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeELFBP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 01:01:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44388 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeELFBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 01:01:11 -0400
X-Google-Smtp-Source: AB8JxZqIJNWGRHfBhBD/joZ/lit+HxFMQGEHzsjUl4Bd1Ux3e0780zsbvNiMTmO66GeD8ITu5EUNVQ==
From: Deepa Dinamani <deepa.kernel@gmail.com>
To: viro@zeniv.linux.org.uk, tglx@linutronix.de
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org
Subject: [PATCH 1/6] fs: add timespec64_truncate()
Date: Fri, 11 May 2018 21:59:16 -0700
Message-Id: <20180512045921.18311-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180512045921.18311-1-deepa.kernel@gmail.com>
References: <20180512045921.18311-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As vfs moves to using struct timespec64 to represent times,
update the argument to timespec_truncate() to use
struct timespec64. Also change the name of the function.
The rest of the implementation logic is the same.

Move this to fs/inode.c instead of kernel/time/time.c as all the
users of this api are filesystems.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: <viro@zeniv.linux.org.uk>
---
 fs/inode.c         | 24 ++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 13ceb98c3bd3..93af998ee290 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2110,6 +2110,30 @@ void inode_nohighmem(struct inode *inode)
 }
 EXPORT_SYMBOL(inode_nohighmem);
 
+/**
+ * timespec64_trunc - Truncate timespec64 to a granularity
+ * @t: Timespec64
+ * @gran: Granularity in ns.
+ *
+ * Truncate a timespec64 to a granularity. Always rounds down. gran must
+ * not be 0 nor greater than a second (NSEC_PER_SEC, or 10^9 ns).
+ */
+struct timespec64 timespec64_trunc(struct timespec64 t, unsigned gran)
+{
+	/* Avoid division in the common cases 1 ns and 1 s. */
+	if (gran == 1) {
+		/* nothing */
+	} else if (gran == NSEC_PER_SEC) {
+		t.tv_nsec = 0;
+	} else if (gran > 1 && gran < NSEC_PER_SEC) {
+		t.tv_nsec -= t.tv_nsec % gran;
+	} else {
+		WARN(1, "illegal file time granularity: %u", gran);
+	}
+	return t;
+}
+EXPORT_SYMBOL(timespec64_trunc);
+
 /**
  * current_time - Return FS time
  * @inode: inode.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0eedf745667b..381c77a37404 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1477,6 +1477,7 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
 }
 
+extern struct timespec64 timespec64_trunc(struct timespec64 t, unsigned gran);
 extern struct timespec current_time(struct inode *inode);
 
 /*
-- 
2.17.0
