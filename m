Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870D2C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50604208B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50604208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbeG0Syj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389096AbeG0Syi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D318181663D8;
        Fri, 27 Jul 2018 17:31:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38BD41C5B9;
        Fri, 27 Jul 2018 17:31:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/38] teach move_mount(2) to work with OPEN_TREE_CLONE [ver
 #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:31:43 +0100
Message-ID: <153271270374.9458.14888440216312686324.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:31:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 27 Jul 2018 17:31:44 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
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
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namespace.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e2934a4f342b..3981fd7b13f5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1846,8 +1846,10 @@ void dissolve_on_fput(struct vfsmount *mnt)
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
@@ -2454,6 +2456,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	struct mount *old;
 	struct mountpoint *mp;
 	int err;
+	bool attached;
 
 	mp = lock_mount(new_path);
 	err = PTR_ERR(mp);
@@ -2464,10 +2467,19 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
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
@@ -2482,7 +2494,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 	/*
 	 * Don't move a mount residing in a shared parent.
 	 */
-	if (IS_MNT_SHARED(old->mnt_parent))
+	if (attached && IS_MNT_SHARED(old->mnt_parent))
 		goto out1;
 	/*
 	 * Don't move a mount tree containing unbindable mounts to a destination
@@ -2496,7 +2508,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
 			goto out1;
 
 	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
-				   &parent_path);
+				   attached ? &parent_path : NULL);
 	if (err)
 		goto out1;
 
@@ -3182,6 +3194,8 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 
 /*
  * Move a mount from one place to another.
+ * In combination with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can be
+ * used to copy a mount subtree.
  *
  * Note the flags value is a combination of MOVE_MOUNT_* flags.
  */

