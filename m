Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds/57AmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97C02601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932306AbeFFPpf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:45:35 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42423 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932148AbeFFPpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:45:31 -0400
X-Google-Smtp-Source: ADUXVKJ8DFMimVLdeNuyqph2La6xvUO4SUoRljbjeb3WWzJRf4V/SJv/ivtaqlV6fuQKnjSleB5Jh5KPWPJOu/Dp6Ec=
MIME-Version: 1.0
In-Reply-To: <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com> <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
 <ae904954-18f7-180a-ce69-7e7618bd398f@daenzer.net>
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 6 Jun 2018 17:44:59 +0200
Message-ID: <CAEJqkgjErpxG44CZXn2BzvPES7Ptf24ae6748dAcYdg2n5HuZw@mail.gmail.com>
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-06 17:03 GMT+02:00 Michel D=C3=A4nzer <michel@daenzer.net>:
> On 2018-06-06 04:44 PM, Christian K=C3=B6nig wrote:
>> Am 06.06.2018 um 16:12 schrieb Michel D=C3=A4nzer:
>>> On 2018-06-06 03:33 PM, Gabriel C wrote:
>>>> 2018-06-06 14:19 GMT+02:00 Christian K=C3=B6nig <christian.koenig@amd.=
com>:
>>>>> Am 06.06.2018 um 14:08 schrieb Gabriel C:
>>>>>> 2018-06-06 13:33 GMT+02:00 Christian K=C3=B6nig <christian.koenig@am=
d.com>:
>>>>>>> Am 06.06.2018 um 13:28 schrieb Gabriel C:
>>>
>>>>>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-=
sr-iov-off.txt
>>>>>>
>>>>>>
>>>>>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-=
sr-iov-on.txt
>>>>>>
>>>>>>
>>>>>> Also nothing else changed in that setup just testing kernel 4.17.
>>>>>
>>>>>
>>>>> That has nothing TODO with the driver nor the original bug you
>>>>> reported. The
>>>>> problem is that SME is active and that is currently not supported at
>>>>> all
>>>>> with a that hardware.
>>>>
>>>> Ok .. so are we playing now kernel an AMD Hardware roulette on each
>>>> release ?
>>>>
>>>> SME was like this in kernel 4.16.x here and all worked.
>>>
>>> If that is true, again please bisect which commit broke it.
>>>
>>> All the reports I've seen before this indicated that at least amdgpu
>>> has never worked with SME (which BTW doesn't mean it's never going to
>>> work or that we don't want to support it, just that as far as we know
>>> it's currently not working).
>>
>> At least in theory it should work when we use the coherent DMA allocator=
.
>>
>> When that really worked before, so the most likely commit which broke
>> this is:
>>
>> commit fd5fd480dd8fe4910546e7b080b3ae345e57fe9f
>> Author: Chunming Zhou <david1.zhou@amd.com>
>> Date:   Fri Feb 9 10:44:09 2018 +0800
>>
>>     drm/amdgpu: only enable swiotlb alloc when need v2
>>
>>     get the max io mapping address of system memory to see if it is over
>>     our card accessing range.
>>     v2: move checking later
>>
>>     Signed-off-by: Chunming Zhou <david1.zhou@amd.com>
>>     Reviewed-by: Monk Liu <monk.liu@amd.com>
>>     Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> Currently looking into how we could somehow improve this detection.
>
> I guess this could fit for Gabriel, but e.g.
> https://bugs.freedesktop.org/104437 says amdgpu was already broken with
> SME in 4.15, if not 4.14 (I suspect there was simply no SME support
> earlier).

I got strange performance issue with 4.15 and 4.16 .. but SME was ON
on that setup ( even before it hit mainline ) and never broke the GPU like =
this.

There is a 4.16.13 boot dmesg which has no such issue:

http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-radeon-SME-ON=
-kernel-4.16.txt

With the setup as is booting 4.16.x works , while 4.17 trows the errors.

>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
