Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF06CC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F13A208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F13A208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389544AbeG0Szr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728713AbeG0Szq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:55:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4BDDA81663CF;
        Fri, 27 Jul 2018 17:32:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 415382026D6B;
        Fri, 27 Jul 2018 17:32:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/38] tomoyo: Implement security hooks for the new mount
 API [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        tomoyo-dev-en@lists.sourceforge.jp,
        linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:32:50 +0100
Message-ID: <153271277078.9458.16912166489973051987.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:32:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:32:52 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the security hook to check the creation of a new mountpoint for
Tomoyo.

As far as I can tell, Tomoyo doesn't make use of the mount data or parse
any mount options, so I haven't implemented any of the fs_context hooks for
it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc: tomoyo-dev-en@lists.sourceforge.jp
cc: linux-security-module@vger.kernel.org
---

 security/tomoyo/common.h |    3 +++
 security/tomoyo/mount.c  |   45 +++++++++++++++++++++++++++++++++++++++++++++
 security/tomoyo/tomoyo.c |   15 +++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 539bcdd30bb8..e637ce73f7f9 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -971,6 +971,9 @@ int tomoyo_init_request_info(struct tomoyo_request_info *r,
 			     const u8 index);
 int tomoyo_mkdev_perm(const u8 operation, const struct path *path,
 		      const unsigned int mode, unsigned int dev);
+int tomoyo_mount_permission_fc(struct fs_context *fc,
+			       const struct path *mountpoint,
+			       unsigned int mnt_flags);
 int tomoyo_mount_permission(const char *dev_name, const struct path *path,
 			    const char *type, unsigned long flags,
 			    void *data_page);
diff --git a/security/tomoyo/mount.c b/security/tomoyo/mount.c
index 7dc7f59b7dde..9ec84ab6f5e1 100644
--- a/security/tomoyo/mount.c
+++ b/security/tomoyo/mount.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/fs_context.h>
 #include <uapi/linux/mount.h>
 #include "common.h"
 
@@ -236,3 +237,47 @@ int tomoyo_mount_permission(const char *dev_name, const struct path *path,
 	tomoyo_read_unlock(idx);
 	return error;
 }
+
+/**
+ * tomoyo_mount_permission_fc - Check permission to create a new mount.
+ * @fc:		Context describing the object to be mounted.
+ * @mountpoint:	The target object to mount on.
+ * @mnt:	The MNT_* flags to be set on the mountpoint.
+ *
+ * Check the permission to create a mount of the object described in @fc.  Note
+ * that the source object may be a newly created superblock or may be an
+ * existing one picked from the filesystem (bind mount).
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+int tomoyo_mount_permission_fc(struct fs_context *fc,
+			       const struct path *mountpoint,
+			       unsigned int mnt_flags)
+{
+	struct tomoyo_request_info r;
+	unsigned int ms_flags = 0;
+	int error;
+	int idx;
+
+	if (tomoyo_init_request_info(&r, NULL, TOMOYO_MAC_FILE_MOUNT) ==
+	    TOMOYO_CONFIG_DISABLED)
+		return 0;
+
+	/* Convert MNT_* flags to MS_* equivalents. */
+	if (mnt_flags & MNT_NOSUID)	ms_flags |= MS_NOSUID;
+	if (mnt_flags & MNT_NODEV)	ms_flags |= MS_NODEV;
+	if (mnt_flags & MNT_NOEXEC)	ms_flags |= MS_NOEXEC;
+	if (mnt_flags & MNT_NOATIME)	ms_flags |= MS_NOATIME;
+	if (mnt_flags & MNT_NODIRATIME)	ms_flags |= MS_NODIRATIME;
+	if (mnt_flags & MNT_RELATIME)	ms_flags |= MS_RELATIME;
+	if (mnt_flags & MNT_READONLY)	ms_flags |= MS_RDONLY;
+
+	idx = tomoyo_read_lock();
+	/* TODO: There may be multiple sources; for the moment, just pick the
+	 * first if there is one.
+	 */
+	error = tomoyo_mount_acl(&r, fc->source, mountpoint, fc->fs_type->name,
+				 ms_flags);
+	tomoyo_read_unlock(idx);
+	return error;
+}
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index e5e349392e7b..c3a0ae4fa7ce 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -391,6 +391,20 @@ static int tomoyo_path_chroot(const struct path *path)
 	return tomoyo_path_perm(TOMOYO_TYPE_CHROOT, path, NULL);
 }
 
+/**
+ * tomoyo_sb_mount - Target for security_sb_mountpoint().
+ * @fc:		Context describing the object to be mounted.
+ * @mountpoint:	The target object to mount on.
+ * @mnt_flags:	Mountpoint specific options (as MNT_* flags).
+ *
+ * Returns 0 on success, negative value otherwise.
+ */
+static int tomoyo_sb_mountpoint(struct fs_context *fc, struct path *mountpoint,
+				unsigned int mnt_flags)
+{
+	return tomoyo_mount_permission_fc(fc, mountpoint, mnt_flags);
+}
+
 /**
  * tomoyo_sb_mount - Target for security_sb_mount().
  *
@@ -521,6 +535,7 @@ static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
 	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
 	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),
+	LSM_HOOK_INIT(sb_mountpoint, tomoyo_sb_mountpoint),
 	LSM_HOOK_INIT(sb_mount, tomoyo_sb_mount),
 	LSM_HOOK_INIT(sb_umount, tomoyo_sb_umount),
 	LSM_HOOK_INIT(sb_pivotroot, tomoyo_sb_pivotroot),

