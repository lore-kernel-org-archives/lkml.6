Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470FFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E911222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbfBMGum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:50:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:33936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387415AbfBMGum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:50:42 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 37FC27C7F29C73C27772;
        Wed, 13 Feb 2019 14:50:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Wed, 13 Feb 2019
 14:50:33 +0800
Subject: Re: [PATCH] fat: enable .splice_write to support splice on O_DIRECT
 file
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <hirofumi@mail.parknet.co.jp>
References: <20190210094754.56355-1-houtao1@huawei.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <05d7e682-1b49-2f9e-37f8-8de1401eeece@huawei.com>
Date:   Wed, 13 Feb 2019 14:50:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190210094754.56355-1-houtao1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?

On 2019/2/10 17:47, Hou Tao wrote:
> Now splice() on O_DIRECT-opened fat file will return -EFAULT, that is
> because the default .splice_write, namely default_file_splice_write(),
> will construct an ITER_KVEC iov_iter and dio_refill_pages() in dio path
> can not handle it.
> 
> Fix it by implementing .splice_write through iter_file_splice_write().
> 
> Spotted by xfs-tests generic/091.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/fat/file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 13935ee99e1e..b3bed32946b1 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -214,6 +214,7 @@ const struct file_operations fat_file_operations = {
>  #endif
>  	.fsync		= fat_file_fsync,
>  	.splice_read	= generic_file_splice_read,
> +	.splice_write	= iter_file_splice_write,
>  	.fallocate	= fat_fallocate,
>  };
>  
> 

