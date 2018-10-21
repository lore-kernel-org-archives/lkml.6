Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D75ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 16:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78C92083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 16:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78C92083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeJVBNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 21:13:01 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:53442 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJVBNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 21:13:01 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gEH3E-0007mK-G8; Sun, 21 Oct 2018 10:58:04 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gEH3D-0007yc-OM; Sun, 21 Oct 2018 10:58:04 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
        <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
Date:   Sun, 21 Oct 2018 11:57:43 -0500
In-Reply-To: <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
        (David Howells's message of "Fri, 21 Sep 2018 17:30:34 +0100")
Message-ID: <877eib5jaw.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gEH3D-0007yc-OM;;;mid=<877eib5jaw.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18bVWAcQuXvszOJa770FuI2IuHkInykmwg=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE [ver #12]
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> From: Al Viro <viro@zeniv.linux.org.uk>
>
> Allow a detached tree created by open_tree(..., OPEN_TREE_CLONE) to be
> attached by move_mount(2).
>
> If by the time of final fput() of OPEN_TREE_CLONE-opened file its tree is
> not detached anymore, it won't be dissolved.  move_mount(2) is adjusted
> to handle detached source.
>
> That gives us equivalents of mount --bind and mount --rbind.

In light of recent conversations about double umount_tree.

Do we want to simply limit ourselves to attaching file->f_path of
a FMODE_NEED_UMOUNT file descriptor and clearing FMODE_NEED_UMOUNT
when it is attached?

Either that or perhaps move the logic into mntput on when to perform the
umount_tree?

Otherwise I believe we start running into surprising situations:

This works:
	ofd = open_tree(...);
	dup_fd = openat(ofd, "", O_PATH);
	mount_move(dup_fd, ...);
	close(ofd);
	close(dup_fd);

This should fail:
	ofd = open_tree(...);
	dup_fd = openat(ofd, "", O_PATH);
	close(ofd);
	mount_move(dup_fd, ...);
	close(dup_fd);

Allowing any file descriptor that points to mnt_ns == NULL without
MNT_UMOUNT set seems like it is adding flexibility for no reason.


> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  fs/namespace.c |   26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index dd38141b1723..caf5c55ef555 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1785,8 +1785,10 @@ void dissolve_on_fput(struct vfsmount *mnt)
>  {
>  	namespace_lock();
>  	lock_mount_hash();
> -	mntget(mnt);
> -	umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
> +	if (!real_mount(mnt)->mnt_ns) {
> +		mntget(mnt);
> +		umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
> +	}

^^^^^^ This change should be unnecessary.

>  	unlock_mount_hash();
>  	namespace_unlock();
>  }
> @@ -2393,6 +2395,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>  	struct mount *old;
>  	struct mountpoint *mp;
>  	int err;
> +	bool attached;
>  
>  	mp = lock_mount(new_path);
>  	err = PTR_ERR(mp);
> @@ -2403,10 +2406,19 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>  	p = real_mount(new_path->mnt);
>  
>  	err = -EINVAL;
> -	if (!check_mnt(p) || !check_mnt(old))
> +	/* The mountpoint must be in our namespace. */
> +	if (!check_mnt(p))
> +		goto out1;
> +	/* The thing moved should be either ours or completely unattached. */
> +	if (old->mnt_ns && !check_mnt(old))
>  		goto out1;

^^^^^^^^^^^^^^^^^^^^^^^

!old->mnt_ns  should only be allowed when it comes from a file
 descriptor with FMODE_NEED_UMOUNT.


> -	if (!mnt_has_parent(old))
> +	attached = mnt_has_parent(old);
> +	/*
> +	 * We need to allow open_tree(OPEN_TREE_CLONE) followed by
> +	 * move_mount(), but mustn't allow "/" to be moved.
> +	 */
> +	if (old->mnt_ns && !attached)
>  		goto out1;
>  
>  	if (old->mnt.mnt_flags & MNT_LOCKED)
> @@ -2421,7 +2433,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>  	/*
>  	 * Don't move a mount residing in a shared parent.
>  	 */
> -	if (IS_MNT_SHARED(old->mnt_parent))
> +	if (attached && IS_MNT_SHARED(old->mnt_parent))
>  		goto out1;
>  	/*
>  	 * Don't move a mount tree containing unbindable mounts to a destination
> @@ -2435,7 +2447,7 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>  			goto out1;
>  
>  	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp,
> -				   &parent_path);
> +				   attached ? &parent_path : NULL);
>  	if (err)
>  		goto out1;

^^^^^^^^^^^^^^^^^^^
Somewhere around here we should have code that clears FMODE_NEED_UMOUNT.


> @@ -3121,6 +3133,8 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
>  
>  /*
>   * Move a mount from one place to another.
> + * In combination with open_tree(OPEN_TREE_CLONE [| AT_RECURSIVE]) it can be
> + * used to copy a mount subtree.
>   *
>   * Note the flags value is a combination of MOVE_MOUNT_* flags.
>   */
