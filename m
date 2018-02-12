Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeBLRJ0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:09:26 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36397 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeBLRJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:09:24 -0500
X-Google-Smtp-Source: AH8x224oniNbrvNo/Ia7Jh7AYycPxDTE3RXRlaJ++HIOI56YGcg1tpc2wGO7AlFm13o4lauZ8wDIRA==
Date: Mon, 12 Feb 2018 18:09:20 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, alessio.balsini@arm.com
Subject: Re: [RFC PATCH 2/3] sched/deadline: add task groups bandwidth
 management support
Message-ID: <20180212170920.GM12979@localhost.localdomain>
References: <20180212134030.12846-1-juri.lelli@redhat.com>
 <20180212134030.12846-3-juri.lelli@redhat.com>
 <20180212164726.GT695913@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212164726.GT695913@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/02/18 08:47, Tejun Heo wrote:
> Hello,
> 
> On Mon, Feb 12, 2018 at 02:40:29PM +0100, Juri Lelli wrote:
> >  - implementation _is not_ hierarchical: only single/plain DEADLINE entities
> >    can be handled, and they get scheduled at root rq level
> 
> This usually is a deal breaker and often indicates that the cgroup
> filesystem is not the right interface for the feature.  Can you please
> elaborate the interface with some details?

The interface is the same as what we have today for groups of RT tasks,
and same rules apply. The difference is that when using RT
<group>/cpu.rt_runtime_us and <group>/cpu.rt_period_us control
RT-Throttling behaviour (fraction of CPU time and granularity), while
for DEADLINE the same interface would be used only at admission control
time (while servicing a sched_setattr(), attaching tasks to a group or
changing group's parameters) since DEADLINE task have their own
throttling mechanism already.

Intended usage should be very similar. For example, a sys admin that
wants to reserve and guarantee CPU bandwidth for a group of tasks would
create a group, configure its rt_runtime_us, rt_period_us and put
DEADLINE tasks inside it (e.g. video/audio pipeline). Related to what I
was saying in the cover letter (i.e., non root access to DEADLINE
scheduling) might be a different situation, where sys admin wants to
grant a user a certain percentage of CPU time (by creating a group and
putting user session inside it) and also control that user doesn't
exceed what granted. User would then be free to spawn DEADLINE tasks to
service her/his needs up to the maximum bandwidth cap set by sys admin.

Does this make any sense and provide a bit more information?

Thanks a lot for looking at this!

Best,

- Juri
