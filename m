Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CA820A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CA820A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbeGJWnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:43:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732299AbeGJWnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AB39407446D;
        Tue, 10 Jul 2018 22:41:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67CEF2026D6B;
        Tue, 10 Jul 2018 22:41:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/32] teach move_mount(2) to work with OPEN_TREE_CLONE [ver
 #9]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Tue, 10 Jul 2018 23:41:48 +0100
Message-ID: <153126250894.14533.11701155170173292521.stgit@warthog.procyon.org.uk>
In-Reply-To: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 10 Jul 2018 22:41:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 10 Jul 2018 22:41:50 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Allow a detached tree created by open_tree(..., OPEN_TREE_CLONE) to be
attached by move_mount(2).

If by the time of final fput() of OPEN_TREE_CLONE-opened file its tree is
not detached anymore, it won't be dissolved.  move_mount(2) is adjusted
to handle detached source.

That gives us equivalents of mount --bind and mount --rbind.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/namespace.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e95b2bc8fcfe..bd2526b24afb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1845,8 +1845,10 @@ void dissolve_on_fput(struct vfsmount *mnt)
 {
 	namespace_lock();
 	lock_mount_hash();
-	mntget(mnt);
-	umount_tree(real_mount(mnt), UMOUNT_SYNC);
+	if (!real_mount(mnt)->mnt_ns) {
+		mntget(mnt);
+		umount_tree(real_mount(mnt), UMOUNT_SYNC);
+	}
 	unlock_mount_hash();
 	namespace_unlock();
 }
@@ -2453,6 +2455,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	struct mount *old;
 	struct mountpoint *mp;
 	int err;
+	bool attached;
 
 	mp = lock_mount(new_path);
 	err = PTR_ERR(mp);
@@ -2463,10 +2466,19 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	p = real_mount(new_path->mnt);
 
 	err = -EINVAL;
-	if (!check_mnt(p) || !check_mnt(old))
+	/* The mountpoint must be in our namespace. */
+	if (!check_mnt(p))
+		goto out1;
+	/* The thing moved should be either ours or completely unattached. */
+	if (old->mnt_ns && !check_mnt(old))
 		goto out1;
 
-	if (!mnt_has_parent(old))
+	attached = mnt_has_parent(old);
+	/*
+	 * We need to allow open_tree(OPEN_TREE_CLONE) followed by
+	 * move_mount(), but mustn't allow "/" to be moved.
+	 */
+	if (old->mnt_ns && !attached)
 		goto out1;
 
 	if (old->mnt.mnt_flags & MNT_LOCKED)
@@ -2481,7 +2493,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	/*
 	 * Don't move a mount residing in a shared parent.
 	 */
-	if (IS_MNT_SHARED(old->mnt_parent))
+	if (attached && IS_MNT_SHARED(old->mnt_parent))
 		goto out1;
 	/*
 	 * Don't move a mount tree containing unbindable mounts to a destination
@@ -2495,7 +2507,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 			goto out1;
 
 	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
-				   &parent_path);
+				   attached ? &parent_path : NULL);
 	if (err)
 		goto out1;
 
@@ -3179,6 +3191,8 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 
 /*
  * Move a mount from one place to another.
+ * In combination with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can be
+ * used to copy a mount subtree.
  *
  * Note the flags value is a combination of MOVE_MOUNT_* flags.
  */

