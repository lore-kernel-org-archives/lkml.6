Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C22C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A05852083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 20:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05852083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388353AbeKGFri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:47:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40688 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbeKGFri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:47:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30D91EBD;
        Tue,  6 Nov 2018 12:20:41 -0800 (PST)
Received: from [192.168.1.123] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CFB93F718;
        Tue,  6 Nov 2018 12:20:38 -0800 (PST)
Subject: Re: IOMMU breakage on arm64
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>
References: <git-mailbomb-linux-master-b4ebe6063204da58e48600b810a97c29ae9e5d12@kernel.org>
 <CAMuHMdUosqWTn5yDjGMWrLpWEyZfxtGWYfqmenYVqE8g7HEt7Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <44b77976-0efe-02d0-3c4e-4e54f91c4fe7@arm.com>
Date:   Tue, 6 Nov 2018 20:20:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUosqWTn5yDjGMWrLpWEyZfxtGWYfqmenYVqE8g7HEt7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 2018-11-06 7:44 pm, Geert Uytterhoeven wrote:
> Hi Christoph et al,
> 
> On Tue, Oct 23, 2018 at 1:40 AM Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
>> Commit:     b4ebe6063204da58e48600b810a97c29ae9e5d12
>> Parent:     7d21ee4c719f00896767ce19c4c01a56374c2ced
>> Refname:    refs/heads/master
>> Web:        https://git.kernel.org/torvalds/c/b4ebe6063204da58e48600b810a97c29ae9e5d12
>> Author:     Christoph Hellwig <hch@lst.de>
>> AuthorDate: Thu Sep 20 14:04:08 2018 +0200
>> Committer:  Christoph Hellwig <hch@lst.de>
>> CommitDate: Mon Oct 1 07:28:03 2018 -0700
>>
>>      dma-direct: implement complete bus_dma_mask handling
>>
>>      Instead of rejecting devices with a too small bus_dma_mask we can handle
>>      by taking the bus dma_mask into account for allocations and bounce
>>      buffering decisions.
>>
>>      Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> I  have bisected the following crash to the above commit:

I think that commit mostly just changes the presentation of my 
underlying cockup - see here for what should fix it: 
https://patchwork.kernel.org/patch/10670177/

