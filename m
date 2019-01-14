Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C5C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C622D206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfANE2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 23:28:23 -0500
Received: from foss.arm.com ([217.140.101.70]:54520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfANE2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 23:28:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 628C180D;
        Sun, 13 Jan 2019 20:28:22 -0800 (PST)
Received: from [10.162.42.129] (p8cg001049571a15.blr.arm.com [10.162.42.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48C03F5BD;
        Sun, 13 Jan 2019 20:28:13 -0800 (PST)
Subject: Re: [PATCH] mm: Introduce GFP_PGTABLE
To:     Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kvmarm@lists.cs.columbia.edu, linux@armlinux.org.uk,
        mingo@redhat.com, vbabka@suse.cz, rientjes@google.com,
        marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
        kirill@shutemov.name, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, steve.capper@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org
References: <1547288798-10243-1-git-send-email-anshuman.khandual@arm.com>
 <20190112121230.GQ6310@bombadil.infradead.org>
 <ddd59fdc-3d8f-4015-e851-e7f099193a1b@c-s.fr>
 <20190112154944.GT6310@bombadil.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <48f81a76-2b2d-5060-d9bc-c42d5b5975c3@arm.com>
Date:   Mon, 14 Jan 2019 09:58:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190112154944.GT6310@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/12/2019 09:19 PM, Matthew Wilcox wrote:
> On Sat, Jan 12, 2019 at 02:49:29PM +0100, Christophe Leroy wrote:
>> As far as I can see,
>>
>> #define GFP_KERNEL_ACCOUNT (GFP_KERNEL | __GFP_ACCOUNT)
>>
>> So what's the difference between:
>>
>> (GFP_KERNEL_ACCOUNT | __GFP_ZERO) & ~__GFP_ACCOUNT
>>
>> and
>>
>> (GFP_KERNEL | __GFP_ZERO) & ~__GFP_ACCOUNT
> 
> Nothing.  But there's a huge difference in the other parts of that same
> file where GFP_ACCOUNT is _not_ used.
> 
> I think this unification is too small to bother with.  Something I've
> had on my todo list for some time and have not done anything about
> is to actually unify all of the architecture pte/pmd/... allocations.
> There are tricks some architectures use that others would benefit from.

Sure. Could you please elaborate on this ?

Invariably all kernel pgtable page allocations should use GFP_PGTABLE and
all user page table allocation should use (GFP_PGTABLE | __GFP_ACCOUNT).
Ideally there should be default generic functions user_pgtable_gfp() or
kernel_pgtable_gfp() returning these values. Overrides can be provided if
an arch still wants some more control.

