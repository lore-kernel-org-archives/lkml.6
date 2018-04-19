Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbeDSXXH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 19:23:07 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35670 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753575AbeDSXXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 19:23:04 -0400
X-Google-Smtp-Source: AIpwx4+0hKct2bGsfEEnVss/Q7f9IKrwgeWzoBn6p7xd8+qTFWyrqTlcixmqQC9HSzdyMo0ggDJN/2CLTYypeDSNU/s=
MIME-Version: 1.0
In-Reply-To: <c0530769-50c3-87ad-1558-164873482130@redhat.com>
References: <20180419190846.GE2066@avx2> <1c3b9cf3-3a36-568f-3da2-e560a721f4aa@redhat.com>
 <20180419195504.GA4343@avx2> <eb7c1569-e445-5cbb-6d10-2694b625232a@redhat.com>
 <20180419203949.GA4555@avx2> <c0530769-50c3-87ad-1558-164873482130@redhat.com>
From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Date: Thu, 19 Apr 2018 16:23:02 -0700
Message-ID: <CAEi0qNn9KbTtUxLvFKvq958BhG9KrpY=S-89T5HJBebO9Da4zw@mail.gmail.com>
Subject: Re: [PATCH] proc/stat: Separate out individual irq counts into /proc/stat_irqs
To: Waiman Long <longman@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rdunlap@infradead.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>>> Or maintain array of registered irqs and iterate over them only.
>>> Right, we can allocate a bitmap of used irqs to do that.
>>>
>>>> I have another idea.
>>>>
>>>> perf record shows mutex_lock/mutex_unlock at the top.
>>>> Most of them are irq mutex not seqfile mutex as there are many more
>>>> interrupts than reads. Take it once.
>>>>
>>> How many cpus are in your test system? In that skylake server, it was
>>> the per-cpu summing operation of the irq counts that was consuming most
>>> of the time for reading /proc/stat. I think we can certainly try to
>>> optimize the lock taking.
>> It's 16x(NR_IRQS: 4352, nr_irqs: 960, preallocated irqs: 16)
>> Given that irq registering is rare operation, maintaining sorted array
>> of irq should be the best option.
>>> For the time being, I think I am going to have a clone /proc/stat2 as
>>> suggested in my earlier email. Alternatively, I can put that somewhere
>>> in sysfs if you have a good idea of where I can put it.
>> sysfs is strictly one-value-per-file.
>>
>>> I will also look into ways to optimize the current per-IRQ stats
>>> handling, but it will come later.
>> There is always a time-honored way of ioctl(2) switching irq info off
>> /proc supports that.
>>
>> There are many options.
>
> OK, it is good to know. Do you have any existing code snippet in the
> kernel that I can use as reference on how to use ioctl(2) switching?
>
> I will look into how to optimize the existing per-IRQ stats code first
> before venturing into cloning /proc/stat.

Can we not just remove per-IRQ stats from /proc/stat (since I gather
from this discussion it isn't scalable), and just have applications
that need per-IRQ stats use /proc/interrupts ?

thanks,

- Joel
