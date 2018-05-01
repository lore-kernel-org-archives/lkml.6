Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756438AbeEASGb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:06:31 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:41343 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756415AbeEASG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:06:29 -0400
X-Google-Smtp-Source: AB8JxZrel5V6v65vcYcyKU2fsLh0C04gb0Cmj8WCTXGSJxyYzSPtzU/9c4ZTnqgTAXXL00Orf1D4EWwjcK5qHfbh5So=
MIME-Version: 1.0
In-Reply-To: <20180501071112.GD12217@hirez.programming.kicks-ass.net>
References: <20180430192925.12589-1-xiyou.wangcong@gmail.com>
 <20180430194251.GB12217@hirez.programming.kicks-ass.net> <CAM_iQpXPNKyCGzY3=9HaQYXCXx3hsU3a_6BsFM+6Hw--v5QZUQ@mail.gmail.com>
 <20180501071112.GD12217@hirez.programming.kicks-ass.net>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 1 May 2018 11:06:08 -0700
Message-ID: <CAM_iQpXi60Ubd_-fzycSZ8fO=QSOc_nE=7GniU_t=QPAfxCbkw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: make CFS bandwidth slice per cpu group
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Turner <pjt@google.com>,
        Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 12:11 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Apr 30, 2018 at 01:37:16PM -0700, Cong Wang wrote:
>> On Mon, Apr 30, 2018 at 12:42 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Mon, Apr 30, 2018 at 12:29:25PM -0700, Cong Wang wrote:
>> >> Currently, the sched_cfs_bandwidth_slice_us is a global setting which
>> >> affects all cgroups. Different groups may want different values based
>> >> on their own workload, one size doesn't fit all. The global pool filled
>> >> periodically is per cgroup too, they should have the right to distribute
>> >> their own quota to each local CPU with their own frequency.
>> >
>> > Why.. what happens? This doesn't really tell us anything.
>>
>> We saw tasks in a container got throttled for many times even
>> when they don't apparently over-burn the CPU's. I tried to reduce
>> the sched_cfs_bandwidth_slice_us from the default 5ms to 1ms,
>> it solved the problem as no tasks got throttled after this change.
>> This is why I want to change it.
>
> The 1ms slice distributes time better at the cost of higher overhead,
> right?


Right, slightly higher. According to this paper [1]:

"While decreasing this value increases the frequency at which CPUs
request for quota from the global pool, we did not notice any measurable
impact on performance."

1. https://landley.net/kdocs/ols/2010/ols2010-pages-245-254.pdf


>
>> And I don't think 1ms will be good for all containers, so in order to
>> minimize the impact, I would like to keep the slice change within
>> each container. This is why I propose this patch rather just
>> `sysctl  -w`. Do you think otherwise?
>
> Well, I think I don't quite remember everything and a Changelog that
> tells me why you want stuff in a little more detail and helps me
> remember some things is a lot more useful than me having to go dig
> through the code myself (which I'll invariably postpone because I'm a
> busy sort of person).

Sure, you just tell me how I should improve my changelog. I didn't
realize I need to state why I need to change sched_cfs_bandwidth_slice_us
since it is already a tunable. I will add it in v2.

>
>> BTW, people reported a similar (if not same) issue here before:
>> https://gist.github.com/bobrik/2030ff040fad360327a5fab7a09c4ff1
>
> That's not a report, that's a random person on the interweb posting
> random crap. A report lands in my inbox.

Well, I found it via LKML:
https://marc.info/?l=linux-kernel&m=151270583632566&w=2

(I was too lazy to search for the original LKML link.)

I will update this patch to improve the changelog and address kbuild
warnings, if you don't object.

Thanks.
