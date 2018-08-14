Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6583EC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E29520894
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E29520894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389025AbeHNUQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:16:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388101AbeHNUQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:16:47 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6DD7D1A;
        Tue, 14 Aug 2018 17:28:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.17 15/97] fix mntput/mntput race
Date:   Tue, 14 Aug 2018 19:16:27 +0200
Message-Id: <20180814171433.772941377@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 9ea0a46ca2c318fcc449c1e6b62a7230a17888f1 upstream.

mntput_no_expire() does the calculation of total refcount under mount_lock;
unfortunately, the decrement (as well as all increments) are done outside
of it, leading to false positives in the "are we dropping the last reference"
test.  Consider the following situation:
	* mnt is a lazy-umounted mount, kept alive by two opened files.  One
of those files gets closed.  Total refcount of mnt is 2.  On CPU 42
mntput(mnt) (called from __fput()) drops one reference, decrementing component
	* After it has looked at component #0, the process on CPU 0 does
mntget(), incrementing component #0, gets preempted and gets to run again -
on CPU 69.  There it does mntput(), which drops the reference (component #69)
and proceeds to spin on mount_lock.
	* On CPU 42 our first mntput() finishes counting.  It observes the
decrement of component #69, but not the increment of component #0.  As the
result, the total it gets is not 1 as it should've been - it's 0.  At which
point we decide that vfsmount needs to be killed and proceed to free it and
shut the filesystem down.  However, there's still another opened file
on that filesystem, with reference to (now freed) vfsmount, etc. and we are
screwed.

It's not a wide race, but it can be reproduced with artificial slowdown of
the mnt_get_count() loop, and it should be easier to hit on SMP KVM setups.

Fix consists of moving the refcount decrement under mount_lock; the tricky
part is that we want (and can) keep the fast case (i.e. mount that still
has non-NULL ->mnt_ns) entirely out of mount_lock.  All places that zero
mnt->mnt_ns are dropping some reference to mnt and they call synchronize_rcu()
before that mntput().  IOW, if mntput() observes (under rcu_read_lock())
a non-NULL ->mnt_ns, it is guaranteed that there is another reference yet to
be dropped.

Reported-by: Jann Horn <jannh@google.com>
Tested-by: Jann Horn <jannh@google.com>
Fixes: 48a066e72d97 ("RCU'd vsfmounts")
Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namespace.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1195,12 +1195,22 @@ static DECLARE_DELAYED_WORK(delayed_mntp
 static void mntput_no_expire(struct mount *mnt)
 {
 	rcu_read_lock();
-	mnt_add_count(mnt, -1);
-	if (likely(mnt->mnt_ns)) { /* shouldn't be the last one */
+	if (likely(READ_ONCE(mnt->mnt_ns))) {
+		/*
+		 * Since we don't do lock_mount_hash() here,
+		 * ->mnt_ns can change under us.  However, if it's
+		 * non-NULL, then there's a reference that won't
+		 * be dropped until after an RCU delay done after
+		 * turning ->mnt_ns NULL.  So if we observe it
+		 * non-NULL under rcu_read_lock(), the reference
+		 * we are dropping is not the final one.
+		 */
+		mnt_add_count(mnt, -1);
 		rcu_read_unlock();
 		return;
 	}
 	lock_mount_hash();
+	mnt_add_count(mnt, -1);
 	if (mnt_get_count(mnt)) {
 		rcu_read_unlock();
 		unlock_mount_hash();


