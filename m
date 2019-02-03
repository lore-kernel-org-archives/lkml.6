Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A73CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F352082C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfBCOUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:20 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55338 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729489AbfBCOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:15 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqId4-0006FQ-4A; Sun, 03 Feb 2019 14:20:14 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9d-00076Y-5k; Sun, 03 Feb 2019 14:49:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Timothy Baldwin" <timbaldwin@fastmail.co.uk>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.842053886@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 161/305] mount: Prevent MNT_DETACH from disconnecting
 locked mounts
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

commit 9c8e0a1b683525464a2abe9fb4b54404a50ed2b4 upstream.

Timothy Baldwin <timbaldwin@fastmail.co.uk> wrote:
> As per mount_namespaces(7) unprivileged users should not be able to look under mount points:
>
>   Mounts that come as a single unit from more privileged mount are locked
>   together and may not be separated in a less privileged mount namespace.
>
> However they can:
>
> 1. Create a mount namespace.
> 2. In the mount namespace open a file descriptor to the parent of a mount point.
> 3. Destroy the mount namespace.
> 4. Use the file descriptor to look under the mount point.
>
> I have reproduced this with Linux 4.16.18 and Linux 4.18-rc8.
>
> The setup:
>
> $ sudo sysctl kernel.unprivileged_userns_clone=1
> kernel.unprivileged_userns_clone = 1
> $ mkdir -p A/B/Secret
> $ sudo mount -t tmpfs hide A/B
>
>
> "Secret" is indeed hidden as expected:
>
> $ ls -lR A
> A:
> total 0
> drwxrwxrwt 2 root root 40 Feb 12 21:08 B
>
> A/B:
> total 0
>
>
> The attack revealing "Secret":
>
> $ unshare -Umr sh -c "exec unshare -m ls -lR /proc/self/fd/4/ 4<A"
> /proc/self/fd/4/:
> total 0
> drwxr-xr-x 3 root root 60 Feb 12 21:08 B
>
> /proc/self/fd/4/B:
> total 0
> drwxr-xr-x 2 root root 40 Feb 12 21:08 Secret
>
> /proc/self/fd/4/B/Secret:
> total 0

I tracked this down to put_mnt_ns running passing UMOUNT_SYNC and
disconnecting all of the mounts in a mount namespace.  Fix this by
factoring drop_mounts out of drop_collected_mounts and passing
0 instead of UMOUNT_SYNC.

There are two possible behavior differences that result from this.
- No longer setting UMOUNT_SYNC will no longer set MNT_SYNC_UMOUNT on
  the vfsmounts being unmounted.  This effects the lazy rcu walk by
  kicking the walk out of rcu mode and forcing it to be a non-lazy
  walk.
- No longer disconnecting locked mounts will keep some mounts around
  longer as they stay because the are locked to other mounts.

There are only two users of drop_collected mounts: audit_tree.c and
put_mnt_ns.

In audit_tree.c the mounts are private and there are no rcu lazy walks
only calls to iterate_mounts. So the changes should have no effect
except for a small timing effect as the connected mounts are disconnected.

In put_mnt_ns there may be references from process outside the mount
namespace to the mounts.  So the mounts remaining connected will
be the bug fix that is needed.  That rcu walks are allowed to continue
appears not to be a problem especially as the rcu walk change was about
an implementation detail not about semantics.

Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
Reported-by: Timothy Baldwin <timbaldwin@fastmail.co.uk>
Tested-by: Timothy Baldwin <timbaldwin@fastmail.co.uk>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1641,7 +1641,7 @@ void drop_collected_mounts(struct vfsmou
 {
 	namespace_lock();
 	lock_mount_hash();
-	umount_tree(real_mount(mnt), UMOUNT_SYNC);
+	umount_tree(real_mount(mnt), 0);
 	unlock_mount_hash();
 	namespace_unlock();
 }

