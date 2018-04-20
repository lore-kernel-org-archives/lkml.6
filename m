Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755507AbeDTOsQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:48:16 -0400
Received: from mail.netline.ch ([148.251.143.178]:35653 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755487AbeDTOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:48:02 -0400
Subject: Re: AMD graphics performance regression in 4.15 and later
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Gabriel C <nix.or.die@gmail.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>, Dave Airlie <airlied@linux.ie>,
        Felix.Kuehling@amd.com, LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <c743b220-0395-eef3-4405-a21cdbe8eee1@mozilla.com>
 <9ca940f1-7f21-c420-de45-13d72e783ab6@amd.com>
 <a96df0b8-fc22-4438-646d-2f0096dfcc84@mozilla.com>
 <6cebabff-908f-5ebe-4252-760773c4cd6f@amd.com>
 <312ed341-7052-a61e-331f-d1e8fd5b477e@mozilla.com>
 <d136f940-d807-d2f7-30a7-8617f130912d@amd.com>
 <77866d66-2728-8295-d7ee-9975dbf64b99@mozilla.com>
 <55e1712b-6567-50c5-3789-53dd1ccddb94@gmail.com>
 <CAEJqkgiOR3aCGoNquVeEyC1BLMBPmXNjgrmjNeeE9UVfzcJKzg@mail.gmail.com>
 <dafca4cc-c7ca-a06d-3a17-46240b1d20c3@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <2a864040-3888-c30a-2fab-6ff637dddda4@daenzer.net>
Date: Fri, 20 Apr 2018 16:47:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <dafca4cc-c7ca-a06d-3a17-46240b1d20c3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-11 11:37 AM, Christian König wrote:
> Am 11.04.2018 um 06:00 schrieb Gabriel C:
>> 2018-04-09 11:42 GMT+02:00 Christian König
>> <ckoenig.leichtzumerken@gmail.com>:
>>> Am 07.04.2018 um 00:00 schrieb Jean-Marc Valin:
>>>> Hi Christian,
>>>>
>>>> Thanks for the info. FYI, I've also opened a Firefox bug for that at:
>>>> https://bugzilla.mozilla.org/show_bug.cgi?id=1448778
>>>> Feel free to comment since you have a better understanding of what's
>>>> going on.
>>>>
>>>> One last question: right now I'm running 4.15.0 with the "offending"
>>>> patch reverted. Is that safe to run or are there possible bad
>>>> interactions with other changes.
>>>
>>> That should work without problems.
>>>
>>> But I just had another idea as well, if you want you could still test
>>> the
>>> new code path which will be using in 4.17.
>>>
>> While Firefox may do some strange things is not about only Firefox.
>>
>> With your patches my EPYC box is unusable with  4.15++ kernels.
>> The whole Desktop is acting weird.  This one is using
>> an Cape Verde PRO [Radeon HD 7750/8740 / R7 250E] GPU.
>>
>> Box is  2 * EPYC 7281 with 128 GB ECC RAM
>>
>> Also a 14C Xeon box with a HD7700 is broken same way.
> 
> The hardware is irrelevant for this. We need to know what software stack
> you use on top of it.
> 
> E.g. desktop environment/Mesa and DDX version etc...
> 
>>
>> Everything breaks in X .. scrolling , moving windows , flickering etc.
>>
>>
>> reverting f4c809914a7c3e4a59cf543da6c2a15d0f75ee38 and
>> 648bc3574716400acc06f99915815f80d9563783
>> from an 4.15 kernel makes things work again.
>>
>>
>>> Backporting all the detection logic is to invasive, but you could
>>> just go
>>> into drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c and forcefull use the other
>>> code path.
>>>
>>> Just look out for "#ifdef CONFIG_SWIOTLB" checks and disable those.
>>>
>> Well you really can't be serious about these suggestions ? Are you ?
>>
>> Telling peoples to #if 0 random code is not a solution.
> 
> That is for testing and not a permanent solution.
> 
>> You broke existsing working userland with your patches and at least
>> please fix that for 4.16.
>>
>> I can help testing code for 4.17/++ if you wish but that is
>> *different* storry.
> 
> Please test Alex's amd-staging-drm-next branch from
> git://people.freedesktop.org/~agd5f/linux.

I think we're still missing something here.

I'm currently running 4.16.2 + the DRM subsystem changes which are going
into 4.17 (so I have the changes Christian is referring to) with a
Kaveri APU, and I'm seeing similar symptoms as described by Jean-Marc.
Some observations:

Firefox, Thunderbird, or worst, gnome-shell, can freeze for up to on the
order of a minute, during which the kernel is spending most of one
core's cycles inside alloc_pages (__alloc_pages_nodemask to be more
precise), called from ttm_alloc_new_pages.

At least in the case of Firefox, this happens due to Mesa internal BO
allocations for glTex(Sub)Image, so it's not obvious that Firefox is
doing something wrong.

I never noticed this before this week. Before, I was running 4.15.y +
DRM subsystem changes from 4.16. Maybe something has changed in core
code, trying harder to allocate huge pages.


Maybe TTM should only try to use any huge pages that happen to be
available, not spend any (/ "too much"?) additional effort trying to
free up huge pages?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
