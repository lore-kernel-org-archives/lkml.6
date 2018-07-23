Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D46ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE5420854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE5420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388687AbeGWQ1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:27:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387831AbeGWQ1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:27:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E5517A7F2;
        Mon, 23 Jul 2018 15:26:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C1B72026D65;
        Mon, 23 Jul 2018 15:26:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/5] vfs: Add a mount-notification facility
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, raven@themaw.net,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Mon, 23 Jul 2018 16:26:05 +0100
Message-ID: <153235956503.32640.8212120843796670089.stgit@warthog.procyon.org.uk>
In-Reply-To: <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
References: <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 23 Jul 2018 15:26:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 23 Jul 2018 15:26:06 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[*] Note that this needs some cleaning up and not all the events work yet.

Add a mount notification facility whereby notifications about changes in
mount topology and configuration can be received.  Note that this only
covers vfsmount topology changes and not superblock events.  A separate
facility will be added for that.

Firstly, an event queue needs to be created:

	fd = open("/dev/event_queue", O_RDWR);

then a notification can be set up to report notifications via that queue:

	struct watch_notification_filter filter;
	memset(&filter, 0, sizeof(filter));
	filter.subtype_filter[0] = ~0ULL;
	filter.info_id		 = 0x02000000;
	mount_notify(AT_FDCWD, "/", 0, fd, &filter);

Note that the queue can be shared between multiple notifications of various
types.

Mount notifications propagate up the tree towards the root, so a watch will
catch all of the events happening in the subtree rooted at the watch.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/Kconfig                             |    9 ++
 fs/Makefile                            |    1 
 fs/fs_context.c                        |    1 
 fs/mount.h                             |   26 +++++
 fs/mount_notify.c                      |  178 ++++++++++++++++++++++++++++++++
 fs/namespace.c                         |   18 +++
 include/linux/dcache.h                 |    1 
 include/linux/syscalls.h               |    2 
 include/uapi/linux/watch_queue.h       |   24 ++++
 kernel/sys_ni.c                        |    3 +
 12 files changed, 265 insertions(+)
 create mode 100644 fs/mount_notify.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 806760188a31..449bbcc19a6d 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -405,3 +405,4 @@
 391	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 392	i386	fspick			sys_fspick			__ia32_sys_fspick
 393	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
+394	i386	mount_notify		sys_mount_notify		__ia32_sys_mount_notify
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 0823eed2b02e..f25fa7ff5fb9 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -350,6 +350,7 @@
 339	common	fsmount			__x64_sys_fsmount
 340	common	fspick			__x64_sys_fspick
 341	common	fsinfo			__x64_sys_fsinfo
+342	common	mount_notify		__x64_sys_mount_notify
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/Kconfig b/fs/Kconfig
index ac474a61be37..cbcca62d32e9 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -107,6 +107,15 @@ source "fs/crypto/Kconfig"
 
 source "fs/notify/Kconfig"
 
