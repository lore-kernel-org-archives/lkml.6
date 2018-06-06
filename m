Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkKJ4QEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6066606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeFFSSD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752243AbeFFSSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:18:01 -0400
X-Google-Smtp-Source: ADUXVKJsrceQb3obGj/SMlh3EqA4n9JPtXXP9oxNJ3a+Kgdax/hD9CEV4mxHWBFDs5HQ//peFepYMPp5WFuxYZhj8zM=
MIME-Version: 1.0
References: <20180601082811.4c0d33ba@imladris.surriel.com> <CALCETrUVFdrtorJBVg1fizUx+c23MVVqNnzGs3oWpN8LHyEvMA@mail.gmail.com>
 <1527877328.7898.80.camel@surriel.com> <1527878882.4448.11.camel@gmx.de>
 <1527882207.7898.86.camel@surriel.com> <CALCETrVE5ugmiSOjQ5sw7V+S4bRpMDs419rgrbTzfvjfhbWeqA@mail.gmail.com>
 <1527885324.7898.88.camel@surriel.com> <CALCETrWMouz7VzYgwC=Ys3-C2O7ZVCn4FNwesH1np4c9iG1g_A@mail.gmail.com>
 <20180601181327.367f0fe3@imladris.surriel.com> <CALCETrXTLqcro4uu5f77EmeaDvNqGZNLpsk-w_BApRNmzvcz=Q@mail.gmail.com>
 <1527915842.7898.93.camel@surriel.com> <CALCETrW5m3Y3CGnRZwDTMT9g-1an_LO6Fp_6FWOokydhN9BDLQ@mail.gmail.com>
 <A87157D6-4A0A-44F8-8AC8-4411F5EDC57A@fb.com> <1527989886.7898.96.camel@surriel.com>
In-Reply-To: <1527989886.7898.96.camel@surriel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 6 Jun 2018 11:17:46 -0700
X-Gmail-Original-Message-ID: <CALCETrU6bqVyBzeMu9RSoXq1Fm6rdHA6rDskqVqo5+W9snkz=A@mail.gmail.com>
Message-ID: <CALCETrU6bqVyBzeMu9RSoXq1Fm6rdHA6rDskqVqo5+W9snkz=A@mail.gmail.com>
Subject: Re: [PATCH] x86,switch_mm: skip atomic operations for init_mm
To: Rik van Riel <riel@surriel.com>
Cc: songliubraving@fb.com, Andrew Lutomirski <luto@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <Kernel-team@fb.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 2, 2018 at 6:38 PM Rik van Riel <riel@surriel.com> wrote:
>
> On Sun, 2018-06-03 at 00:51 +0000, Song Liu wrote:
>
> > > Just to check: in the workload where you're seeing this problem,
> > > are
> > > you using an mm with many threads?  I would imagine that, if you
> > > only
> > > have one or two threads, the bit operations aren't so bad.
> >
> > Yes, we are running netperf/netserver with 300 threads. We don't see
> > this much overhead in with real workload.
>
> We may not, but there are some crazy workloads out
> there in the world. Think of some Java programs with
> thousands of threads, causing a million context
> switches a second on a large system.
>
> I like Andy's idea of having one cache line with
> a cpumask per node. That seems like it will have
> fewer downsides for tasks with fewer threads running
> on giant systems.
>
> I'll throw out the code I was working on, and look
> into implementing that :)
>

I'm not sure you should throw your patch out.  It's a decent idea, too.
