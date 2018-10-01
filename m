Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7E4C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E962064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E962064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbeJARSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:18:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46728 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbeJARSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:18:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADADC18A;
        Mon,  1 Oct 2018 03:41:42 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.Emea.Arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FB573F5B3;
        Mon,  1 Oct 2018 03:41:41 -0700 (PDT)
Subject: Re: [PATCH v5 5/6] arm64/mm: Populate the swapper_pg_dir by fixmap.
To:     Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-6-yaojun8558363@gmail.com>
 <20180924163619.rx7bae67i5isq2fy@lakrids.cambridge.arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <24c91d6c-85c8-afb4-74d1-202e4d780ab6@arm.com>
Date:   Mon, 1 Oct 2018 11:41:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924163619.rx7bae67i5isq2fy@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 24/09/18 17:36, Mark Rutland wrote:
> On Mon, Sep 17, 2018 at 12:43:32PM +0800, Jun Yao wrote:
>> Since we will move the swapper_pg_dir to rodata section, we need a
>> way to update it. The fixmap can handle it. When the swapper_pg_dir
>> needs to be updated, we map it dynamically. The map will be
>> canceled after the update is complete. In this way, we can defend
>> against KSMA(Kernel Space Mirror Attack).

>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 71532bcd76c1..a8a60927f716 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -67,6 +67,24 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
>>  static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>>  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>>  
>> +static DEFINE_SPINLOCK(swapper_pgdir_lock);
>> +
>> +void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>> +{
>> +	pgd_t *fixmap_pgdp;
>> +
>> +	spin_lock(&swapper_pgdir_lock);
>> +	fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
>> +	WRITE_ONCE(*fixmap_pgdp, pgd);
>> +	/*
>> +	 * We need dsb(ishst) here to ensure the page-table-walker sees
>> +	 * our new entry before set_p?d() returns. The fixmap's
>> +	 * flush_tlb_kernel_range() via clear_fixmap() does this for us.
>> +	 */
>> +	pgd_clear_fixmap();
>> +	spin_unlock(&swapper_pgdir_lock);
>> +}
> 
> I'm rather worried that we could deadlock here.

We can use the irqsave versions if you're worried, but I think any code doing
this is already broken.

(I'd like to eventually depend on the init_mm.page_table_lock for this, but it
isn't held when the vmemmap is being populated.)


> Are we certain we never poke the kernel page tables in IRQ context?

The RAS code was doing this, but was deemed unsafe, and changed to use the
fixmap: https://lkml.org/lkml/2017/10/30/500
The fixmap only ever touches the last level, so can't hit this.

x86 can't do its IPI tlb-maintenance from IRQ context, so anything trying to
unmap from irq context is already broken: https://lkml.org/lkml/2018/9/6/324

vunmap()/vfree() is allowed from irq context, but it defers its work.

I can't find any way to pass GFP_ATOMIC into ioremap(),
I didn't think vmalloc() could either, ...  but now I spot __vmalloc() does...

This __vmalloc() path is used by the percpu allocator, which starting from
pcpu_alloc() can be passed something other than GFP_KERNEL, and uses
spin_lock_irqsave(), so it is expecting to be called in irq context.

... so yes it looks like this can happen.

I'll post a fix


Thanks!

James
