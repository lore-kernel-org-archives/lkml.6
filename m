Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbeDSQo3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:44:29 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37174 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbeDSQo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:44:28 -0400
Date: Thu, 19 Apr 2018 17:44:24 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Alexander Aring <aring@mojatatu.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [bisected] Stack overflow after fs: "switch the IO-triggering
 parts of umount to fs_pin" (was net namespaces kernel stack overflow)
Message-ID: <20180419164424.GI30522@ZenIV.linux.org.uk>
References: <CAOHTApjPwWDxHmGrfMwFvszWubfjJ7YfBgZL-DQ0mdv00UtQEQ@mail.gmail.com>
 <ef45eb94-4480-0683-ccc0-eb1efaf7e96c@virtuozzo.com>
 <d6e6f694-1bd9-7f3e-eaa8-1947c47f523f@virtuozzo.com>
 <20180419153447.GH30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419153447.GH30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 04:34:48PM +0100, Al Viro wrote:

> IOW, we only get there if our vfsmount was an MNT_INTERNAL one.
> So we have mnt->mnt_umount of some MNT_INTERNAL mount found in
> ->mnt_pins of some other mount.  Which, AFAICS, means that
> it used to be mounted on that other mount.  How the hell can
> that happen?
> 
> It looks like you somehow get a long chain of MNT_INTERNAL mounts
> stacked on top of each other, which ought to be prevented by
>         mnt_flags &= ~MNT_INTERNAL_FLAGS;
> in do_add_mount().  Nuts...

Arrrrrgh...  Nuts is right - clone_mnt() preserves the sodding
MNT_INTERNAL, with obvious results.

netns is related to the problem, by exposing MNT_INTERNAL mounts
(in /proc/*/ns/*) for mount --bind to copy and attach to the
tree.  AFAICS, the minimal reproducer is

touch /tmp/a
unshare -m sh -c 'for i in `seq 10000`; do mount --bind /proc/1/ns/net /tmp/a; done'

(and it can be anything in /proc/*/ns/*, really)

I think the fix should be along the lines of the following:

Don't leak MNT_INTERNAL away from internal mounts

We want it only for the stuff created by SB_KERNMOUNT mounts, *not* for
their copies.

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1089,7 +1089,8 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 			goto out_free;
 	}
 
-	mnt->mnt.mnt_flags = old->mnt.mnt_flags & ~(MNT_WRITE_HOLD|MNT_MARKED);
+	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
+	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
 	/* Don't allow unprivileged users to change mount flags */
 	if (flag & CL_UNPRIVILEGED) {
 		mnt->mnt.mnt_flags |= MNT_LOCK_ATIME;
