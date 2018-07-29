Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85665C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B66E20881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B66E20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeG2XiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:38:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51584 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbeG2Xg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:36:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fjto5-0003VE-R0; Sun, 29 Jul 2018 22:04:53 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 01/16] nfs_instantiate(): prevent multiple aliases for directory inode
Date:   Sun, 29 Jul 2018 23:04:38 +0100
Message-Id: <20180729220453.13431-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180729220317.GB30522@ZenIV.linux.org.uk>
References: <20180729220317.GB30522@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Since NFS allows open-by-fhandle, we have to cope with the possibility
of mkdir vs. open-by-guessed-handle races.  A local filesystem could
decide what the inumber of the new object will be and insert a locked
inode with that inumber into icache _before_ the on-disk data structures
begin to look good and unlock it only once it has a dentry alias, so
that open-by-handle coming first would quietly fail and mkdir coming
first would have open-by-handle grab its dentry.

For NFS it's a non-starter - the icache key is server-supplied fhandle
and we do not get that until the object has been fully created on server.
We really have to deal with the possibility that open-by-handle gets
the in-core inode and attaches a dentry to it before mkdir does.

Solution: let nfs_mkdir() use d_splice_alias() to catch those.  We can
	* get an error.  Just return it to our caller.
	* get NULL - no preexisting dentry aliases, we'd just done what
d_add() would've done.  Success.
	* get a reference to preexisting alias.  In that case the alias
had been moved in place of nfs_mkdir() argument (and hashed there), while
nfs_mkdir() argument is left unhashed negative.  Which is just fine for
->mkdir() callers, all we need is to release the reference we'd got from
d_splice_alias() and report success.

Cc: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/dir.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 7a9c14426855..df6fd4e5b068 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1641,6 +1641,7 @@ int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fhandle,
 	struct dentry *parent = dget_parent(dentry);
 	struct inode *dir = d_inode(parent);
 	struct inode *inode;
+	struct dentry *d;
 	int error = -EACCES;
 
 	d_drop(dentry);
@@ -1662,10 +1663,12 @@ int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fhandle,
 			goto out_error;
 	}
 	inode = nfs_fhget(dentry->d_sb, fhandle, fattr, label);
-	error = PTR_ERR(inode);
-	if (IS_ERR(inode))
+	d = d_splice_alias(inode, dentry);
+	if (IS_ERR(d)) {
+		error = PTR_ERR(d);
 		goto out_error;
-	d_add(dentry, inode);
+	}
+	dput(d);
 out:
 	dput(parent);
 	return 0;
-- 
2.11.0

