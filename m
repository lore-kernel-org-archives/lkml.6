Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0FBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EA02075B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbfB0MnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:43:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728189AbfB0MnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:43:07 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A14732191A174E25D870;
        Wed, 27 Feb 2019 20:43:05 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 20:42:59 +0800
Subject: Re: [PATCH 3/3] staging: erofs: fix mis-acted TAIL merging behavior
To:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, <stable@vger.kernel.org>
References: <20190227053332.38504-1-gaoxiang25@huawei.com>
 <20190227053332.38504-3-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1d8b2544-5be1-bf48-70f3-5bd703c37040@huawei.com>
Date:   Wed, 27 Feb 2019 20:42:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190227053332.38504-3-gaoxiang25@huawei.com>
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
> EROFS has an optimized path called TAIL merging, which is designed
> to merge multiple reads and the corresponding decompressions into
> one if these requests read continuous pages almost at the same time.
> 
> In general, it behaves as follows:
>  ________________________________________________________________
>   ... |  TAIL  .  HEAD  |  PAGE  |  PAGE  |  TAIL    . HEAD | ...
>  _____|_combined page A_|________|________|_combined page B_|____
>         1  ]  ->  [  2                          ]  ->  [ 3
> If the above three reads are requested in the order 1-2-3, it will
> generate a large work chain rather than 3 individual work chains
> to reduce scheduling overhead and boost up sequential read.
> 
> However, if Read 2 is processed slightly earlier than Read 1,
> currently it still generates 2 individual work chains (chain 1, 2)
> but it does in-place decompression for combined page A, moreover,
> if chain 2 decompresses ahead of chain 1, it will be a race and
> lead to corrupted decompressed page. This patch fixes it.
> 
> Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
> Cc: <stable@vger.kernel.org> # 4.19+
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

