Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5129AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1266D20866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCeSDnKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1266D20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394123AbeKVU4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:56:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388046AbeKVU4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:56:02 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE9FB20684;
        Thu, 22 Nov 2018 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542881835;
        bh=4qEpFH3jL3XoPlqUH+hNrkZzqtVYQsVVcZTCBxHiqT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCeSDnKkpCmUOVAbhKmcBZtWMzKxTUP//b0sIR+oaD7l17adobcY6wE0vgEvYY4VH
         fLxoKMIZEUhRQNA5LHXCiDsdDVENo9HBL6mFhYkmB7bjf6i2gAlRjT82EaYVAYk8Wx
         6Thkq4EWlzd2mxF78q/XCEFsqigiZaOFuJqulVDM=
Date:   Thu, 22 Nov 2018 11:17:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH 02/10] staging: erofs: fix race when the managed cache is
 enabled
Message-ID: <20181122101711.GA3189@kroah.com>
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

Any specific reason why you are not using the refcount.h api instead of
"doing it yourself" with atomic_inc/dec()?

I'm not rejecting this, just curious.

thanks,

greg k-h
