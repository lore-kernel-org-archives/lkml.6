Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31604C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A99520652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfAQP2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:28:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbfAQP17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:27:59 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7120FD4E56;
        Thu, 17 Jan 2019 15:27:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-128.rdu2.redhat.com [10.10.120.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 911ED60BE8;
        Thu, 17 Jan 2019 15:27:58 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/6] afs: Fix key refcounting in file locking code
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Jan 2019 15:27:57 +0000
Message-ID: <154773887782.24105.4322577070607935352.stgit@warthog.procyon.org.uk>
In-Reply-To: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
References: <154773884927.24105.2730570814701376379.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 17 Jan 2019 15:27:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the refcounting of the authentication keys in the file locking code.
The vnode->lock_key member points to a key on which it expects to be
holding a ref, but it isn't always given an extra ref, however.

Fixes: 0fafdc9f888b ("afs: Fix file locking")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/flock.c |    4 ++--
 fs/afs/inode.c |    2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index 0568fd986821..e432bd27a2e7 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -208,7 +208,7 @@ void afs_lock_work(struct work_struct *work)
 		/* The new front of the queue now owns the state variables. */
 		next = list_entry(vnode->pending_locks.next,
 				  struct file_lock, fl_u.afs.link);
-		vnode->lock_key = afs_file_key(next->fl_file);
+		vnode->lock_key = key_get(afs_file_key(next->fl_file));
 		vnode->lock_type = (next->fl_type == F_RDLCK) ? AFS_LOCK_READ : AFS_LOCK_WRITE;
 		vnode->lock_state = AFS_VNODE_LOCK_WAITING_FOR_CB;
 		goto again;
@@ -413,7 +413,7 @@ static void afs_dequeue_lock(struct afs_vnode *vnode, struct file_lock *fl)
 	/* The new front of the queue now owns the state variables. */
 	next = list_entry(vnode->pending_locks.next,
 			  struct file_lock, fl_u.afs.link);
-	vnode->lock_key = afs_file_key(next->fl_file);
+	vnode->lock_key = key_get(afs_file_key(next->fl_file));
 	vnode->lock_type = (next->fl_type == F_RDLCK) ? AFS_LOCK_READ : AFS_LOCK_WRITE;
 	vnode->lock_state = AFS_VNODE_LOCK_WAITING_FOR_CB;
 	afs_lock_may_be_available(vnode);
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 211343831c30..1a4ce07fb406 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -545,6 +545,8 @@ void afs_evict_inode(struct inode *inode)
 #endif
 
 	afs_put_permits(rcu_access_pointer(vnode->permit_cache));
+	key_put(vnode->lock_key);
+	vnode->lock_key = NULL;
 	_leave("");
 }
 

