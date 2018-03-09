Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeCISKj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbeCISKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:10:38 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0D12133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 9 Mar 2018 13:10:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Hawkins <whh8b@virginia.edu>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: x86 performance monitor counters save/restore on context switch
Message-ID: <20180309131035.550be653@vmware.local.home>
In-Reply-To: <CAE+MWFsoX2wOEiYkXsZop-K7+ehNzf5eAG-rSy7+mbqf5k0vuQ@mail.gmail.com>
References: <CAE+MWFsoX2wOEiYkXsZop-K7+ehNzf5eAG-rSy7+mbqf5k0vuQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2018 02:29:55 -0500
Will Hawkins <whh8b@virginia.edu> wrote:

> Mr. Rostedt and others interested reading on the LKML,
> 
> I hope that this is the proper venue to ask this (longwinded)
> question. If it is not, I apologize for the SPAM and wasting
> everyone's time and bits. I am emailing to ask for clarification about
> the "policy" of saving and restoring x86 performance monitor counters
> (and other PMU-related registers) on context switch in the Kernel.
> 
> Having plumbed through the code for scheduling, I get the sense that
> code in the perf subsystem is the only code that would, if conditions
> are right, save/restore performance registers on a context switch.
> 
> In my investigation, I started from the top where
> prepare_task_switch() calls perf_event_task_sched_out() and where
> finish_task_switch() calls perf_event_task_sched_in(). Having traced
> the implementation of each of those functions to (what I think is)
> their lowest levels, the Kernel will only save and restore performance
> monitor counters if:
> 
> 1. The task, process of task's CPU is actively monitoring performance.
> That monitoring would have been initiated by a user by calling
> perf_event_open() (or using a high level library that eventually calls
> that function).
> 2. The performance aspects being monitored are hardware counters/events.
> 
> I am sure that there are other conditions, but those are the two that
> stuck out to me the most.
> 
> All that is a long (perhaps incorrect) preface to a very simple question:

You above explanation appears to be mostly correct.

> 
> Is it only the performance counting registers that are actively in use
> (again, as told to the perf subsystem by a call to perf_event_open())
> that are saved/restored on context switch?
> 
> I ask because I have written code (mostly out of curiosity and not
> necessarily for production) that accesses those registers directly by
> writing/reading their values through the msr kernel module. If what I
> said above is correct, then I have to be wary of the fact that the
> values read from those counters reflect statistics from all the
> processes/threads running on the same CPU at the same time. At first
> blush, this was the way I expected the performance monitoring
> registers and counters to work, but I wanted to confirm and you seemed
> like the right person to ask.

Yes, basically the perf infrastructure "owns" the performance counters.
Any other subsystem that wants to access them should go through the
perf system. But what you are doing seems more for academic purposes
(or simply self learning). But yes, perf may interfere with your code.

> 
> If I was wrong about asking for your help, I apologize and hope that I
> didn't waste your valuable time.

The actual person to ask is Peter Zijlstra (Cc'd). He's the maintainer
of the perf infrastructure in the kernel. But he's even more busy than
I am so I'm not sure how much he'll be able to respond.

> 
> Thanks for all the work that you do on the performance monitoring
> systems for Linux -- they are invaluable for debugging those
> hard-to-find bottlenecks that inevitably pop up when you really need
> something to "just work."

Your welcome, and I hope you continue your curiosity in the Linux
kernel and enjoy learning about how the nuts and bolts all interact.

-- Steve
