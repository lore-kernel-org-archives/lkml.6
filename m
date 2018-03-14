Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeCNRmd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:42:33 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35674 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752281AbeCNRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:42:30 -0400
X-Google-Smtp-Source: AG47ELtkzeUc/0jPOH83MjXIvhxbEFqmMD0eFCaAt1CD+Y57ZzprzIKAh2vAfTNfPuTC/5kLFvOq2dLcT9ebsbLCAnc=
MIME-Version: 1.0
In-Reply-To: <20180314154312.GZ2943022@devbig577.frc2.facebook.com>
References: <CAK1sfuYAQf0irGzGxusNg-PdqLSzJ6tSHMENG2Vp8gH1c0FG9w@mail.gmail.com>
 <20180314154312.GZ2943022@devbig577.frc2.facebook.com>
From: David Chen <tuxoko@gmail.com>
Date: Wed, 14 Mar 2018 10:42:28 -0700
Message-ID: <CAK1sfuZmXYBsEouVMOS9eXUfVGn4q5Yn3Wcut12r2BHqiqGTXA@mail.gmail.com>
Subject: Re: blk_mq_freeze_queue hang and possible race in percpu-refcount
To: Tejun Heo <tj@kernel.org>
Cc: Shaohua Li <shli@fb.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

Thanks, I see I missed the RCU part.
I'll try the force atomic thing.
Though so far I haven't been able to reproduce it yet.

Thanks,
David


2018-03-14 8:43 GMT-07:00 Tejun Heo <tj@kernel.org>:
> Hello, David.
>
> On Tue, Mar 13, 2018 at 03:50:47PM -0700, David Chen wrote:
>> ====
>> CPU A                           CPU B
>> -----                           -----
>> percpu_ref_kill()               percpu_ref_tryget_live()
>> {
>>                                 if (__ref_is_percpu())
>>   set __PERCPU_REF_DEAD;
>>   __percpu_ref_switch_mode();
>>    ^ sum up current percpu_count
>>                                 this_cpu_inc(*percpu_count); <- this
>> increment got leaked.
>>
>> ====
>>
>> So if later CPU B later does percpu_ref_put, it will cause ref->count
>> to drop to -1.
>> And thus causing the above hung task issue.
>>
>> Do you think this theory is correct, or am I missing something?
>> Please tell me what do you think.
>
> The switching to atomic mode does something like the following.
>
> 1. Mark the refcnt so that __ref_is_percpu() is false.
>
> 2. Wait for RCU grace period so that everyone including
>    percpu_ref_tryget_live() which has seen true __ref_is_percpu() is
>    done with its operation.
>
> 3. Now that it knows nobody is operating on the assumption that the
>    counter is in percpu mode, it adds up all the percpu counters.
>
> So, provided there aren't some silly bugs, what you described
> shouldn't happen.  Can you force the refcnt into atomic mode w/
> PERCPU_REF_INIT_ATOMIC and see whether the problem persists?
>
> Thanks.
>
> --
> tejun