I have a feeling we've ironed out crash-on-early-domain-free bugs in the 
SMMU drivers already - arm-smmu certainly has an early return in 
arm_smmu_destroy_domain_context() which should behave exactly like your 
diff below, while I think arm-smmu-v3 gets away with it by virtue of 
smmu_domain->cfg being unset, but I'll double-check that when I'm fresh 
tomorrow (Jean-Philippe reported SMMUv3 hitting the DMA thing to me 
internally, but didn't mention any crash).

Thanks for the report,
Robin.

>      ipmmu-vmsa e67b0000.mmu: Cannot accommodate DMA translation for
> IOMMU page tables
>      sata_rcar ee300000.sata: Unable to initialize IPMMU context
>      iommu: Failed to add device ee300000.sata to group 0: -22
>      Unable to handle kernel NULL pointer dereference at virtual
> address 0000000000000038
>      Mem abort info:
>        ESR = 0x96000004
>        Exception class = DABT (current EL), IL = 32 bits
>        SET = 0, FnV = 0
>        EA = 0, S1PTW = 0
>      Data abort info:
>        ISV = 0, ISS = 0x00000004
>        CM = 0, WnR = 0
>      [0000000000000038] user address but active_mm is swapper
>      Internal error: Oops: 96000004 [#1] PREEMPT SMP
>      CPU: 2 PID: 51 Comm: kworker/2:1 Not tainted
> 4.20.0-rc1-arm64-renesas-dirty #74
>      Hardware name: Renesas Salvator-X 2nd version board based on
> r8a7795 ES2.0+ (DT)
>      Workqueue: events deferred_probe_work_func
>      pstate: 60000005 (nZCv daif -PAN -UAO)
>      pc : ipmmu_domain_free+0x1c/0xa0
>      lr : ipmmu_domain_free+0x14/0xa0
>      sp : ffff000009c9b990
>      x29: ffff000009c9b990 x28: 0000000000000000
>      x27: ffff000008dff000 x26: 0000000000000000
>      x25: ffff000008dd9000 x24: 0000000000000014
>      x23: ffff8006fffdbb20 x22: ffff000008dff000
>      x21: ffff8006f898e680 x20: ffff8006f8fa6c00
>      x19: ffff8006f8fa6c08 x18: 0000000000000037
>      x17: 0000000000000020 x16: ffff000008a8f780
>      x15: ffff8006fb096f10 x14: ffff8006f93731c8
>      x13: 0000000000000000 x12: ffff8006fb096f10
>      x11: ffff8006f9372fe8 x10: ffff000008dff708
>      x9 : ffff8006fb096f50 x8 : ffff000008dff708
>      x7 : ffff0000089f1858 x6 : 0000000000000000
>      x5 : 0000000000000000 x4 : ffff8006f89a3000
>      x3 : 00008006f7131000 x2 : ffff8006fb2b5700
>      x1 : 0000000000000000 x0 : 0000000000000028
>      Process kworker/2:1 (pid: 51, stack limit = 0x(____ptrval____))
>      Call trace:
>       ipmmu_domain_free+0x1c/0xa0
>       iommu_group_release+0x48/0x68
>       kobject_put+0x74/0xe8
>       kobject_del.part.0+0x3c/0x50
>       kobject_put+0x60/0xe8
>       iommu_group_get_for_dev+0xa8/0x1f0
>       ipmmu_add_device+0x1c/0x40
>       of_iommu_configure+0x118/0x190
>       of_dma_configure+0xcc/0x1f0
>       platform_dma_configure+0x18/0x28
>       really_probe+0x94/0x2a8
>       driver_probe_device+0x58/0x100
>       __device_attach_driver+0x90/0xd0
>       bus_for_each_drv+0x64/0xc8
>       __device_attach+0xd8/0x130
>       device_initial_probe+0x10/0x18
>       bus_probe_device+0x98/0xa0
>       deferred_probe_work_func+0x74/0xb0
>       process_one_work+0x294/0x6f0
>       worker_thread+0x238/0x460
>       kthread+0x120/0x128
>       ret_from_fork+0x10/0x1c
>      Code: aa0003f3 97ffeb1a d1002274 f85f8261 (f9401c20)
>      ---[ end trace 4c46c7fd7cd07245 ]---
> 
> Reproducing on v4.20-rc1 requires CONFIG_IPMMU_VMSA=y, and whitelisting
> SATA for IOMMU use (https://patchwork.kernel.org/patch/10544059/).
> For older versions you also have to backport commit 3a0832d093693ede ("arm64:
> dts: renesas: salvator-xs: enable SATA").
> 
> Actually there are two issues at hand:
> 
> 1) drivers/iommu/io-pgtable-arm.c:__arm_lpae_alloc_pages() allocates
>     memory (above 4 GiB) and maps it for DMA use, but it is rejected due
>     to:
> 
>         dma_map_single(dev, pages, size, DMA_TO_DEVICE) != virt_to_phys(pages)
> 
>> --- a/include/linux/dma-direct.h
>> +++ b/include/linux/dma-direct.h
>> @@ -27,7 +27,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
>>          if (!dev->dma_mask)
>>                  return false;
>>
>> -       return addr + size - 1 <= *dev->dma_mask;
>> +       return addr + size - 1 <=
>> +               min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
> 
>         *dev->dma_mask = 0xffffffffff (40-bit)
>         dev->bus_dma_mask = 0xffffffff (32-bit)
> 
>     Hence before, we had (in __arm_lpae_alloc_pages()):
> 
>         arm-lpae io-pgtable: pages = ffff8006f88f3000
>         arm-lpae io-pgtable: dma = 0x00000007388f3000
>         arm-lpae io-pgtable: virt_to_phys(pages) = 0x00000007388f3000
> 
>     After this change, we have:
> 
>         arm-lpae io-pgtable: pages = ffff8006f882b000
>         arm-lpae io-pgtable: dma = 0x0000000074009000
>         arm-lpae io-pgtable: virt_to_phys(pages) = 0x000000073882b000
> 
>     And SATA runs without using the IOMMU.
> 
> 2) The Renesas IPMMU driver doesn't handle the above failure well,
>     leading to a NULL pointer dereference.
>     This can be fixed using the (gmail-whitespace-damaged) patch below:
> 
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -635,7 +635,8 @@ static void ipmmu_domain_free(struct iommu_domain
> *io_domain)
>           * been detached.
>           */
>          iommu_put_dma_cookie(io_domain);
> -       ipmmu_domain_destroy_context(domain);
> +       if (domain->mmu)
> +               ipmmu_domain_destroy_context(domain);
>          free_io_pgtable_ops(domain->iop);
>          kfree(domain);
>   }
> 
>     I expect drivers/iommu/arm-smmu-v3.c and drivers/iommu/arm-smmu.c
>     need similar fixes.
>     I didn't check all drivers, but e.g. drivers/iommu/amd_iommu.c has
> a similar check.
> 
> Does the IOMMU work on other arm64 platforms in v4.20-rc1?
> 
> Thanks for your comments!
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
