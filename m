Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C9BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD8420685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 00:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD8420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbeKVK7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 05:59:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44696 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730835AbeKVK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 05:59:33 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB678721;
        Thu, 22 Nov 2018 00:22:48 +0000 (UTC)
Date:   Wed, 21 Nov 2018 16:22:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Primiano Tucci <primiano@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rostedt@goodmis.org,
        tglx@linutronix.de, mingo@kernel.org, linux@dominikbrodowski.net,
        jpoimboe@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ktsanaktsidis@zendesk.com, David Howells <dhowells@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Add /proc/pid_gen
Message-Id: <20181121162247.467fcab6c0aca0819a822286@linux-foundation.org>
In-Reply-To: <CAKOZuesF5zi9mpEE6No7oq0hDnM8KFhQFU=NM7qUF635s0r3-A@mail.gmail.com>
References: <20181121201452.77173-1-dancol@google.com>
        <20181121205428.165205-1-dancol@google.com>
        <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org>
        <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com>
        <20181121145043.fa029f4f91afddc2a10bb81e@linux-foundation.org>
        <CAKOZuesF5zi9mpEE6No7oq0hDnM8KFhQFU=NM7qUF635s0r3-A@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 15:21:40 -0800 Daniel Colascione <dancol@google.com> wrote:

> On Wed, Nov 21, 2018 at 2:50 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 21 Nov 2018 14:40:28 -0800 Daniel Colascione <dancol@google.com> wrote:
> >
> > > On Wed, Nov 21, 2018 at 2:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> ...
>
> > > I wouldn't call tracing a specialized thing: it's important enough to
> > > justify its own summit and a whole ecosystem of trace collection and
> > > analysis tools. We use it in every day in Android. It's tremendously
> > > helpful for understanding system behavior, especially in cases where
> > > multiple components interact in ways that we can't readily predict or
> > > replicate. Reliability and precision in this area are essential:
> > > retrospective analysis of difficult-to-reproduce problems involves
> > > puzzling over trace files and testing hypothesis, and when the trace
> > > system itself is occasionally unreliable, the set of hypothesis to
> > > consider grows. I've tried to keep the amount of kernel infrastructure
> > > needed to support this precision and reliability to a minimum, pushing
> > > most of the complexity to userspace. But we do need, from the kernel,
> > > reliable process disambiguation.
> > >
> > > Besides: things like checkpoint and restart are also non-core
> > > features, but the kernel has plenty of infrastructure to support them.
> > > We're talking about a very lightweight feature in this thread.
> >
> > I'm still not understanding the seriousness of the problem.  Presumably
> > you've hit problems in real-life which were serious and frequent enough
> > to justify getting down and writing the code.  Please share some sob stories
> > with us!
> 
> The problem here is the possibility of confusion, even if it's rare.
> Does the naive approach of just walking /proc and ignoring the
> possibility of PID reuse races work most of the time? Sure. But "most
> of the time" isn't good enough. It's not that there are tons of sob
> stories: it's that without completely robust reporting, we can't rule
> out of the possibility that weirdness we observe in a given trace is
> actually just an artifact from a kinda-sort-working best-effort trace
> collection system instead of a real anomaly in behavior. Tracing,
> essentially, gives us deltas for system state, and without an accurate
> baseline, collected via some kind of scan on trace startup, it's
> impossible to use these deltas to robustly reconstruct total system
> state at a given time. And this matters, because errors in
> reconstruction (e.g., assigning a thread to the wrong process because
> the IDs happen to be reused) can affect processing of the whole trace.
> If it's 3am and I'm analyzing the lone trace from a dogfooder
> demonstrating a particularly nasty problem, I don't want to find out
> that the trace I'm analyzing ended up being useless because the
> kernel's trace system is merely best effort. It's very cheap to be
> 100% reliable here, so let's be reliable and rule out sources of
> error.

So we're solving a problem which isn't known to occur, but solving it
provides some peace-of-mind?  Sounds thin!

btw, how should tool developers test their pid_gen-based disambiguation
code?

> > > > Which userspace tools will be using pid_gen?  Are the developers of
> > > > those tools signed up to use pid_gen?
> > >
> > > I'll be changing Android tracing tools to capture process snapshots
> > > using pid_gen, using the algorithm in the commit message.
> >
> > Which other tools could use this and what was the feedback from their
> > developers?
> 
> I'm going to have Android's systrace and Perfetto use this approach.
> Exactly how many tools signed up to use this feature do you need?

What other ones are there?

> > Those people are the intended audience and the
> > best-positioned reviewers so let's hear from them?
> 
> I'm writing plenty of trace analysis tools myself, so I'm part of this
> intended audience. Other tracing tool authors have told me about
> out-of-tree hacks for process atomic snapshots via ftrace events. This
> approach avoids the necessity of these more-invasive hacks.

Those authors would make great reviewers!  Adding a cc is cheap.

