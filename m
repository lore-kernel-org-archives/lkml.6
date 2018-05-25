Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971777AbeEYAGH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 20:06:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S970097AbeEYAFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 20:05:45 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/32] VFS: Introduce the basic header for the new mount
 API's filesystem context [ver #8]
From: David Howells <dhowells@redhat.com>
To: viro@zeniv.linux.org.uk
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 25 May 2018 01:05:43 +0100
Message-ID: <152720674345.9073.7664682296580266598.stgit@warthog.procyon.org.uk>
In-Reply-To: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a filesystem context concept to be used during superblock
creation for mount and superblock reconfiguration for remount.  This is
allocated at the beginning of the mount procedure and into it is placed:

 (1) Filesystem type.

 (2) Namespaces.

 (3) Source/Device names (there may be multiple).

 (4) Superblock flags (SB_*).

 (5) Security details.

 (6) Filesystem-specific data, as set by the mount options.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/fs_context.h |   75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 include/linux/fs_context.h

diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
new file mode 100644
index 000000000000..04783814632c
--- /dev/null
+++ b/include/linux/fs_context.h
@@ -0,0 +1,75 @@
+/* Filesystem superblock creation and reconfiguration context.
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
+#ifndef _LINUX_FS_CONTEXT_H
+#define _LINUX_FS_CONTEXT_H
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+
+struct cred;
+struct dentry;
+struct file_operations;
+struct file_system_type;
+struct mnt_namespace;
+struct net;
+struct pid_namespace;
+struct super_block;
+struct user_namespace;
+struct vfsmount;
+
+enum fs_context_purpose {
+	FS_CONTEXT_FOR_USER_MOUNT,	/* New superblock for user-specified mount */
+	FS_CONTEXT_FOR_KERNEL_MOUNT,	/* New superblock for kernel-internal mount */
+	FS_CONTEXT_FOR_SUBMOUNT,	/* New superblock for automatic submount */
+	FS_CONTEXT_FOR_RECONFIGURE,	/* Superblock reconfiguration (remount) */
+};
+
+/*
+ * Filesystem context for holding the parameters used in the creation or
+ * reconfiguration of a superblock.
+ *
+ * Superblock creation fills in ->root whereas reconfiguration begins with this
+ * already set.
+ *
+ * See Documentation/filesystems/mounting.txt
+ */
+struct fs_context {
+	const struct fs_context_operations *ops;
+	struct file_system_type	*fs_type;
+	void			*fs_private;	/* The filesystem's context */
+	struct dentry		*root;		/* The root and superblock */
+	struct user_namespace	*user_ns;	/* The user namespace for this mount */
+	struct net		*net_ns;	/* The network namespace for this mount */
+	const struct cred	*cred;		/* The mounter's credentials */
+	char			*source;	/* The source name (eg. dev path) */
+	char			*subtype;	/* The subtype to set on the superblock */
+	void			*security;	/* The LSM context */
+	void			*s_fs_info;	/* Proposed s_fs_info */
+	unsigned int		sb_flags;	/* Proposed superblock flags (SB_*) */
+	bool			sloppy:1;	/* T if unrecognised options are okay */
+	bool			silent:1;	/* T if "o silent" specified */
+	bool			drop_sb:1;	/* T if need to drop an SB reference */
+	bool			source_is_dev:1; /* T if source is local device/file */
+	enum fs_context_purpose	purpose : 8;
+};
+
+struct fs_context_operations {
+	void (*free)(struct fs_context *fc);
+	int (*dup)(struct fs_context *fc, struct fs_context *src_fc);
+	int (*parse_source)(struct fs_context *fc, char *source);
+	int (*parse_option)(struct fs_context *fc, char *opt, size_t len);
+	int (*parse_monolithic)(struct fs_context *fc, void *data);
+	int (*validate)(struct fs_context *fc);
+	int (*get_tree)(struct fs_context *fc);
+};
+
+#endif /* _LINUX_FS_CONTEXT_H */
