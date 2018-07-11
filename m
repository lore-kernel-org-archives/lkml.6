Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D5C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0C320C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0C320C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbeGKNYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732562AbeGKNYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:24:05 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870FB20BF2;
        Wed, 11 Jul 2018 13:19:45 +0000 (UTC)
Date:   Wed, 11 Jul 2018 09:19:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 5/7] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180711091944.4d8e78ef@gandalf.local.home>
In-Reply-To: <20180711131256.GH2476@hirez.programming.kicks-ass.net>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-6-joel@joelfernandes.org>
        <20180711131256.GH2476@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 15:12:56 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jun 28, 2018 at 11:21:47AM -0700, Joel Fernandes wrote:
> > One note, I have to check for lockdep recursion in the code that calls
> > the trace events API and bail out if we're in lockdep recursion  
> 
> I'm not seeing any new lockdep_recursion checks...

I believe he's talking about this part:

+void trace_hardirqs_on(void)
+{
+	if (lockdep_recursing(current) || !this_cpu_read(tracing_irq_cpu))
+		return;
+

[etc]

> 
> > protection to prevent something like the following case: a spin_lock is
> > taken. Then lockdep_acquired is called.  That does a raw_local_irq_save
> > and then sets lockdep_recursion, and then calls __lockdep_acquired. In
> > this function, a call to get_lock_stats happens which calls
> > preempt_disable, which calls trace IRQS off somewhere which enters my
> > tracepoint code and sets the tracing_irq_cpu flag to prevent recursion.
> > This flag is then never cleared causing lockdep paths to never be
> > entered and thus causing splats and other bad things.  
> 
> Would it not be much easier to avoid that entirely, afaict all
> get/put_lock_stats() callers already have IRQs disabled, so that
> (traced) preempt fiddling is entirely superfluous.

Agreed. Looks like a good clean up.

-- Steve
