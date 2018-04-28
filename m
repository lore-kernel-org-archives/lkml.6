Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeD1XCH (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 19:02:07 -0400
Received: from mail.netline.ch ([148.251.143.178]:34848 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeD1XCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 19:02:06 -0400
Subject: Re: [PATCH v2 1/2] drm/ttm: Only allocate huge pages with new flag
 TTM_PAGE_FLAG_TRANSHUGE
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180426150618.13470-1-michel@daenzer.net>
 <20180427130811.7642-1-michel@daenzer.net>
 <CAKb7Uvj6FFRK6dtvR7xpfZDzs0o3QKHq7ESueBBmr_VnQt6XDQ@mail.gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <e8166443-14f0-1eb3-a6a2-d425792b0643@daenzer.net>
Date: Sun, 29 Apr 2018 01:02:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKb7Uvj6FFRK6dtvR7xpfZDzs0o3QKHq7ESueBBmr_VnQt6XDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-28 06:30 PM, Ilia Mirkin wrote:
> On Fri, Apr 27, 2018 at 9:08 AM, Michel Dänzer <michel@daenzer.net> wrote:
>> From: Michel Dänzer <michel.daenzer@amd.com>
>>
>> Previously, TTM would always (with CONFIG_TRANSPARENT_HUGEPAGE enabled)
>> try to allocate huge pages. However, not all drivers can take advantage
>> of huge pages, but they would incur the overhead for allocating and
>> freeing them anyway.
>>
>> Now, drivers which can take advantage of huge pages need to set the new
>> flag TTM_PAGE_FLAG_TRANSHUGE to get them. Drivers not setting this flag
>> no longer incur any overhead for allocating or freeing huge pages.
>>
>> v2:
>> * Also guard swapping of consecutive pages in ttm_get_pages
>> * Reword commit log, hopefully clearer now
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
> 
> Both I and lots of other people, based on reports, are still seeing
> plenty of issues with this as late as 4.16.4.

"lots of other people", "plenty of issues" sounds a bit exaggerated from
what I've seen. FWIW, while I did see the original messages myself, I
haven't seen any since Christian's original fix (see below), neither
with amdgpu nor radeon, even before this patch you followed up to.


> Admittedly I'm on nouveau, but others have reported issues with
> radeon/amdgpu as well. It's been going on since the feature was merged
> in v4.15, with what seems like little investigation from the authors
> introducing the feature.

That's not a fair assessment. See
https://bugs.freedesktop.org/show_bug.cgi?id=104082#c40 and following
comments.

Christian fixed the original issue in
d0bc0c2a31c95002d37c3cc511ffdcab851b3256 "swiotlb: suppress warning when
__GFP_NOWARN is set". Christian did his best to try and get the fix in
before 4.15 final, but for reasons beyond his control, it was delayed
until 4.16-rc1 and then backported to 4.15.5.

Unfortunately, there was an swiotlb regression (not directly related to
Christian's work) shortly after this fix, also in 4.16-rc1, which is now
fixed in 4.17-rc1 and will be backported to 4.16.y.

It looks like there's at least one more bug left, but it's not clear yet
when that was introduced, whether it's directly related to Christian's
work, or indeed what the impact is. Let's not get ahead of ourselves.


> We now have *two* broken releases, v4.15 and v4.16 (anything that
> spews error messages and stack traces ad-infinitum in dmesg is, by
> definition, broken).

I haven't seen any evidence that there's still an issue in 4.15, is
there any?


> You're putting this behind a flag now (finally),

I wrote this patch because I realized due to some remark I happened to
see you make this week on IRC that the huge page support in TTM was
enabled for all drivers. Instead of making that kind of remark on IRC,
it would have been more constructive, and more conducive to quick
implementation, to suggest making the feature not active for drivers
which don't need it in a mailing list post.


At least, please do more research before making this kind of negative
post.

P.S. You might also want to look into whether nouveau really should be
hitting swiotlb in these cases.

-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
