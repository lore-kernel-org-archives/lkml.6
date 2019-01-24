Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBA6C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6AD2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 02:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548296907;
	bh=/9oaBKKDAPyKylbGIZAFDm/ELv3Sw3tVomFs+zkbxSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FQepO9PXydBlSdcX0yookfpOUJAQBkXAFP9jPav4lAI8h/f8Xo8vMUhL+tFKsQ0CY
	 WfmIt2XzbZiFHBchWGLzgxLssJ1Kr6G/XkcxyU0V82NvCan3VEz3rsgpV4/45zcIYa
	 oyPvb7l8gr4edCI+bs5MTPj2mwMsYbK0LA43efn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfAXC1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 21:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbfAXC07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 21:26:59 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5315821872;
        Thu, 24 Jan 2019 02:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548296818;
        bh=/9oaBKKDAPyKylbGIZAFDm/ELv3Sw3tVomFs+zkbxSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yBTH2Zq1VvknLjwn2rYh5qd4xL3HNY+7sxmHOl0QiK9fWvptgcCknGfA89bXKN5Vj
         OZgPoOEXeyz8aAjaIBJ0ua5ZK+XZkVEDvj01NvsEJgov9wMk5aZ7iIsrhTEGqQtpey
         +7nTPz+pxY4qbk9yB7uS6i7/wf2gYxUTzc8JO/yw=
Date:   Thu, 24 Jan 2019 11:26:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-Id: <20190124112652.f31fc4b8dd9892f0d2f84790@kernel.org>
In-Reply-To: <20190123102814.GB17123@kroah.com>
References: <20190123102702.GA17123@kroah.com>
        <20190123102814.GB17123@kroah.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 11:28:14 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

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

With Greg's return check removal patches, I'm OK for this change.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
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
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
