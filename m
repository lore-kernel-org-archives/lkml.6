Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeEHSLN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:11:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:54257 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755806AbeEHSGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:18 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 62/76] fs/quota: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:22 -0700
Message-Id: <20180508180436.716-63-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/quota/dquot.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 020c597ef9b6..ba6d549323cb 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -920,7 +920,7 @@ EXPORT_SYMBOL(dqget);
 
 static inline struct dquot **i_dquot(struct inode *inode)
 {
-	return inode->i_sb->s_op->get_dquots(inode);
+	return inode_sb(inode)->s_op->get_dquots(inode);
 }
 
 static int dqinit_needed(struct inode *inode, int type)
@@ -1406,7 +1406,7 @@ static int info_bdq_free(struct dquot *dquot, qsize_t space)
 
 static int dquot_active(const struct inode *inode)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	if (IS_NOQUOTA(inode))
 		return 0;
@@ -1423,7 +1423,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 {
 	int cnt, init_needed = 0;
 	struct dquot **dquots, *got[MAXQUOTAS] = {};
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	qsize_t rsv;
 	int ret = 0;
 
@@ -1462,7 +1462,7 @@ static int __dquot_initialize(struct inode *inode, int type)
 			qid = make_kqid_gid(inode->i_gid);
 			break;
 		case PRJQUOTA:
-			rc = inode->i_sb->dq_op->get_projid(inode, &projid);
+			rc = inode_sb(inode)->dq_op->get_projid(inode, &projid);
 			if (rc)
 				continue;
 			qid = make_kqid_projid(projid);
@@ -1540,7 +1540,7 @@ bool dquot_initialize_needed(struct inode *inode)
 
 	dquots = i_dquot(inode);
 	for (i = 0; i < MAXQUOTAS; i++)
-		if (!dquots[i] && sb_has_quota_active(inode->i_sb, i))
+		if (!dquots[i] && sb_has_quota_active(inode_sb(inode), i))
 			return true;
 	return false;
 }
@@ -1603,13 +1603,13 @@ static qsize_t *inode_reserved_space(struct inode * inode)
 {
 	/* Filesystem must explicitly define it's own method in order to use
 	 * quota reservation interface */
-	BUG_ON(!inode->i_sb->dq_op->get_reserved_space);
-	return inode->i_sb->dq_op->get_reserved_space(inode);
+	BUG_ON(!inode_sb(inode)->dq_op->get_reserved_space);
+	return inode_sb(inode)->dq_op->get_reserved_space(inode);
 }
 
 static qsize_t __inode_get_rsv_space(struct inode *inode)
 {
-	if (!inode->i_sb->dq_op->get_reserved_space)
+	if (!inode_sb(inode)->dq_op->get_reserved_space)
 		return 0;
 	return *inode_reserved_space(inode);
 }
@@ -1618,7 +1618,7 @@ static qsize_t inode_get_rsv_space(struct inode *inode)
 {
 	qsize_t ret;
 
-	if (!inode->i_sb->dq_op->get_reserved_space)
+	if (!inode_sb(inode)->dq_op->get_reserved_space)
 		return 0;
 	spin_lock(&inode->i_lock);
 	ret = __inode_get_rsv_space(inode);
@@ -1955,8 +1955,8 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 	if (IS_NOQUOTA(inode))
 		return 0;
 
-	if (inode->i_sb->dq_op->get_inode_usage) {
-		ret = inode->i_sb->dq_op->get_inode_usage(inode, &inode_usage);
+	if (inode_sb(inode)->dq_op->get_inode_usage) {
+		ret = inode_sb(inode)->dq_op->get_inode_usage(inode, &inode_usage);
 		if (ret)
 			return ret;
 	}
@@ -1988,7 +1988,7 @@ int __dquot_transfer(struct inode *inode, struct dquot **transfer_to)
 		if (!transfer_to[cnt])
 			continue;
 		/* Avoid races with quotaoff() */
-		if (!sb_has_quota_active(inode->i_sb, cnt))
+		if (!sb_has_quota_active(inode_sb(inode), cnt))
 			continue;
 		is_valid[cnt] = 1;
 		transfer_from[cnt] = i_dquot(inode)[cnt];
@@ -2070,7 +2070,7 @@ int dquot_transfer(struct inode *inode, struct iattr *iattr)
 {
 	struct dquot *transfer_to[MAXQUOTAS] = {};
 	struct dquot *dquot;
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	int ret;
 
 	if (!dquot_active(inode))
@@ -2302,7 +2302,7 @@ static int vfs_load_quota_inode(struct inode *inode, int type, int format_id,
 	unsigned int flags)
 {
 	struct quota_format_type *fmt = find_quota_format(format_id);
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 	struct quota_info *dqopt = sb_dqopt(sb);
 	int error;
 
@@ -2464,7 +2464,7 @@ EXPORT_SYMBOL(dquot_quota_on);
 int dquot_enable(struct inode *inode, int type, int format_id,
 		 unsigned int flags)
 {
-	struct super_block *sb = inode->i_sb;
+	struct super_block *sb = inode_sb(inode);
 
 	/* Just unsuspend quotas? */
 	BUG_ON(flags & DQUOT_SUSPENDED);
-- 
2.15.1
