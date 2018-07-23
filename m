Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9C9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7E020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7E020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388706AbeGWQ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:27:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387831AbeGWQ16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:27:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B71B5401DED1;
        Mon, 23 Jul 2018 15:26:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EA91111CD37;
        Mon, 23 Jul 2018 15:26:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/5] vfs: Add superblock notifications
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, raven@themaw.net,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Mon, 23 Jul 2018 16:26:11 +0100
Message-ID: <153235957165.32640.10593983430211812657.stgit@warthog.procyon.org.uk>
In-Reply-To: <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
References: <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 23 Jul 2018 15:26:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 23 Jul 2018 15:26:13 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a superblock event notification facility whereby notifications about
superblock events, such as I/O errors (EIO), quota limits being hit
(EDQUOT) and running out of space (ENOSPC) can be reported to a monitoring
process asynchronously.  Note that this does not cover vfsmount topology
changes.  mount_notify() is used for that.

Firstly, an event queue needs to be created:

	fd = open("/dev/event_queue", O_RDWR);

then a notification can be set up to report notifications via that queue:

	struct watch_notification_filter filter;
	memset(&filter, 0, sizeof(filter));
	filter.subtype_filter[0] = ~0ULL;
	filter.info_id		 = 0x03000000;
	sb_notify(AT_FDCWD, "/home/dhowells", 0, fd, &filter);

In this case, it would let me monitor my own homedir for events.

Note that the queue can be shared between multiple notifications of various
types.

[*] QUESTION: Does this want to be per-sb, per-mount_namespace,
    per-some-new-notify-ns or per-system?  Or do multiple options make
    sense?

[*] QUESTION: I've done it this way so that anyone could theoretically
    monitor the superblock of any filesystem they can pathwalk to, but do
    we need other security controls?

[*] QUESTION: Should the LSM be able to filter the events a queue can
    receive?  For instance the opener of the queue would grant that queue
    subject creds (by ->f_cred) that could be used to govern what events
    could be seen, assuming the target superblock to have some object
    creds, based on, say, the mounter.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/Kconfig                             |   12 +++
 fs/super.c                             |  116 ++++++++++++++++++++++++++++++++
 include/linux/fs.h                     |   77 +++++++++++++++++++++
 include/linux/syscalls.h               |    2 +
 include/uapi/linux/watch_queue.h       |   26 +++++++
 kernel/sys_ni.c                        |    3 +
 8 files changed, 238 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 449bbcc19a6d..c9db9d51a7df 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -406,3 +406,4 @@
 392	i386	fspick			sys_fspick			__ia32_sys_fspick
 393	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
 394	i386	mount_notify		sys_mount_notify		__ia32_sys_mount_notify
+395	i386	sb_notify		sys_sb_notify			__ia32_sys_sb_notify
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f25fa7ff5fb9..17869bf7788a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -351,6 +351,7 @@
 340	common	fspick			__x64_sys_fspick
 341	common	fsinfo			__x64_sys_fsinfo
 342	common	mount_notify		__x64_sys_mount_notify
+343	common	sb_notify		__x64_sys_sb_notify
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/Kconfig b/fs/Kconfig
index cbcca62d32e9..0551abf08504 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -116,6 +116,18 @@ config MOUNT_NOTIFICATIONS
 	  device to handle the notification buffer and provides the
 	  mount_notify() system call to enable/disable watchpoints.
 
+config SB_NOTIFICATIONS
+	bool "Superblock event notifications"
+	select WATCH_QUEUE
+	help
+	  This option provides support for receiving superblock event
+	  notifications.  This makes use of the /dev/watch_queue misc device to
+	  handle the notification buffer and provides the sb_notify() system
+	  call to enable/disable watches.
+
+	  Events can include things like changing between R/W and R/O, EIO
+	  generation, ENOSPC generation and EDQUOT generation.
+
 source "fs/quota/Kconfig"
 
 source "fs/autofs/Kconfig"
diff --git a/fs/super.c b/fs/super.c
index 3fe5d12b7697..1a1cf517dbd8 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -37,6 +37,8 @@
 #include <linux/user_namespace.h>
 #include <uapi/linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/syscalls.h>
+#include <linux/namei.h>
 #include "internal.h"
 
 static int thaw_super_locked(struct super_block *sb);
