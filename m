Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbeFAPLV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 11:11:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751422AbeFAPLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 11:11:20 -0400
X-Google-Smtp-Source: ADUXVKKeTMlGmV4i9kDXuxFuRWZdVgjXLUvkuPwEAgqTRhNYKUMYWFfu5jWdGBagAGRSy4uJGvfirnzWrl64NbM9BAo=
MIME-Version: 1.0
References: <20180601082811.4c0d33ba@imladris.surriel.com>
In-Reply-To: <20180601082811.4c0d33ba@imladris.surriel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 1 Jun 2018 08:11:06 -0700
X-Gmail-Original-Message-ID: <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
Message-ID: <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
To: riel@surriel.com
Cc: LKML <linux-kernel@vger.kernel.org>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 5:28 AM Rik van Riel <riel@surriel.com> wrote:
>
> Song noticed switch_mm_irqs_off taking a lot of CPU time in recent
> kernels,using 2.4% of a 48 CPU system during a netperf to localhost run.
> Digging into the profile, we noticed that cpumask_clear_cpu and
> cpumask_set_cpu together take about half of the CPU time taken by
> switch_mm_irqs_off.
>
> However, the CPUs running netperf end up switching back and forth
> between netperf and the idle task, which does not require changes
> to the mm_cpumask. Furthermore, the init_mm cpumask ends up being
> the most heavily contended one in the system.`
>
> Skipping cpumask_clear_cpu and cpumask_set_cpu for init_mm
> (mostly the idle task) reduced CPU use of switch_mm_irqs_off
> from 2.4% of the CPU to 1.9% of the CPU, with the following
> netperf commandline:

I'm conceptually fine with this change.  Does mm_cpumask(&init_mm) end
up in a deterministic state?

Mike, depending on exactly what's going on with your benchmark, this
might help recover a bit of your performance, too.

--Andy