+config MOUNT_NOTIFICATIONS
+	bool "Mount topology change notifications"
+	select WATCH_QUEUE
+	help
+	  This option provides support for getting change notifications on the
+	  mount tree topology.  This makes use of the /dev/watch_queue misc
+	  device to handle the notification buffer and provides the
+	  mount_notify() system call to enable/disable watchpoints.
+
 source "fs/quota/Kconfig"
 
 source "fs/autofs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index d3b33798998e..49b60030d905 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,3 +129,4 @@ obj-y				+= exofs/ # Multiple modules
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_MOUNT_NOTIFICATIONS) += mount_notify.o
diff --git a/fs/fs_context.c b/fs/fs_context.c
index 071723cf11c8..4fa99a438471 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -321,6 +321,7 @@ struct fs_context *vfs_new_fs_context(struct file_system_type *fs_type,
 	case FS_CONTEXT_FOR_SUBMOUNT:
 		fc->user_ns = get_user_ns(reference->d_sb->s_user_ns);
 		fc->net_ns = get_net(current->nsproxy->net_ns);
+		fc->sb_flags |= SB_SUBMOUNT;
 		break;
 	case FS_CONTEXT_FOR_RECONFIGURE:
 		/* We don't pin any namespaces as the superblock's
diff --git a/fs/mount.h b/fs/mount.h
index f39bc9da4d73..7f72f824b958 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -4,6 +4,7 @@
 #include <linux/poll.h>
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
+#include <linux/watch_queue.h>
 
 struct mnt_namespace {
 	atomic_t		count;
@@ -67,9 +68,13 @@ struct mount {
 	int mnt_id;			/* mount identifier */
 	int mnt_group_id;		/* peer group identifier */
 	int mnt_expiry_mark;		/* true if marked for expiry */
+	int mnt_nr_watchers;		/* The number of subtree watches tracking this */
 	struct hlist_head mnt_pins;
 	struct fs_pin mnt_umount;
 	struct dentry *mnt_ex_mountpoint;
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	struct watch_list *mnt_watchers; /* Watches on dentries within this mount */
+#endif
 } __randomize_layout;
 
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
@@ -146,3 +151,24 @@ static inline bool is_local_mountpoint(struct dentry *dentry)
 
 	return __is_local_mountpoint(dentry);
 }
