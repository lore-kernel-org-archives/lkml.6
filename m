Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7FFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D0721104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zfAhsEwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D0721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbeKTDPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbeKTDO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:14:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ABA7213A2;
        Mon, 19 Nov 2018 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646243;
        bh=03NO1ZJ1I1y9zsepBwQQPeTSO8kFYKvn1BwLJgXgDOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zfAhsEwoJEpUCiZKZj2C0XdVszIZZT2wX1ihexiH3AKCevE3tRzomCUnFG2JEIffe
         IIC4pKrnmoK+0FkJOG6gmSi7iZT/K42gnjGsszuHLA02Jn3NvkQl+G5Q6L2pUyZWxB
         Xf2X6HErlzzC58l7wtmdnO8lqVp3587W+LHW8q3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Timothy Baldwin <timbaldwin@fastmail.co.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.14 092/124] mount: Prevent MNT_DETACH from disconnecting locked mounts
Date:   Mon, 19 Nov 2018 17:29:06 +0100
Message-Id: <20181119162630.275723231@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

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

Cc: stable@vger.kernel.org
Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
Reported-by: Timothy Baldwin <timbaldwin@fastmail.co.uk>
Tested-by: Timothy Baldwin <timbaldwin@fastmail.co.uk>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namespace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1874,7 +1874,7 @@ void drop_collected_mounts(struct vfsmou
 {
 	namespace_lock();
 	lock_mount_hash();
-	umount_tree(real_mount(mnt), UMOUNT_SYNC);
+	umount_tree(real_mount(mnt), 0);
 	unlock_mount_hash();
 	namespace_unlock();
 }


