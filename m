Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADF1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D600F20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D600F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbeKLGXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:23:11 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50132 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730258AbeKLFsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:16 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsc-0000lG-Bn; Sun, 11 Nov 2018 19:58:46 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsZ-0001pR-7l; Sun, 11 Nov 2018 19:58:43 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jann Horn" <jannh@google.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.6098155@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 315/366] fix mntput/mntput race
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
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[bwh: Backported to 3.16: Use ACCESS_ONCE() instead of READ_ONCE()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/namespace.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -969,12 +969,22 @@ static void mntput_no_expire(struct moun
 {
 put_again:
 	rcu_read_lock();
-	mnt_add_count(mnt, -1);
-	if (likely(mnt->mnt_ns)) { /* shouldn't be the last one */
+	if (likely(ACCESS_ONCE(mnt->mnt_ns))) {
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

