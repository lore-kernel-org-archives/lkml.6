Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37D6ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E17021566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E17021566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391041AbeIUWWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:22:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:19311 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390065AbeIUWWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:22:08 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D7ACC05D3E6;
        Fri, 21 Sep 2018 16:32:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9823862EB;
        Fri, 21 Sep 2018 16:32:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/34] procfs: Move proc_fill_super() to fs/proc/root.c [ver
 #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:32:27 +0100
Message-ID: <153754754793.17872.17561436000413099524.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 21 Sep 2018 16:32:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move proc_fill_super() to fs/proc/root.c as that's where the other
superblock stuff is.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/proc/inode.c    |   49 +------------------------------------------------
 fs/proc/internal.h |    4 +---
 fs/proc/root.c     |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 49 insertions(+), 52 deletions(-)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 8f121c476c07..9fdda2946554 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -24,7 +24,6 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/mount.h>
-#include <linux/magic.h>
 
 #include <linux/uaccess.h>
 
@@ -124,7 +123,7 @@ static int proc_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static const struct super_operations proc_sops = {
+const struct super_operations proc_sops = {
 	.alloc_inode	= proc_alloc_inode,
 	.destroy_inode	= proc_destroy_inode,
 	.drop_inode	= generic_delete_inode,
@@ -490,49 +489,3 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 	       pde_put(de);
 	return inode;
 }
-
-int proc_fill_super(struct super_block *s, void *data, size_t data_size,
-		    int silent)
-{
-	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
-	struct inode *root_inode;
-	int ret;
-
-	if (!proc_parse_options(data, ns))
-		return -EINVAL;
-
-	/* User space would break if executables or devices appear on proc */
-	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
-	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
-	s->s_blocksize = 1024;
-	s->s_blocksize_bits = 10;
-	s->s_magic = PROC_SUPER_MAGIC;
-	s->s_op = &proc_sops;
-	s->s_time_gran = 1;
-
-	/*
-	 * procfs isn't actually a stacking filesystem; however, there is
-	 * too much magic going on inside it to permit stacking things on
-	 * top of it
-	 */
-	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
-	
-	pde_get(&proc_root);
-	root_inode = proc_get_inode(s, &proc_root);
-	if (!root_inode) {
-		pr_err("proc_fill_super: get root inode failed\n");
-		return -ENOMEM;
-	}
-
-	s->s_root = d_make_root(root_inode);
-	if (!s->s_root) {
-		pr_err("proc_fill_super: allocate dentry failed\n");
-		return -ENOMEM;
-	}
-
-	ret = proc_setup_self(s);
-	if (ret) {
-		return ret;
-	}
-	return proc_setup_thread_self(s);
-}
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 3b88db52d206..912cb2cd29dd 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -205,13 +205,12 @@ struct pde_opener {
 	struct completion *c;
 } __randomize_layout;
 extern const struct inode_operations proc_link_inode_operations;
-
 extern const struct inode_operations proc_pid_link_inode_operations;
+extern const struct super_operations proc_sops;
 
 void proc_init_kmemcache(void);
 void set_proc_pid_nlink(void);
 extern struct inode *proc_get_inode(struct super_block *, struct proc_dir_entry *);
-extern int proc_fill_super(struct super_block *, void *, size_t, int);
 extern void proc_entry_rundown(struct proc_dir_entry *);
 
 /*
@@ -269,7 +268,6 @@ static inline void proc_tty_init(void) {}
  * root.c
  */
 extern struct proc_dir_entry proc_root;
-extern int proc_parse_options(char *options, struct pid_namespace *pid);
 
 extern void proc_self_init(void);
 extern int proc_remount(struct super_block *, int *, char *, size_t);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 28fadb0c51ab..15da85cefd3f 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -23,6 +23,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/parser.h>
 #include <linux/cred.h>
+#include <linux/magic.h>
 
 #include "internal.h"
 
@@ -36,7 +37,7 @@ static const match_table_t tokens = {
 	{Opt_err, NULL},
 };
 
-int proc_parse_options(char *options, struct pid_namespace *pid)
+static int proc_parse_options(char *options, struct pid_namespace *pid)
 {
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
@@ -78,6 +79,51 @@ int proc_parse_options(char *options, struct pid_namespace *pid)
 	return 1;
 }
 
+static int proc_fill_super(struct super_block *s, void *data, size_t data_size, int silent)
+{
+	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
+	struct inode *root_inode;
+	int ret;
+
+	if (!proc_parse_options(data, ns))
+		return -EINVAL;
+
+	/* User space would break if executables or devices appear on proc */
+	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
+	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
+	s->s_blocksize = 1024;
+	s->s_blocksize_bits = 10;
+	s->s_magic = PROC_SUPER_MAGIC;
+	s->s_op = &proc_sops;
+	s->s_time_gran = 1;
+
+	/*
+	 * procfs isn't actually a stacking filesystem; however, there is
+	 * too much magic going on inside it to permit stacking things on
+	 * top of it
+	 */
+	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
+	
+	pde_get(&proc_root);
+	root_inode = proc_get_inode(s, &proc_root);
+	if (!root_inode) {
+		pr_err("proc_fill_super: get root inode failed\n");
+		return -ENOMEM;
+	}
+
+	s->s_root = d_make_root(root_inode);
+	if (!s->s_root) {
+		pr_err("proc_fill_super: allocate dentry failed\n");
+		return -ENOMEM;
+	}
+
+	ret = proc_setup_self(s);
+	if (ret) {
+		return ret;
+	}
+	return proc_setup_thread_self(s);
+}
+
 int proc_remount(struct super_block *sb, int *flags,
 		 char *data, size_t data_size)
 {

