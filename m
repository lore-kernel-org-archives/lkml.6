Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754594AbeD3SWk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 14:22:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36532 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753522AbeD3SWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 14:22:33 -0400
X-Google-Smtp-Source: AB8JxZrYAbVPwnlsMCA5IeENCFSoY0JTaeFOZTP4BMOnu4Zx3dY65z2N5un0g4haNapw0xnTrDYMTQ==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH v2 1/2] drm/ttm: Only allocate huge pages with new flag
 TTM_PAGE_FLAG_TRANSHUGE
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180426150618.13470-1-michel@daenzer.net>
 <20180427130811.7642-1-michel@daenzer.net>
 <CAKb7Uvj6FFRK6dtvR7xpfZDzs0o3QKHq7ESueBBmr_VnQt6XDQ@mail.gmail.com>
 <e8166443-14f0-1eb3-a6a2-d425792b0643@daenzer.net>
 <d5f9459e-801c-e592-d06d-c9052ef3ad4d@amd.com>
 <e5256136-6da0-cc5e-9490-5a70c89dfd83@daenzer.net>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <361a765a-f491-4450-867e-fa88857827ee@gmail.com>
Date: Mon, 30 Apr 2018 20:22:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e5256136-6da0-cc5e-9490-5a70c89dfd83@daenzer.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.04.2018 um 18:33 schrieb Michel Dänzer:
> On 2018-04-29 09:02 AM, Christian König wrote:
>> Am 29.04.2018 um 01:02 schrieb Michel Dänzer:
>>> On 2018-04-28 06:30 PM, Ilia Mirkin wrote:
>>>> On Fri, Apr 27, 2018 at 9:08 AM, Michel Dänzer <michel@daenzer.net>
>>>> wrote:
>>>>> From: Michel Dänzer <michel.daenzer@amd.com>
>>>>>
>>>>> Previously, TTM would always (with CONFIG_TRANSPARENT_HUGEPAGE enabled)
>>>>> try to allocate huge pages. However, not all drivers can take advantage
>>>>> of huge pages, but they would incur the overhead for allocating and
>>>>> freeing them anyway.
>>>>>
>>>>> Now, drivers which can take advantage of huge pages need to set the new
>>>>> flag TTM_PAGE_FLAG_TRANSHUGE to get them. Drivers not setting this flag
>>>>> no longer incur any overhead for allocating or freeing huge pages.
>>>>>
>>>>> v2:
>>>>> * Also guard swapping of consecutive pages in ttm_get_pages
>>>>> * Reword commit log, hopefully clearer now
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
>>>> Both I and lots of other people, based on reports, are still seeing
>>>> plenty of issues with this as late as 4.16.4.
>>> "lots of other people", "plenty of issues" sounds a bit exaggerated from
>>> what I've seen. FWIW, while I did see the original messages myself, I
>>> haven't seen any since Christian's original fix (see below), neither
>>> with amdgpu nor radeon, even before this patch you followed up to.
>>>
>>>
>>>> Admittedly I'm on nouveau, but others have reported issues with
>>>> radeon/amdgpu as well. It's been going on since the feature was merged
>>>> in v4.15, with what seems like little investigation from the authors
>>>> introducing the feature.
>>> That's not a fair assessment. See
>>> https://bugs.freedesktop.org/show_bug.cgi?id=104082#c40 and following
>>> comments.
>>>
>>> Christian fixed the original issue in
>>> d0bc0c2a31c95002d37c3cc511ffdcab851b3256 "swiotlb: suppress warning when
>>> __GFP_NOWARN is set". Christian did his best to try and get the fix in
>>> before 4.15 final, but for reasons beyond his control, it was delayed
>>> until 4.16-rc1 and then backported to 4.15.5.
>>>
>>> Unfortunately, there was an swiotlb regression (not directly related to
>>> Christian's work) shortly after this fix, also in 4.16-rc1, which is now
>>> fixed in 4.17-rc1 and will be backported to 4.16.y.
>> And that's exactly the reason why I intentionally kept this enabled for
>> all users of the TTM DMA page pool and not put it behind a flag.
>>
>> This change has surfaced quite a number of bugs in the swiotlb code
>> which could have caused issues before. It's just that those code path
>> where never exercised massively before.
>>
>> Additional to that using huge pages is beneficial for the MM and CPU TLB
>> (not implemented yet) even when the GPU driver can't make much use of it.
> Do I understand correctly that you're against this patch?

Not completely, I've considered adding that multiple times myself.

I'm just torn apart between keeping it enabled so that the underlying 
bugs gets fixed and disabling it for a better end user experience.

But in general I would opt out for a pool configuration option, not a 
per driver flag.

> AFAIU the only benefit of huge pages with a driver which doesn't take
> advantage of them directly is "for the MM". Can you describe a bit more
> what that benefit is exactly?

When transparent huge pages are in effect we should have more huge pages 
than small pages in the system allocator.

So by enforcing allocation of small pages we fragment the huge pages 
once more and give khugepaged quite a bunch of work todo to gather them 
together into huge pages again.

> Is it expected to outweigh the cost of allocating / freeing huge pages?

Yes, and actually quite well (at least in theory).

>>> It looks like there's at least one more bug left, but it's not clear yet
>>> when that was introduced, whether it's directly related to Christian's
>>> work, or indeed what the impact is. Let's not get ahead of ourselves.
>> Well my patches surfaced the problems, but the underlying issues where
>> present even before those changes and I'm very well involved in fixing
>> the underlying issues.
>>
>> I even considered to just revert the huge page path for the DMA pool
>> allocator, but it's just that the TTM patches seem to work exactly as
>> they are intended. So that doesn't feel like doing the right thing here.
> I agree. Has anyone reported this to the DMA/SWIOTLB developers?

Yes, I fixed the original false positive messages myself with the 
swiotlb maintainer and I was CCed in fixing the recent fallout from 
Chris changes as well.

Regards,
Christian.