+
+extern void post_mount_notification(struct mount *changed,
+				    struct mount_notification *notify);
+
+static inline void notify_mount(struct mount *changed,
+				struct mount *aux,
+				enum mount_notification_subtype subtype,
+				u32 info_flags)
+{
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	struct mount_notification n = {
+		.watch.type	= WATCH_TYPE_MOUNT_NOTIFY,
+		.watch.subtype	= subtype,
+		.watch.info	= info_flags | sizeof(n),
+		.triggered_on	= changed->mnt_id,
+		.changed_mount	= aux ? aux->mnt_id : 0,
+	};
+
+	post_mount_notification(changed, &n);
+#endif
+}
diff --git a/fs/mount_notify.c b/fs/mount_notify.c
new file mode 100644
index 000000000000..b4905c363136
--- /dev/null
+++ b/fs/mount_notify.c
@@ -0,0 +1,178 @@
+/* Provide mount topology/attribute change notifications.
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/syscalls.h>
+#include "mount.h"
+
+/*
+ * Post mount notifications to all watches going rootwards along the tree.
+ *
+ * Must be called with the mount_lock held.
+ */
+void post_mount_notification(struct mount *changed,
+			     struct mount_notification *notify)
+{
+	struct path cursor;
+	struct mount *mnt;
+	unsigned seq;
+
+	seq = 0;
+	rcu_read_lock();
+restart:
+	cursor.mnt = &changed->mnt;
+	cursor.dentry = changed->mnt.mnt_root;
+	mnt = real_mount(cursor.mnt);
+	notify->watch.info &= ~WATCH_INFO_IN_SUBTREE;
+
+	read_seqbegin_or_lock(&rename_lock, &seq);
+	for (;;) {
+		if (mnt->mnt_watchers &&
+		    !hlist_empty(&mnt->mnt_watchers->watchers)) {
+			if (cursor.dentry->d_flags & DCACHE_MOUNT_WATCH)
+				post_watch_notification(mnt->mnt_watchers,
+							&notify->watch,
+							(unsigned long)cursor.dentry);
+		} else {
+			cursor.dentry = mnt->mnt.mnt_root;
+		}
+		notify->watch.info |= WATCH_INFO_IN_SUBTREE;
+
+		if (cursor.dentry == cursor.mnt->mnt_root ||
+		    IS_ROOT(cursor.dentry)) {
+			struct mount *parent = READ_ONCE(mnt->mnt_parent);
+
+			/* Escaped? */
+			if (cursor.dentry != cursor.mnt->mnt_root)
+				break;
+
+			/* Global root? */
+			if (mnt != parent) {
+				cursor.dentry = READ_ONCE(mnt->mnt_mountpoint);
+				mnt = parent;
+				cursor.mnt = &mnt->mnt;
+				continue;
+			}
+			break;
+		}
+
+		cursor.dentry = cursor.dentry->d_parent;
+	}
+
+	if (need_seqretry(&rename_lock, seq)) {
+		seq = 1;
+		goto restart;
+	}
+
+	done_seqretry(&rename_lock, seq);
+	rcu_read_unlock();
+}
+
+static void release_mount_watch(struct watch_list *wlist, struct watch *watch)
+{
+	struct vfsmount *mnt = watch->private;
+	struct dentry *dentry = (struct dentry *)(unsigned long)watch->id;
+
+	dput(dentry);
+	mntput(mnt);
+}
+
+/**
+ * sys_mount_notify - Watch for mount topology/attribute changes
+ * @dfd: Base directory to pathwalk from or fd referring to mount.
+ * @filename: Path to mount to place the watch upon
+ * @at_flags: Pathwalk control flags
+ * @watch_fd: The watch queue to send notifications to.
+ * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
+ */
+SYSCALL_DEFINE5(mount_notify,
+		int, dfd,
+		const char __user *, filename,
+		unsigned int, at_flags,
+		int, watch_fd,
+		int, watch_id)
+{
+	struct watch_queue *wqueue;
+	struct watch_list *wlist = NULL;
+	struct watch *watch;
+	struct mount *m;
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
+	m = real_mount(path.mnt);
+
+	if (watch_id >= 0) {
+		if (!m->mnt_watchers) {
+			wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
+			if (!wlist)
+				goto err_wqueue;
+			INIT_HLIST_HEAD(&wlist->watchers);
+			spin_lock_init(&wlist->lock);
+			wlist->release_watch = release_mount_watch;
+		}
+
+		watch = kzalloc(sizeof(*watch), GFP_KERNEL);
+		if (!watch)
+			goto err_wlist;
+
+		init_watch(watch);
+		watch->id		= (unsigned long)path.dentry;
+		watch->queue		= wqueue;
+		watch->private		= path.mnt;
+		watch->info_id		= (u32)watch_id << 24;
+
+		down_write(&m->mnt.mnt_sb->s_umount);
+		if (!m->mnt_watchers) {
+			m->mnt_watchers = wlist;
+			wlist = NULL;
+		}
+
+		watch->watch_list = m->mnt_watchers;
+		ret = add_watch_to_object(watch);
+		if (ret == 0) {
+			spin_lock(&path.dentry->d_lock);
+			path.dentry->d_flags |= DCACHE_MOUNT_WATCH;
+			spin_unlock(&path.dentry->d_lock);
+			path_get(&path);
+		}
+		up_write(&m->mnt.mnt_sb->s_umount);
+		if (ret < 0)
+			kfree(watch);
+	} else if (m->mnt_watchers) {
+		down_write(&m->mnt.mnt_sb->s_umount);
+		ret = remove_watch_from_object(m->mnt_watchers, wqueue,
+					       (unsigned long)path.dentry,
+					       false);
+		up_write(&m->mnt.mnt_sb->s_umount);
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
diff --git a/fs/namespace.c b/fs/namespace.c
index 7e7b1145d15d..d4d16111659d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -589,6 +589,9 @@ static int mnt_make_readonly(struct mount *mnt)
 	smp_wmb();
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
 	unlock_mount_hash();
+	if (ret == 0)
+		notify_mount(mnt, NULL, notify_mount_readonly,
+			     WATCH_INFO_FLAG_0);
 	return ret;
 }
 
@@ -597,6 +600,7 @@ static int __mnt_unmake_readonly(struct mount *mnt)
 	lock_mount_hash();
 	mnt->mnt.mnt_flags &= ~MNT_READONLY;
 	unlock_mount_hash();
+	notify_mount(mnt, NULL, notify_mount_readonly, 0);
 	return 0;
 }
 
@@ -900,6 +904,7 @@ static void umount_mnt(struct mount *mnt)
 {
 	/* old mountpoint will be dropped when we can do that */
 	mnt->mnt_ex_mountpoint = mnt->mnt_mountpoint;
+	notify_mount(mnt->mnt_parent, mnt, notify_mount_unmount, 0);
 	unhash_mnt(mnt);
 }
 
