Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71F5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED1821904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392797AbfBNBzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:55:20 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732533AbfBNBzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:55:19 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5FEF880D0304659AC8D8;
        Thu, 14 Feb 2019 09:55:17 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 14 Feb
 2019 09:55:09 +0800
Subject: Re: [PATCH] erofs: fix memleak of node's shared xattr array
To:     Sheng Yong <shengyong1@huawei.com>
CC:     <yuchao0@huawei.com>, <gregkh@linuxfoundation.org>,
        <linux-erofs@lists.ozlabs.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190214093754.14339-1-shengyong1@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <23bb86d7-817f-5447-eb2c-5e384d3a462b@huawei.com>
Date:   Thu, 14 Feb 2019 09:53:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190214093754.14339-1-shengyong1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sheng,

On 2019/2/14 17:37, Sheng Yong wrote:
> If it fails to read a shared xattr page, the node's shared xattr array

node -> inode since erofs doesn't have 'node' concept like f2fs...

> is not freed. The next time the node's xattr is accessed, the previously
> allocated array is leaked.
> 

Good catch! I think it's a valid object memory leak.
the subject should be fixed as [PATCH] staging: erofs: fix memleak of inode's shared xattr array
                                              ^

Thanks,
Gao Xiang

> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  drivers/staging/erofs/xattr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
> index 80dca6a4adbe..e3f8b904a680 100644
> --- a/drivers/staging/erofs/xattr.c
> +++ b/drivers/staging/erofs/xattr.c
> @@ -92,8 +92,11 @@ static int init_inode_xattrs(struct inode *inode)
>  
>  			it.page = erofs_get_meta_page(sb,
>  				++it.blkaddr, S_ISDIR(inode->i_mode));
> -			if (IS_ERR(it.page))
> +			if (IS_ERR(it.page)) {
> +				kfree(vi->xattr_shared_xattrs);
> +				vi->xattr_shared_xattrs = NULL;
>  				return PTR_ERR(it.page);
> +			}
>  
>  			it.kaddr = kmap_atomic(it.page);
>  			atomic_map = true;
> 
