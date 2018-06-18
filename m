Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97158C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D65120874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D65120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966046AbeFRI0H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:26:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966010AbeFRI0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:26:03 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EBA70C7A;
        Mon, 18 Jun 2018 08:26:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashish Samant <ashish.samant@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Jun Piao <piaojun@huawei.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Changwei Ge <ge.changwei@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 230/279] ocfs2: take inode cluster lock before moving reflinked inode from orphan dir
Date:   Mon, 18 Jun 2018 10:13:35 +0200
Message-Id: <20180618080618.338372281@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ashish Samant <ashish.samant@oracle.com>

[ Upstream commit e4383029201470523c3ffe339bd7d57e9b4a7d65 ]

While reflinking an inode, we create a new inode in orphan directory,
then take EX lock on it, reflink the original inode to orphan inode and
release EX lock.  Once the lock is released another node could request
it in EX mode from ocfs2_recover_orphans() which causes downconvert of
the lock, on this node, to NL mode.

Later we attempt to initialize security acl for the orphan inode and
move it to the reflink destination.  However, while doing this we dont
take EX lock on the inode.  This could potentially cause problems
because we could be starting transaction, accessing journal and
modifying metadata of the inode while holding NL lock and with another
node holding EX lock on the inode.

Fix this by taking orphan inode cluster lock in EX mode before
initializing security and moving orphan inode to reflink destination.
Use the __tracker variant while taking inode lock to avoid recursive
locking in the ocfs2_init_security_and_acl() call chain.

Link: http://lkml.kernel.org/r/1523475107-7639-1-git-send-email-ashish.samant@oracle.com
Signed-off-by: Ashish Samant <ashish.samant@oracle.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>
Acked-by: Jun Piao <piaojun@huawei.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/refcounttree.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -4250,10 +4250,11 @@ out:
 static int ocfs2_reflink(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry, bool preserve)
 {
-	int error;
+	int error, had_lock;
 	struct inode *inode = d_inode(old_dentry);
 	struct buffer_head *old_bh = NULL;
 	struct inode *new_orphan_inode = NULL;
+	struct ocfs2_lock_holder oh;
 
 	if (!ocfs2_refcount_tree(OCFS2_SB(inode->i_sb)))
 		return -EOPNOTSUPP;
@@ -4295,6 +4296,14 @@ static int ocfs2_reflink(struct dentry *
 		goto out;
 	}
 
+	had_lock = ocfs2_inode_lock_tracker(new_orphan_inode, NULL, 1,
+					    &oh);
+	if (had_lock < 0) {
+		error = had_lock;
+		mlog_errno(error);
+		goto out;
+	}
+
 	/* If the security isn't preserved, we need to re-initialize them. */
 	if (!preserve) {
 		error = ocfs2_init_security_and_acl(dir, new_orphan_inode,
@@ -4302,14 +4311,15 @@ static int ocfs2_reflink(struct dentry *
 		if (error)
 			mlog_errno(error);
 	}
-out:
 	if (!error) {
 		error = ocfs2_mv_orphaned_inode_to_new(dir, new_orphan_inode,
 						       new_dentry);
 		if (error)
 			mlog_errno(error);
 	}
+	ocfs2_inode_unlock_tracker(new_orphan_inode, 1, &oh, had_lock);
 
+out:
 	if (new_orphan_inode) {
 		/*
 		 * We need to open_unlock the inode no matter whether we


