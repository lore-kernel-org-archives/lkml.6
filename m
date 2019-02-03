Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C40C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5732084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbfBCOWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:22:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55922 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729824AbfBCOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:44 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeU-0006TO-Ld; Sun, 03 Feb 2019 14:21:42 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9d-00076K-20; Sun, 03 Feb 2019 14:49:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Al Viro" <viro@ZenIV.linux.org.uk>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.331999817@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 159/305] mount: Retest MNT_LOCKED in do_umount
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Eric W. Biederman" <ebiederm@xmission.com>

commit 25d202ed820ee347edec0bf3bf553544556bf64b upstream.

It was recently pointed out that the one instance of testing MNT_LOCKED
outside of the namespace_sem is in ksys_umount.

Fix that by adding a test inside of do_umount with namespace_sem and
the mount_lock held.  As it helps to fail fails the existing test is
maintained with an additional comment pointing out that it may be racy
because the locks are not held.

Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/namespace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1423,8 +1423,13 @@ static int do_umount(struct mount *mnt,
 
 	namespace_lock();
 	lock_mount_hash();
-	event++;
 
+	/* Recheck MNT_LOCKED with the locks held */
+	retval = -EINVAL;
+	if (mnt->mnt.mnt_flags & MNT_LOCKED)
+		goto out;
+
+	event++;
 	if (flags & MNT_DETACH) {
 		if (!list_empty(&mnt->mnt_list))
 			umount_tree(mnt, UMOUNT_PROPAGATE);
@@ -1438,6 +1443,7 @@ static int do_umount(struct mount *mnt,
 			retval = 0;
 		}
 	}
+out:
 	unlock_mount_hash();
 	namespace_unlock();
 	return retval;
@@ -1484,7 +1490,7 @@ SYSCALL_DEFINE2(umount, char __user *, n
 		goto dput_and_out;
 	if (!check_mnt(mnt))
 		goto dput_and_out;
-	if (mnt->mnt.mnt_flags & MNT_LOCKED)
+	if (mnt->mnt.mnt_flags & MNT_LOCKED) /* Check optimistically */
 		goto dput_and_out;
 	retval = -EPERM;
 	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))

