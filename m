Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B8BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46F52175F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46F52175F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933509AbeFUREg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:04:36 -0400
Received: from foss.arm.com ([217.140.101.70]:52708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933429AbeFUREf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:04:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF2AD1435;
        Thu, 21 Jun 2018 10:04:34 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E1B53F557;
        Thu, 21 Jun 2018 10:04:33 -0700 (PDT)
Subject: Re: [PATCH 1/1] arm64/mm: move
 {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata section
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jun Yao <yaojun8558363@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <20180620085755.20045-1-yaojun8558363@gmail.com>
 <20180620085755.20045-2-yaojun8558363@gmail.com>
 <CAKv+Gu8_=uTJFDXr0GpGMc=9WZ9tbz305CE6i=qbnqRB=suRVA@mail.gmail.com>
 <20180621025141.GB11276@toy>
 <CAKv+Gu_3Cfuq-qQuRHkYCB2uTPOK=KVeVh4OKmtu2MDYwfOtTA@mail.gmail.com>
 <70ebe6d7-0745-5606-ae89-8a7b2fb62008@arm.com>
 <CAKv+Gu-t5ErL89J=sxeVRYzDNrB1Ejdj+XOggAMWk-gY7ewsOg@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <67a238a8-e4db-6bf1-6da5-62ca9536191f@arm.com>
Date:   Thu, 21 Jun 2018 18:04:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-t5ErL89J=sxeVRYzDNrB1Ejdj+XOggAMWk-gY7ewsOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On 21/06/18 10:29, Ard Biesheuvel wrote:
> On 21 June 2018 at 10:59, James Morse <james.morse@arm.com> wrote:
>> On 21/06/18 07:39, Ard Biesheuvel wrote:
>>> On 21 June 2018 at 04:51, Jun Yao <yaojun8558363@gmail.com> wrote:
>>>> On Wed, Jun 20, 2018 at 12:09:49PM +0200, Ard Biesheuvel wrote:
>>>>> On 20 June 2018 at 10:57, Jun Yao <yaojun8558363@gmail.com> wrote:
>>>>>> Move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata
>>>>>> section. And update the swapper_pg_dir by fixmap.
>>>>>
>>>>> I think we may be able to get away with not mapping idmap_pg_dir and
>>>>> tramp_pg_dir at all.
>>>>
>>>> I think we need to move tramp_pg_dir to .rodata. The attacker can write
>>>> a block-mapping(AP=01) to tramp_pg_dir and then he can access kernel
>>>> memory.
>>
>>> Why does it need to be mapped at all? When do we ever access it from the code?
>>
>> (We would want to make its fixmap entry read-only too)
> 
> It already is.

Sorry, I missed that,


>>>>> As for swapper_pg_dir, it would indeed be nice if we could keep those
>>>>> mappings read-only most of the time, but I'm not sure how useful this
>>>>> is if we apply it to the root level only.
>>>>
>>>> The purpose of it is to make 'KSMA' harder, where an single arbitrary
>>>> write is used to add a block mapping to the page-tables, giving the
>>>> attacker full access to kernel memory. That's why we just apply it to
>>>> the root level only. If the attacker can arbitrary write multiple times,
>>>> I think it's hard to defend.
>>>
>>> So the assumption is that the root level is more easy to find?
>>> Otherwise, I'm not sure I understand why being able to write a level 0
>>> entry is so harmful, given that we don't have block mappings at that
>>> level.
>>
>> I think this thing assumes 3-level page tables with 39bit VA.

> The attack, you mean? Because this code is unlikely to build with that
> configuration, given that __pgd_populate() BUILD_BUG()s in that case.

Yes, the attack. (I struggle to think of it as an 'attack' because you already
have arbitrary write...)


>>>>> @@ -417,12 +421,22 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
>>>>>>
>>>>>>  void __init mark_linear_text_alias_ro(void)
>>>>>>  {
>>
>>>>>> +       size = (unsigned long)__init_begin - (unsigned long)swapper_pg_end;
>>>>>> +       update_mapping_prot(__pa_symbol(swapper_pg_end),
>>>>>> +                           (unsigned long)lm_alias(swapper_pg_end),
>>>>>> +                           size, PAGE_KERNEL_RO);
>>>>>
>>>>> I don't think this is necessary. Even if some pages are freed, it
>>>>> doesn't harm to keep a read-only alias of them here since the new
>>>>> owner won't access them via this mapping anyway. So we can keep
>>>>> .rodata as a single region.
>>>>
>>>> To be honest, I didn't think of this issue at first. I later found a
>>>> problem when testing the code on qemu:
>>>
>>> OK, you're right. I missed the fact that this operates on the linear
>>> alias, not the kernel mapping itself.
>>>
>>> What I don't like is that we lose the ability to use block mappings
>>> for the entire .rodata section this way. Isn't it possible to move
>>> these pgdirs to the end of the .rodata segment, perhaps by using a
>>> separate input section name and placing that explicitly? We could even
>>> simply forget about freeing those pages, given that [on 4k pages] the
>>> benefit of freeing 12 KB of space is likely to get lost in the
>>> rounding noise anyway [segments are rounded up to 64 KB in size]
>>
>> I assumed that to move swapper_pg_dir into the .rodata section we would need to
>> break it up. Today its ~3 levels, which we setup in head.S, then do a dance in
>> paging_init() so that swapper_pg_dir is always the top level.
>>
>> We could generate all leves of the 'init_pg_dir' in the __initdata section, then
>> copy only the top level into swapper_pg_dir into the rodata section during
>> paging_init().

> Is that complexity truly justified for a security sensitive piece of
> code?

Wouldn't this be less complex? (I've probably explained it badly.)

Today head.S builds the initial page tables in ~3 levels of swapper_pg_dir, then
during paging_init() build new tables with a temporary top level.
We switch to the temporary top level, then copy over the first level of
swapper_pg_dir, then switch back to swapper_pg_dir. Finally we free the
no-longer-used levels of swapper_pg_dir.

This looks like re-inventing __initdata for the bits of page table we eventually
free.

What I tried to describe is building the head.S/initial-page-tables in a
reserved area of the the __initdata section. We no longer need a temporary
top-level, we can build the final page tables directly in swapper_pg_dir, which
means one fewer rounds of cpu_replace_ttbr1().


> Can't we just drop the memblock_free() and be done with it?

That works, I assumed it would be at least frowned on!


Thanks,

James
