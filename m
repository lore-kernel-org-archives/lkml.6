Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFE7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486D720811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486D720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeLKLvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:51:18 -0500
Received: from foss.arm.com ([217.140.101.70]:45448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbeLKLvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:51:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B4D215AB;
        Tue, 11 Dec 2018 03:51:17 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08B9E3F6A8;
        Tue, 11 Dec 2018 03:51:15 -0800 (PST)
Subject: Re: [PATCH] dma-debug: fix soft lockup when a lot of debug are
 enabled
To:     Anders Roxell <anders.roxell@linaro.org>, hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20181211103616.22137-1-anders.roxell@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <613667c4-f850-d88c-7a2e-76dda5d966f5@arm.com>
Date:   Tue, 11 Dec 2018 11:51:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211103616.22137-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On 11/12/2018 10:36, Anders Roxell wrote:
> When running a kernel in qemu with enough debugging options (slub-debug,
> ftrace, kcov, kasan, ubsan, ...) enabled together, that results in a
> slow initcall. So a 'watchdog: BUG: soft lockup' happens:
> 
> [   44.105619] Call trace:
> [   44.106709]  __slab_alloc+0x70/0x88
> [   44.107757]  kmem_cache_alloc_trace+0x13c/0x590
> [   44.108764]  prealloc_memory+0xb8/0x240
> [   44.109768]  dma_debug_init+0x174/0x1f0
> [   44.110725]  do_one_initcall+0x430/0x8b0
> [   44.111719]  do_initcall_level+0x548/0x5b4
> [   44.112672]  do_initcalls+0x28/0x4c
> [   44.113628]  do_basic_setup+0x34/0x3c
> [   44.114559]  kernel_init_freeable+0x194/0x24c
> [   44.115570]  kernel_init+0x24/0x18c
> [   44.116498]  ret_from_fork+0x10/0x18
> 
> Rework to call cond_resched(), in the function prealloc_memory()'s
> for-loop.

Funnily enough I've just done a bit of work in this area which should 
make allocation a lot more efficient - would you mind giving this series 
a spin on the same setup to see how much it helps the performance?

https://lore.kernel.org/lkml/cover.1544447601.git.robin.murphy@arm.com/

Thanks,
Robin.

> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   kernel/dma/debug.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 231ca4628062..2abdc265aec4 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -767,6 +767,7 @@ static int prealloc_memory(u32 num_entries)
>   	int i;
>   
>   	for (i = 0; i < num_entries; ++i) {
> +		cond_resched();
>   		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>   		if (!entry)
>   			goto out_err;
> 
