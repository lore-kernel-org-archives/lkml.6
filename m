Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EF1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFADD20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLWWNssT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFADD20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394190AbeKVVCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:02:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387625AbeKVVCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:02:31 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AC5920684;
        Thu, 22 Nov 2018 10:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542882223;
        bh=E2LADVbCbBFia8VLdZLhkv1JGhmg0kg/n8W84RF/zQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLWWNssTNq9Lp4LlMaxNtBV4ug1gxaT2OkHGeP/VZH99fj3y5v4ED1a6QE0tsi5+3
         3SCyRVKMAJLIiWgClETaq/iLpq02UxD+6fbEryNwwKxGT+iV2bnb9THNAR9Q+3ePdn
         ICMUl1imziGCqbgKg4Vd4eXTufy9cNCf9SrnUEHI=
Date:   Thu, 22 Nov 2018 11:23:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 07/10] staging: erofs: separate into init_once / always
Message-ID: <20181122102339.GG3189@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-8-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120143425.43637-8-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:34:22PM +0800, Gao Xiang wrote:
> `z_erofs_vle_workgroup' is heavily generated in the decompression,
> for example, it resets 32 bytes redundantly for 64-bit platforms
> even through Z_EROFS_VLE_INLINE_PAGEVECS + Z_EROFS_CLUSTER_MAX_PAGES,
> default 4, pages are stored in `z_erofs_vle_workgroup'.
> 
> As an another example, `struct mutex' takes 72 bytes for our kirin
> 64-bit platforms, it's unnecessary to be reseted at first and
> be initialized each time.
> 
> Let's avoid filling all `z_erofs_vle_workgroup' with 0 at first
> since most fields are reinitialized to meaningful values later,
> and pagevec is no need to initialized at all.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/unzip_vle.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index ede3383ac601..4e5843e8ee35 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -43,12 +43,38 @@ static inline int init_unzip_workqueue(void)
>  	return z_erofs_workqueue ? 0 : -ENOMEM;
>  }
>  
> +static void init_once(void *ptr)
> +{
> +	struct z_erofs_vle_workgroup *grp = ptr;
> +	struct z_erofs_vle_work *const work =
> +		z_erofs_vle_grab_primary_work(grp);
> +	unsigned int i;
> +
> +	mutex_init(&work->lock);
> +	work->nr_pages = 0;
> +	work->vcnt = 0;
> +	for (i = 0; i < Z_EROFS_CLUSTER_MAX_PAGES; ++i)
> +		grp->compressed_pages[i] = NULL;
> +}
> +
> +static void init_always(struct z_erofs_vle_workgroup *grp)
> +{
> +	struct z_erofs_vle_work *const work =
> +		z_erofs_vle_grab_primary_work(grp);
> +
> +	atomic_set(&grp->obj.refcount, 1);
> +	grp->flags = 0;
> +
> +	DBG_BUGON(work->nr_pages);
> +	DBG_BUGON(work->vcnt);

How can these ever be triggered?  I understand the need for debugging
code when you are writing code, but at this point it shouldn't be needed
anymore, right?

thanks,

greg k-h
