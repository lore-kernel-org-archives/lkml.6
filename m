Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D50C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB7820871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB7820871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbeKLGXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:23:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50126 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730259AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000lJ-7D; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001pW-8x; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Oleg Nesterov" <oleg@redhat.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.627579593@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 316/366] fix __legitimize_mnt()/mntput() race
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

commit 119e1ef80ecfe0d1deb6378d4ab41f5b71519de1 upstream.

__legitimize_mnt() has two problems - one is that in case of success
the check of mount_lock is not ordered wrt preceding increment of
refcount, making it possible to have successful __legitimize_mnt()
on one CPU just before the otherwise final mntpu() on another,
with __legitimize_mnt() not seeing mntput() taking the lock and
mntput() not seeing the increment done by __legitimize_mnt().
Solved by a pair of barriers.

Another is that failure of __legitimize_mnt() on the second
read_seqretry() leaves us with reference that'll need to be
dropped by caller; however, if that races with final mntput()
we can end up with caller dropping rcu_read_lock() and doing
mntput() to release that reference - with the first mntput()
having freed the damn thing just as rcu_read_lock() had been
dropped.  Solution: in "do mntput() yourself" failure case
grab mount_lock, check if MNT_DOOMED has been set by racing
final mntput() that has missed our increment and if it has -
undo the increment and treat that as "failure, caller doesn't
need to drop anything" case.

It's not easy to hit - the final mntput() has to come right
after the first read_seqretry() in __legitimize_mnt() *and*
manage to miss the increment done by __legitimize_mnt() before
the second read_seqretry() in there.  The things that are almost
impossible to hit on bare hardware are not impossible on SMP
KVM, though...

Reported-by: Oleg Nesterov <oleg@redhat.com>
Fixes: 48a066e72d97 ("RCU'd vsfmounts")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[bwh: Backported to 3.16: __legitimize_mnt() has not been split out
 from legitimize_mnt().  Adjust the added return statement and
 comments accordingly.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/namespace.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -592,12 +592,20 @@ bool legitimize_mnt(struct vfsmount *bas
 		return true;
 	mnt = real_mount(bastard);
 	mnt_add_count(mnt, 1);
+	smp_mb();			// see mntput_no_expire()
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return true;
 	if (bastard->mnt_flags & MNT_SYNC_UMOUNT) {
 		mnt_add_count(mnt, -1);
 		return false;
 	}
+	lock_mount_hash();
+	if (unlikely(bastard->mnt_flags & MNT_DOOMED)) {
+		mnt_add_count(mnt, -1);
+		unlock_mount_hash();
+		return false;
+	}
+	unlock_mount_hash();
 	rcu_read_unlock();
 	mntput(bastard);
 	rcu_read_lock();
@@ -984,6 +992,11 @@ put_again:
 		return;
 	}
 	lock_mount_hash();
+	/*
+	 * make sure that if legitimize_mnt() has not seen us grab
+	 * mount_lock, we'll see their refcount increment here.
+	 */
+	smp_mb();
 	mnt_add_count(mnt, -1);
 	if (mnt_get_count(mnt)) {
 		rcu_read_unlock();

