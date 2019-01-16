Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6749C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE5220675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404328AbfAPN11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:27:27 -0500
Received: from foss.arm.com ([217.140.101.70]:48240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732810AbfAPN10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:27:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1CB580D;
        Wed, 16 Jan 2019 05:27:25 -0800 (PST)
Received: from [10.162.42.129] (p8cg001049571a15.blr.arm.com [10.162.42.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99B543F70D;
        Wed, 16 Jan 2019 05:27:13 -0800 (PST)
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
To:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, mpe@ellerman.id.au, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com,
        peterz@infradead.org, christoffer.dall@arm.com,
        marc.zyngier@arm.com, kirill@shutemov.name,
        rppt@linux.vnet.ibm.com, ard.biesheuvel@linaro.org,
        mark.rutland@arm.com, steve.capper@arm.com, james.morse@arm.com,
        robin.murphy@arm.com, aneesh.kumar@linux.ibm.com, vbabka@suse.cz,
        shakeelb@google.com, rientjes@google.com, palmer@sifive.com,
        greentime@andestech.com
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
 <20190116124431.GK24149@dhcp22.suse.cz>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d074a7aa-9582-b95a-dce0-d95ac3d3c949@arm.com>
Date:   Wed, 16 Jan 2019 18:57:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190116124431.GK24149@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/16/2019 06:14 PM, Michal Hocko wrote:
> On Wed 16-01-19 04:30:18, Matthew Wilcox wrote:
>> On Wed, Jan 16, 2019 at 07:57:03AM +0100, Michal Hocko wrote:
>>> On Wed 16-01-19 11:51:32, Anshuman Khandual wrote:
>>>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>>>> __GFP_ZERO) and using it for allocating page table pages. This causes some
>>>> code duplication which can be easily avoided. GFP_KERNEL allocated and
>>>> cleared out pages (__GFP_ZERO) are required for page tables on any given
>>>> architecture. This creates a new generic GFP flag flag which can be used
>>>> for any page table page allocation. Does not cause any functional change.
>>>>
>>>> GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
>>>> generic page tabe header just to prevent it's potential misuse as a general
>>>> allocation flag if included in include/linux/gfp.h.
>>>
>>> I haven't reviewed the patch yet but I am wondering whether this is
>>> really worth it without going all the way down to unify the common code
>>> and remove much more code duplication. Or is this not possible for some
>>> reason?
>>
>> Exactly what I suggested doing in response to v1.
>>
>> Also, the approach taken here is crazy.  x86 has a feature that no other
>> architecture has bothered to implement yet -- accounting page tables
>> to the process.  Yet instead of spreading that goodness to all other
>> architectures, Anshuman has gone to more effort to avoid doing that.
> 
> Yes, I believe the only reason this is x86 only is that each arch would
> have to be tweaked separately. So a cleanup in _that_ regard would be
> helpful. There is no real reason to have ptes accounted only for x86.
> There might be some exceptions but well, our asm-generic allows to opt
> in for generic implementation or override it with a special one. The
> later should be an exception rather than the rule.

Fair enough. So we seem to have agreement over __GFP_ACCOUNT for user page
tables but not for the kernel. But should we accommodate __GFP_RETRY_MAYFAIL
or drop them altogether (including multi order allocation requests) ?
