Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbeFAVWO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 17:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbeFAVWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 17:22:13 -0400
X-Google-Smtp-Source: ADUXVKJ8B+JM7RItZojRJFmNk+a0PqKj+/G4V+lyhiaIb6wtii8znmELtreVbwtkXGqgNkoP8JYcD9HM8Kt/DzWvTn8=
MIME-Version: 1.0
References: <20180601082811.4c0d33ba@imladris.surriel.com> <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
 <1527877328.7898.80.camel@surriel.com> <1527878882.4448.11.camel@gmx.de>
 <1527882207.7898.86.camel@surriel.com> <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
 <1527885324.7898.88.camel@surriel.com>
In-Reply-To: <1527885324.7898.88.camel@surriel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 1 Jun 2018 14:21:58 -0700
X-Gmail-Original-Message-ID: <CALCETrWMouz7VzYgwC=Ys3-C2O7ZVCn4FNwesH1np4c9iG1g_A@mail.gmail.com>
Message-ID: <CALCETrWMouz7VzYgwC=Ys3-C2O7ZVCn4FNwesH1np4c9iG1g_A@mail.gmail.com>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
To: riel@surriel.com
Cc: Andrew Lutomirski <luto@kernel.org>, Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 1, 2018 at 1:35 PM Rik van Riel <riel@surriel.com> wrote:
>
> On Fri, 2018-06-01 at 13:03 -0700, Andy Lutomirski wrote:
> > Mike, you never did say: do you have PCID on your CPU?  Also, what is
> > your workload doing to cause so many switches back and forth between
> > init_mm and a task.
> >
> > The point of the optimization is that switching to init_mm() should
> > be
> > fairly fast on a PCID system, whereas an IPI to do the deferred flush
> > is very expensive regardless of PCID.
>
> While I am sure that bit is true, Song and I
> observed about 4x as much CPU use in the atomic
> operations in cpumask_clear_cpu and cpumask_set_cpu
> (inside switch_mm_irqs_off) as we saw CPU used
> in the %cr3 reload itself.
>
> Given how expensive those cpumask updates are,
> lazy TLB mode might always be worth it, especially
> on larger systems.
>

Hmm.  I wonder if there's a more clever data structure than a bitmap
that we could be using here.  Each CPU only ever needs to be in one
mm's cpumask, and each cpu only ever changes its own state in the
bitmask.  And writes are much less common than reads for most
workloads.
