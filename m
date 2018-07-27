Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C64DC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1F8208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1F8208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389462AbeG0SzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388886AbeG0SzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:55:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E01F740216E6;
        Fri, 27 Jul 2018 17:32:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12A891C5B9;
        Fri, 27 Jul 2018 17:32:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/38] vfs: Add LSM hooks for the new mount API [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:32:16 +0100
Message-ID: <153271273658.9458.13966476574915847397.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 17:32:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 17:32:17 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LSM hooks for use by the new mount API and filesystem context code.
This includes:

 (1) Hooks to handle allocation, duplication and freeing of the security
     record attached to a filesystem context.

 (2) A hook to snoop source specifications.  There may be multiple of these
     if the filesystem supports it.  They will to be local files/devices if
     fs_context::source_is_dev is true and will be something else, possibly
     remote server specifications, if false.

 (3) A hook to snoop superblock configuration options in key[=val] form.
     If the LSM decides it wants to handle it, it can suppress the option
     being passed to the filesystem.  Note that 'val' may include commas
     and binary data with the fsopen patch.

 (4) A hook to perform validation and allocation after the configuration
     has been done but before the superblock is allocated and set up.

 (5) A hook to transfer the security from the context to a newly created
     superblock.

 (6) A hook to rule on whether a path point can be used as a mountpoint.

These are intended to replace:

	security_sb_copy_data
	security_sb_kern_mount
	security_sb_mount
	security_sb_set_mnt_opts
	security_sb_clone_mnt_opts
	security_sb_parse_opts_str

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-security-module@vger.kernel.org
---

 include/linux/lsm_hooks.h |   61 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/security.h  |   47 +++++++++++++++++++++++++++++++++++
 security/security.c       |   41 ++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 924424e7be8f..60a9a40bd46c 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -76,6 +76,49 @@
  *	changes on the process such as clearing out non-inheritable signal
  *	state.  This is called immediately after commit_creds().
  *
+ * Security hooks for mount using fs_context.
+ *	[See also Documentation/filesystems/mounting.txt]
+ *
+ * @fs_context_alloc:
+ *	Allocate and attach a security structure to sc->security.  This pointer
+ *	is initialised to NULL by the caller.
+ *	@fc indicates the new filesystem context.
+ *	@reference indicates the source dentry of a submount or start of reconfig.
+ * @fs_context_dup:
+ *	Allocate and attach a security structure to sc->security.  This pointer
+ *	is initialised to NULL by the caller.
+ *	@fc indicates the new filesystem context.
+ *	@src_fc indicates the original filesystem context.
+ * @fs_context_free:
+ *	Clean up a filesystem context.
+ *	@fc indicates the filesystem context.
+ * @fs_context_parse_param:
+ *	Userspace provided a parameter to configure a superblock.  The LSM may
+ *	reject it with an error and may use it for itself, in which case it
+ *	should return 1; otherwise it should return 0 to pass it on to the
+ *	filesystem.
+ *	@fc indicates the filesystem context.
+ *	@param The parameter
+ * @fs_context_validate:
+ *	Validate the filesystem context preparatory to applying it.  This is
+ *	done after all the options have been parsed.
+ *	@fc indicates the filesystem context.
+ * @sb_get_tree:
+ *	Assign the security to a newly created superblock.
+ *	@fc indicates the filesystem context.
+ *	@fc->root indicates the root that will be mounted.
+ *	@fc->root->d_sb points to the superblock.
+ * @sb_reconfigure:
+ *	Apply reconfiguration to the security on a superblock.
+ *	@fc indicates the filesystem context.
+ *	@fc->root indicates a dentry in the mount.
+ *	@fc->root->d_sb points to the superblock.
+ * @sb_mountpoint:
+ *	Equivalent of sb_mount, but with an fs_context.
+ *	@fc indicates the filesystem context.
+ *	@mountpoint indicates the path on which the mount will take place.
+ *	@mnt_flags indicates the MNT_* flags specified.
+ *
  * Security hooks for filesystem operations.
  *
  * @sb_alloc_security:
@@ -1462,6 +1505,16 @@ union security_list_options {
 	void (*bprm_committing_creds)(struct linux_binprm *bprm);
 	void (*bprm_committed_creds)(struct linux_binprm *bprm);
 
+	int (*fs_context_alloc)(struct fs_context *fc, struct dentry *reference);
+	int (*fs_context_dup)(struct fs_context *fc, struct fs_context *src_sc);
+	void (*fs_context_free)(struct fs_context *fc);
+	int (*fs_context_parse_param)(struct fs_context *fc, struct fs_parameter *param);
+	int (*fs_context_validate)(struct fs_context *fc);
+	int (*sb_get_tree)(struct fs_context *fc);
+	void (*sb_reconfigure)(struct fs_context *fc);
+	int (*sb_mountpoint)(struct fs_context *fc, struct path *mountpoint,
+			     unsigned int mnt_flags);
+
 	int (*sb_alloc_security)(struct super_block *sb);
 	void (*sb_free_security)(struct super_block *sb);
 	int (*sb_copy_data)(char *orig, size_t orig_size, char *copy);
@@ -1803,6 +1856,14 @@ struct security_hook_heads {
 	struct hlist_head bprm_check_security;
 	struct hlist_head bprm_committing_creds;
 	struct hlist_head bprm_committed_creds;
+	struct hlist_head fs_context_alloc;
+	struct hlist_head fs_context_dup;
+	struct hlist_head fs_context_free;
+	struct hlist_head fs_context_parse_param;
+	struct hlist_head fs_context_validate;
+	struct hlist_head sb_get_tree;
+	struct hlist_head sb_reconfigure;
+	struct hlist_head sb_mountpoint;
 	struct hlist_head sb_alloc_security;
 	struct hlist_head sb_free_security;
 	struct hlist_head sb_copy_data;
diff --git a/include/linux/security.h b/include/linux/security.h
index 9bb5bc6d596c..a8b1056ed6e4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -53,6 +53,9 @@ struct msg_msg;
 struct xattr;
 struct xfrm_sec_ctx;
 struct mm_struct;
+struct fs_context;
+struct fs_parameter;
+enum fs_value_type;
 
 /* If capable should audit the security request */
 #define SECURITY_CAP_NOAUDIT 0
@@ -225,6 +228,15 @@ int security_bprm_set_creds(struct linux_binprm *bprm);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
+int security_fs_context_alloc(struct fs_context *fc, struct dentry *reference);
+int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc);
+void security_fs_context_free(struct fs_context *fc);
+int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param);
+int security_fs_context_validate(struct fs_context *fc);
+int security_sb_get_tree(struct fs_context *fc);
+void security_sb_reconfigure(struct fs_context *fc);
+int security_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
+			   unsigned int mnt_flags);
 int security_sb_alloc(struct super_block *sb);
 void security_sb_free(struct super_block *sb);
 int security_sb_copy_data(char *orig, size_t orig_size, char *copy);
