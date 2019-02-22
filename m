Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DFAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF1220823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBVKVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:21:45 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57292 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfBVKVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:21:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C24EB80D;
        Fri, 22 Feb 2019 02:21:44 -0800 (PST)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A30923F703;
        Fri, 22 Feb 2019 02:21:41 -0800 (PST)
Subject: Re: [PATCH v2 03/13] mm: Add generic p?d_large() macros
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Mark Rutland <Mark.Rutland@arm.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        "Liang, Kan" <kan.liang@linux.intel.com>
References: <20190221113502.54153-1-steven.price@arm.com>
 <20190221113502.54153-4-steven.price@arm.com>
 <20190221142812.oa53lfnnfmsuh6ys@kshutemo-mobl1>
 <a3076d01-41b3-d59b-e98c-a0fd9ba5d3f5@arm.com>
 <20190221145706.zqwfdoyiirn3lc7y@kshutemo-mobl1>
 <e0c7fc0c-7924-1106-a7a3-fc12136b7b82@arm.com>
 <20190221210618.voyfs5cnafpvgedh@kshutemo-mobl1>
From:   Steven Price <steven.price@arm.com>
Message-ID: <9441949b-6982-eea3-a05e-e277776ff821@arm.com>
Date:   Fri, 22 Feb 2019 10:21:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190221210618.voyfs5cnafpvgedh@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2019 21:06, Kirill A. Shutemov wrote:
> On Thu, Feb 21, 2019 at 05:16:46PM +0000, Steven Price wrote:
>>>> Note that in terms of the new page walking code, these new defines are
>>>> only used when walking a page table without a VMA (which isn't currently
>>>> done), so architectures which don't use p?d_large currently will work
>>>> fine with the generic versions. They only need to provide meaningful
>>>> definitions when switching to use the walk-without-a-VMA functionality.
>>>
>>> How other architectures would know that they need to provide the helpers
>>> to get walk-without-a-VMA functionality? This looks very fragile to me.
>>
>> Yes, you've got a good point there. This would apply to the p?d_large
>> macros as well - any arch which (inadvertently) uses the generic version
>> is likely to be fragile/broken.
>>
>> I think probably the best option here is to scrap the generic versions
>> altogether and simply introduce a ARCH_HAS_PXD_LARGE config option which
>> would enable the new functionality to those arches that opt-in. Do you
>> think this would be less fragile?
> 
> These helpers are useful beyond pagewalker.
> 
> Can we actually do some grinding and make *all* archs to provide correct
> helpers? Yes, it's tedious, but not that bad.
> 
> I think we could provide generic helpers for folded levels in
> <asm-generic/pgtable-nop?d.h> and rest has to be provided by the arch.
> Architectures that support only 2 level paging would need to provide
> pgd_large(), with 3 -- pmd_large() and so on.

Fair enough, I'll have a go and hopefully people will be able to correct
it if I make any mistakes - I'm certainly not going to be able to test
all architectures myself.

Steve
