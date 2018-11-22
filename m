Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9209FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA0120870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyoA9j9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA0120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394171AbeKVU7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:59:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731554AbeKVU7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:59:37 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEBE920684;
        Thu, 22 Nov 2018 10:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542882050;
        bh=KCUkvC/hppxT223CzA2yW6igTjdLakLXjGFU3qkoUcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZyoA9j9bnlLIZuZV/UX9dmx7zWJZXbgOjYKS+XkNmeYXAtjvg+yb2bbmuvSpWutb4
         pMg5An7QIvvFi60nP8O1HmcieSMCRYMrAaTp1iaoEdaUmVOUj2clBNnZSLM+4zEwA3
         Tu4zIzhWUD/hhAKQZ+5NWVS0podbkz/2yCPV9Pss=
Date:   Thu, 22 Nov 2018 11:20:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 03/10] staging: erofs: atomic_cond_read_relaxed on
 ref-locked workgroup
Message-ID: <20181122102046.GD3189@kroah.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
 <20181120143425.43637-4-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120143425.43637-4-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:34:18PM +0800, Gao Xiang wrote:
> It's better to use atomic_cond_read_relaxed, which is implemented
> in hardware instructions to monitor a variable changes currently
> for ARM64, instead of open-coded busy waiting.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/internal.h | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index 89dbd0888e53..eb80ba44d072 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -221,23 +221,29 @@ static inline void erofs_workgroup_unfreeze(
>  	preempt_enable();
>  }
>  
> +#if defined(CONFIG_SMP)
> +static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
> +{
> +	return atomic_cond_read_relaxed(&grp->refcount,
> +					VAL != EROFS_LOCKED_MAGIC);
> +}
> +#else
> +static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
> +{
> +	int v = atomic_read(&grp->refcount);

Again, why not use the refcount api instead of doing this yourself?

thanks,

greg k-h
