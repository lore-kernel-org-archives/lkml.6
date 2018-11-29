Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD94C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAF5206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAF5206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeK2O2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:28:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeK2O2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:28:32 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A472086B;
        Thu, 29 Nov 2018 03:24:38 +0000 (UTC)
Date:   Wed, 28 Nov 2018 22:24:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] kernel/trace: fix watchdog soft lockup
Message-ID: <20181128222436.2d29ca9a@vmware.local.home>
In-Reply-To: <CAK8P3a1tONAdbfncqzEYW_Q8LOrprez+8fYsCTTK9+d+O1Mc3w@mail.gmail.com>
References: <20181128081334.18408-1-anders.roxell@linaro.org>
        <20181128090903.7a27ae58@gandalf.local.home>
        <CAK8P3a1tONAdbfncqzEYW_Q8LOrprez+8fYsCTTK9+d+O1Mc3w@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 23:24:26 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Nov 28, 2018 at 3:09 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 28 Nov 2018 09:13:34 +0100
> > Anders Roxell <anders.roxell@linaro.org> wrote:
> >  
> > > When building a allmodconfig kernel for arm64 and boot that in qemu,
> > > CONFIG_FTRACE_STARTUP_TEST gets enabled and that takes time so the
> > > watchdog expires and prints out a message like this:
> > > 'watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]'
> > > Each time the function ftrace_replace_code gets called it stays in that
> > > functions loop for 41424 times.
> > > Rework so that function cond_resched() gets called in the
> > > ftrace_replace_code loop.
> > >
> > > Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > ---
> > >  kernel/trace/ftrace.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index 5b4f73e4fd56..3f456921dedf 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -2426,6 +2426,10 @@ void __weak ftrace_replace_code(int enable)
> > >
> > >       do_for_each_ftrace_rec(pg, rec) {
> > >
> > > +             /* This loop can take minutes when sanitizers are enabled, so
> > > +              * lets make sure we allow RCU processing.
> > > +              */
> > > +             cond_resched();
> > >               if (rec->flags & FTRACE_FL_DISABLED)
> > >                       continue;
> > >  
> >
> > NACK.  On some architectures this code is run from stop machine. We
> > can't call cond_resched() because it may be called with interrupts
> > disabled.
> >
> > This is a weak function. If arm64 has special needs, just copy it in
> > the arm64 code.  
> 
> I think it's currently broken on all architectures that don't already
> override it, the problem being that the function is simply too
> expensive when all debug options are enabled.

Would it be possible to add something like touch_nmi_watchdog()?

> 
> In an ARM64 allmodconfig kernel, there are 41424 records
> that we iterate through several times. In an earlier version of the
> test, the cond_resched() was only in the loop in
> init_trace_selftests(), and I think that is safe and should /mostly/
> solve the problem, so maybe Anders can submit that version again.
> 
> However, at least trace_selftest_ops() still takes half a minute
> to complete in qemu, and that triggers the softlockup watchdog.
> trace_selftest_ops() calls ftrace_replace_code() four or five times.

And I don't have a problem with adding cond_resched() there. I'm
concerned about adding it where it can be called with interrupts and/or
preemption disabled.

> 
> Here is the excerpt with printk times from one of Anders' tests:
> 
> [    8.350607] Running postponed tracer tests:
> [    8.356045] Testing tracer function:
> [   18.932077] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   27.454205] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   27.462594] PASSED
> [   27.462954] Testing dynamic ftrace:
> [   28.510903] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   28.746934] PASSED
> [   28.747469] Testing dynamic ftrace ops #1:
> [   32.488427] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   32.501864] (1 0 1 0 0)
> [   32.502041] (1 1 2 0 0)
> [   50.213914] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   50.219736] (2 1 3 0 1066085)
> [   50.220077] (2 2 4 0 1066100)
> [   60.580678] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   60.758019] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   60.910501] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   60.918354] PASSED
> [   60.919672] Testing dynamic ftrace ops #2:
> [   64.680222] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   64.843430] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   81.247068] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   81.250895] (1 0 1 1033119 0)
> [   81.251186] (1 1 2 1033134 0)
> [   81.343168] (2 1 3 1 3732)
> [   81.344492] (2 2 4 118 3849)
> [   89.837665] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   89.844371] PASSED
> [   89.844719] Testing ftrace recursion:
> [   90.890373] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   91.042146] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   91.048475] PASSED
> [   91.048806] Testing ftrace recursion safe:
> [   92.091174] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   92.242403] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   92.249119] PASSED
> [   92.249470] Testing ftrace regs(no arch support):
> [   93.293605] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   93.444942] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [   93.451738] PASSED
> [   93.452300] Testing tracer nop: PASSED
> [   93.453288] Testing tracer irqsoff:
> [  104.486368] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [  112.918828] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [  112.925809] PASSED
> [  112.926435] Testing tracer function_graph:
> [  123.303248] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [  132.599763] ../kernel/trace/ftrace.c:2441, loop_counter: 41424
> [  132.607614] PASSED
> 
> In particular, the test_probe3 in trace_selftest_ops() takes
> around 20 seconds, or 482 microseconds per loop iteration
> in ftrace_replace_code().
> Do you think there is another bug that makes it slower than
> expected, or is that a reasonable time that it could take?

Well, if you are doing it under qemu and with all the debug options
set, I could expect it to take that long.

-- Steve
