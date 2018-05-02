Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeEBMS7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:18:59 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38172 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751138AbeEBMS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:18:58 -0400
X-Google-Smtp-Source: AB8JxZoLwHK7U78Zzsz+NdOUTOKSQf8zHIVokcazXha1IHvkuc8aiUAgQoPdawp2YQiOBhd4M3VyyYiD20394Qm/vE8=
MIME-Version: 1.0
X-Originating-IP: [2a02:168:5635:0:39d2:f87e:2033:9f6]
In-Reply-To: <786ca83f-45c4-264b-2aef-d84fb18d3d28@gmail.com>
References: <20180501132411.2311-1-michel@daenzer.net> <786ca83f-45c4-264b-2aef-d84fb18d3d28@gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 2 May 2018 14:18:56 +0200
X-Google-Sender-Auth: s-ZrYJvRHkSdTeUj8kHKc2kfptk
Message-ID: <CAKMK7uH2+v3_UUqXdCjz_8=H4VRt1zB+dgE99PuuPqd+XM2=-w@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w42CJ3C3014028

On Wed, May 2, 2018 at 11:49 AM, Christian König
<ckoenig.leichtzumerken@gmail.com> wrote:
> Am 01.05.2018 um 15:24 schrieb Michel Dänzer:
>>
>> From: Michel Dänzer <michel.daenzer@amd.com>
>>
>> The result was printing the warning only when we were explicitly asked
>> not to.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 0176adb004065d6815a8e67946752df4cd947c5b "swiotlb: refactor
>>   coherent buffer allocation"
>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
>
>
> Good catch, looked at the code multiple times and haven't seen that myself
> :)
>
> Reviewed-by: Christian König <christian.koenig@amd.com>.

Other dma-api backends like cma just shut up when __GFP_NOWARN is
passed. And afaiui Christoph Hellwig has plans to nuke the DMA_ATTR
stuff (or at least clean it up) - should we just remove
DMA_ATTR_NO_WARN and instead only look at __GFP_NOWARN?

For context the CMA patch:

commit ef4650144e76ae361fe4b8c9a0afcd53074cd520
Author: Boris Brezillon <boris.brezillon@free-electrons.com>
Date:   Fri Oct 13 15:58:01 2017 -0700

    mm/cma.c: take __GFP_NOWARN into account in cma_alloc()

Or maybe we should at least enforce that both or none are set, for
consistency for now?

Cheers, Daniel


>
> Christian.
>
>> ---
>>   lib/swiotlb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
>> index c43ec2271469..e9ac21540628 100644
>> --- a/lib/swiotlb.c
>> +++ b/lib/swiotlb.c
>> @@ -750,7 +750,7 @@ swiotlb_alloc_buffer(struct device *dev, size_t size,
>> dma_addr_t *dma_handle,
>>         swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
>>                         DMA_ATTR_SKIP_CPU_SYNC);
>>   out_warn:
>> -       if ((attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
>> +       if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit()) {
>>                 dev_warn(dev,
>>                         "swiotlb: coherent allocation failed, size=%zu\n",
>>                         size);
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
