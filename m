Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8762C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795A021873
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864883;
	bh=WzgQUdK71BR6aFQKtUtwSIcH1NeqJtH/Ej0VAs96O/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tJ1xg00KLhEZ/xw6C1ZQT/72sOiUR+9tyEa/j8BM49om7MI2BMZGLOSHCYy65yBqb
	 Y4bnt+RFuI6E+zKMkh9dRNFzEoCwpDIy4ycM7ASTKZ5MAvXWcdONATBGks8qK19Y6D
	 uieM98OEoHjnWrC0BrW5FacQNFPs+Rb2NK6NnSxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfAGMlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbfAGMlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:41:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADD682183E;
        Mon,  7 Jan 2019 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864878;
        bh=WzgQUdK71BR6aFQKtUtwSIcH1NeqJtH/Ej0VAs96O/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2JdAtzYzBvkzBs6Im9ajqowQ6ldHrGZ1WqR7uf63FaHKyw+yrmrq05stznMRMsKz
         w7voDD/vviSKBiXI41DVGkQJqJBQ9Em7BSz5El70S0W3hs7zJn1EU0UcsJEd+d6GPP
         lPgKcOmtvU8AK+Ng3ViySsJcB+0IV+tzzJpWaR1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.20 090/145] binder: fix use-after-free due to ksys_close() during fdget()
Date:   Mon,  7 Jan 2019 13:32:07 +0100
Message-Id: <20190107104448.976364882@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Todd Kjos <tkjos@android.com>

commit 80cd795630d6526ba729a089a435bf74a57af927 upstream.

44d8047f1d8 ("binder: use standard functions to allocate fds")
exposed a pre-existing issue in the binder driver.

fdget() is used in ksys_ioctl() as a performance optimization.
One of the rules associated with fdget() is that ksys_close() must
not be called between the fdget() and the fdput(). There is a case
where this requirement is not met in the binder driver which results
in the reference count dropping to 0 when the device is still in
use. This can result in use-after-free or other issues.

If userpace has passed a file-descriptor for the binder driver using
a BINDER_TYPE_FDA object, then kys_close() is called on it when
handling a binder_ioctl(BC_FREE_BUFFER) command. This violates
the assumptions for using fdget().

The problem is fixed by deferring the close using task_work_add(). A
new variant of __close_fd() was created that returns a struct file
with a reference. The fput() is deferred instead of using ksys_close().

Fixes: 44d8047f1d87a ("binder: use standard functions to allocate fds")
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/android/binder.c |   63 +++++++++++++++++++++++++++++++++++++++++++++--
 fs/file.c                |   29 +++++++++++++++++++++
 include/linux/fdtable.h  |    1 
 3 files changed, 91 insertions(+), 2 deletions(-)

--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -72,6 +72,7 @@
 #include <linux/spinlock.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
+#include <linux/task_work.h>
 
 #include <uapi/linux/android/binder.h>
 
@@ -2160,6 +2161,64 @@ static bool binder_validate_fixup(struct
 	return (fixup_offset >= last_min_offset);
 }
 
+/**
+ * struct binder_task_work_cb - for deferred close
+ *
+ * @twork:                callback_head for task work
+ * @fd:                   fd to close
+ *
+ * Structure to pass task work to be handled after
+ * returning from binder_ioctl() via task_work_add().
+ */
+struct binder_task_work_cb {
+	struct callback_head twork;
+	struct file *file;
+};
+
+/**
+ * binder_do_fd_close() - close list of file descriptors
+ * @twork:	callback head for task work
+ *
+ * It is not safe to call ksys_close() during the binder_ioctl()
+ * function if there is a chance that binder's own file descriptor
+ * might be closed. This is to meet the requirements for using
+ * fdget() (see comments for __fget_light()). Therefore use
+ * task_work_add() to schedule the close operation once we have
+ * returned from binder_ioctl(). This function is a callback
+ * for that mechanism and does the actual ksys_close() on the
+ * given file descriptor.
+ */
+static void binder_do_fd_close(struct callback_head *twork)
+{
+	struct binder_task_work_cb *twcb = container_of(twork,
+			struct binder_task_work_cb, twork);
+
+	fput(twcb->file);
+	kfree(twcb);
+}
+
+/**
+ * binder_deferred_fd_close() - schedule a close for the given file-descriptor
+ * @fd:		file-descriptor to close
+ *
+ * See comments in binder_do_fd_close(). This function is used to schedule
+ * a file-descriptor to be closed after returning from binder_ioctl().
+ */
+static void binder_deferred_fd_close(int fd)
+{
+	struct binder_task_work_cb *twcb;
+
+	twcb = kzalloc(sizeof(*twcb), GFP_KERNEL);
+	if (!twcb)
+		return;
+	init_task_work(&twcb->twork, binder_do_fd_close);
+	__close_fd_get_file(fd, &twcb->file);
+	if (twcb->file)
+		task_work_add(current, &twcb->twork, true);
+	else
+		kfree(twcb);
+}
+
 static void binder_transaction_buffer_release(struct binder_proc *proc,
 					      struct binder_buffer *buffer,
 					      binder_size_t *failed_at)
@@ -2299,7 +2358,7 @@ static void binder_transaction_buffer_re
 			}
 			fd_array = (u32 *)(parent_buffer + (uintptr_t)fda->parent_offset);
 			for (fd_index = 0; fd_index < fda->num_fds; fd_index++)
-				ksys_close(fd_array[fd_index]);
+				binder_deferred_fd_close(fd_array[fd_index]);
 		} break;
 		default:
 			pr_err("transaction release %d bad object type %x\n",
@@ -3912,7 +3971,7 @@ static int binder_apply_fd_fixups(struct
 		} else if (ret) {
 			u32 *fdp = (u32 *)(t->buffer->data + fixup->offset);
 
-			ksys_close(*fdp);
+			binder_deferred_fd_close(*fdp);
 		}
 		list_del(&fixup->fixup_entry);
 		kfree(fixup);
--- a/fs/file.c
+++ b/fs/file.c
@@ -640,6 +640,35 @@ out_unlock:
 }
 EXPORT_SYMBOL(__close_fd); /* for ksys_close() */
 
+/*
+ * variant of __close_fd that gets a ref on the file for later fput
+ */
+int __close_fd_get_file(unsigned int fd, struct file **res)
+{
+	struct files_struct *files = current->files;
+	struct file *file;
+	struct fdtable *fdt;
+
+	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
+	if (fd >= fdt->max_fds)
+		goto out_unlock;
+	file = fdt->fd[fd];
+	if (!file)
+		goto out_unlock;
+	rcu_assign_pointer(fdt->fd[fd], NULL);
+	__put_unused_fd(files, fd);
+	spin_unlock(&files->file_lock);
+	get_file(file);
+	*res = file;
+	return filp_close(file, files);
+
+out_unlock:
+	spin_unlock(&files->file_lock);
+	*res = NULL;
+	return -ENOENT;
+}
+
 void do_close_on_exec(struct files_struct *files)
 {
 	unsigned i;
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -121,6 +121,7 @@ extern void __fd_install(struct files_st
 		      unsigned int fd, struct file *file);
 extern int __close_fd(struct files_struct *files,
 		      unsigned int fd);
+extern int __close_fd_get_file(unsigned int fd, struct file **res);
 
 extern struct kmem_cache *files_cachep;
 


