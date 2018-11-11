Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81389C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D07220871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D07220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbeKLGXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:23:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50108 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730253AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000oF-4T; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001pb-9Z; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Howells" <dhowells@redhat.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.321731002@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 317/366] VFS: Impose ordering on accesses of d_inode
 and d_flags
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

From: David Howells <dhowells@redhat.com>

commit 4bf46a272647d89e780126b52eda04737defd9f4 upstream.

Impose ordering on accesses of d_inode and d_flags to avoid the need to do
this:

	if (!dentry->d_inode || d_is_negative(dentry)) {

when this:

	if (d_is_negative(dentry)) {

should suffice.

This check is especially problematic if a dentry can have its type field set
to something other than DENTRY_MISS_TYPE when d_inode is NULL (as in
unionmount).

What we really need to do is stick a write barrier between setting d_inode and
setting d_flags and a read barrier between reading d_flags and reading
d_inode.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[bwh: Backported to 3.16:
 - Use ACCESS_ONCE() instead of {READ,WRITE}_ONCE()
 - There's no DCACHE_FALLTHRU flag]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/dcache.c            | 47 +++++++++++++++++++++++++++++++++++-------
 include/linux/dcache.h | 21 +++----------------
 2 files changed, 42 insertions(+), 26 deletions(-)

--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -281,6 +281,41 @@ void release_dentry_name_snapshot(struct
 }
 EXPORT_SYMBOL(release_dentry_name_snapshot);
 
+/*
+ * Make sure other CPUs see the inode attached before the type is set.
+ */
+static inline void __d_set_inode_and_type(struct dentry *dentry,
+					  struct inode *inode,
+					  unsigned type_flags)
+{
+	unsigned flags;
+
+	dentry->d_inode = inode;
+	smp_wmb();
+	flags = ACCESS_ONCE(dentry->d_flags);
+	flags &= ~DCACHE_ENTRY_TYPE;
+	flags |= type_flags;
+	ACCESS_ONCE(dentry->d_flags) = flags;
+}
+
+/*
+ * Ideally, we want to make sure that other CPUs see the flags cleared before
+ * the inode is detached, but this is really a violation of RCU principles
+ * since the ordering suggests we should always set inode before flags.
+ *
+ * We should instead replace or discard the entire dentry - but that sucks
+ * performancewise on mass deletion/rename.
+ */
+static inline void __d_clear_type_and_inode(struct dentry *dentry)
+{
+	unsigned flags = ACCESS_ONCE(dentry->d_flags);
+
+	flags &= ~DCACHE_ENTRY_TYPE;
+	ACCESS_ONCE(dentry->d_flags) = flags;
+	smp_wmb();
+	dentry->d_inode = NULL;
+}
+
 static void dentry_free(struct dentry *dentry)
 {
 	WARN_ON(!hlist_unhashed(&dentry->d_u.d_alias));
@@ -317,7 +352,7 @@ static void dentry_iput(struct dentry *
 {
 	struct inode *inode = dentry->d_inode;
 	if (inode) {
-		dentry->d_inode = NULL;
+		__d_clear_type_and_inode(dentry);
 		hlist_del_init(&dentry->d_u.d_alias);
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&inode->i_lock);
@@ -341,8 +376,7 @@ static void dentry_unlink_inode(struct d
 	__releases(dentry->d_inode->i_lock)
 {
 	struct inode *inode = dentry->d_inode;
-	__d_clear_type(dentry);
-	dentry->d_inode = NULL;
+	__d_clear_type_and_inode(dentry);
 	hlist_del_init(&dentry->d_u.d_alias);
 	dentry_rcuwalk_barrier(dentry);
 	spin_unlock(&dentry->d_lock);
@@ -1644,10 +1678,9 @@ static void __d_instantiate(struct dentr
 	unsigned add_flags = d_flags_for_inode(inode);
 
 	spin_lock(&dentry->d_lock);
-	__d_set_type(dentry, add_flags);
 	if (inode)
 		hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
-	dentry->d_inode = inode;
+	__d_set_inode_and_type(dentry, inode, add_flags);
 	dentry_rcuwalk_barrier(dentry);
 	spin_unlock(&dentry->d_lock);
 	fsnotify_d_instantiate(dentry, inode);
@@ -1904,8 +1937,7 @@ struct dentry *d_obtain_alias(struct ino
 	add_flags = d_flags_for_inode(inode) | DCACHE_DISCONNECTED;
 
 	spin_lock(&tmp->d_lock);
-	tmp->d_inode = inode;
-	tmp->d_flags |= add_flags;
+	__d_set_inode_and_type(tmp, inode, add_flags);
 	hlist_add_head(&tmp->d_u.d_alias, &inode->i_dentry);
 	hlist_bl_lock(&tmp->d_sb->s_anon);
 	hlist_bl_add_head(&tmp->d_hash, &tmp->d_sb->s_anon);
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -411,26 +411,11 @@ static inline bool d_mountpoint(const st
 /*
  * Directory cache entry type accessor functions.
  */
-static inline void __d_set_type(struct dentry *dentry, unsigned type)
-{
-	dentry->d_flags = (dentry->d_flags & ~DCACHE_ENTRY_TYPE) | type;
-}
-
-static inline void __d_clear_type(struct dentry *dentry)
-{
-	__d_set_type(dentry, DCACHE_MISS_TYPE);
-}
-
-static inline void d_set_type(struct dentry *dentry, unsigned type)
-{
-	spin_lock(&dentry->d_lock);
-	__d_set_type(dentry, type);
-	spin_unlock(&dentry->d_lock);
-}
-
 static inline unsigned __d_entry_type(const struct dentry *dentry)
 {
-	return dentry->d_flags & DCACHE_ENTRY_TYPE;
+	unsigned type = ACCESS_ONCE(dentry->d_flags);
+	smp_rmb();
+	return type & DCACHE_ENTRY_TYPE;
 }
 
 static inline bool d_can_lookup(const struct dentry *dentry)

