Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C322C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FF323FD2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0FF323FD2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeGFOlM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:41:12 -0400
Received: from foss.arm.com ([217.140.101.70]:37882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932714AbeGFOlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:41:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAFB5ED1;
        Fri,  6 Jul 2018 07:41:10 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9C43F2EA;
        Fri,  6 Jul 2018 07:41:09 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] arm64/mm: Create initial page tables in
 init_pg_dir
From:   James Morse <james.morse@arm.com>
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-4-yaojun8558363@gmail.com>
 <3977afaa-63ae-e390-7660-4d25146140b8@arm.com>
Message-ID: <41a18121-c91d-f9ec-87c3-8dba7931b517@arm.com>
Date:   Fri, 6 Jul 2018 15:41:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <3977afaa-63ae-e390-7660-4d25146140b8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 06/07/18 09:58, James Morse wrote:
> The series so far fails to boot from me. This is because the kaslr code tries to
> read the kaslr-seed from the DT, via the fixmap. To do this, it needs the fixmap
> tables installed, which early_fixmap_init() does.
> 
> early_fixmap_init() calls pgd_offset_k(), which assumes init_mm.pgd is in use,
> so we hit a BUG_ON() when trying to setup the fixmap because we added the tables
> to the wrong page tables.
> 
> If you enable 'CONFIG_RANDOMIZE_BASE', even without EFI you should see the same
> thing happen.
> 
> 
> I think we should move this hunk:
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 30ad2f085d1f..b065c08d4008 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -249,6 +249,7 @@ void __init setup_arch(char **cmdline_p)
>>  	init_mm.end_code   = (unsigned long) _etext;
>>  	init_mm.end_data   = (unsigned long) _edata;
>>  	init_mm.brk	   = (unsigned long) _end;
>> +	init_mm.pgd	   = init_pg_dir;
>>
>>  	*cmdline_p = boot_command_line;
>>
> 
> into early_fixmap_init(), which is the first thing setup_arch() calls.
> Something like [0] fixes it.
> 
> This looks to be the only thing that goes near init_mm.pgd before paging_init().

I missed one: head.S has a call to kasan_early_init() before start_kernel(),
this goes messing with the page tables, and calls pgd_offset_k(), which pulls in
swapper_pg_dir. This one is enabled by CONFIG_KASAN.

Something like that same hunk [0] in kasan_early_init() fixes it. This is still
within arch/arm64, so I still think we should get away without some #ifdeffery
to override the core-code's initial setup of swapper_pg_dir...

Thanks,

James


> [0] make sure fixmap tables go in the init page tables
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 117d080639b3..e097c78a66f8 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -770,6 +771,13 @@ void __init early_fixmap_init(void)
>         pmd_t *pmdp;
>         unsigned long addr = FIXADDR_START;
> 
> +       /*
> +        * During early setup we use init_pg_dir, update init_mm so its
> +        * implicit use by pgd_offset_k() gets the live page tables.
> +        * swapper_pg_dir is restored by paging_init().
> +        */
> +       init_mm.pgd = init_pg_dir;
> +
>         pgdp = pgd_offset_k(addr);
>         pgd = READ_ONCE(*pgdp);
>         if (CONFIG_PGTABLE_LEVELS > 3 &&
> 
> 
> 