@@ -1451,6 +1456,11 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		p = list_first_entry(&tmp_list, struct mount, mnt_list);
 		list_del_init(&p->mnt_expire);
 		list_del_init(&p->mnt_list);
+
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+		if (p->mnt_watchers)
+			remove_watch_list(p->mnt_watchers);
+#endif
 		ns = p->mnt_ns;
 		if (ns) {
 			ns->mounts--;
@@ -2004,11 +2014,17 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		lock_mount_hash();
 	}
 	if (parent_path) {
+		notify_mount(source_mnt->mnt_parent, source_mnt,
+			     notify_mount_move_from, 0);
 		detach_mnt(source_mnt, parent_path);
+		notify_mount(dest_mnt, source_mnt, notify_mount_move_to, 0);
 		attach_mnt(source_mnt, dest_mnt, dest_mp);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
+		notify_mount(dest_mnt, source_mnt, notify_mount_new_mount,
+			     source_mnt->mnt.mnt_sb->s_flags & SB_SUBMOUNT ?
+			     WATCH_INFO_FLAG_0 : 0);
 		commit_tree(source_mnt);
 	}
 
@@ -2361,6 +2377,7 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 	mnt->mnt.mnt_flags = mnt_flags;
 	touch_mnt_namespace(mnt->mnt_ns);
 	unlock_mount_hash();
+	notify_mount(mnt, NULL, notify_mount_setattr, 0);
 }
 
 /*
@@ -2767,6 +2784,7 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
 			propagate_mount_busy(mnt, 1))
 			continue;
+		notify_mount(mnt, NULL, notify_mount_expiry, 0);
 		list_move(&mnt->mnt_expire, &graveyard);
 	}
 	while (!list_empty(&graveyard)) {
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 66c6e17e61e5..b0eb68ed5b9b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -217,6 +217,7 @@ struct dentry_operations {
 
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
+#define DCACHE_MOUNT_WATCH		0x40000000 /* There's a mount watch here */
 
 extern seqlock_t rename_lock;
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 84b653874ab8..7db37c58289a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -913,6 +913,8 @@ asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags)
 asmlinkage long sys_fsinfo(int dfd, const char __user *path,
 			   struct fsinfo_params __user *params,
 			   void __user *buffer, size_t buf_size);
+asmlinkage long sys_mount_notify(int dfd, const char __user *path,
+				 unsigned int at_flags, int watch_fd, int watch_id);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 3e0ab5fe388d..9d8e165e0065 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -103,4 +103,28 @@ struct key_notification {
 	__u32	aux;		/* Per-type auxiliary data */
 };
 
+/*
+ * Type of mount topology change notification.
+ */
+enum mount_notification_subtype {
+	notify_mount_new_mount	= 0, /* New mount added */
+	notify_mount_unmount	= 1, /* Mount removed manually */
+	notify_mount_expiry	= 2, /* Automount expired */
+	notify_mount_readonly	= 3, /* Mount R/O state changed */
+	notify_mount_setattr	= 4, /* Mount attributes changed */
+	notify_mount_move_from	= 5, /* Mount moved from here */
+	notify_mount_move_to	= 6, /* Mount moved to here (compare op_id) */
+};
+
+/*
+ * Mount topology/configuration change notification record.
+ * - watch.type = WATCH_TYPE_MOUNT_NOTIFY
+ * - watch.subtype = enum mount_notification_subtype
+ */
+struct mount_notification {
+	struct watch_notification watch; /* WATCH_TYPE_MOUNT_NOTIFY */
+	__u32	triggered_on;		/* The mount that the notify was on */
+	__u32	changed_mount;		/* The mount that got changed */
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index df556175be50..f608777be045 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -80,6 +80,9 @@ COND_SYSCALL(ioprio_get);
 /* fs/locks.c */
 COND_SYSCALL(flock);
 
+/* fs/mount_notify.c */
+COND_SYSCALL(mount_notify);
+
 /* fs/namei.c */
 
 /* fs/namespace.c */

