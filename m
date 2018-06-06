Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYzabnwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCF65606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeFFPYz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:24:55 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35383 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeFFPYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:24:53 -0400
X-Google-Smtp-Source: ADUXVKJINzlLlDV+q3Jk4PyyC2dg0PlbyaByvG0cIJKyPoei+K81vdxMtOErI37zCQ3F5jay2JHamOmR5Ee3Rw4OMfM=
MIME-Version: 1.0
In-Reply-To: <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
 <516cddbe-73c2-01f3-a552-0d9fd75ce63a@amd.com> <8f7d00f9-992f-cc07-6bd0-b1b47c5d2ccf@amd.com>
From: Gabriel C <nix.or.die@gmail.com>
Date: Wed, 6 Jun 2018 17:24:21 +0200
Message-ID: <CAEJqkgjGqvM0-3ahNRWUQFoAtntkY4cTyXjCw_OYukeTz5rpLg@mail.gmail.com>
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>, alexander.deucher@amd.com,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-06 16:44 GMT+02:00 Christian K=C3=B6nig <christian.koenig@amd.com>:
> Am 06.06.2018 um 16:12 schrieb Michel D=C3=A4nzer:
>>
>> On 2018-06-06 03:33 PM, Gabriel C wrote:
>>>
>>> 2018-06-06 14:19 GMT+02:00 Christian K=C3=B6nig <christian.koenig@amd.c=
om>:
>>>>
>>>> Am 06.06.2018 um 14:08 schrieb Gabriel C:
>>>>>
>>>>> 2018-06-06 13:33 GMT+02:00 Christian K=C3=B6nig <christian.koenig@amd=
.com>:
>>>>>>
>>>>>> Am 06.06.2018 um 13:28 schrieb Gabriel C:
>>>>>>>
>>>>>>> 2018-04-11 7:02 GMT+02:00 Gabriel C <nix.or.die@gmail.com>:
>>>>>>>>
>>>>>>>>
>>>>>>>> [    6.337838] [drm] PCIE GART of 2048M enabled (table at
>>>>>>>> 0x00000000001D6000).
>>>>>>>> [    6.338210] radeon 0000:21:00.0: (-12) create WB bo failed
>>>>>>>> [    6.338214] radeon 0000:21:00.0: disabling GPU acceleration
>>>>>>>>
>>>>>>>> ...
>>>>>>>>
>>>>>>> I have the same Issue now on final 4.17.
>>
>>
>> Please file a bug report, and ideally bisect which commit(s) introduced
>> the issue(s).
>>
>>
>>>>>
>>>>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-s=
r-iov-off.txt
>>>>>
>>>>>
>>>>> http://ftp.frugalware.org/pub/other/people/crazy/radeon/dmesg-iommu-s=
r-iov-on.txt
>>>>>
>>>>> Also nothing else changed in that setup just testing kernel 4.17.
>>>>
>>>>
>>>>
>>>> That has nothing TODO with the driver nor the original bug you reporte=
d.
>>>> The
>>>> problem is that SME is active and that is currently not supported at a=
ll
>>>> with a that hardware.
>>>
>>>
>>> Ok .. so are we playing now kernel an AMD Hardware roulette on each
>>> release ?
>>>
>>> SME was like this in kernel 4.16.x here and all worked.
>>
>>
>> If that is true, again please bisect which commit broke it.
>>
>> All the reports I've seen before this indicated that at least amdgpu has
>> never worked with SME (which BTW doesn't mean it's never going to work o=
r
>> that we don't want to support it, just that as far as we know it's curre=
ntly
>> not working).
>
>
> At least in theory it should work when we use the coherent DMA allocator.
>
> When that really worked before, so the most likely commit which broke thi=
s
> is:
>
> commit fd5fd480dd8fe4910546e7b080b3ae345e57fe9f
> Author: Chunming Zhou <david1.zhou@amd.com>
> Date:   Fri Feb 9 10:44:09 2018 +0800
>
>     drm/amdgpu: only enable swiotlb alloc when need v2
>
>     get the max io mapping address of system memory to see if it is over
>     our card accessing range.
>     v2: move checking later
>
>     Signed-off-by: Chunming Zhou <david1.zhou@amd.com>
>     Reviewed-by: Monk Liu <monk.liu@amd.com>
>     Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Currently looking into how we could somehow improve this detection.

Is not this one , I've build an kernel with this reverted.

I'll do an bisect tonight or tomorrow.

>
> Regards,
> Christian.
