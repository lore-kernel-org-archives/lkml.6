Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4ADC00319
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787F52075B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbfB0Mns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:43:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727967AbfB0Mnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:43:47 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B6590E010D59EEB79AF6;
        Wed, 27 Feb 2019 20:43:43 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 20:43:37 +0800
Subject: Re: [PATCH 1/3] staging: erofs: compressed_pages should not be
 accessed again after freed
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, <stable@vger.kernel.org>
References: <20190227053332.38504-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <55e62c67-81db-e7c9-0ff0-fb4909e2fbc0@huawei.com>
Date:   Wed, 27 Feb 2019 20:43:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190227053332.38504-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/2/27 13:33, Gao Xiang wrote:
> This patch resolves the following page use-after-free issue,
> z_erofs_vle_unzip:
>     ...
>     for (i = 0; i < nr_pages; ++i) {
>         ...
>         z_erofs_onlinepage_endio(page);  (1)
>     }
> 
>     for (i = 0; i < clusterpages; ++i) {
>         page = compressed_pages[i];
> 
>         if (page->mapping == mngda)      (2)
>             continue;
>         /* recycle all individual staging pages */
>         (void)z_erofs_gather_if_stagingpage(page_pool, page); (3)
>         WRITE_ONCE(compressed_pages[i], NULL);
>     }
>     ...
> 
> After (1) is executed, page is freed and could be then reused, if
> compressed_pages is scanned after that, it could fall info (2) or
> (3) by mistake and that could finally be in a mess.
> 
> This patch aims to solve the above issue only with little changes
> as much as possible in order to make the fix backport easier.
> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Cc: <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

