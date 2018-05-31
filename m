Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeEaLaN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754778AbeEaL3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:29:53 -0400
From: Jeff Layton <jlayton@kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: willy@infradead.org, andres@anarazel.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cmaiolino@redhat.com
Subject: [PATCH v2 5/5] vfs: add a new ioctl for fetching the superblock's errseq_t
Date: Thu, 31 May 2018 07:29:45 -0400
Message-Id: <20180531112945.8629-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531112945.8629-1-jlayton@kernel.org>
References: <20180531112945.8629-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@redhat.com>

The postgres developers recently mentioned that they'd like a way to
tell whether there have been any writeback errors on a given filesystem
without having to forcibly sync out all buffered writes.

Now that we have a per-sb errseq_t that tracks whether any inode on the
filesystem might have failed writeback, we can present that to userland
applications via a new interface. Add a new generic fs ioctl for that
purpose. This just reports the current state of the errseq_t counter
with the SEEN bit masked off.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ioctl.c              |  3 +++
 include/linux/errseq.h  |  1 +
 include/uapi/linux/fs.h |  1 +
 lib/errseq.c            | 33 +++++++++++++++++++++++++++++++--
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4823431d1c9d..fd5e6b7f395c 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -667,6 +667,9 @@ int do_vfs_ioctl(struct file *filp, unsigned int fd, unsigned int cmd,
 	case FS_IOC_FIEMAP:
 		return ioctl_fiemap(filp, arg);
 
+	case FS_IOC_GETFSERR:
+		return put_user(errseq_scrape(&inode->i_sb->s_wb_err), argp);
+
 	case FIGETBSZ:
 		return put_user(inode->i_sb->s_blocksize, argp);
 
diff --git a/include/linux/errseq.h b/include/linux/errseq.h
index fc2777770768..de165623fa86 100644
--- a/include/linux/errseq.h
+++ b/include/linux/errseq.h
@@ -9,6 +9,7 @@ typedef u32	errseq_t;
 
 errseq_t errseq_set(errseq_t *eseq, int err);
 errseq_t errseq_sample(errseq_t *eseq);
+errseq_t errseq_scrape(errseq_t *eseq);
 int errseq_check(errseq_t *eseq, errseq_t since);
 int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
 #endif
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index d2a8313fabd7..6dedb35c5a96 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -253,6 +253,7 @@ struct fsxattr {
 #define FS_IOC32_SETVERSION		_IOW('v', 2, int)
 #define FS_IOC_FSGETXATTR		_IOR ('X', 31, struct fsxattr)
 #define FS_IOC_FSSETXATTR		_IOW ('X', 32, struct fsxattr)
+#define FS_IOC_GETFSERR			_IOR('e', 1, unsigned int)
 
 /*
  * File system encryption support
diff --git a/lib/errseq.c b/lib/errseq.c
index 81f9e33aa7e7..8ded0920eed3 100644
--- a/lib/errseq.c
+++ b/lib/errseq.c
@@ -108,7 +108,7 @@ errseq_t errseq_set(errseq_t *eseq, int err)
 EXPORT_SYMBOL(errseq_set);
 
 /**
- * errseq_sample() - Grab current errseq_t value.
+ * errseq_sample() - Grab current errseq_t value (or 0 if it hasn't been seen)
  * @eseq: Pointer to errseq_t to be sampled.
  *
  * This function allows callers to initialise their errseq_t variable.
@@ -117,7 +117,7 @@ EXPORT_SYMBOL(errseq_set);
  * see it the next time it checks for an error.
  *
  * Context: Any context.
- * Return: The current errseq value.
+ * Return: The current errseq value or 0 if it wasn't previously seen
  */
 errseq_t errseq_sample(errseq_t *eseq)
 {
@@ -130,6 +130,35 @@ errseq_t errseq_sample(errseq_t *eseq)
 }
 EXPORT_SYMBOL(errseq_sample);
 
+/**
+ * errseq_scrape() - Grab current errseq_t value
+ * @eseq: Pointer to errseq_t to be sampled.
+ *
+ * This function allows callers to scrape the current value of an errseq_t.
+ * Unlike errseq_sample, this will always return the current value with
+ * the SEEN flag unset, even when the value has not yet been seen.
+ *
+ * Context: Any context.
+ * Return: The current errseq value with ERRSEQ_SEEN masked off
+ */
+errseq_t errseq_scrape(errseq_t *eseq)
+{
+	errseq_t old = READ_ONCE(*eseq);
+
+	/*
+	 * For the common case of no errors ever having been set, we can skip
+	 * marking the SEEN bit. Once an error has been set, the value will
+	 * never go back to zero.
+	 */
+	if (old != 0) {
+		errseq_t new = old | ERRSEQ_SEEN;
+		if (old != new)
+			cmpxchg(eseq, old, new);
+	}
+	return old & ~ERRSEQ_SEEN;
+}
+EXPORT_SYMBOL(errseq_scrape);
+
 /**
  * errseq_check() - Has an error occurred since a particular sample point?
  * @eseq: Pointer to errseq_t value to be checked.
-- 
2.17.0
