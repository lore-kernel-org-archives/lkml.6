Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D940C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03CA20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E03CA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50064 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729503AbeKLFsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:14 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsb-0000l5-NA; Sun, 11 Nov 2018 19:58:45 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001pg-AT; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.919488062@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 318/366] use ->d_seq to get coherency between
 ->d_inode and ->d_flags
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

commit a528aca7f359f4b0b1d72ae406097e491a5ba9ea upstream.

Games with ordering and barriers are way too brittle.  Just
bump ->d_seq before and after updating ->d_inode and ->d_flags
type bits, so that verifying ->d_seq would guarantee they are
coherent.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/dcache.c            | 20 +++++---------------
 include/linux/dcache.h |  4 +---
 2 files changed, 6 insertions(+), 18 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -291,28 +291,18 @@ static inline void __d_set_inode_and_typ
 	unsigned flags;
 
 	dentry->d_inode = inode;
-	smp_wmb();
 	flags = ACCESS_ONCE(dentry->d_flags);
 	flags &= ~DCACHE_ENTRY_TYPE;
 	flags |= type_flags;
 	ACCESS_ONCE(dentry->d_flags) = flags;
 }
 
-/*
- * Ideally, we want to make sure that other CPUs see the flags cleared before
- * the inode is detached, but this is really a violation of RCU principles
- * since the ordering suggests we should always set inode before flags.
- *
- * We should instead replace or discard the entire dentry - but that sucks
- * performancewise on mass deletion/rename.
- */
 static inline void __d_clear_type_and_inode(struct dentry *dentry)
 {
 	unsigned flags = ACCESS_ONCE(dentry->d_flags);
 
 	flags &= ~DCACHE_ENTRY_TYPE;
 	ACCESS_ONCE(dentry->d_flags) = flags;
-	smp_wmb();
 	dentry->d_inode = NULL;
 }
 
@@ -376,9 +366,11 @@ static void dentry_unlink_inode(struct d
 	__releases(dentry->d_inode->i_lock)
 {
 	struct inode *inode = dentry->d_inode;
+
+	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_clear_type_and_inode(dentry);
 	hlist_del_init(&dentry->d_u.d_alias);
-	dentry_rcuwalk_barrier(dentry);
+	raw_write_seqcount_end(&dentry->d_seq);
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&inode->i_lock);
 	if (!inode->i_nlink)
@@ -1680,8 +1672,9 @@ static void __d_instantiate(struct dentr
 	spin_lock(&dentry->d_lock);
 	if (inode)
 		hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
+	raw_write_seqcount_begin(&dentry->d_seq);
 	__d_set_inode_and_type(dentry, inode, add_flags);
-	dentry_rcuwalk_barrier(dentry);
+	raw_write_seqcount_end(&dentry->d_seq);
 	spin_unlock(&dentry->d_lock);
 	fsnotify_d_instantiate(dentry, inode);
 }
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -413,9 +413,7 @@ static inline bool d_mountpoint(const st
  */
 static inline unsigned __d_entry_type(const struct dentry *dentry)
 {
-	unsigned type = ACCESS_ONCE(dentry->d_flags);
-	smp_rmb();
-	return type & DCACHE_ENTRY_TYPE;
+	return dentry->d_flags & DCACHE_ENTRY_TYPE;
 }
 
 static inline bool d_can_lookup(const struct dentry *dentry)

