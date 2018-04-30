Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754650AbeD3S3Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 14:29:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36089 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754138AbeD3S3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 14:29:15 -0400
X-Google-Smtp-Source: AB8JxZpG9MCV1z87hjcLRJME7oulQyHrhh0xyQeQdZz6XLyq5ONpNNg5Jhc2Pt0OiG5HWzVKxSU40g==
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc: David.Panariti@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        "Eric W. Biederman" <ebiederm@xmission.com>, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org, christian.koenig@amd.com
References: <87muxsbmkp.fsf@xmission.com>
 <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com> <877eowa5qh.fsf@xmission.com>
 <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> <874ljyu98e.fsf@xmission.com>
 <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
 <bceb1a1b-c453-782d-5a7d-40fa2f22c813@amd.com>
 <20180430160006.GB10583@redhat.com>
 <e5b0221d-84ba-10ff-4a58-4fa27c99650f@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <bb224134-7ccb-cc87-9a71-3ef1743eb074@gmail.com>
Date: Mon, 30 Apr 2018 20:29:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e5b0221d-84ba-10ff-4a58-4fa27c99650f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.04.2018 um 18:10 schrieb Andrey Grodzovsky:
>
>
> On 04/30/2018 12:00 PM, Oleg Nesterov wrote:
>> On 04/30, Andrey Grodzovsky wrote:
>>> What about changing PF_SIGNALED to PF_EXITING in
>>> drm_sched_entity_do_release
>>>
>>> -       if ((current->flags & PF_SIGNALED) && current->exit_code == 
>>> SIGKILL)
>>> +      if ((current->flags & PF_EXITING) && current->exit_code == 
>>> SIGKILL)
>> let me repeat, please don't use task->exit_code. And in fact this 
>> check is racy
>>
>> But this doesn't matter. Say, we can trivially add 
>> SIGNAL_GROUP_KILLED_BY_SIGKILL,
>> or do something else,
>
>
> Can you explain where is the race and what is a possible alternative 
> then ?

The race is that the release doesn't necessarily comes from the 
process/context which used the fd.

E.g. it is just called when the last reference count goes away, but that 
can be anywhere not related to the original process using it, e.g. in a 
kernel thread or a debugger etc...

The approach with the flush is indeed a really nice idea and I bite 
myself to not had that previously as well.

Christian.

>
>>   but I fail to understand what are you trying to do. Suppose
>> that the check above is correct in that it is true iff the task is 
>> exiting and
>> it was killed by SIGKILL. What about the "else" branch which does
>>
>>     r = wait_event_killable(sched->job_scheduled, ...)
>>
>> ?
>>
>> Once again, fatal_signal_pending() (or even signal_pending()) is not 
>> well defined
>> after the exiting task passes exit_signals().
>>
>> So wait_event_killable() can fail because fatal_signal_pending() is 
>> true; and this
>> can happen even if it was not killed.
>>
>> Or it can block and SIGKILL won't be able to wake it up.
>>
>>> If SIGINT was sent then it's SIGINT,
>> Yes, but see above. in this case fatal_signal_pending() will be 
>> likely true so
>> wait_event_killable() will fail unless condition is already true.
>
> My bad, I didn't show the full intended fix, it was just a snippet to 
> address the differentiation between exiting
> do to SIGKILL and any other exit, I also intended to change 
> wait_event_killable to wait_event_timeout.
>
> Andrey
>
>>
>> Oleg.
>>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
