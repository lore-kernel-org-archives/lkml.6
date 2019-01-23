Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA6CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DE421019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548241594;
	bh=1feXq55a+tjAd8GPP3+j0e4i97UqMAOmFaFkijc0wTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UdD9ODaZWsP6Mz9mZGNCj5PxbcoalN07tPJDqHe5YjOK2d4nNYavynikUqgAihmtQ
	 9TbllYftAIKO3oKlYR74rwTpEnunuqz1085ig0XeBmcpUFwC+wd3IM837eHpSEBRUz
	 D3hMLvwupZkRv1C/pXGNi3cpHhagOEpZ6KroThNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfAWLGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:06:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:55480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbfAWLGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:06:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2257FAF4F;
        Wed, 23 Jan 2019 11:06:30 +0000 (UTC)
Date:   Wed, 23 Jan 2019 12:06:28 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190123110628.GV4087@dhcp22.suse.cz>
References: <20190123102702.GA17123@kroah.com>
 <20190123102814.GB17123@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123102814.GB17123@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-01-19 11:28:14, Greg KH wrote:
> When an error happens, debugfs should return an error pointer value, not
> NULL.  This will prevent the totally theoretical error where a debugfs
> call fails due to lack of memory, returning NULL, and that dentry value
> is then passed to another debugfs call, which would end up succeeding,
> creating a file at the root of the debugfs tree, but would then be
> impossible to remove (because you can not remove the directory NULL).
> 
> So, to make everyone happy, always return errors, this makes the users
> of debugfs much simpler (they do not have to ever check the return
> value), and everyone can rest easy.

How come this is safe at all? Say you are creating a directory by
debugfs_create_dir and then feed the return value to debugfs_create_files
as a parent. In case of error you are giving it an invalid pointer and
likely blow up unless I miss something.

I do agree that reporting errors is better than a simple catch all NULL
but this should have been done when introduced rather than now when most
callers simply check for NULL as a failure.

> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reported-by: Gary R Hook <ghook@amd.com>
> Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/debugfs/inode.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 41ef452c1fcf..b16f8035b1af 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -254,8 +254,8 @@ MODULE_ALIAS_FS("debugfs");
>   * @parent: a pointer to the parent dentry of the file.
>   *
>   * This function will return a pointer to a dentry if it succeeds.  If the file
> - * doesn't exist or an error occurs, %NULL will be returned.  The returned
> - * dentry must be passed to dput() when it is no longer needed.
> + * doesn't exist or an error occurs, %ERR_PTR(-ERROR) will be returned.  The
> + * returned dentry must be passed to dput() when it is no longer needed.
>   *
>   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
> @@ -265,17 +265,17 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
>  	struct dentry *dentry;
>  
>  	if (IS_ERR(parent))
> -		return NULL;
> +		return parent;
>  
>  	if (!parent)
>  		parent = debugfs_mount->mnt_root;
>  
>  	dentry = lookup_one_len_unlocked(name, parent, strlen(name));
>  	if (IS_ERR(dentry))
> -		return NULL;
> +		return dentry;
>  	if (!d_really_is_positive(dentry)) {
>  		dput(dentry);
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  	return dentry;
>  }
> @@ -324,7 +324,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
>  	inode_unlock(d_inode(dentry->d_parent));
>  	dput(dentry);
>  	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
> -	return NULL;
> +	return ERR_PTR(-ENOMEM);
>  }
>  
>  static struct dentry *end_creating(struct dentry *dentry)
> @@ -347,7 +347,7 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
>  	dentry = start_creating(name, parent);
>  
>  	if (IS_ERR(dentry))
> -		return NULL;
> +		return dentry;
>  
>  	inode = debugfs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode))
> @@ -386,7 +386,8 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
>   * This function will return a pointer to a dentry if it succeeds.  This
>   * pointer must be passed to the debugfs_remove() function when the file is
>   * to be removed (no automatic cleanup happens if your module is unloaded,
> - * you are responsible here.)  If an error occurs, %NULL will be returned.
> + * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
> + * returned.
>   *
>   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
> @@ -464,7 +465,8 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_unsafe);
>   * This function will return a pointer to a dentry if it succeeds.  This
>   * pointer must be passed to the debugfs_remove() function when the file is
>   * to be removed (no automatic cleanup happens if your module is unloaded,
> - * you are responsible here.)  If an error occurs, %NULL will be returned.
> + * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
> + * returned.
>   *
>   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
> @@ -495,7 +497,8 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_size);
>   * This function will return a pointer to a dentry if it succeeds.  This
>   * pointer must be passed to the debugfs_remove() function when the file is
>   * to be removed (no automatic cleanup happens if your module is unloaded,
> - * you are responsible here.)  If an error occurs, %NULL will be returned.
> + * you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR) will be
> + * returned.
>   *
>   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
> @@ -506,7 +509,7 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>  	struct inode *inode;
>  
>  	if (IS_ERR(dentry))
> -		return NULL;
> +		return dentry;
>  
>  	inode = debugfs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode))
> @@ -545,7 +548,7 @@ struct dentry *debugfs_create_automount(const char *name,
>  	struct inode *inode;
>  
>  	if (IS_ERR(dentry))
> -		return NULL;
> +		return dentry;
>  
>  	inode = debugfs_get_inode(dentry->d_sb);
>  	if (unlikely(!inode))
> @@ -581,8 +584,8 @@ EXPORT_SYMBOL(debugfs_create_automount);
>   * This function will return a pointer to a dentry if it succeeds.  This
>   * pointer must be passed to the debugfs_remove() function when the symbolic
>   * link is to be removed (no automatic cleanup happens if your module is
> - * unloaded, you are responsible here.)  If an error occurs, %NULL will be
> - * returned.
> + * unloaded, you are responsible here.)  If an error occurs, %ERR_PTR(-ERROR)
> + * will be returned.
>   *
>   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
> @@ -594,12 +597,12 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
>  	struct inode *inode;
>  	char *link = kstrdup(target, GFP_KERNEL);
>  	if (!link)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	dentry = start_creating(name, parent);
>  	if (IS_ERR(dentry)) {
>  		kfree(link);
> -		return NULL;
> +		return dentry;
>  	}
>  
>  	inode = debugfs_get_inode(dentry->d_sb);
> @@ -827,7 +830,9 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
>  	if (dentry && !IS_ERR(dentry))
>  		dput(dentry);
>  	unlock_rename(new_dir, old_dir);
> -	return NULL;
> +	if (IS_ERR(dentry))
> +		return dentry;
> +	return ERR_PTR(-EINVAL);
>  }
>  EXPORT_SYMBOL_GPL(debugfs_rename);
>  
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
