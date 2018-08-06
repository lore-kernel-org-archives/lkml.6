Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503F7C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD1E219E5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD1E219E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeHFKlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:41:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbeHFKlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:41:47 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C0630ECF301E1;
        Mon,  6 Aug 2018 16:33:44 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Mon, 6 Aug 2018
 16:33:39 +0800
Subject: Re: [V9fs-developer] [PATCH] net/9p: avoid request size exceed to the
 virtqueue number in the zero copy
To:     jiangyiwen <jiangyiwen@huawei.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
References: <5B63FB4D.1050703@huawei.com>
CC:     <v9fs-developer@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B6807BB.9010803@huawei.com>
Date:   Mon, 6 Aug 2018 16:32:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <5B63FB4D.1050703@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yiwen,

On 2018/8/3 14:50, jiangyiwen wrote:
> Unfortunately, when the address(input and response headers) are not
> at page boundary, it will need two extra entry in the zero copy, or
> else it will cause sg array out of bounds.
> 
> To avoid the problem, we should subtract two pages for maxsize.
> 
> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
> ---
>  net/9p/trans_virtio.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 6265d1d..63591b2 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -754,11 +754,12 @@ static void p9_virtio_remove(struct virtio_device *vdev)
>  	.cancel = p9_virtio_cancel,
>  	/*
>  	 * We leave one entry for input and one entry for response
> -	 * headers. We also skip one more entry to accomodate, address
> -	 * that are not at page boundary, that can result in an extra
> -	 * page in zero copy.
> +	 * headers. We also skip three more entrys to accomodate
> +	 * (input + response headers + data pages), address
> +	 * that are not at page boundary, that can result in
> +	 * an extra page in zero copy.

Here should be two extra pages.

Thanks,
Jun

>  	 */
> -	.maxsize = PAGE_SIZE * (VIRTQUEUE_NUM - 3),
> +	.maxsize = PAGE_SIZE * (VIRTQUEUE_NUM - 5),
>  	.def = 1,
>  	.owner = THIS_MODULE,
>  };
> 
