Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D244AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B5420868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B5420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeK3UZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:25:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbeK3UZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:25:13 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 41CB1F8FF158C;
        Fri, 30 Nov 2018 17:16:27 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Fri, 30 Nov 2018
 17:16:18 +0800
Subject: Re: [PATCH] dma-debug: hns_enet_drv could use more DMA entries
To:     Christoph Hellwig <hch@lst.de>, Qian Cai <cai@gmx.us>
References: <20181130035456.1586-1-cai@gmx.us> <20181130084203.GA19812@lst.de>
CC:     <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <netdev@vger.kernel.org>,
        <yisen.zhuang@huawei.com>, Linuxarm <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <23da2426-a397-a33c-cfd8-dba7b3c1aaee@huawei.com>
Date:   Fri, 30 Nov 2018 09:16:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181130084203.GA19812@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+

Pasting original message at bottom.


On 30/11/2018 08:42, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018 at 10:54:56PM -0500, Qian Cai wrote:
>>  /* allow architectures to override this if absolutely required */
>>  #ifndef PREALLOC_DMA_DEBUG_ENTRIES
>> +/* amount of DMA mappings on this driver is huge. */
>> +#ifdef	HNS_ENET
>> +#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 17)
>> +#else
>>  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>>  #endif
>> +#endif
>
> How would this be defined in a header that leaks into this file?
>
> I think we need to turn PREALLOC_DMA_DEBUG_ENTRIES into a user
> selectable config options, as I really don't want to collect hacks like
> this.
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
>







The amount of DMA mappings from Hisilicon HNS ethernet devices is huge,
so it could trigger "DMA-API: debugging out of memory - disabling".

hnae_get_handle [1]
   hnae_init_queue
     hnae_init_ring
       hnae_alloc_buffers [2]
         debug_dma_map_page
           dma_entry_alloc

[1] for (i = 0; i < handle->q_num; i++)
[2] for (i = 0; i < ring->desc_num; i++)

On this Huawei TaiShan 2280 aarch64 server, it has reached the limit
already,

4 (ports) x 16 (handles) x 1024 (rings) = 65536

Signed-off-by: Qian Cai <cai@gmx.us>
---
  kernel/dma/debug.c | 5 +++++
  1 file changed, 5 insertions(+)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 231ca4628062..ae91689cc9ad 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -43,8 +43,13 @@

  /* allow architectures to override this if absolutely required */
  #ifndef PREALLOC_DMA_DEBUG_ENTRIES
+/* amount of DMA mappings on this driver is huge. */
+#ifdef	HNS_ENET
+#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 17)
+#else
  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
  #endif
+#endif

  enum {
  	dma_debug_single,


