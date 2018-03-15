Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeCONsD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:48:03 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41547 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbeCONsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:48:01 -0400
X-Google-Smtp-Source: AG47ELsGkjKop9Mo4CHvFCc+Op152PH0nHuW8760Nz1iYTKSbncgQDsO+H+/uOVcL1zH6SC4KneCz9p9OYc5Rn9t9AI=
MIME-Version: 1.0
In-Reply-To: <20180315114312.GC23100@dhcp22.suse.cz>
References: <20180314134431.13241-1-ard.biesheuvel@linaro.org>
 <20180314141323.GD23100@dhcp22.suse.cz> <CAKv+Gu9hrZnX6pmiCaT=S30KQ11tY4kv=qvdSPPZ2nYDC7P7eQ@mail.gmail.com>
 <20180314145450.GI23100@dhcp22.suse.cz> <CAKv+Gu8qguR0tFWZxecQDTPS3_Eyt_E6_YA1ivyAAqNuaaR9-g@mail.gmail.com>
 <20180315101411.GA23100@dhcp22.suse.cz> <CAKv+Gu_f9mNQ37GzfZybcUfanSAx1zH0ifSNfDE0EWACGH-GCg@mail.gmail.com>
 <20180315114312.GC23100@dhcp22.suse.cz>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 15 Mar 2018 13:48:00 +0000
Message-ID: <CAKv+Gu8TZXv8SG24VsvA8Ct7UrJgKDNzY+E7N1uLfeWAsnkEfQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm/page_alloc: fix memmap_init_zone pageblock alignment"
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>, Daniel Vacek <neelx@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 March 2018 at 11:43, Michal Hocko <mhocko@kernel.org> wrote:
> On Thu 15-03-18 10:17:24, Ard Biesheuvel wrote:
>> On 15 March 2018 at 10:14, Michal Hocko <mhocko@kernel.org> wrote:
>> > On Wed 14-03-18 15:54:16, Ard Biesheuvel wrote:
>> >> On 14 March 2018 at 14:54, Michal Hocko <mhocko@kernel.org> wrote:
>> >> > On Wed 14-03-18 14:35:12, Ard Biesheuvel wrote:
>> >> >> On 14 March 2018 at 14:13, Michal Hocko <mhocko@kernel.org> wrote:
>> >> >> > Does http://lkml.kernel.org/r/20180313224240.25295-1-neelx@redhat.com
>> >> >> > fix your issue? From the debugging info you provided it should because
>> >> >> > the patch prevents jumping backwards.
>> >> >> >
>> >> >>
>> >> >> The patch does fix the boot hang.
>> >> >>
>> >> >> But I am concerned that we are papering over a fundamental flaw in
>> >> >> memblock_next_valid_pfn().
>> >> >
>> >> > It seems that memblock_next_valid_pfn is doing the right thing here. It
>> >> > is the alignment which moves the pfn back AFAICS. I am not really
>> >> > impressed about the original patch either, to be completely honest.
>> >> > It just looks awfully tricky. I still didn't manage to wrap my head
>> >> > around the original issue though so I do not have much better ideas to
>> >> > be honest.
>> >>
>> >> So first of all, memblock_next_valid_pfn() never refers to its max_pfn
>> >> argument, which is odd nut easily fixed.
>> >
>> > There is a patch to remove that parameter sitting in the mmotm tree.
>> >
>> >> Then, the whole idea of substracting one so that the pfn++ will
>> >> produce the expected value is rather hacky,
>> >
>> > Absolutely agreed!
>> >
>> >> But the real problem is that rounding down pfn for the next iteration
>> >> is dodgy, because early_pfn_valid() isn't guaranteed to return true
>> >> for the rounded down value. I know it is probably fine in reality, but
>> >> dodgy as hell.
>> >
>> > Yes, that is what I meant when saying I was not impressed... I am always
>> > nervous when a loop makes jumps back and forth. I _think_ the main
>> > problem here is that we try to initialize a partial pageblock even
>> > though a part of it is invalid. We should simply ignore struct pages
>> > for those pfns. We don't do that and that is mostly because of the
>> > disconnect between what the page allocator and early init code refers to
>> > as a unit of memory to care about. I do not remember exactly why but I
>> > strongly suspect this is mostly a performance optimization on the page
>> > allocator side so that we do not have to check each and every pfn. Maybe
>> > we should signal partial pageblocks from an early code and drop the
>> > optimization in the page allocator init code.
>> >
>> >> The same applies to the call to early_pfn_in_nid() btw
>> >
>> > Why?
>>
>> By 'the same' I mean it isn't guaranteed to return true for the
>> rounded down value *at the API level*. I understand it will be mostly
>> fine in reality, but juggling (in)valid PFNs like this is likely to
>> end badly.
>
> OK, I see your point now. I can really imagine that sub-pageblocks would
> be splitted into different NUMA nodes but that should be really rare.
>

Yes, it should never happen.

But these abstractions exist for a reason: it makes this code
understandable to humans, and so taking all kinds of shortcuts around
them makes the code unmaintainable.

If ARM's implementation of pfn_valid() is flawed, we should fix it. If
memblock_next_valid_pfn() is flawed, we should fix it. But papering
over these issues by bypassing the abstractions is really not the way
to go (but I think we're already in agreement there)
