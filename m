Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971911AbeEYAIY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:08:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965178AbeEYAIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:08:20 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 27/32] vfs: Use a 'struct fd_cookie *' type for light fd
 handling [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:08:18 +0100
Message-ID: <152720689885.9073.2472504465486115237.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a 'struct fd_cookie *' type for light fd handling rather than an
unsigned long so that confusion doesn't arise with integer fd numbers.

I have a use case where I want to store this in struct nameidata, but don't
want to expand it to a struct fd to save space.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/file.c            |   20 +++++++++++---------
 include/linux/file.h |   31 ++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 7ffd6e9d103d..8b0012ddadad 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -727,7 +727,7 @@ EXPORT_SYMBOL(fget_raw);
  * The fput_needed flag returned by fget_light should be passed to the
  * corresponding fput_light.
  */
-static unsigned long __fget_light(unsigned int fd, fmode_t mask)
+static struct fd_cookie *__fget_light(unsigned int fd, fmode_t mask)
 {
 	struct files_struct *files = current->files;
 	struct file *file;
@@ -736,33 +736,35 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 		file = __fcheck_files(files, fd);
 		if (!file || unlikely(file->f_mode & mask))
 			return 0;
-		return (unsigned long)file;
+		return (struct fd_cookie *)file;
 	} else {
 		file = __fget(fd, mask);
 		if (!file)
 			return 0;
-		return FDPUT_FPUT | (unsigned long)file;
+		return (struct fd_cookie *)(FDPUT_FPUT | (unsigned long)file);
 	}
 }
-unsigned long __fdget(unsigned int fd)
+
+struct fd_cookie *__fdget(unsigned int fd)
 {
 	return __fget_light(fd, FMODE_PATH);
 }
 EXPORT_SYMBOL(__fdget);
 
-unsigned long __fdget_raw(unsigned int fd)
+struct fd_cookie *__fdget_raw(unsigned int fd)
 {
 	return __fget_light(fd, 0);
 }
 
-unsigned long __fdget_pos(unsigned int fd)
+struct fd_cookie *__fdget_pos(unsigned int fd)
 {
-	unsigned long v = __fdget(fd);
-	struct file *file = (struct file *)(v & ~3);
+	struct fd_cookie *v = __fdget(fd);
+	struct file *file = __fdfile(v);
 
 	if (file && (file->f_mode & FMODE_ATOMIC_POS)) {
 		if (file_count(file) > 1) {
-			v |= FDPUT_POS_UNLOCK;
+			v = (struct fd_cookie *)
+				((unsigned long)v | FDPUT_POS_UNLOCK);
 			mutex_lock(&file->f_pos_lock);
 		}
 	}
diff --git a/include/linux/file.h b/include/linux/file.h
index 279720db984a..3fce1c92b576 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -11,6 +11,7 @@
 #include <linux/posix_types.h>
 
 struct file;
+struct fd_cookie; /* Deliberately undefined structure */
 
 extern void fput(struct file *);
 
@@ -31,8 +32,24 @@ struct fd {
 	struct file *file;
 	unsigned int flags;
 };
-#define FDPUT_FPUT       1
-#define FDPUT_POS_UNLOCK 2
+#define FDPUT_FPUT		1
+#define FDPUT_POS_UNLOCK	2
+#define FDPUT__MASK		3
+
+static inline unsigned long __fdflags(struct fd_cookie *f)
+{
+	return (unsigned long)f & FDPUT__MASK;
+}
+
+static inline struct file *__fdfile(struct fd_cookie *f)
+{
+	return (struct file *)((unsigned long)f & ~FDPUT__MASK);
+}
+
+static inline void __fdput(struct fd_cookie *f)
+{
+	fput_light(__fdfile(f), __fdflags(f) & FDPUT_FPUT);
+}
 
 static inline void fdput(struct fd fd)
 {
@@ -42,14 +59,14 @@ static inline void fdput(struct fd fd)
 
 extern struct file *fget(unsigned int fd);
 extern struct file *fget_raw(unsigned int fd);
-extern unsigned long __fdget(unsigned int fd);
-extern unsigned long __fdget_raw(unsigned int fd);
-extern unsigned long __fdget_pos(unsigned int fd);
+extern struct fd_cookie * __fdget(unsigned int fd);
+extern struct fd_cookie *__fdget_raw(unsigned int fd);
+extern struct fd_cookie *__fdget_pos(unsigned int fd);
 extern void __f_unlock_pos(struct file *);
 
-static inline struct fd __to_fd(unsigned long v)
+static inline struct fd __to_fd(struct fd_cookie *v)
 {
-	return (struct fd){(struct file *)(v & ~3),v & 3};
+	return (struct fd){__fdfile(v), __fdflags(v)};
 }
 
 static inline struct fd fdget(unsigned int fd)
