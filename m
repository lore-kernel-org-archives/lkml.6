Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA608C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C75B208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C75B208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbeLCSYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:24:03 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:52898 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbeLCSYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:24:03 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 82954B9244584;
        Tue,  4 Dec 2018 02:23:54 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 4 Dec 2018
 02:23:47 +0800
Subject: Re: [PATCH 3/4] dma-debug: Dynamically expand the dma_debug_entry
 pool
To:     Robin Murphy <robin.murphy@arm.com>, <hch@lst.de>
References: <cover.1543856576.git.robin.murphy@arm.com>
 <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
CC:     <m.szyprowski@samsung.com>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <cai@gmx.us>,
        <salil.mehta@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a45fce07-3663-2a55-5b97-336002f21cdb@huawei.com>
Date:   Mon, 3 Dec 2018 18:23:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <f99ea022be92a99339404867bc925f4fbd2ee6c4.1543856576.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2018 17:28, Robin Murphy wrote:
> Certain drivers such as large multi-queue network adapters can use pools
> of mapped DMA buffers larger than the default dma_debug_entry pool of
> 65536 entries, with the result that merely probing such a device can
> cause DMA debug to disable itself during boot unless explicitly given an
> appropriate "dma_debug_entries=..." option.
>
> Developers trying to debug some other driver on such a system may not be
> immediately aware of this, and at worst it can hide bugs if they fail to
> realise that dma-debug has already disabled itself unexpectedly by the
> time the code of interest gets to run. Even once they do realise, it can
> be a bit of a pain to emprirically determine a suitable number of
> preallocated entries to configure without massively over-allocating.
>
> There's really no need for such a static limit, though, since we can
> quite easily expand the pool at runtime in those rare cases that the
> preallocated entries are insufficient, which is arguably the least
> surprising and most useful behaviour.

Hi Robin,

Do you have an idea on shrinking the pool again when the culprit driver 
is removed, i.e. we have so many unused debug entries now available?

Thanks,
John

>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  kernel/dma/debug.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index de5db800dbfc..46cc075aec99 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -47,6 +47,9 @@
>  #ifndef PREALLOC_DMA_DEBUG_ENTRIES
>  #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
>  #endif
> +/* If the pool runs out, try this many times to allocate this many new entries */
> +#define DMA_DEBUG_DYNAMIC_ENTRIES 256
> +#define DMA_DEBUG_DYNAMIC_RETRIES 2
>
>  enum {
>  	dma_debug_single,
> @@ -702,12 +705,21 @@ static struct dma_debug_entry *dma_entry_alloc(void)
>  {
>  	struct dma_debug_entry *entry;
>  	unsigned long flags;
> +	int retry_count;
>
> -	spin_lock_irqsave(&free_entries_lock, flags);
> +	for (retry_count = 0; ; retry_count++) {
> +		spin_lock_irqsave(&free_entries_lock, flags);
> +
> +		if (num_free_entries > 0)
> +			break;
>
> -	if (list_empty(&free_entries)) {
> -		global_disable = true;
>  		spin_unlock_irqrestore(&free_entries_lock, flags);
> +
> +		if (retry_count < DMA_DEBUG_DYNAMIC_RETRIES &&
> +		    !prealloc_memory(DMA_DEBUG_DYNAMIC_ENTRIES))
> +			continue;
> +
> +		global_disable = true;
>  		pr_err("debugging out of memory - disabling\n");
>  		return NULL;
>  	}
>


