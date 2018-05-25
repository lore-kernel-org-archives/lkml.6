Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161638AbeEYAHk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:07:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1161628AbeEYAHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:07:35 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/32] vfs: Make close() unmount the attached mount if so
 flagged [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:07:34 +0100
Message-ID: <152720685405.9073.17445116582570028610.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


---

 fs/file_table.c    |    4 ++++
 include/linux/fs.h |    4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 7ec0b3e5f05d..dbbcc563748a 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -30,6 +30,7 @@
 #include <linux/atomic.h>
 
 #include "internal.h"
+#include "mount.h"
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {
@@ -200,6 +201,9 @@ static void __fput(struct file *file)
 	eventpoll_release(file);
 	locks_remove_file(file);
 
+	if (unlikely(file->f_mode & FMODE_NEED_UNMOUNT))
+		__detach_mounts(dentry);
+
 	ima_file_free(file);
 	if (unlikely(file->f_flags & FASYNC)) {
 		if (file->f_op->fasync)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e771803cc8dc..ba571c18e236 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -152,7 +152,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 
 /* File is capable of returning -EAGAIN if I/O will block */
-#define FMODE_NOWAIT	((__force fmode_t)0x8000000)
+#define FMODE_NOWAIT		((__force fmode_t)0x8000000)
+/* File represents mount that needs unmounting */
+#define FMODE_NEED_UNMOUNT	((__force fmode_t)0x10000000)
 
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
