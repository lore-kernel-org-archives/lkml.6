Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B88C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ADA20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lku0bWzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfAWHFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:05:16 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7957 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfAWHFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:05:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4812070000>; Tue, 22 Jan 2019 23:04:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 22 Jan 2019 23:05:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 Jan 2019 23:05:14 -0800
Received: from [10.24.242.22] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 23 Jan
 2019 07:05:05 +0000
Subject: Re: kmemleak panic
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
CC:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sachin Nikam <snikam@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>,
        <vdumpa@nvidia.com>, <praithatha@nvidia.com>
References: <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
 <20190119132832.GA29881@MBP.local>
 <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr>
 <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
 <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
 <20190121143704.GE29504@arrakis.emea.arm.com>
 <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
 <20190121174234.GC26461@rapoport-lnx>
 <2bb30550-435a-046c-4f45-21dd594aa695@free.fr>
 <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
 <20190123055414.GA4747@rapoport-lnx>
From:   Prateek Patel <prpatel@nvidia.com>
Message-ID: <5e5be6bc-5fc1-5def-d1b8-dc2fa4bbc93e@nvidia.com>
Date:   Wed, 23 Jan 2019 12:35:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190123055414.GA4747@rapoport-lnx>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548227079; bh=XqLNJAxvj6WFZ0l03Rch4zfDuGF6h7Hpt/ajtk8MdT4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=lku0bWzbbKgl/BPsCqUDjxTE2TnC1ob9pdgEtn+6Jtm1u7dIBWkn8PVY90ZM3bOPC
         d+fvQuIACpZjFfnH234D2avmPGKiThatt9vfEn9u2b+6xbw3L1aJ6B5mk3IWM8YTcJ
         6FPezTD7MQGb6JFC5GluCC/QpthvZ4jpM3pOZte1LczY1w5snU3uJpE1Es63CMErB2
         N+Lt3HKt45mVz71QvPOayMxuGNLrL7B1hz83s+TKOh8jQOk69ycLPUU2OgAfZ56dxN
         wN+B2fBcjXgkzW3LvIF3qf+U8Pps+gth9d+iV3f0NAxfcfFoeyC+CBn64cI3r10N23
         uRSKvpPBXjr1Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/23/2019 11:24 AM, Mike Rapoport wrote:
