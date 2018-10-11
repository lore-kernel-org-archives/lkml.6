Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D7AC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CF8204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CF8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbeJLCHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:07:13 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56631 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbeJLCHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:07:13 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gAfrC-0005bm-Eq; Thu, 11 Oct 2018 12:38:46 -0600
Received: from 67-3-154-154.omah.qwest.net ([67.3.154.154] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gAfr8-00086b-Nu; Thu, 11 Oct 2018 12:38:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     David Howells <dhowells@redhat.com>
Cc:     Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
References: <5c6f3d62-4cec-2aea-4693-62928611c526@gmail.com>
        <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
        <153754743491.17872.12115848333103740766.stgit@warthog.procyon.org.uk>
        <de050902-f3d0-b2db-2627-983a36c87b3c@gmail.com>
        <862e36a2-2a6f-4e26-3228-8cab4b4cf230@gmail.com>
        <17405.1539272035@warthog.procyon.org.uk>
Date:   Thu, 11 Oct 2018 13:38:31 -0500
In-Reply-To: <17405.1539272035@warthog.procyon.org.uk> (David Howells's
        message of "Thu, 11 Oct 2018 16:33:55 +0100")
Message-ID: <87sh1cqqfs.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gAfr8-00086b-Nu;;;mid=<87sh1cqqfs.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=67.3.154.154;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18VEsie434TnCovjye8QVPcVR1KblGZ4Co=
X-SA-Exim-Connect-IP: 67.3.154.154
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 03/34] teach move_mount(2) to work with OPEN_TREE_CLONE [ver #12]
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Okay, this appears to fix the cycle-creation problem.
>
> It could probably be improved by comparing sequence numbers as Alan suggests,
> but I need to work out how to get at that.

It should just be a matter of replacing the test
"if (p->mnt.mnt_sb->s_type == &nsfs)" with "if mnt_ns_loop(p->mnt.mnt_root)"

That would allow reusing 100% of the existing logic, and remove the need
to export file_system_type nsfs;

As your test exists below it will reject a lot more than mount namespace
file descriptors.  It will reject file descriptors for every other
namespace as well.

Eric

> ---
> commit 069c3376f7849044117c866aeafbb1a525f84926
> Author: David Howells <dhowells@redhat.com>
> Date:   Thu Oct 4 23:18:59 2018 +0100
>
>     fixes
>
> diff --git a/fs/internal.h b/fs/internal.h
> index 17029b30e196..47a6c80c3c51 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -172,6 +172,7 @@ extern void mnt_pin_kill(struct mount *m);
>   * fs/nsfs.c
>   */
>  extern const struct dentry_operations ns_dentry_operations;
> +extern struct file_system_type nsfs;
>  
>  /*
>   * fs/ioctl.c
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e969ded7d54b..25ecd8b3c76b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2388,6 +2388,27 @@ static inline int tree_contains_unbindable(struct mount *mnt)
>  	return 0;
>  }
>  
> +/*
> + * Object if there are any nsfs mounts in the specified subtree.  These can act
> + * as pins for mount namespaces that aren't checked by the mount-cycle checking
> + * code, thereby allowing cycles to be made.
> + */
> +static bool check_for_nsfs_mounts(struct mount *subtree)
> +{
> +	struct mount *p;
> +	bool ret = false;
> +
> +	lock_mount_hash();
> +	for (p = subtree; p; p = next_mnt(p, subtree))
> +		if (p->mnt.mnt_sb->s_type == &nsfs)
> +			goto out;
> +
> +	ret = true;
> +out:
> +	unlock_mount_hash();
> +	return ret;
> +}
> +
>  static int do_move_mount(struct path *old_path, struct path *new_path)
>  {
>  	struct path parent_path = {.mnt = NULL, .dentry = NULL};
> @@ -2442,6 +2463,8 @@ static int do_move_mount(struct path *old_path, struct path *new_path)
>  	if (IS_MNT_SHARED(p) && tree_contains_unbindable(old))
>  		goto out1;
>  	err = -ELOOP;
> +	if (!check_for_nsfs_mounts(old))
> +		goto out1;
>  	for (; mnt_has_parent(p); p = p->mnt_parent)
>  		if (p == old)
>  			goto out1;
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index f069eb6495b0..d3abcd5c2a23 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -269,7 +269,7 @@ static struct dentry *nsfs_mount(struct file_system_type *fs_type,
>  	return mount_pseudo(fs_type, "nsfs:", &nsfs_ops,
>  			&ns_dentry_operations, NSFS_MAGIC);
>  }
> -static struct file_system_type nsfs = {
> +struct file_system_type nsfs = {
>  	.name = "nsfs",
>  	.mount = nsfs_mount,
>  	.kill_sb = kill_anon_super,
