Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754602AbeDWKXz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:23:55 -0400
Received: from mail.netline.ch ([148.251.143.178]:48010 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeDWKXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:23:54 -0400
Subject: Re: AMD graphics performance regression in 4.15 and later
To: Felix Kuehling <felix.kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Gabriel C <nix.or.die@gmail.com>, Philip Yang <Philip.Yang@amd.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>, Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        alexander.deucher@amd.com, Andrew Morton <akpm@linux-foundation.org>,
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
 <2a864040-3888-c30a-2fab-6ff637dddda4@daenzer.net>
 <35c599a3-0042-4f00-52e4-9d17164b93b1@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <45fc9cac-f37e-833f-5f4a-811db206166d@daenzer.net>
Date: Mon, 23 Apr 2018 12:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <35c599a3-0042-4f00-52e4-9d17164b93b1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-20 09:40 PM, Felix Kuehling wrote:
> On 2018-04-20 10:47 AM, Michel Dänzer wrote:
>> On 2018-04-11 11:37 AM, Christian König wrote:
>>> Am 11.04.2018 um 06:00 schrieb Gabriel C:
>>>> 2018-04-09 11:42 GMT+02:00 Christian König
>>>> <ckoenig.leichtzumerken@gmail.com>:
>>>>> Am 07.04.2018 um 00:00 schrieb Jean-Marc Valin:
>>>>>> Hi Christian,
>>>>>>
>>>>>> Thanks for the info. FYI, I've also opened a Firefox bug for that at:
>>>>>> https://bugzilla.mozilla.org/show_bug.cgi?id=1448778
>>>>>> Feel free to comment since you have a better understanding of what's
>>>>>> going on.
>>>>>>
>>>>>> One last question: right now I'm running 4.15.0 with the "offending"
>>>>>> patch reverted. Is that safe to run or are there possible bad
>>>>>> interactions with other changes.
>>>>> That should work without problems.
>>>>>
>>>>> But I just had another idea as well, if you want you could still test
>>>>> the
>>>>> new code path which will be using in 4.17.
>>>>>
>>>> While Firefox may do some strange things is not about only Firefox.
>>>>
>>>> With your patches my EPYC box is unusable with  4.15++ kernels.
>>>> The whole Desktop is acting weird.  This one is using
>>>> an Cape Verde PRO [Radeon HD 7750/8740 / R7 250E] GPU.
>>>>
>>>> Box is  2 * EPYC 7281 with 128 GB ECC RAM
>>>>
>>>> Also a 14C Xeon box with a HD7700 is broken same way.
>>> The hardware is irrelevant for this. We need to know what software stack
>>> you use on top of it.
>>>
>>> E.g. desktop environment/Mesa and DDX version etc...
>>>
>>>> Everything breaks in X .. scrolling , moving windows , flickering etc.
>>>>
>>>>
>>>> reverting f4c809914a7c3e4a59cf543da6c2a15d0f75ee38 and
>>>> 648bc3574716400acc06f99915815f80d9563783
>>>> from an 4.15 kernel makes things work again.
>>>>
>>>>
>>>>> Backporting all the detection logic is to invasive, but you could
>>>>> just go
>>>>> into drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c and forcefull use the other
>>>>> code path.
>>>>>
>>>>> Just look out for "#ifdef CONFIG_SWIOTLB" checks and disable those.
>>>>>
>>>> Well you really can't be serious about these suggestions ? Are you ?
>>>>
>>>> Telling peoples to #if 0 random code is not a solution.
>>> That is for testing and not a permanent solution.
>>>
>>>> You broke existsing working userland with your patches and at least
>>>> please fix that for 4.16.
>>>>
>>>> I can help testing code for 4.17/++ if you wish but that is
>>>> *different* storry.
>>> Please test Alex's amd-staging-drm-next branch from
>>> git://people.freedesktop.org/~agd5f/linux.
>> I think we're still missing something here.
>>
>> I'm currently running 4.16.2 + the DRM subsystem changes which are going
>> into 4.17 (so I have the changes Christian is referring to) with a
>> Kaveri APU, and I'm seeing similar symptoms as described by Jean-Marc.
>> Some observations:
>>
>> Firefox, Thunderbird, or worst, gnome-shell, can freeze for up to on the
>> order of a minute, during which the kernel is spending most of one
>> core's cycles inside alloc_pages (__alloc_pages_nodemask to be more
>> precise), called from ttm_alloc_new_pages.
> Philip debugged a similar problem with a KFD memory stress test about
> two weeks ago, where the kernel was seemingly stuck in an infinite loop
> trying to allocate huge pages. I'm pasting his analysis for the record:
> 
>> [...] it uses huge_flags GFP_TRANSHUGE to call alloc_pages(), this
>> seems a corner case inside __alloc_pages_slowpath(), it never exits
>> but goes to retry path every time. It can reclaim pages and
>> did_some_progress (as a result, no_progress_loops is reset to 0 every
>> loop, never reach MAX_RECLAIM_RETRIES) but cannot finish huge page
>> allocations under this specific memory pressure.  
> As a workaround to unblock our release branch testing we removed
> transparent huge page allocation from  ttm_get_pages. We're seeing this
> as far back as 4.13 on our release branch.

Thanks for sharing this. In the future, please raise issues like this on
the public mailing lists from the beginning.


> If we're really talking about the same problem, I don't think it's
> caused by recent page allocator changes, but rather exposed by recent
> TTM changes.

It sounds related, but probably not exactly the same problem. I already
had the TTM code using GFP_TRANSHUGE before I ran into the issue. Also,
__alloc_pages_slowpath eventually succeeds for me, it can just take up
to about a minute.

I'm currently testing using (GFP_TRANSHUGE_LIGHT | __GFP_NORETRY)
instead of GFP_TRANSHUGE in TTM.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
