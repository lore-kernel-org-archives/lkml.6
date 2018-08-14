Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E262C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD1321655
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD1321655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390023AbeHNUaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:30:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbeHNUaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:01 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 43289D7D;
        Tue, 14 Aug 2018 17:41:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 014/107] fix __legitimize_mnt()/mntput() race
Date:   Tue, 14 Aug 2018 19:16:37 +0200
Message-Id: <20180814171521.642290088@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namespace.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -603,12 +603,21 @@ int __legitimize_mnt(struct vfsmount *ba
 		return 0;
 	mnt = real_mount(bastard);
 	mnt_add_count(mnt, 1);
+	smp_mb();			// see mntput_no_expire()
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
 	if (bastard->mnt_flags & MNT_SYNC_UMOUNT) {
 		mnt_add_count(mnt, -1);
 		return 1;
 	}
+	lock_mount_hash();
+	if (unlikely(bastard->mnt_flags & MNT_DOOMED)) {
+		mnt_add_count(mnt, -1);
+		unlock_mount_hash();
+		return 1;
+	}
+	unlock_mount_hash();
+	/* caller will mntput() */
 	return -1;
 }
 
@@ -1154,6 +1163,11 @@ static void mntput_no_expire(struct moun
 		return;
 	}
 	lock_mount_hash();
+	/*
+	 * make sure that if __legitimize_mnt() has not seen us grab
+	 * mount_lock, we'll see their refcount increment here.
+	 */
+	smp_mb();
 	mnt_add_count(mnt, -1);
 	if (mnt_get_count(mnt)) {
 		rcu_read_unlock();


