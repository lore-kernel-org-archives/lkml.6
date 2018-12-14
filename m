Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D581C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441A520892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441A520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeLNMex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:34:53 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51034 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731336AbeLNMeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:34:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B412EBD;
        Fri, 14 Dec 2018 04:34:45 -0800 (PST)
Received: from [10.37.12.200] (unknown [10.37.12.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFCDF3F575;
        Fri, 14 Dec 2018 04:34:36 -0800 (PST)
Subject: Re: [PATCH v13 19/25] kasan: add hooks implementation for tag-based
 mode
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Vishwath Mohan <vishwath@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Jann Horn <jannh@google.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Mark Brand <markbrand@google.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Evgenii Stepanov <eugenis@google.com>
References: <cover.1544099024.git.andreyknvl@google.com>
 <bda78069e3b8422039794050ddcb2d53d053ed41.1544099024.git.andreyknvl@google.com>
 <2bf7415e-2724-b3c3-9571-20c8b6d43b92@arm.com>
 <CAAeHK+xc6R_p26-tu--9W1L1PvUAFb70J23ByiEukKz3uVC3EQ@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b99b331d-22ca-b9db-8677-4896c427ef10@arm.com>
Date:   Fri, 14 Dec 2018 12:35:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xc6R_p26-tu--9W1L1PvUAFb70J23ByiEukKz3uVC3EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 3:04 PM, Andrey Konovalov wrote:
> On Tue, Dec 11, 2018 at 5:22 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> Hi Andrey,
>>
>> On 06/12/2018 12:24, Andrey Konovalov wrote:
>>> This commit adds tag-based KASAN specific hooks implementation and
>>> adjusts common generic and tag-based KASAN ones.
>>>
>>> 1. When a new slab cache is created, tag-based KASAN rounds up the size of
>>>    the objects in this cache to KASAN_SHADOW_SCALE_SIZE (== 16).
>>>
>>> 2. On each kmalloc tag-based KASAN generates a random tag, sets the shadow
>>>    memory, that corresponds to this object to this tag, and embeds this
>>>    tag value into the top byte of the returned pointer.
>>>
>>> 3. On each kfree tag-based KASAN poisons the shadow memory with a random
>>>    tag to allow detection of use-after-free bugs.
>>>
>>> The rest of the logic of the hook implementation is very much similar to
>>> the one provided by generic KASAN. Tag-based KASAN saves allocation and
>>> free stack metadata to the slab object the same way generic KASAN does.
>>>
>>> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>>> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>>> ---
>>>  mm/kasan/common.c | 116 ++++++++++++++++++++++++++++++++++++++--------
>>>  mm/kasan/kasan.h  |   8 ++++
>>>  mm/kasan/tags.c   |  48 +++++++++++++++++++
>>>  3 files changed, 153 insertions(+), 19 deletions(-)
>>>
>>
>>
>> [...]
>>
>>> @@ -265,6 +290,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>>>               return;
>>>       }
>>>
>>> +     cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
>>> +
>>
>> Did you consider to set ARCH_SLAB_MINALIGN instead of this round up?
> 
> I didn't know about this macro. Looks like we can use it to do the
> same thing. Do you think it's a better solution to redefine
> ARCH_SLAB_MINALIGN to KASAN_SHADOW_SCALE_SIZE for arm64 when tag-based
> KASAN is enabled instead of adjusting cache->align in
> kasan_cache_create?
>

Yes, I think it is better because in this way we do not need to add extra code
to do the rounding.

Curiosity, did you try your patches with SLUB red zoning enabled?
Since the area used for the Redzone is just after the payload, aligning the
object_size independently from the allocator could have side effects, at least
if I understand well how the mechanism works.

Setting ARCH_SLAB_MINALIGN should avoid this as well.

What do you think?

>>
>> --
>> Regards,
>> Vincenzo
>>
>> --
>> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
>> To post to this group, send email to kasan-dev@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/2bf7415e-2724-b3c3-9571-20c8b6d43b92%40arm.com.
>> For more options, visit https://groups.google.com/d/optout.

-- 
Regards,
Vincenzo
