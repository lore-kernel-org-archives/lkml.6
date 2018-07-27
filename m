Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EA5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B2A20862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18B2A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389281AbeG0Syv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389233AbeG0Syv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABB9F8577C;
        Fri, 27 Jul 2018 17:31:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EACB82166BA3;
        Fri, 27 Jul 2018 17:31:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/38] vfs: Introduce the basic header for the new mount
 API's filesystem context [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:31:56 +0100
Message-ID: <153271271646.9458.2535241852617893548.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 17:31:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 27 Jul 2018 17:31:57 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

Also introduce a struct for typed key=value parameter concept with which
configuration data will be passed to filesystems.  This will allow not only
for ordinary string values, but also make it possible to pass more exotic
values such as binary blobs, paths and fds with greater ease.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/fs_context.h |  101 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 include/linux/fs_context.h

diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
new file mode 100644
index 000000000000..0ff4969f9d5a
--- /dev/null
+++ b/include/linux/fs_context.h
@@ -0,0 +1,101 @@
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
+ * Type of parameter value.
+ */
+enum fs_value_type {
+	fs_value_is_undefined,
+	fs_value_is_flag,		/* Value not given a value */
+	fs_value_is_string,		/* Value is a string */
+	fs_value_is_blob,		/* Value is a binary blob */
+	fs_value_is_filename,		/* Value is a filename* + dirfd */
+	fs_value_is_filename_empty,	/* Value is a filename* + dirfd + AT_EMPTY_PATH */
+	fs_value_is_file,		/* Value is a file* */
+};
+
+/*
+ * Configuration parameter.
+ */
+struct fs_parameter {
+	const char		*key;		/* Parameter name */
+	enum fs_value_type	type:8;		/* The type of value here */
+	union {
+		char		*string;
+		void		*blob;
+		struct filename	*name;
+		struct file	*file;
+	};
+	size_t	size;
+	int	dirfd;
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
+	enum fs_context_purpose	purpose:8;
+	bool			sloppy:1;	/* T if unrecognised options are okay */
+	bool			silent:1;	/* T if "o silent" specified */
+};
+
+struct fs_context_operations {
+	void (*free)(struct fs_context *fc);
+	int (*dup)(struct fs_context *fc, struct fs_context *src_fc);
+	int (*parse_param)(struct fs_context *fc, struct fs_parameter *param);
+	int (*parse_monolithic)(struct fs_context *fc, void *data, size_t data_size);
+	int (*validate)(struct fs_context *fc);
+	int (*get_tree)(struct fs_context *fc);
+};
+
+#endif /* _LINUX_FS_CONTEXT_H */

