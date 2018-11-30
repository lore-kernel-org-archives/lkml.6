Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AC6C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A80C20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A80C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeLAGuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:50:14 -0500
Received: from foss.arm.com ([217.140.101.70]:35646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbeLAGuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:50:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C213165C;
        Fri, 30 Nov 2018 11:39:53 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1086C3F575;
        Fri, 30 Nov 2018 11:39:51 -0800 (PST)
Subject: Re: [PATCH] dma-debug: Kconfig for PREALLOC_DMA_DEBUG_ENTRIES
To:     Qian Cai <cai@gmx.us>, hch@lst.de, m.szyprowski@samsung.com
Cc:     netdev@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        yisen.zhuang@huawei.com
References: <20181130175449.2625-1-cai@gmx.us>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b22d2ad6-2638-96d7-1df2-24701589202f@arm.com>
Date:   Fri, 30 Nov 2018 19:39:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130175449.2625-1-cai@gmx.us>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 17:54, Qian Cai wrote:
> The amount of DMA mappings from Hisilicon HNS ethernet devices is huge,
> so it could trigger "DMA-API: debugging out of memory - disabling".
> 
> hnae_get_handle [1]
>    hnae_init_queue
>      hnae_init_ring
>        hnae_alloc_buffers [2]
>          debug_dma_map_page
>            dma_entry_alloc
> 
> [1] for (i = 0; i < handle->q_num; i++)
> [2] for (i = 0; i < ring->desc_num; i++)
> 
> On this Huawei TaiShan 2280 aarch64 server, it has reached the limit
> already,
> 
> 4 (ports) x 16 (handles) x 1024 (rings) = 65536
> 
> Added a Kconfig entry for PREALLOC_DMA_DEBUG_ENTRIES, so make it easier
> for users to deal with special cases like this.
> 
> Signed-off-by: Qian Cai <cai@gmx.us>
> ---
>   kernel/dma/debug.c | 9 ++-------
>   lib/Kconfig.debug  | 9 +++++++++
>   2 files changed, 11 insertions(+), 7 deletions(-)

Oh, right, the arch overrides actually got cleaned up already. I'd 
forgotten that...

> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 231ca4628062..3752fb23f72f 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -41,11 +41,6 @@
>   #define HASH_FN_SHIFT   13
>   #define HASH_FN_MASK    (HASH_SIZE - 1)
>   
> -/* allow architectures to override this if absolutely required */
> -#ifndef PREALLOC_DMA_DEBUG_ENTRIES
> -#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
> -#endif
> -
>   enum {
>   	dma_debug_single,
>   	dma_debug_page,
> @@ -132,7 +127,7 @@ static u32 min_free_entries;
>   static u32 nr_total_entries;
>   
>   /* number of preallocated entries requested by kernel cmdline */
> -static u32 nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
> +static u32 nr_prealloc_entries = CONFIG_PREALLOC_DMA_DEBUG_ENTRIES;
>   
>   /* debugfs dentry's for the stuff above */
>   static struct dentry *dma_debug_dent        __read_mostly;
> @@ -1063,7 +1058,7 @@ static __init int dma_debug_entries_cmdline(char *str)
>   	if (!str)
>   		return -EINVAL;
>   	if (!get_option(&str, &nr_prealloc_entries))
> -		nr_prealloc_entries = PREALLOC_DMA_DEBUG_ENTRIES;
> +		nr_prealloc_entries = CONFIG_PREALLOC_DMA_DEBUG_ENTRIES;
>   	return 0;
>   }
>   
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af29b8224fd..2c281edcb5ad 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1659,6 +1659,15 @@ config DMA_API_DEBUG
>   
>   	  If unsure, say N.
>   
> +config PREALLOC_DMA_DEBUG_ENTRIES
> +	int "Preallocated DMA-API debugging entries"
> +	depends on DMA_API_DEBUG
> +	default 65536

I was assuming the point was to also add something like

	default 131072 if HNS_ENET

so that DMA debug doesn't require too much thought from the user. If 
they still have to notice the overflow message and empirically figure 
out a value that does work, rebuilding the kernel each time is far less 
convenient than simply adding "dma_debug_entries=..." to their kernel 
command line and rebooting, which they can do today. If they do already 
know up-front that the default will need overriding and what the 
appropriate value is, then the command line still seems seems just as 
convenient.

Robin.

> +	help
> +	  The number of preallocated entries for DMA-API debugging code. One
> +	  entry is required per DMA-API allocation. Increase this if the DMA-API
> +	  debugging code disables itself because the default is too low.
> +
>   config DMA_API_DEBUG_SG
>   	bool "Debug DMA scatter-gather usage"
>   	default y
> 
