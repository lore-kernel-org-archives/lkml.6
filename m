Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeD1X4X (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 19:56:23 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35203 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbeD1X4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 19:56:22 -0400
X-Google-Smtp-Source: AB8JxZqzptExahXGIPkY+TJ/+Rct/G4hyG4wz3Uc7bxIBKGzt8KauGuMLZmMjqFo2RAIjRIGJW8lwN82vnT+o/siH9s=
MIME-Version: 1.0
In-Reply-To: <e8166443-14f0-1eb3-a6a2-d425792b0643@daenzer.net>
References: <20180426150618.13470-1-michel@daenzer.net> <20180427130811.7642-1-michel@daenzer.net>
 <CAKb7Uvj6FFRK6dtvR7xpfZDzs0o3QKHq7ESueBBmr_VnQt6XDQ@mail.gmail.com> <e8166443-14f0-1eb3-a6a2-d425792b0643@daenzer.net>
From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Sat, 28 Apr 2018 19:56:20 -0400
X-Google-Sender-Auth: PHtCw-2-keSWbfIcZyZn42y1yc0
Message-ID: <CAKb7UvibaW0d3H++c4dMFgeXQUYTMVFhi1qO=5W-NFbDWVDT2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/ttm: Only allocate huge pages with new flag TTM_PAGE_FLAG_TRANSHUGE
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3SNv9CN001704

On Sat, Apr 28, 2018 at 7:02 PM, Michel Dänzer <michel@daenzer.net> wrote:
> On 2018-04-28 06:30 PM, Ilia Mirkin wrote:
>> On Fri, Apr 27, 2018 at 9:08 AM, Michel Dänzer <michel@daenzer.net> wrote:
>>> From: Michel Dänzer <michel.daenzer@amd.com>
>>>
>>> Previously, TTM would always (with CONFIG_TRANSPARENT_HUGEPAGE enabled)
>>> try to allocate huge pages. However, not all drivers can take advantage
>>> of huge pages, but they would incur the overhead for allocating and
>>> freeing them anyway.
>>>
>>> Now, drivers which can take advantage of huge pages need to set the new
>>> flag TTM_PAGE_FLAG_TRANSHUGE to get them. Drivers not setting this flag
>>> no longer incur any overhead for allocating or freeing huge pages.
>>>
>>> v2:
>>> * Also guard swapping of consecutive pages in ttm_get_pages
>>> * Reword commit log, hopefully clearer now
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
>>
>> Both I and lots of other people, based on reports, are still seeing
>> plenty of issues with this as late as 4.16.4.
>
> "lots of other people", "plenty of issues" sounds a bit exaggerated from
> what I've seen. FWIW, while I did see the original messages myself, I
> haven't seen any since Christian's original fix (see below), neither
> with amdgpu nor radeon, even before this patch you followed up to.

Probably a half-dozen reports of it with nouveau, in addition to
another bunch of people talking about it on the bug you mention below,
along with email threads on dri-devel.

I figured I didn't have to raise my own since it was identical to the
others, and, I assumed, was being handled.

>> Admittedly I'm on nouveau, but others have reported issues with
>> radeon/amdgpu as well. It's been going on since the feature was merged
>> in v4.15, with what seems like little investigation from the authors
>> introducing the feature.
>
> That's not a fair assessment. See
> https://bugs.freedesktop.org/show_bug.cgi?id=104082#c40 and following
> comments.
>
> Christian fixed the original issue in
> d0bc0c2a31c95002d37c3cc511ffdcab851b3256 "swiotlb: suppress warning when
> __GFP_NOWARN is set". Christian did his best to try and get the fix in
> before 4.15 final, but for reasons beyond his control, it was delayed
> until 4.16-rc1 and then backported to 4.15.5.

In case it's unclear, let me state this explicitly -- I totally get
that despite best intentions, bugs get introduced. I do it myself.
What I'm having trouble with is the handling once the issue is
discovered.

>
> Unfortunately, there was an swiotlb regression (not directly related to
> Christian's work) shortly after this fix, also in 4.16-rc1, which is now
> fixed in 4.17-rc1 and will be backported to 4.16.y.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=v4.16.5&id=2c9dacf5bfe1e45d96dfe97cb71d2b717786a7b9

This guy? Didn't help. I'm running 4.16.4 right now.

> It looks like there's at least one more bug left, but it's not clear yet
> when that was introduced, whether it's directly related to Christian's
> work, or indeed what the impact is. Let's not get ahead of ourselves.

Whether it is directly related to that work or not, the issue
persists. There are two options:

 - When declaring things fixed, no serious attempt was actually made
at reproducing the underlying issues.
 - The authors truly can't reproduce the underlying issues users are
seeing and are taking stabs in the dark.

Given that a number of people are reporting problems, in either
scenario, the reasonable thing is to disable the feature, and figure
out what is going on. Maybe condition it on !CONFIG_SWIOTLB.

>> We now have *two* broken releases, v4.15 and v4.16 (anything that
>> spews error messages and stack traces ad-infinitum in dmesg is, by
>> definition, broken).
>
> I haven't seen any evidence that there's still an issue in 4.15, is
> there any?

Well, I did have a late 4.15 rc kernel in addition to the 'suppress
warning' patch. Now I'm questioning my memory of whether the issue was
resolved there or not. I'm pretty sure that 'not', but no longer 100%.
Either way, I think we all agree v4.15 was broken and more importantly
was *known* to be broken well in advance of the release. A reasonable
option would have been to disable the feature until the other bits
fell into place.

>> You're putting this behind a flag now (finally),
>
> I wrote this patch because I realized due to some remark I happened to
> see you make this week on IRC that the huge page support in TTM was
> enabled for all drivers. Instead of making that kind of remark on IRC,
> it would have been more constructive, and more conducive to quick
> implementation, to suggest making the feature not active for drivers
> which don't need it in a mailing list post.

I see IRC as a much faster and direct way of reaching the authors
and/or people who need to know an issue. As there was already a bug
filed about it and the issue was known about, I didn't really see a
reason to pile on (until now).

> At least, please do more research before making this kind of negative
> post.

Every time I've reported it, I've been told that patch X definitely
solves the issue. There was the original fix from Christian which went
into v4.15 and I'm pretty sure didn't fix it (I had it applied to a
4.15 tree), and then the later issue with the swiotlb logic inversion
bug which also didn't fix it. It's entirely possible that the true
issue lies not in the code that was written as part of this feature
enablement but rather existing code in handling of thp. But the end
result is that I have a broken kernel.

As a user who is not in a position to debug this directly due to lack
of time and knowledge, my options are limited. This issue hasn't
gotten a ton of visibility since it's waved away every time as
"fixed", so I'm trying to turn up the heat a little bit to cause a fix
or revert to happen. I believe the policy in Linux is "no
regressions", unlike many other graphics components where regressions
are welcome as long as they're downstream components of where the
change is made.

> P.S. You might also want to look into whether nouveau really should be
> hitting swiotlb in these cases.

I don't have a strong enough concept of what the swiotlb does and when
it's needed. Hopefully someone that does will take a look.

  -ilia
