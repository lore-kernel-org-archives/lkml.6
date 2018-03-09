Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeCIH36 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 02:29:58 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:44962 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeCIH34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 02:29:56 -0500
X-Google-Smtp-Source: AG47ELuM8TrGC3np964LQqAjKzWXoP2dpYhHDy+3SM/UgY9ZsmR8fhTrDD4fbCVb+V4Fb0XuRjArwMPIT/feAmrP9OE=
MIME-Version: 1.0
From: Will Hawkins <whh8b@virginia.edu>
Date: Fri, 9 Mar 2018 02:29:55 -0500
Message-ID: <CAE+MWFsoX2wOEiYkXsZop-K7+ehNzf5eAG-rSy7+mbqf5k0vuQ@mail.gmail.com>
Subject: x86 performance monitor counters save/restore on context switch
To: Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Rostedt and others interested reading on the LKML,

I hope that this is the proper venue to ask this (longwinded)
question. If it is not, I apologize for the SPAM and wasting
everyone's time and bits. I am emailing to ask for clarification about
the "policy" of saving and restoring x86 performance monitor counters
(and other PMU-related registers) on context switch in the Kernel.

Having plumbed through the code for scheduling, I get the sense that
code in the perf subsystem is the only code that would, if conditions
are right, save/restore performance registers on a context switch.

In my investigation, I started from the top where
prepare_task_switch() calls perf_event_task_sched_out() and where
finish_task_switch() calls perf_event_task_sched_in(). Having traced
the implementation of each of those functions to (what I think is)
their lowest levels, the Kernel will only save and restore performance
monitor counters if:

1. The task, process of task's CPU is actively monitoring performance.
That monitoring would have been initiated by a user by calling
perf_event_open() (or using a high level library that eventually calls
that function).
2. The performance aspects being monitored are hardware counters/events.

I am sure that there are other conditions, but those are the two that
stuck out to me the most.

All that is a long (perhaps incorrect) preface to a very simple question:

Is it only the performance counting registers that are actively in use
(again, as told to the perf subsystem by a call to perf_event_open())
that are saved/restored on context switch?

I ask because I have written code (mostly out of curiosity and not
necessarily for production) that accesses those registers directly by
writing/reading their values through the msr kernel module. If what I
said above is correct, then I have to be wary of the fact that the
values read from those counters reflect statistics from all the
processes/threads running on the same CPU at the same time. At first
blush, this was the way I expected the performance monitoring
registers and counters to work, but I wanted to confirm and you seemed
like the right person to ask.

If I was wrong about asking for your help, I apologize and hope that I
didn't waste your valuable time.

Thanks for all the work that you do on the performance monitoring
systems for Linux -- they are invaluable for debugging those
hard-to-find bottlenecks that inevitably pop up when you really need
something to "just work."

Will



.
