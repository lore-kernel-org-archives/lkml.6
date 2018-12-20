Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A1DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB31E2176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbeLTKnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:43:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbeLTKnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:43:14 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AB501C6BD8103;
        Thu, 20 Dec 2018 18:43:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Thu, 20 Dec 2018
 18:43:09 +0800
Subject: Re: [PATCH] jffs2: Fix integer underflow in jffs2_rtime_compress
To:     Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20181215162350.12489-1-richard@nod.at>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <cae86ca1-91f9-6728-df64-40580145220d@huawei.com>
Date:   Thu, 20 Dec 2018 18:43:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181215162350.12489-1-richard@nod.at>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/12/16 0:23, Richard Weinberger wrote:
> The rtime compressor assumes that at least two bytes are
> compressed.
> If we try to compress just one byte, the loop condition will
> wrap around and an out-of-bounds write happens.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  fs/jffs2/compr_rtime.c | 3 +++
>  1 file changed, 3 insertions(+)
> It seems that it doesn't incur any harm because the minimal allocated
size will be 8-bytes and jffs2_rtime_compress() will write 2-bytes into
the allocated buffer.

> diff --git a/fs/jffs2/compr_rtime.c b/fs/jffs2/compr_rtime.c
> index 406d9cc84ba8..cbf700001fc9 100644
> --- a/fs/jffs2/compr_rtime.c
> +++ b/fs/jffs2/compr_rtime.c
> @@ -39,6 +39,9 @@ static int jffs2_rtime_compress(unsigned char *data_in,
>  
>  	memset(positions,0,sizeof(positions));
>  
> +	if (*dstlen < 2)
> +		return -1;
> +
>  	while (pos < (*sourcelen) && outpos <= (*dstlen)-2) {
>  		int backpos, runlen=0;
>  		unsigned char value;
> 

