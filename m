Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A343C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D9820871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D9820871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbeKLGWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:22:45 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50148 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730273AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000oM-1K; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001pl-C8; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.183799287@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 319/366] unify dentry_iput() and dentry_unlink_inode()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 550dce01dd606c88a837138aa448ccd367fb0cbb upstream.

There is a lot of duplication between dentry_unlink_inode() and dentry_iput().
The only real difference is that dentry_unlink_inode() bumps ->d_seq and
dentry_iput() doesn't.  The argument of the latter is known to have been
unhashed, so anybody who might've found it in RCU lookup would already be
doomed to a ->d_seq mismatch.  And we want to avoid pointless smp_rmb() there.

This patch makes dentry_unlink_inode() bump ->d_seq only for hashed dentries.
It's safe (d_delete() calls that sucker only if we are holding the only
reference to dentry, so rehash is not going to happen) and it allows
to use dentry_unlink_inode() in __dentry_kill() and get rid of dentry_iput().

The interesting question here is profiling; it *is* a hot path, and extra
conditional jumps in there might or might not be painful.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/dcache.c | 45 ++++++++++-----------------------------------
 1 file changed, 10 insertions(+), 35 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -333,44 +333,21 @@ static inline void dentry_rcuwalk_barrie
 
 /*
  * Release the dentry's inode, using the filesystem
- * d_iput() operation if defined. Dentry has no refcount
- * and is unhashed.
- */
-static void dentry_iput(struct dentry * dentry)
-	__releases(dentry->d_lock)
-	__releases(dentry->d_inode->i_lock)
-{
-	struct inode *inode = dentry->d_inode;
-	if (inode) {
-		__d_clear_type_and_inode(dentry);
-		hlist_del_init(&dentry->d_u.d_alias);
-		spin_unlock(&dentry->d_lock);
-		spin_unlock(&inode->i_lock);
-		if (!inode->i_nlink)
-			fsnotify_inoderemove(inode);
-		if (dentry->d_op && dentry->d_op->d_iput)
-			dentry->d_op->d_iput(dentry, inode);
-		else
-			iput(inode);
-	} else {
-		spin_unlock(&dentry->d_lock);
-	}
-}
-
-/*
- * Release the dentry's inode, using the filesystem
- * d_iput() operation if defined. dentry remains in-use.
+ * d_iput() operation if defined.
  */
 static void dentry_unlink_inode(struct dentry * dentry)
 	__releases(dentry->d_lock)
 	__releases(dentry->d_inode->i_lock)
 {
 	struct inode *inode = dentry->d_inode;
+	bool hashed = !d_unhashed(dentry);
 
-	raw_write_seqcount_begin(&dentry->d_seq);
+	if (hashed)
+		raw_write_seqcount_begin(&dentry->d_seq);
 	__d_clear_type_and_inode(dentry);
 	hlist_del_init(&dentry->d_u.d_alias);
-	raw_write_seqcount_end(&dentry->d_seq);
+	if (hashed)
+		raw_write_seqcount_end(&dentry->d_seq);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&inode->i_lock);
 	if (!inode->i_nlink)
@@ -537,12 +514,10 @@ static void __dentry_kill(struct dentry
 	dentry->d_flags |= DCACHE_DENTRY_KILLED;
 	if (parent)
 		spin_unlock(&parent->d_lock);
-	dentry_iput(dentry);
-	/*
-	 * dentry_iput drops the locks, at which point nobody (except
-	 * transient RCU lookups) can reach this dentry.
-	 */
-	BUG_ON((int)dentry->d_lockref.count > 0);
+	if (dentry->d_inode)
+		dentry_unlink_inode(dentry);
+	else
+		spin_unlock(&dentry->d_lock);
 	this_cpu_dec(nr_dentry);
 	if (dentry->d_op && dentry->d_op->d_release)
 		dentry->d_op->d_release(dentry);

