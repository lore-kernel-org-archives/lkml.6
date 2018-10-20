Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB162C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9524321523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9524321523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJTT6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 15:58:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50506 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeJTT6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 15:58:42 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDpk2-0004L5-Dy; Sat, 20 Oct 2018 11:48:26 +0000
Date:   Sat, 20 Oct 2018 12:48:26 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Alan Jenkins <alan.christopher.jenkins@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE
 [ver #12]
Message-ID: <20181020114826.GM32577@ZenIV.linux.org.uk>
References: <97872123-70be-2833-ea7a-a463ce204b53@gmail.com>
 <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
 <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
 <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
 <6518.1539956277@warthog.procyon.org.uk>
 <29902.1539988579@warthog.procyon.org.uk>
 <209e8c35-d26e-0a29-84d7-b8b1d0ecbebc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <209e8c35-d26e-0a29-84d7-b8b1d0ecbebc@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 12:06:32PM +0100, Alan Jenkins wrote:

> You posted an analysis of a GPF, where you showed the reference count was
> clearly one less than it should have been.  You narrowed this down to a step
> where you connected an unmounted mount (MNT_UMOUNT) to a mounted mount.  So
> your analysis is consistent with the comment in disconnect_mount(), which
> says 1) you're not allowed to do that, 2) the reason is because of different
> reference-counting rules.  AFAICT, the GPF you analyzed would be prevented
> by the fix in do_move_mount(), checking for MNT_UMOUNT.

Not just refcounting; it's that fs_pin is really intended to have ->kill()
triggered only once.  If you look at the pin_kill() (which is where the
livelock happened) you'll see what's going on - anyone hitting it between
the first call and freeing of the object will be sleeping until ->kill()
from the first call gets through pin_remove(), at which point they bugger
off (being very careful with accessing the sucker to avoid use-after-free).

MNT_UMOUNT means that there's no way back.

> pre-date MNT_UMOUNT.  I *think* the added check in dissolve_on_fput() makes
> things right, but I don't understand enough to be sure.

That, plus making sure that do_move_mount() grabs a reference in case
of successfully attaching a tree.  I hate passing bool argument, BTW -
better just do mnt_add_count() either before attach_recursive_mnt()
and decrement on failure, or, better yet, just do it on success.  Note
that namespace_sem is held, so the damn thing *can't* disappear under
us - nobody will be able to detach it until we drop namespace_lock.

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 4dfe7e23b7ee..e8d61d5f581d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1763,7 +1763,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
>  {
>  	namespace_lock();
>  	lock_mount_hash();
> -	if (!real_mount(mnt)->mnt_ns) {
> +	if (!real_mount(mnt)->mnt_ns && !(mnt->mnt_flags & MNT_UMOUNT)) {
>  		mntget(mnt);
>  		umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
>  	}
> @@ -2469,7 +2469,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>  	if (old->mnt_ns && !attached)
>  		goto out1;
>  
> -	if (old->mnt.mnt_flags & MNT_LOCKED)
> +	if (old->mnt.mnt_flags & (MNT_LOCKED | MNT_UMOUNT))
>  		goto out1;
>  
>  	if (old_path->dentry != old_path->mnt->mnt_root)

