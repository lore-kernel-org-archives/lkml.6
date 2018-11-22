Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3065C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A293120866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WloBIhHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A293120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394132AbeKVU5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387447AbeKVU5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:57:53 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A56E20684;
        Thu, 22 Nov 2018 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542881946;
        bh=mF182HNntgqJiCdTomz8KE4JWX96LxCiMGktvNxe0lI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WloBIhHnEUq8t3JgrHU/RlSRu9Z8xgMNDK7hcwi77Ty3nPUyyfCbnT3JkHl+mtF/0
         HXJ+CgG1p9gFxgBBIh0WNKrCmmOX0JYD3NS2eOzHgwh69Js7Js8RjsS+hhioZGQz3o
         zaUU+sE5NoMf+fnNQUKT8LJzQdnj7kHGI5iy0eIY=
Date:   Thu, 22 Nov 2018 11:19:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 02/10] staging: erofs: fix race when the managed cache is
 enabled
Message-ID: <20181122101902.GB3189@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-3-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120143425.43637-3-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:34:17PM +0800, Gao Xiang wrote:
> When the managed cache is enabled, the last reference count
> of a workgroup must be used for its workstation.
> 
> Otherwise, it could lead to incorrect (un)freezes in
> the reclaim path, and it would be harmful.
> 
> A typical race as follows:
> 
> Thread 1 (In the reclaim path)  Thread 2
> workgroup_freeze(grp, 1)                                refcnt = 1
> ...
> workgroup_unfreeze(grp, 1)                              refcnt = 1
>                                 workgroup_get(grp)      refcnt = 2 (x)
> workgroup_put(grp)                                      refcnt = 1 (x)
>                                 ...unexpected behaviors
> 
> * grp is detached but still used, which violates cache-managed
>   freeze constraint.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/internal.h |   1 +
>  drivers/staging/erofs/utils.c    | 131 +++++++++++++++++++++++++++------------
>  2 files changed, 93 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index 57575c7f5635..89dbd0888e53 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -250,6 +250,7 @@ static inline bool erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
>  }
>  
>  #define __erofs_workgroup_get(grp)	atomic_inc(&(grp)->refcount)
> +#define __erofs_workgroup_put(grp)	atomic_dec(&(grp)->refcount)
>  
>  extern int erofs_workgroup_put(struct erofs_workgroup *grp);
>  
> diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
> index ea8a962e5c95..90de8d9195b7 100644
> --- a/drivers/staging/erofs/utils.c
> +++ b/drivers/staging/erofs/utils.c
> @@ -83,12 +83,21 @@ int erofs_register_workgroup(struct super_block *sb,
>  
>  	grp = xa_tag_pointer(grp, tag);
>  
> -	err = radix_tree_insert(&sbi->workstn_tree,
> -		grp->index, grp);
> +	/*
> +	 * Bump up reference count before making this workgroup
> +	 * visible to other users in order to avoid potential UAF
> +	 * without serialized by erofs_workstn_lock.
> +	 */
> +	__erofs_workgroup_get(grp);
>  
> -	if (!err) {
> -		__erofs_workgroup_get(grp);
> -	}
> +	err = radix_tree_insert(&sbi->workstn_tree,
> +				grp->index, grp);
> +	if (unlikely(err))
> +		/*
> +		 * it's safe to decrease since the workgroup isn't visible
> +		 * and refcount >= 2 (cannot be freezed).
> +		 */
> +		__erofs_workgroup_put(grp);
>  
>  	erofs_workstn_unlock(sbi);
>  	radix_tree_preload_end();
> @@ -97,19 +106,91 @@ int erofs_register_workgroup(struct super_block *sb,
>  
>  extern void erofs_workgroup_free_rcu(struct erofs_workgroup *grp);
>  
> +static void  __erofs_workgroup_free(struct erofs_workgroup *grp)
> +{
> +	atomic_long_dec(&erofs_global_shrink_cnt);
> +	erofs_workgroup_free_rcu(grp);
> +}
> +
>  int erofs_workgroup_put(struct erofs_workgroup *grp)
>  {
>  	int count = atomic_dec_return(&grp->refcount);
>  
>  	if (count == 1)
>  		atomic_long_inc(&erofs_global_shrink_cnt);
> -	else if (!count) {
> -		atomic_long_dec(&erofs_global_shrink_cnt);
> -		erofs_workgroup_free_rcu(grp);
> -	}
> +	else if (!count)
> +		__erofs_workgroup_free(grp);
>  	return count;
>  }
>  
> +#ifdef EROFS_FS_HAS_MANAGED_CACHE
> +/* for cache-managed case, customized reclaim paths exist */
> +static void erofs_workgroup_unfreeze_final(struct erofs_workgroup *grp)
> +{
> +	erofs_workgroup_unfreeze(grp, 0);
> +	__erofs_workgroup_free(grp);
> +}
> +
> +bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
> +				    struct erofs_workgroup *grp,
> +				    bool cleanup)
> +{
> +	/*
> +	 * for managed cache enabled, the refcount of workgroups
> +	 * themselves could be < 0 (freezed). So there is no guarantee
> +	 * that all refcount > 0 if managed cache is enabled.
> +	 */
> +	if (!erofs_workgroup_try_to_freeze(grp, 1))
> +		return false;
> +
> +	/*
> +	 * note that all cached pages should be unlinked
> +	 * before delete it from the radix tree.
> +	 * Otherwise some cached pages of an orphan old workgroup
> +	 * could be still linked after the new one is available.
> +	 */
> +	if (erofs_try_to_free_all_cached_pages(sbi, grp)) {
> +		erofs_workgroup_unfreeze(grp, 1);
> +		return false;
> +	}
> +
> +	/* it is impossible to fail after we freeze the workgroup */
> +	BUG_ON(xa_untag_pointer(radix_tree_delete(&sbi->workstn_tree,
> +						  grp->index)) != grp);
> +

It is not a good idea to crash the system.  Please try to recover from
this, a BUG_ON() implies that the developer has no idea how to handle
this type of error so either it can never happen (which means that the
BUG_ON can be removed), or you need to fix the logic to handle this type
of issue when it does happen.

I'm not going to take this as-is, sorry.

greg k-h