@@ -320,6 +322,10 @@ void deactivate_locked_super(struct super_block *s)
 {
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
+#ifdef CONFIG_SB_NOTIFICATIONS
+		if (s->s_watchers)
+			remove_watch_list(s->s_watchers);
+#endif
 		cleancache_invalidate_fs(s);
 		unregister_shrinker(&s->s_shrink);
 		fs->kill_sb(s);
@@ -997,6 +1003,8 @@ int do_remount_sb(struct super_block *sb, int sb_flags, void *data,
 	/* Needs to be ordered wrt mnt_is_readonly() */
 	smp_wmb();
 	sb->s_readonly_remount = 0;
+	notify_sb(sb, notify_superblock_readonly,
+		  remount_ro ? WATCH_INFO_FLAG_0 : 0);
 
 	/*
 	 * Some filesystems modify their metadata via some other path than the
@@ -1810,3 +1818,111 @@ int vfs_get_tree(struct fs_context *fc)
 	return ret;
 }
 EXPORT_SYMBOL(vfs_get_tree);
+
+#ifdef CONFIG_SB_NOTIFICATIONS
+/*
+ * Post superblock notifications.
+ */
+void post_sb_notification(struct super_block *s, struct superblock_notification *n)
+{
+	post_watch_notification(s->s_watchers, &n->watch, s->s_watch_id);
+}
+
+static void release_sb_watch(struct watch_list *wlist, struct watch *watch)
+{
+	struct super_block *s = watch->private;
+
+	put_super(s);
+}
+
+/**
+ * sys_sb_notify - Watch for superblock events.
+ * @dfd: Base directory to pathwalk from or fd referring to superblock.
+ * @filename: Path to superblock to place the watch upon
+ * @at_flags: Pathwalk control flags
+ * @watch_fd: The watch queue to send notifications to.
+ * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
+ */
+SYSCALL_DEFINE5(sb_notify,
+		int, dfd,
+		const char __user *, filename,
+		unsigned int, at_flags,
+		int, watch_fd,
+		int, watch_id)
+{
+	struct watch_queue *wqueue;
+	struct super_block *s;
+	struct watch_list *wlist = NULL;
+	struct watch *watch;
+	struct path path;
+	int ret;
+
+	if (watch_id < -1 || watch_id > 0xff)
+		return -EINVAL;
+
+	ret = user_path_at(dfd, filename, at_flags, &path);
+	if (ret)
+		return ret;
+
+	wqueue = get_watch_queue(watch_fd);
+	if (IS_ERR(wqueue))
+		goto err_path;
+
+	s = path.dentry->d_sb;
+	if (watch_id >= 0) {
+		if (!s->s_watchers) {
+			wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
+			if (!wlist)
+				goto err_wqueue;
+			INIT_HLIST_HEAD(&wlist->watchers);
+			spin_lock_init(&wlist->lock);
+			wlist->release_watch = release_sb_watch;
+		}
+
+		watch = kzalloc(sizeof(*watch), GFP_KERNEL);
+		if (!watch)
+			goto err_wlist;
+
+		init_watch(watch);
+		watch->id		= s->s_watch_id;
+		watch->queue		= wqueue;
+		watch->private		= s;
+		watch->info_id		= (u32)watch_id << 24;
+
+		down_write(&s->s_umount);
+		ret = -EIO;
+		if (atomic_read(&s->s_active)) {
+			if (!s->s_watchers) {
+				s->s_watchers = wlist;
+				wlist = NULL;
+			}
+
+			watch->watch_list = s->s_watchers;
+			ret = add_watch_to_object(watch);
+			if (ret == 0) {
+				spin_lock(&sb_lock);
+				s->s_count++;
+				spin_unlock(&sb_lock);
+			}
+		}
+		up_write(&s->s_umount);
+		if (ret < 0)
+			kfree(watch);
+	} else if (s->s_watchers) {
+		down_write(&s->s_umount);
+		ret = remove_watch_from_object(s->s_watchers, wqueue,
+					       s->s_watch_id, false);
+		up_write(&s->s_umount);
+	} else {
+		ret = -EBADSLT;
+	}
+
+err_wlist:
+	kfree(wlist);
+err_wqueue:
+	put_watch_queue(wqueue);
+err_path:
+	path_put(&path);
+	return ret;
+}
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bcbe94c0dfe8..6dbc4f9aa6c3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -37,6 +37,7 @@
 #include <linux/uuid.h>
 #include <linux/errseq.h>
 #include <linux/ioprio.h>
+#include <linux/watch_queue.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1463,6 +1464,12 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+
+	/* Superblock event notifications */
+#ifdef CONFIG_SB_NOTIFICATIONS
+	struct watch_list	*s_watchers;
+	u64			s_watch_id;
+#endif
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
@@ -3458,4 +3465,74 @@ static inline bool dir_relax_shared(struct inode *inode)
 extern bool path_noexec(const struct path *path);
 extern void inode_nohighmem(struct inode *inode);
 
+extern void post_sb_notification(struct super_block *, struct superblock_notification *);
+
+/**
+ * notify_sb: Post simple superblock notification.
+ * @s: The superblock the notification is about.
+ * @subtype: The type of notification.
+ */
+static inline void notify_sb(struct super_block *s,
+			     enum superblock_notification_type subtype,
+			     u32 info)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_notification n = {
+			.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.watch.subtype	= subtype,
+			.watch.info	= sizeof(n) | info,
+			.sb_id		= s->s_watch_id,
+		};
+
+		post_sb_notification(s, &n);
+	}
+			     
+#endif
+}
+
+/**
+ * sb_error: Post superblock error notification.
+ * @s: The superblock the notification is about.
+ */
+static inline int sb_error(struct super_block *s, int error)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_error_notification n = {
+			.s.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.s.watch.subtype = notify_superblock_error,
+			.s.watch.info	= sizeof(n),
+			.s.sb_id	= s->s_watch_id,
+			.error_number	= error,
+			.error_cookie	= 0,
+		};
+
+		post_sb_notification(s, &n.s);
+	}
+#endif
+	return error;
+}
+
+/**
+ * sb_EDQUOT: Post superblock quota overrun notification.
+ * @s: The superblock the notification is about.
+ */
+static inline int sb_EQDUOT(struct super_block *s)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_notification n = {
+			.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.watch.subtype	= notify_superblock_edquot,
+			.watch.info	= sizeof(n),
+			.sb_id		= s->s_watch_id,
+		};
+
+		post_sb_notification(s, &n);
+	}
+#endif
+	return -EDQUOT;
+}
+
 #endif /* _LINUX_FS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 7db37c58289a..4d852f218949 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -915,6 +915,8 @@ asmlinkage long sys_fsinfo(int dfd, const char __user *path,
 			   void __user *buffer, size_t buf_size);
 asmlinkage long sys_mount_notify(int dfd, const char __user *path,
 				 unsigned int at_flags, int watch_fd, int watch_id);