@@ -526,6 +538,41 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
 {
 }
 
+static inline int security_fs_context_alloc(struct fs_context *fc,
+					    struct dentry *reference)
+{
+	return 0;
+}
+static inline int security_fs_context_dup(struct fs_context *fc,
+					  struct fs_context *src_fc)
+{
+	return 0;
+}
+static inline void security_fs_context_free(struct fs_context *fc)
+{
+}
+static inline int security_fs_context_parse_param(struct fs_context *fc,
+						  struct fs_parameter *param)
+{
+	return 0;
+}
+static inline int security_fs_context_validate(struct fs_context *fc)
+{
+	return 0;
+}
+static inline int security_sb_get_tree(struct fs_context *fc)
+{
+	return 0;
+}
+static inline void security_sb_reconfigure(struct fs_context *fc)
+{
+}
+static inline int security_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
+					 unsigned int mnt_flags)
+{
+	return 0;
+}
+
 static inline int security_sb_alloc(struct super_block *sb)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 5149c2cbe8a7..9bdc21ae645c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -358,6 +358,47 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
 	call_void_hook(bprm_committed_creds, bprm);
 }
 
+int security_fs_context_alloc(struct fs_context *fc, struct dentry *reference)
+{
+	return call_int_hook(fs_context_alloc, 0, fc, reference);
+}
+
+int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
+{
+	return call_int_hook(fs_context_dup, 0, fc, src_fc);
+}
+
+void security_fs_context_free(struct fs_context *fc)
+{
+	call_void_hook(fs_context_free, fc);
+}
+
+int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	return call_int_hook(fs_context_parse_param, 0, fc, param);
+}
+
+int security_fs_context_validate(struct fs_context *fc)
+{
+	return call_int_hook(fs_context_validate, 0, fc);
+}
+
+int security_sb_get_tree(struct fs_context *fc)
+{
+	return call_int_hook(sb_get_tree, 0, fc);
+}
+
+void security_sb_reconfigure(struct fs_context *fc)
+{
+	call_void_hook(sb_reconfigure, fc);
+}
+
+int security_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
+			   unsigned int mnt_flags)
+{
+	return call_int_hook(sb_mountpoint, 0, fc, mountpoint, mnt_flags);
+}
+
 int security_sb_alloc(struct super_block *sb)
 {
 	return call_int_hook(sb_alloc_security, 0, sb);

