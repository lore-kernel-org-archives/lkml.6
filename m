Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01E5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B470F206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393033AbfAPNMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:12:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47878 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390336AbfAPNMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:12:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61DE080D;
        Wed, 16 Jan 2019 05:12:33 -0800 (PST)
Received: from [10.162.42.129] (p8cg001049571a15.blr.arm.com [10.162.42.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89A743F70D;
        Wed, 16 Jan 2019 05:12:22 -0800 (PST)
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <07d6a264-dccd-78ab-e8a9-2410bbef7b97@arm.com>
Date:   Wed, 16 Jan 2019 18:42:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190116123018.GF6310@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/16/2019 06:00 PM, Matthew Wilcox wrote:
> On Wed, Jan 16, 2019 at 07:57:03AM +0100, Michal Hocko wrote:
>> On Wed 16-01-19 11:51:32, Anshuman Khandual wrote:
>>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>>> __GFP_ZERO) and using it for allocating page table pages. This causes some
>>> code duplication which can be easily avoided. GFP_KERNEL allocated and
>>> cleared out pages (__GFP_ZERO) are required for page tables on any given
>>> architecture. This creates a new generic GFP flag flag which can be used
>>> for any page table page allocation. Does not cause any functional change.
>>>
>>> GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
>>> generic page tabe header just to prevent it's potential misuse as a general
>>> allocation flag if included in include/linux/gfp.h.
>>
>> I haven't reviewed the patch yet but I am wondering whether this is
>> really worth it without going all the way down to unify the common code
>> and remove much more code duplication. Or is this not possible for some
>> reason?
> 
> Exactly what I suggested doing in response to v1.
> 
> Also, the approach taken here is crazy.  x86 has a feature that no other
> architecture has bothered to implement yet -- accounting page tables
> to the process.  Yet instead of spreading that goodness to all other
> architectures, Anshuman has gone to more effort to avoid doing that.
> 

The basic objective for this patch is to create a common minimum allocation
flag that can be used by architectures but that still allows archs to add
on additional constraints if they see fit. This patch does not intend to
change functionality for any arch.

Yes. There is opportunity for further clean up and consolidation like the
one you mentioned about accounting. Uses pages tables should have
__GFP_ACCOUNT and kernel ones should not. IIUC unfortunately not all arch
implement this right now. It is something which should not be arch specific.
Accounting semantics should be common for all archs. A default function
switching between GFP_PGTABLE for kernel and GFP_PGTABLE | __GFP_ACCOUNT
looking into mm_struct can help here.

Then there is __GFP_RETRY_MAYFAIL. Some archs use it for multi order page
allocation but some use for a single page as well.

If there is an agreement on __GFP_ACCOUNT and __GFP_RETRY_MAYFAIL we can
clean this up further.
