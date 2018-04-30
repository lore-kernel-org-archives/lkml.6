Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755718AbeD3Uhi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 16:37:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33981 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755226AbeD3Uhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 16:37:37 -0400
X-Google-Smtp-Source: AB8JxZoukFiYBOoplDsGjM9sAenN4Xn/70nCrb9BfOcTUbyemJuJ23svySzkk9W7U6SvhJ6PY/eTRxzt0X8g5lkBujQ=
MIME-Version: 1.0
In-Reply-To: <20180430194251.GB12217@hirez.programming.kicks-ass.net>
References: <20180430192925.12589-1-xiyou.wangcong@gmail.com> <20180430194251.GB12217@hirez.programming.kicks-ass.net>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 30 Apr 2018 13:37:16 -0700
Message-ID: <CAM_iQpXPNKyCGzY3=9HaQYXCXx3hsU3a_6BsFM+6Hw--v5QZUQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: make CFS bandwidth slice per cpu group
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Turner <pjt@google.com>,
        Mike Galbraith <efault@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 12:42 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Apr 30, 2018 at 12:29:25PM -0700, Cong Wang wrote:
>> Currently, the sched_cfs_bandwidth_slice_us is a global setting which
>> affects all cgroups. Different groups may want different values based
>> on their own workload, one size doesn't fit all. The global pool filled
>> periodically is per cgroup too, they should have the right to distribute
>> their own quota to each local CPU with their own frequency.
>
> Why.. what happens? This doesn't really tell us anything.

We saw tasks in a container got throttled for many times even
when they don't apparently over-burn the CPU's. I tried to reduce
the sched_cfs_bandwidth_slice_us from the default 5ms to 1ms,
it solved the problem as no tasks got throttled after this change.
This is why I want to change it.

And I don't think 1ms will be good for all containers, so in order to
minimize the impact, I would like to keep the slice change within
each container. This is why I propose this patch rather just
`sysctl  -w`. Do you think otherwise?

BTW, people reported a similar (if not same) issue here before:
https://gist.github.com/bobrik/2030ff040fad360327a5fab7a09c4ff1

Thanks!
