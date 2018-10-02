Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A630C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C377206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C377206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbeJBURp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbeJBURo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:44 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C7A4F5AA;
        Tue,  2 Oct 2018 13:34:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH 4.14 109/137] ovl: hash non-dir by lower inode for fsnotify
Date:   Tue,  2 Oct 2018 06:25:10 -0700
Message-Id: <20181002132506.146641790@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 764baba80168ad3adafb521d2ab483ccbc49e344 upstream.

Commit 31747eda41ef ("ovl: hash directory inodes for fsnotify")
fixed an issue of inotify watch on directory that stops getting
events after dropping dentry caches.

A similar issue exists for non-dir non-upper files, for example:

$ mkdir -p lower upper work merged
$ touch lower/foo
$ mount -t overlay -o
lowerdir=lower,workdir=work,upperdir=upper none merged
$ inotifywait merged/foo &
$ echo 2 > /proc/sys/vm/drop_caches
$ cat merged/foo

inotifywait doesn't get the OPEN event, because ovl_lookup() called
from 'cat' allocates a new overlay inode and does not reuse the
watched inode.

Fix this by hashing non-dir overlay inodes by lower real inode in
the following cases that were not hashed before this change:
 - A non-upper overlay mount
 - A lower non-hardlink when index=off

A helper ovl_hash_bylower() was added to put all the logic and
documentation about which real inode an overlay inode is hashed by
into one place.

The issue dates back to initial version of overlayfs, but this
patch depends on ovl_inode code that was introduced in kernel v4.13.

Cc: <stable@vger.kernel.org> #v4.13
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com> #4.14
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/inode.c |   62 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 18 deletions(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -14,6 +14,7 @@
 #include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include "overlayfs.h"
+#include "ovl_entry.h"
 
 int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 {
@@ -608,39 +609,63 @@ static bool ovl_verify_inode(struct inod
 	return true;
 }
 
+/*
+ * Does overlay inode need to be hashed by lower inode?
+ */
+static bool ovl_hash_bylower(struct super_block *sb, struct dentry *upper,
+			     struct dentry *lower, struct dentry *index)
+{
+	struct ovl_fs *ofs = sb->s_fs_info;
+
+	/* No, if pure upper */
+	if (!lower)
+		return false;
+
+	/* Yes, if already indexed */
+	if (index)
+		return true;
+
+	/* Yes, if won't be copied up */
+	if (!ofs->upper_mnt)
+		return true;
+
+	/* No, if lower hardlink is or will be broken on copy up */
+	if ((upper || !ovl_indexdir(sb)) &&
+	    !d_is_dir(lower) && d_inode(lower)->i_nlink > 1)
+		return false;
+
+	/* No, if non-indexed upper with NFS export */
+	if (sb->s_export_op && upper)
+		return false;
+
+	/* Otherwise, hash by lower inode for fsnotify */
+	return true;
+}
+
 struct inode *ovl_get_inode(struct dentry *dentry, struct dentry *upperdentry,
 			    struct dentry *index)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct dentry *lowerdentry = ovl_dentry_lower(dentry);
 	struct inode *realinode = upperdentry ? d_inode(upperdentry) : NULL;
 	struct inode *inode;
-	/* Already indexed or could be indexed on copy up? */
-	bool indexed = (index || (ovl_indexdir(dentry->d_sb) && !upperdentry));
-	struct dentry *origin = indexed ? lowerdentry : NULL;
+	bool bylower = ovl_hash_bylower(sb, upperdentry, lowerdentry, index);
 	bool is_dir;
 
-	if (WARN_ON(upperdentry && indexed && !lowerdentry))
-		return ERR_PTR(-EIO);
-
 	if (!realinode)
 		realinode = d_inode(lowerdentry);
 
 	/*
-	 * Copy up origin (lower) may exist for non-indexed non-dir upper, but
-	 * we must not use lower as hash key in that case.
-	 * Hash non-dir that is or could be indexed by origin inode.
-	 * Hash dir that is or could be merged by origin inode.
-	 * Hash pure upper and non-indexed non-dir by upper inode.
+	 * Copy up origin (lower) may exist for non-indexed upper, but we must
+	 * not use lower as hash key if this is a broken hardlink.
 	 */
 	is_dir = S_ISDIR(realinode->i_mode);
-	if (is_dir)
-		origin = lowerdentry;
-
-	if (upperdentry || origin) {
-		struct inode *key = d_inode(origin ?: upperdentry);
+	if (upperdentry || bylower) {
+		struct inode *key = d_inode(bylower ? lowerdentry :
+						      upperdentry);
 		unsigned int nlink = is_dir ? 1 : realinode->i_nlink;
 
-		inode = iget5_locked(dentry->d_sb, (unsigned long) key,
+		inode = iget5_locked(sb, (unsigned long) key,
 				     ovl_inode_test, ovl_inode_set, key);
 		if (!inode)
 			goto out_nomem;
@@ -664,7 +689,8 @@ struct inode *ovl_get_inode(struct dentr
 			nlink = ovl_get_nlink(lowerdentry, upperdentry, nlink);
 		set_nlink(inode, nlink);
 	} else {
-		inode = new_inode(dentry->d_sb);
+		/* Lower hardlink that will be broken on copy up */
+		inode = new_inode(sb);
 		if (!inode)
 			goto out_nomem;
 	}