+asmlinkage long sys_sb_notify(int dfd, const char __user *path,
+			      unsigned int at_flags, int watch_fd, int watch_id);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 9d8e165e0065..40a3f809c73c 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -127,4 +127,30 @@ struct mount_notification {
 	__u32	changed_mount;		/* The mount that got changed */
 };
 
+/*
+ * Type of superblock notification.
+ */
+enum superblock_notification_type {
+	notify_superblock_readonly	= 0, /* Filesystem toggled between R/O and R/W */
+	notify_superblock_error		= 1, /* Error in filesystem or blockdev */
+	notify_superblock_edquot	= 2, /* EDQUOT notification */
+	notify_superblock_network	= 3, /* Network status change */
+};
+
+/*
+ * Superblock notification record.
+ * - watch.type = WATCH_TYPE_MOUNT_NOTIFY
+ * - watch.subtype = enum superblock_notification_subtype
+ */
+struct superblock_notification {
+	struct watch_notification watch; /* WATCH_TYPE_SB_NOTIFY */
+	__u64	sb_id;			/* 64-bit superblock ID [fsinfo_ids::f_sb_id] */
+};
+
+struct superblock_error_notification {
+	struct superblock_notification s; /* subtype = notify_superblock_error */
+	__u32	error_number;
+	__u32	error_cookie;
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index f608777be045..3b5aacb8a5a0 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -100,6 +100,9 @@ COND_SYSCALL(quotactl);
 
 /* fs/read_write.c */
 
+/* fs/sb_notify.c */
+COND_SYSCALL(sb_notify);
+
 /* fs/sendfile.c */
 
 /* fs/select.c */

