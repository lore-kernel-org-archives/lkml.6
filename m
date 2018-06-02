Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeFBDfq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 23:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbeFBDfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 23:35:43 -0400
X-Google-Smtp-Source: ADUXVKLCPxnuRgRujk1LR3bj3AF+gpXZ93qiacoiWReTIRp5Jx/957Zm4+YnDzO8eodnoIkFbys+eaz8JUDnwmneiRI=
MIME-Version: 1.0
References: <20180601082811.4c0d33ba@imladris.surriel.com> <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
 <1527877328.7898.80.camel@surriel.com> <1527878882.4448.11.camel@gmx.de>
 <1527882207.7898.86.camel@surriel.com> <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
 <1527885324.7898.88.camel@surriel.com> <CALCETrWMouz7VzYgwC=Ys3-C2O7ZVCn4FNwesH1np4c9iG1g_A@mail.gmail.com>
 <20180601181327.367f0fe3@imladris.surriel.com>
In-Reply-To: <20180601181327.367f0fe3@imladris.surriel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 1 Jun 2018 20:35:29 -0700
X-Gmail-Original-Message-ID: <CALCETrXTLqcro4uu5f77EmeaDvNqGZNLpsk-w_BApRNmzvcz=Q@mail.gmail.com>
Message-ID: <CALCETrXTLqcro4uu5f77EmeaDvNqGZNLpsk-w_BApRNmzvcz=Q@mail.gmail.com>
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

On Fri, Jun 1, 2018 at 3:13 PM Rik van Riel <riel@surriel.com> wrote:
>
> On Fri, 1 Jun 2018 14:21:58 -0700
> Andy Lutomirski <luto@kernel.org> wrote:
>
> > Hmm.  I wonder if there's a more clever data structure than a bitmap
> > that we could be using here.  Each CPU only ever needs to be in one
> > mm's cpumask, and each cpu only ever changes its own state in the
> > bitmask.  And writes are much less common than reads for most
> > workloads.
>
> It would be easy enough to add an mm_struct pointer to the
> per-cpu tlbstate struct, and iterate over those.
>
> However, that would be an orthogonal change to optimizing
> lazy TLB mode.
>
> Does the (untested) patch below make sense as a potential
> improvement to the lazy TLB heuristic?
>
> ---8<---
> Subject: x86,tlb: workload dependent per CPU lazy TLB switch
>
> Lazy TLB mode is a tradeoff between flushing the TLB and touching
> the mm_cpumask(&init_mm) at context switch time, versus potentially
> incurring a remote TLB flush IPI while in lazy TLB mode.
>
> Whether this pays off is likely to be workload dependent more than
> anything else. However, the current heuristic keys off hardware type.
>
> This patch changes the lazy TLB mode heuristic to a dynamic, per-CPU
> decision, dependent on whether we recently received a remote TLB
> shootdown while in lazy TLB mode.
>
> This is a very simple heuristic. When a CPU receives a remote TLB
> shootdown IPI while in lazy TLB mode, a counter in the same cache
> line is set to 16. Every time we skip lazy TLB mode, the counter
> is decremented.
>
> While the counter is zero (no recent TLB flush IPIs), allow lazy TLB mode.

Hmm, cute.  That's not a bad idea at all.  It would be nice to get
some kind of real benchmark on both PCID and !PCID.  If nothing else,
I would expect the threshold (16 in your patch) to want to be lower on
PCID systems.

--Andy
