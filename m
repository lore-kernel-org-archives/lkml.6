Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeCWXPS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 19:15:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51646 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeCWXPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 19:15:16 -0400
Date: Fri, 23 Mar 2018 23:15:11 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] fs: Extend mount_ns with support for a fast
 namespace to vfsmount function
Message-ID: <20180323231511.GK30522@ZenIV.linux.org.uk>
References: <20180323060457.sxgsd3j2obi33fyw@gordon>
 <87k1u3ti9e.fsf@xmission.com>
 <87fu4qo4ff.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fu4qo4ff.fsf_-_@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 04:41:40PM -0500, Eric W. Biederman wrote:

>  struct dentry *mount_ns(struct file_system_type *fs_type,
>  	int flags, void *data, void *ns, struct user_namespace *user_ns,
> +	struct vfsmount *(*ns_to_mnt)(void *ns),
>  	int (*fill_super)(struct super_block *, void *, int))
>  {
>  	struct super_block *sb;
> -
> +	int (*test_super)(struct super_block *, void *) = ns_test_super;
>  	/* Don't allow mounting unless the caller has CAP_SYS_ADMIN
>  	 * over the namespace.
>  	 */
>  	if (!(flags & SB_KERNMOUNT) && !ns_capable(user_ns, CAP_SYS_ADMIN))
>  		return ERR_PTR(-EPERM);
>  
> -	sb = sget_userns(fs_type, ns_test_super, ns_set_super, flags,
> -			 user_ns, ns);
> +	if (ns_to_mnt) {
> +		test_super = NULL;
> +		if (!(flags & SB_KERNMOUNT)) {
> +			struct vfsmount *m = ns_to_mnt(ns);
> +			if (IS_ERR(m))
> +				return ERR_CAST(m);
> +			atomic_inc(&m->mnt_sb->s_active);
> +			down_write(&m->mnt_sb->s_umount);
> +			return dget(m->mnt_root);

This is completely wrong.  Look:
	* SB_KERNMOUNT and !SB_KERNMOUNT cases are almost entirely isolated;
completely so once that ns_to_mnt becomes unconditionally non-NULL.  
	* in !SB_KERNMOUNT passing ns_to_mnt() is pointless - you might as
well pass existing vfsmount (or ERR_PTR()) and use _that_.  fill_super()
is not used at all in that case.
	* is SB_KERNMOUNT ns_to_mnt serves only as a flag, eventually
constant true.

So let's split it in two helpers and give them sane arguments.
