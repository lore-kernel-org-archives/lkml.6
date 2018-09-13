Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6DFC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9147920854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9147920854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeIMSn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:43:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbeIMSnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:43:25 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 32DCFCF3;
        Thu, 13 Sep 2018 13:33:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        =?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>
Subject: [PATCH 4.4 51/60] ovl: proper cleanup of workdir
Date:   Thu, 13 Sep 2018 15:30:58 +0200
Message-Id: <20180913131747.854187083@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131745.261413581@linuxfoundation.org>
References: <20180913131745.261413581@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit eea2fb4851e9dcbab6b991aaf47e2e024f1f55a0 upstream.

When mounting overlayfs it needs a clean "work" directory under the
supplied workdir.

Previously the mount code removed this directory if it already existed and
created a new one.  If the removal failed (e.g. directory was not empty)
then it fell back to a read-only mount not using the workdir.

While this has never been reported, it is possible to get a non-empty
"work" dir from a previous mount of overlayfs in case of crash in the
middle of an operation using the work directory.

In this case the left over state should be discarded and the overlay
filesystem will be consistent, guaranteed by the atomicity of operations on
moving to/from the workdir to the upper layer.

This patch implements cleaning out any files left in workdir.  It is
implemented using real recursion for simplicity, but the depth is limited
to 2, because the worst case is that of a directory containing whiteouts
under "work".

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/overlayfs.h |    2 +
 fs/overlayfs/readdir.c   |   63 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/overlayfs/super.c     |    2 -
 3 files changed, 65 insertions(+), 2 deletions(-)

--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -165,6 +165,8 @@ int ovl_check_empty_dir(struct dentry *d
 void ovl_cleanup_whiteouts(struct dentry *upper, struct list_head *list);
 void ovl_cache_free(struct list_head *list);
 int ovl_check_d_type_supported(struct path *realpath);
+void ovl_workdir_cleanup(struct inode *dir, struct vfsmount *mnt,
+			 struct dentry *dentry, int level);
 
 /* inode.c */
 int ovl_setattr(struct dentry *dentry, struct iattr *attr);
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -248,7 +248,7 @@ static inline int ovl_dir_read(struct pa
 			err = rdd->err;
 	} while (!err && rdd->count);
 
-	if (!err && rdd->first_maybe_whiteout)
+	if (!err && rdd->first_maybe_whiteout && rdd->dentry)
 		err = ovl_check_whiteouts(realpath->dentry, rdd);
 
 	fput(realfile);
@@ -610,3 +610,64 @@ int ovl_check_d_type_supported(struct pa
 
 	return rdd.d_type_supported;
 }
+
+static void ovl_workdir_cleanup_recurse(struct path *path, int level)
+{
+	int err;
+	struct inode *dir = path->dentry->d_inode;
+	LIST_HEAD(list);
+	struct ovl_cache_entry *p;
+	struct ovl_readdir_data rdd = {
+		.ctx.actor = ovl_fill_merge,
+		.dentry = NULL,
+		.list = &list,
+		.root = RB_ROOT,
+		.is_lowest = false,
+	};
+
+	err = ovl_dir_read(path, &rdd);
+	if (err)
+		goto out;
+
+	inode_lock_nested(dir, I_MUTEX_PARENT);
+	list_for_each_entry(p, &list, l_node) {
+		struct dentry *dentry;
+
+		if (p->name[0] == '.') {
+			if (p->len == 1)
+				continue;
+			if (p->len == 2 && p->name[1] == '.')
+				continue;
+		}
+		dentry = lookup_one_len(p->name, path->dentry, p->len);
+		if (IS_ERR(dentry))
+			continue;
+		if (dentry->d_inode)
+			ovl_workdir_cleanup(dir, path->mnt, dentry, level);
+		dput(dentry);
+	}
+	inode_unlock(dir);
+out:
+	ovl_cache_free(&list);
+}
+
+void ovl_workdir_cleanup(struct inode *dir, struct vfsmount *mnt,
+			 struct dentry *dentry, int level)
+{
+	int err;
+
+	if (!d_is_dir(dentry) || level > 1) {
+		ovl_cleanup(dir, dentry);
+		return;
+	}
+
+	err = ovl_do_rmdir(dir, dentry);
+	if (err) {
+		struct path path = { .mnt = mnt, .dentry = dentry };
+
+		inode_unlock(dir);
+		ovl_workdir_cleanup_recurse(&path, level + 1);
+		inode_lock_nested(dir, I_MUTEX_PARENT);
+		ovl_cleanup(dir, dentry);
+	}
+}
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -784,7 +784,7 @@ retry:
 				goto out_dput;
 
 			retried = true;
-			ovl_cleanup(dir, work);
+			ovl_workdir_cleanup(dir, mnt, work, 0);
 			dput(work);
 			goto retry;
 		}


