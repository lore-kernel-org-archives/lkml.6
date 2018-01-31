Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756035AbeAaXZ7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 18:25:59 -0500
Received: from ozlabs.org ([103.22.144.67]:42931 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756018AbeAaXZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 18:25:56 -0500
Date: Thu, 1 Feb 2018 10:25:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: linux-next: manual merge of the vfs tree with the overlayfs
 tree
Message-ID: <20180201102553.73370fa6@canb.auug.org.au>
In-Reply-To: <20180125143155.20b15b37@canb.auug.org.au>
References: <20180125143155.20b15b37@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Thu, 25 Jan 2018 14:31:55 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the vfs tree got a conflict in:
> 
>   fs/dcache.c
> 
> between commit:
> 
>   f9c34674bc60 ("vfs: factor out helpers d_instantiate_anon() and d_alloc_anon()")
> 
> from the overlayfs tree and commit:
> 
>   f1ee616214cb ("VFS: don't keep disconnected dentries on d_anon")
> 
> from the vfs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc fs/dcache.c
> index 99bce0ed0213,17e6b84b9656..000000000000
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@@ -1954,16 -1961,18 +1953,18 @@@ static struct dentry *__d_instantiate_a
>   	if (disconnected)
>   		add_flags |= DCACHE_DISCONNECTED;
>   
>  -	spin_lock(&tmp->d_lock);
>  -	__d_set_inode_and_type(tmp, inode, add_flags);
>  -	hlist_add_head(&tmp->d_u.d_alias, &inode->i_dentry);
>  +	spin_lock(&dentry->d_lock);
>  +	__d_set_inode_and_type(dentry, inode, add_flags);
>  +	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
> - 	hlist_bl_lock(&dentry->d_sb->s_anon);
> - 	hlist_bl_add_head(&dentry->d_hash, &dentry->d_sb->s_anon);
> - 	hlist_bl_unlock(&dentry->d_sb->s_anon);
> + 	if (!disconnected) {
>  -		hlist_bl_lock(&tmp->d_sb->s_roots);
>  -		hlist_bl_add_head(&tmp->d_hash, &tmp->d_sb->s_roots);
>  -		hlist_bl_unlock(&tmp->d_sb->s_roots);
> ++		hlist_bl_lock(&dentry->d_sb->s_roots);
> ++		hlist_bl_add_head(&dentry->d_hash, &tmp->d_sb->s_roots);
> ++		hlist_bl_unlock(&dentry->d_sb->s_roots);
> + 	}
>  -	spin_unlock(&tmp->d_lock);
>  +	spin_unlock(&dentry->d_lock);
>   	spin_unlock(&inode->i_lock);
>   
>  -	return tmp;
>  +	return dentry;
>   
>    out_iput:
>   	iput(inode);

This is now a conflict between the overlayfs tree and Linus' tree.

-- 
Cheers,
Stephen Rothwell
