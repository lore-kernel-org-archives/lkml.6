Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F4C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D898F20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D898F20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeINN5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:57:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58226 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeINN5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:57:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C75B18A;
        Fri, 14 Sep 2018 01:44:20 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.Emea.Arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 469933F703;
        Fri, 14 Sep 2018 01:44:19 -0700 (PDT)
Subject: Re: [RESEND PATCH v4 5/6] arm64/mm: Populate the swapper_pg_dir by
 fixmap.
To:     linux-arm-kernel@lists.infradead.org
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-6-yaojun8558363@gmail.com>
 <2bf9b9d1-271c-f85e-5a98-0eb74f2fedd9@arm.com> <20180910114153.GA10734@toy>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org
From:   James Morse <james.morse@arm.com>
Message-ID: <4a4303c6-36c3-9460-a167-d576e8a6351b@arm.com>
Date:   Fri, 14 Sep 2018 09:44:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910114153.GA10734@toy>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 10/09/18 12:41, Jun Yao wrote:
> On Fri, Sep 07, 2018 at 10:58:22AM +0100, James Morse wrote:
>> On 22/08/18 10:54, Jun Yao wrote:
>>>  	WRITE_ONCE(*pmdp, pmd);
>>>  	dsb(ishst);
>>>  }
>>> @@ -480,6 +511,19 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>>>  
>>>  static inline void set_pud(pud_t *pudp, pud_t pud)
>>>  {
>>> +#ifdef __PAGETABLE_PUD_FOLDED
>>> +	if (in_swapper_pgdir(pudp)) {
>>> +		pud_t *fixmap_pudp;
>>> +
>>> +		spin_lock(&swapper_pgdir_lock);
>>> +		fixmap_pudp = (pud_t *)pgd_set_fixmap(__pa(pudp));
>>
>> This is a bit subtle: are you using the pgd fixmap entry because the path from
>> map_mem() uses the other three?
>>
>> Using the pgd fix slot for a pud looks a bit strange to me, but its arguably a
>> side-effect of the folding.
> 
> Yes, it's a side-effect of the folding.
> 
> When the CONFIG_PGTABLE_LEVELS == 3, the pud is folded into the pgd. It
> means that the pgd is never none and it is also a pud. That's why I use
> the pgd fixmap entry.
> 
> Maybe write this more clearly:
> 
> static inline void set_pud(pud_t *pudp, pud_t pud)
> {
> #ifdef __PAGETABLE_PUD_FOLDED
> 	pgd_t *pgdp = (pgd_t *)pudp;
> 
> 	if (...) {
> 		pgd_t *fixmap_pgdp;
> 		pud_t *fixmap_pudp;
> 
> 		spin_lock(...);
> 		fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
> 		fixmap_pudp = pud_set_fixmap_offset(fixmap_pgdp, 0UL);

Using two fixmap entries is excessive, this is behind __PAGETABLE_PUD_FOLDED, so
we should know what is going on.

(The folding confuses me every time I look at it)


> Do you have any way to make it look more reasonable?

I'm just reacting to a function with 'pud' in the name, that takes two pud's as
arguments, using the pgd fixmap slot. I think its fine to leave it like this, as
in_swapper_pg_dir() has told us this is the pgd we're dealing with, it just
looks funny.


>> I see this called 68 times during boot on a 64K/42bit-VA, 65 of which appear to
>> be during paging_init(). What do you think to keeping paging_init()s use of the
>> pgd fixmap for swapper_pg_dir, deliberately to skip the in_swapper_pgdir() test
>> during paging_init()?
> 
> I think the set_pud() should not be called on a 64K/42bit-VA. As only
> the level 2 and level 3 page tables are in use. It means that the pmd is
> folded into the pud and the pud is never none. So the set_pud() should
> not be called.

(yes, sorry, it was just the one I picked on!)


> I think a variable can be introduced to indicate whether paging_init()
> has been completed. And decide whether or not to skip the
> in_swapper_pgdir() base on the value of it.
> 
> I don't know if this is reasonable. What do you think?

I think we can just trick in_swapper_pgdir(), this code only runs once, and its
already in a very strange environment.


Thanks,

James
