Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEAFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CB1206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 02:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfBTCj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 21:39:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726235AbfBTCj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 21:39:26 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 26A7CBE841C07D3BD209;
        Wed, 20 Feb 2019 10:39:24 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 20 Feb
 2019 10:39:16 +0800
Subject: Re: [PATCH] staging: erofs: remove rcu_read_lock() in
 erofs_try_to_free_cached_page
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        "Fang Wei" <fangwei1@huawei.com>
References: <20190216084650.33841-1-gaoxiang25@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <fc058e45-a645-c680-2ce0-19de83fffc2e@huawei.com>
Date:   Wed, 20 Feb 2019 10:38:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190216084650.33841-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Could you consider take some time on these two patches for linux-5.1-rc1?
 1) staging: erofs: fix race of initializing xattrs of a inode at the same time
 2) staging: erofs: remove rcu_read_lock() in erofs_try_to_free_cached_page

It will be of great help, especially patch 1 (it could cause potential memleak
in the race condition without it).

If something (eg, resend these patches in a new patchset) is needed, I'm happy
to do that. :)

Thanks,
Gao Xiang

On 2019/2/16 16:46, Gao Xiang wrote:
> page_private(page) cannot be changed if page lock is taken.
> 
> Besides, the corresponding workgroup won't be freed
> if the page is already protected by page lock, therefore
> no need to take rcu read lock.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  drivers/staging/erofs/unzip_vle.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index 2b5951f233db..a127d8db76d8 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -238,14 +238,9 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
>  {
>  	struct erofs_sb_info *const sbi = EROFS_SB(mapping->host->i_sb);
>  	const unsigned int clusterpages = erofs_clusterpages(sbi);
> -
> -	struct z_erofs_vle_workgroup *grp;
> +	struct z_erofs_vle_workgroup *const grp = (void *)page_private(page);
>  	int ret = 0;	/* 0 - busy */
>  
> -	/* prevent the workgroup from being freed */
> -	rcu_read_lock();
> -	grp = (void *)page_private(page);
> -
>  	if (erofs_workgroup_try_to_freeze(&grp->obj, 1)) {
>  		unsigned int i;
>  
> @@ -257,12 +252,11 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
>  			}
>  		}
>  		erofs_workgroup_unfreeze(&grp->obj, 1);
> -	}
> -	rcu_read_unlock();
>  
> -	if (ret) {
> -		ClearPagePrivate(page);
> -		put_page(page);
> +		if (ret) {
> +			ClearPagePrivate(page);
> +			put_page(page);
> +		}
>  	}
>  	return ret;
>  }
> 
