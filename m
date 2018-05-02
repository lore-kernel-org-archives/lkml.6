Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeEBJuF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:50:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37743 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751731AbeEBJuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:50:01 -0400
X-Google-Smtp-Source: AB8JxZoPyMNPWDMNr8dsBOxk7JkXzmwuyqO3T3zZ6mA88KutI8D4AjsXhM9vGMfWjCDbIdslPMzDfg==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20180501132411.2311-1-michel@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <786ca83f-45c4-264b-2aef-d84fb18d3d28@gmail.com>
Date: Wed, 2 May 2018 11:49:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501132411.2311-1-michel@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 01.05.2018 um 15:24 schrieb Michel Dänzer:
> From: Michel Dänzer <michel.daenzer@amd.com>
>
> The result was printing the warning only when we were explicitly asked
> not to.
>
> Cc: stable@vger.kernel.org
> Fixes: 0176adb004065d6815a8e67946752df4cd947c5b "swiotlb: refactor
>   coherent buffer allocation"
> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>

Good catch, looked at the code multiple times and haven't seen that 
myself :)

Reviewed-by: Christian König <christian.koenig@amd.com>.

Christian.

> ---
>   lib/swiotlb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index c43ec2271469..e9ac21540628 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -750,7 +750,7 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
>   	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
>   			DMA_ATTR_SKIP_CPU_SYNC);
>   out_warn:
> -	if ((attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
> +	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
>   		dev_warn(dev,
>   			"swiotlb: coherent allocation failed, size=%zu\n",
>   			size);
