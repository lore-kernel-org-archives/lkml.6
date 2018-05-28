Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbeE1KG7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:06:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754767AbeE1KGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:06:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun Piao <piaojun@huawei.com>,
        Alex Chen <alex.chen@huawei.com>, Mark Fasheh <mfasheh@versity.com>,
        Joel Becker <jlbec@evilplan.org>, Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>, Changwei Ge <ge.changwei@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 028/185] ocfs2/acl: use ip_xattr_sem to protect getting extended attribute
Date: Mon, 28 May 2018 12:01:09 +0200
Message-Id: <20180528100052.273625112@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100050.700971285@linuxfoundation.org>
References: <20180528100050.700971285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: piaojun <piaojun@huawei.com>

[ Upstream commit 16c8d569f5704a84164f30ff01b29879f3438065 ]

The race between *set_acl and *get_acl will cause getting incomplete
xattr data as below:

  processA                                    processB

  ocfs2_set_acl
    ocfs2_xattr_set
      __ocfs2_xattr_set_handle

                                              ocfs2_get_acl_nolock
                                                ocfs2_xattr_get_nolock:

processB may get incomplete xattr data if processA hasn't set_acl done.

So we should use 'ip_xattr_sem' to protect getting extended attribute in
ocfs2_get_acl_nolock(), as other processes could be changing it
concurrently.

Link: http://lkml.kernel.org/r/5A5DDCFF.7030001@huawei.com
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Alex Chen <alex.chen@huawei.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/acl.c   |    6 ++++++
 fs/ocfs2/xattr.c |    2 ++
 2 files changed, 8 insertions(+)

--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -300,7 +300,9 @@ struct posix_acl *ocfs2_iop_get_acl(stru
 	if (ret < 0)
 		return ERR_PTR(ret);
 
+	down_read(&OCFS2_I(inode)->ip_xattr_sem);
 	acl = ocfs2_get_acl_nolock(inode, type, di_bh);
+	up_read(&OCFS2_I(inode)->ip_xattr_sem);
 
 	brelse(di_bh);
 
@@ -319,7 +321,9 @@ int ocfs2_acl_chmod(struct inode *inode,
 	if (!(osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL))
 		return 0;
 
+	down_read(&OCFS2_I(inode)->ip_xattr_sem);
 	acl = ocfs2_get_acl_nolock(inode, ACL_TYPE_ACCESS, bh);
+	up_read(&OCFS2_I(inode)->ip_xattr_sem);
 	if (IS_ERR(acl) || !acl)
 		return PTR_ERR(acl);
 	ret = __posix_acl_chmod(&acl, GFP_KERNEL, inode->i_mode);
@@ -350,8 +354,10 @@ int ocfs2_init_acl(handle_t *handle,
 
 	if (!S_ISLNK(inode->i_mode)) {
 		if (osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL) {
+			down_read(&OCFS2_I(dir)->ip_xattr_sem);
 			acl = ocfs2_get_acl_nolock(dir, ACL_TYPE_DEFAULT,
 						   dir_bh);
+			up_read(&OCFS2_I(dir)->ip_xattr_sem);
 			if (IS_ERR(acl))
 				return PTR_ERR(acl);
 		}
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -645,9 +645,11 @@ int ocfs2_calc_xattr_init(struct inode *
 						     si->value_len);
 
 	if (osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL) {
+		down_read(&OCFS2_I(dir)->ip_xattr_sem);
 		acl_len = ocfs2_xattr_get_nolock(dir, dir_bh,
 					OCFS2_XATTR_INDEX_POSIX_ACL_DEFAULT,
 					"", NULL, 0);
+		up_read(&OCFS2_I(dir)->ip_xattr_sem);
 		if (acl_len > 0) {
 			a_size = ocfs2_xattr_entry_real_size(0, acl_len);
 			if (S_ISDIR(mode))
