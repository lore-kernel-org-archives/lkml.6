Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05488C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978D422408
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 12:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHQG9M5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978D422408
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeHJPZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 11:25:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbeHJPZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 11:25:04 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61B0C22402;
        Fri, 10 Aug 2018 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533905715;
        bh=4kB2hzrvaM4F0t2fZ7Z8lQLsM5sS40LsGT9f2FZDSAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HHQG9M5+27BdUpMN+nSrIeum2ANM0MXhP7dRh3BDQAudG2WkGgDAOkeFib/W7JbyC
         IRZ9X1WkAJN/EaK3WoNbCLhdo5kRjM6X0gmeErEAk0L3FNoa1Ar45bxhoKBiFUf/ER
         sPnmYcX5mgrJk9waJM7eNsOKdhVgrpCJFwdb6t+8=
Date:   Fri, 10 Aug 2018 21:55:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH ftrace/core] tracing: irqsoff: Account for additional
 preempt_disable
Message-Id: <20180810215511.60d5882c8efd271c01043881@kernel.org>
In-Reply-To: <CAJWu+orzTpcjAcWRmgE8bLtK6BfzfQ_SW1WMho5Y-nsiACTCyQ@mail.gmail.com>
References: <20180806034049.67949-1-joel@joelfernandes.org>
        <20180806230536.ef217b2c2c008838606bedc3@kernel.org>
        <CAJWu+orzTpcjAcWRmgE8bLtK6BfzfQ_SW1WMho5Y-nsiACTCyQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2018 07:14:35 -0700
Joel Fernandes <joelaf@google.com> wrote:

> On Mon, Aug 6, 2018 at 7:05 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > On Sun,  5 Aug 2018 20:40:49 -0700
> > "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> >
> >> Recently we tried to make the preemptirqsoff tracer to use irqsoff
> >> tracepoint probes. However this causes issues as reported by Masami:
> >>
> >> [2.271078] Testing tracer preemptirqsoff: .. no entries found ..FAILED!
> >> [2.381015] WARNING: CPU: 0 PID: 1 at /home/mhiramat/ksrc/linux/kernel/
> >> trace/trace.c:1512 run_tracer_selftest+0xf3/0x154
> >>
> >> This is due to the tracepoint code increasing the preempt nesting count
> >> by calling an additional preempt_disable before calling into the
> >> preemptoff tracer which messes up the preempt_count() check in
> >> tracer_hardirqs_off.
> >>
> >> To fix this, make the irqsoff tracer probes balance the additional outer
> >> preempt_disable with a preempt_enable_notrace.
> >
> > I've tested it and ensured this fixes the problem.
> >
> > Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks!
> 
> >> The other way to fix this is to just use SRCU for all tracepoints.
> >> However we can't do that because we can't use NMIs from RCU context.
> >>
> >> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints
> >>                       and unify their usage")
> >> Fixes: e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use SRCU")
> >> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> ---
> >>  kernel/trace/trace_irqsoff.c | 26 ++++++++++++++++++++++++++
> >>  1 file changed, 26 insertions(+)
> >>
> >> diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
> >> index 770cd30cda40..ffbf1505d5bc 100644
> >> --- a/kernel/trace/trace_irqsoff.c
> >> +++ b/kernel/trace/trace_irqsoff.c
> >> @@ -603,14 +603,40 @@ static void irqsoff_tracer_stop(struct trace_array *tr)
> >>   */
> >>  static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
> >>  {
> >
> > To ensure this function must not be preempted even if we increment preempt
> > count, I think you should check irq_disabled() whole this process, put below
> > here.
> >
> >         if (unlikely(!irq_disabled()))
> >                 return;
> >
> > Since irq_disabled() will be checked in irq_trace() anyway, so no problem
> > to return here when !irq_disabled().
> 
> IRQs can never be enabled here. The trace hooks are called only after
> disabling interrupts, or before enabling them. Right?
> 

Even though, it should be verified or atleast commented on the function header.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
