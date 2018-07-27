Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA2EC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0FF208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0FF208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389517AbeG0Szd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728713AbeG0Szd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:55:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 575E677888;
        Fri, 27 Jul 2018 17:32:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 497F11C5BD;
        Fri, 27 Jul 2018 17:32:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/38] apparmor: Implement security hooks for the new mount
 API [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     John Johansen <john.johansen@canonical.com>,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:32:37 +0100
Message-ID: <153271275782.9458.14087164564403655935.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 27 Jul 2018 17:32:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 27 Jul 2018 17:32:39 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement hooks to check the creation of new mountpoints for AppArmor.

Unfortunately, the DFA evaluation puts the option data in last, after the
details of the mountpoint, so we have to cache the mount options in the
fs_context using those hooks till we get to the new mountpoint hook.

Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: John Johansen <john.johansen@canonical.com>
cc: apparmor@lists.ubuntu.com
cc: linux-security-module@vger.kernel.org
---

 security/apparmor/include/mount.h |   11 +++++
 security/apparmor/lsm.c           |   80 +++++++++++++++++++++++++++++++++++++
 security/apparmor/mount.c         |   46 +++++++++++++++++++++
 3 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/include/mount.h b/security/apparmor/include/mount.h
index 25d6067fa6ef..0441bfae30fa 100644
--- a/security/apparmor/include/mount.h
+++ b/security/apparmor/include/mount.h
@@ -16,6 +16,7 @@
 
 #include <linux/fs.h>
 #include <linux/path.h>
+#include <linux/fs_context.h>
 
 #include "domain.h"
 #include "policy.h"
@@ -27,7 +28,13 @@
 #define AA_AUDIT_DATA		0x40
 #define AA_MNT_CONT_MATCH	0x40
 
-#define AA_MS_IGNORE_MASK (MS_KERNMOUNT | MS_NOSEC | MS_ACTIVE | MS_BORN)
+#define AA_SB_IGNORE_MASK (SB_KERNMOUNT | SB_NOSEC | SB_ACTIVE | SB_BORN)
+
+struct apparmor_fs_context {
+	struct fs_context	fc;
+	char			*saved_options;
+	size_t			saved_size;
+};
 
 int aa_remount(struct aa_label *label, const struct path *path,
 	       unsigned long flags, void *data);
@@ -45,6 +52,8 @@ int aa_move_mount(struct aa_label *label, const struct path *path,
 int aa_new_mount(struct aa_label *label, const char *dev_name,
 		 const struct path *path, const char *type, unsigned long flags,
 		 void *data);
+int aa_new_mount_fc(struct aa_label *label, struct fs_context *fc,
+		    const struct path *mountpoint);
 
 int aa_umount(struct aa_label *label, struct vfsmount *mnt, int flags);
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 84e644ce3583..9a5915dffbdc 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -520,6 +520,78 @@ static int apparmor_file_mprotect(struct vm_area_struct *vma,
 			   !(vma->vm_flags & VM_SHARED) ? MAP_PRIVATE : 0);
 }
 
+static int apparmor_fs_context_alloc(struct fs_context *fc, struct dentry *reference)
+{
+	struct apparmor_fs_context *afc;
+
+	afc = kzalloc(sizeof(*afc), GFP_KERNEL);
+	if (!afc)
+		return -ENOMEM;
+
+	fc->security = afc;
+	return 0;
+}
+
+static int apparmor_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
+{
+	fc->security = NULL;
+	return 0;
+}
+
+static void apparmor_fs_context_free(struct fs_context *fc)
+{
+	struct apparmor_fs_context *afc = fc->security;
+
+	if (afc) {
+		kfree(afc->saved_options);
+		kfree(afc);
+	}
+}
+
+/*
+ * As a temporary hack, we buffer all the options.  The problem is that we need
+ * to pass them to the DFA evaluator *after* mount point parameters, which
+ * means deferring the entire check to the sb_mountpoint hook.
+ */
+static int apparmor_fs_context_parse_option(struct fs_context *fc, char *opt, size_t len)
+{
+	struct apparmor_fs_context *afc = fc->security;
+	size_t space = 0;
+	char *p, *q;
+
+	if (afc->saved_size > 0)
+		space = 1;
+
+	p = krealloc(afc->saved_options, afc->saved_size + space + len + 1, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	q = p + afc->saved_size;
+	if (q != p)
+		*q++ = ' ';
+	memcpy(q, opt, len);
+	q += len;
+	*q = 0;
+
+	afc->saved_options = p;
+	afc->saved_size += 1 + len;
+	return 0;
+}
+
+static int apparmor_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
+				  unsigned int mnt_flags)
+{
+	struct aa_label *label;
+	int error = 0;
+
+	label = __begin_current_label_crit_section();
+	if (!unconfined(label))
+		error = aa_new_mount_fc(label, fc, mountpoint);
+	__end_current_label_crit_section(label);
+
+	return error;
+}
+
 static int apparmor_sb_mount(const char *dev_name, const struct path *path,
 			     const char *type, unsigned long flags,
 			     void *data, size_t data_size)
@@ -531,7 +603,7 @@ static int apparmor_sb_mount(const char *dev_name, const struct path *path,
 	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
 		flags &= ~MS_MGC_MSK;
 
-	flags &= ~AA_MS_IGNORE_MASK;
+	flags &= ~AA_SB_IGNORE_MASK;
 
 	label = __begin_current_label_crit_section();
 	if (!unconfined(label)) {
@@ -1134,6 +1206,12 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(capget, apparmor_capget),
 	LSM_HOOK_INIT(capable, apparmor_capable),
 
+	LSM_HOOK_INIT(fs_context_alloc, apparmor_fs_context_alloc),
+	LSM_HOOK_INIT(fs_context_dup, apparmor_fs_context_dup),
+	LSM_HOOK_INIT(fs_context_free, apparmor_fs_context_free),
+	LSM_HOOK_INIT(fs_context_parse_option, apparmor_fs_context_parse_option),
+	LSM_HOOK_INIT(sb_mountpoint, apparmor_sb_mountpoint),
+
 	LSM_HOOK_INIT(sb_mount, apparmor_sb_mount),
 	LSM_HOOK_INIT(sb_umount, apparmor_sb_umount),
 	LSM_HOOK_INIT(sb_pivotroot, apparmor_sb_pivotroot),
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 8c3787399356..3c95fffb76ac 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -554,6 +554,52 @@ int aa_new_mount(struct aa_label *label, const char *dev_name,
 	return error;
 }
 
+int aa_new_mount_fc(struct aa_label *label, struct fs_context *fc,
+		    const struct path *mountpoint)
+{
+	struct apparmor_fs_context *afc = fc->security;
+	struct aa_profile *profile;
+	char *buffer = NULL, *dev_buffer = NULL;
+	bool binary;
+	int error;
+	struct path tmp_path, *dev_path = NULL;
+
+	AA_BUG(!label);
+	AA_BUG(!mountpoint);
+
+	binary = fc->fs_type->fs_flags & FS_BINARY_MOUNTDATA;
+
+	if (fc->fs_type->fs_flags & FS_REQUIRES_DEV) {
+		if (!fc->source)
+			return -ENOENT;
+
+		error = kern_path(fc->source, LOOKUP_FOLLOW, &tmp_path);
+		if (error)
+			return error;
+		dev_path = &tmp_path;
+	}
+
+	get_buffers(buffer, dev_buffer);
+	if (dev_path) {
+		error = fn_for_each_confined(label, profile,
+			match_mnt(profile, mountpoint, buffer, dev_path, dev_buffer,
+				  fc->fs_type->name,
+				  fc->sb_flags & ~AA_SB_IGNORE_MASK,
+				  afc->saved_options, binary));
+	} else {
+		error = fn_for_each_confined(label, profile,
+			match_mnt_path_str(profile, mountpoint, buffer,
+					   fc->source, fc->fs_type->name,
+					   fc->sb_flags & ~AA_SB_IGNORE_MASK,
+					   afc->saved_options, binary, NULL));
+	}
+	put_buffers(buffer, dev_buffer);
+	if (dev_path)
+		path_put(dev_path);
+
+	return error;
+}
+
 static int profile_umount(struct aa_profile *profile, struct path *path,
 			  char *buffer)
 {