> On Tue, Jan 22, 2019 at 03:12:54PM +0100, Marc Gonzalez wrote:
>> On 22/01/2019 15:02, Marc Gonzalez wrote:
>>
>>> On 21/01/2019 18:42, Mike Rapoport wrote:
>>>
>>>> If I understood correctly, the trouble comes from no-map range allocated in
>>>> early_init_dt_alloc_reserved_memory_arch().
>>>>
>>>> There's indeed imbalance, because memblock_alloc() does kmemleak_alloc(), but
>>>> memblock_remove() does not do kmemleak_free().
>>>>
>>>> I think the best way is to replace __memblock_alloc_base() with
>>>> memblock_find_in_range(), e.g something like:
>>>>
>>>>
>>>> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
>>>> index 1977ee0adcb1..6807a1cffe55 100644
>>>> --- a/drivers/of/of_reserved_mem.c
>>>> +++ b/drivers/of/of_reserved_mem.c
>>>> @@ -37,21 +37,16 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>>>>   	 */
>>>>   	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
>>>>   	align = !align ? SMP_CACHE_BYTES : align;
>>>> -	base = __memblock_alloc_base(size, align, end);
>>>> +	base = memblock_find_in_range(size, align, start, end);
>>>>   	if (!base)
>>>>   		return -ENOMEM;
>>>>   
>>>> -	/*
>>>> -	 * Check if the allocated region fits in to start..end window
>>>> -	 */
>>>> -	if (base < start) {
>>>> -		memblock_free(base, size);
>>>> -		return -ENOMEM;
>>>> -	}
>>>> -
>>>>   	*res_base = base;
>>>>   	if (nomap)
>>>>   		return memblock_remove(base, size);
>>>> +	else
>>>> +		return memblock_reserve(base, size);
>>>> +
>>>>   	return 0;
>>>>   }
>>>>   
>>> Your patch solves the issue. \o/
> Great :)
>   
>> [ Add nvidia devs, but drop schowdary@nvidia.com ]
>>
> Resending it as a formal patch now, I took a liberty to add your Tested-by.
>
>  From a847ca684db29a3c09e4dd2a8a008b35cf36e52f Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Wed, 23 Jan 2019 07:38:50 +0200
> Subject: [PATCH] of: fix kmemleak crash caused by imbalance in early memory
>   reservation
>
> Marc Gonzalez reported the following kmemleak crash:
>
> Unable to handle kernel paging request at virtual address ffffffc021e00000
> Mem abort info:
>    ESR = 0x96000006
>    Exception class = DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
> Data abort info:
>    ISV = 0, ISS = 0x00000006
>    CM = 0, WnR = 0
> swapper pgtable: 4k pages, 39-bit VAs, pgdp = (____ptrval____)
> [ffffffc021e00000] pgd=000000017e3ba803, pud=000000017e3ba803,
> pmd=0000000000000000
> Internal error: Oops: 96000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 6 PID: 523 Comm: kmemleak Tainted: G S      W         5.0.0-rc1 #13
> Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
> pstate: 80000085 (Nzcv daIf -PAN -UAO)
> pc : scan_block+0x70/0x190
> lr : scan_block+0x6c/0x190
> sp : ffffff8012e8bd20
> x29: ffffff8012e8bd20 x28: ffffffc0fdbaf018
> x27: ffffffc022000000 x26: 0000000000000080
> x25: ffffff8011aadf70 x24: ffffffc0f8cc8000
> x23: ffffff8010dc8000 x22: ffffff8010dc8830
> x21: ffffffc021e00ff9 x20: ffffffc0f8cc8050
> x19: ffffffc021e00000 x18: 0000000000002409
> x17: 0000000000000200 x16: 0000000000000000
> x15: ffffff8010e14dd8 x14: 0000000000002406
> x13: 000000004c4dd0c6 x12: ffffffc0f77dad58
> x11: 0000000000000001 x10: ffffff8010d9e688
> x9 : ffffff8010d9f000 x8 : ffffff8010d9e688
> x7 : 0000000000000002 x6 : 0000000000000000
> x5 : ffffff8011511c20 x4 : 00000000000026d1
> x3 : ffffff8010e14d88 x2 : 5b36396f4e7d4000
> x1 : 0000000000208040 x0 : 0000000000000000
> Process kmemleak (pid: 523, stack limit = 0x(____ptrval____))
> Call trace:
>   scan_block+0x70/0x190
>   scan_gray_list+0x108/0x1c0
>   kmemleak_scan+0x33c/0x7c0
>   kmemleak_scan_thread+0x98/0xf0
>   kthread+0x11c/0x120
>   ret_from_fork+0x10/0x1c
> Code: f9000fb4 d503201f 97ffffd2 35000580 (f9400260)
> ---[ end trace 176d6ed9d86a0c33 ]---
> note: kmemleak[523] exited with preempt_count 2
>
> The crash happens when a no-map area is allocated in
> early_init_dt_alloc_reserved_memory_arch(). The allocated region is
> registered with kmemleak, but it is then removed from memblock using
> memblock_remove() that is not kmemleak-aware.
>
> Replacing __memblock_alloc_base() with memblock_find_in_range() makes sure
> that the allocated memory is not added to kmemleak and then
> memblock_remove()'ing this memory is safe.
>
> As a bonus, since memblock_find_in_range() ensures the allocation in the
> specified range, the bounds check can be removed.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---
>   drivers/of/of_reserved_mem.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 1977ee0adcb1..6807a1cffe55 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -37,21 +37,16 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
>   	 */
>   	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
>   	align = !align ? SMP_CACHE_BYTES : align;
> -	base = __memblock_alloc_base(size, align, end);
> +	base = memblock_find_in_range(size, align, start, end);
>   	if (!base)
>   		return -ENOMEM;
>   
> -	/*
> -	 * Check if the allocated region fits in to start..end window
> -	 */
> -	if (base < start) {
> -		memblock_free(base, size);
> -		return -ENOMEM;
> -	}
> -
>   	*res_base = base;
>   	if (nomap)
>   		return memblock_remove(base, size);
> +	else
> +		return memblock_reserve(base, size);
> +
>   	return 0;
>   }
>   

Thanks Mike for the patch. With this, skipping kmemleak scan: 
https://patchwork.ozlabs.org/patch/995367/ is not required.

