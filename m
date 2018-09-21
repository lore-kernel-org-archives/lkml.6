Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B40C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C70321477
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C70321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390879AbeIUWUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:20:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390381AbeIUWUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:20:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 697EC30B8FA3;
        Fri, 21 Sep 2018 16:31:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B48A1425F;
        Fri, 21 Sep 2018 16:31:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/34] vfs: Add LSM hooks for the new mount API [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:31:12 +0100
Message-ID: <153754747294.17872.6507090218671594343.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 21 Sep 2018 16:31:15 +0000 (UTC)
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
index d052db1a1565..7e50bfa1aee0 100644
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
+ *	should return 0; otherwise it should return -ENOPARAM to pass it on to
+ *	the filesystem.
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
@@ -1466,6 +1509,16 @@ union security_list_options {
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
@@ -1808,6 +1861,14 @@ struct security_hook_heads {
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
index a306061d2197..636215bf4c1b 100644
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
@@ -246,6 +249,15 @@ int security_bprm_set_creds(struct linux_binprm *bprm);
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
@@ -548,6 +560,41 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
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
+	return -ENOPARAM;
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
index 96a061cecb39..64304d20aae1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -363,6 +363,47 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
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
+	return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
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

