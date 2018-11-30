Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA11FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859AF206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859AF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbeK3Vtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 16:49:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbeK3Vtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 16:49:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B7487BDAE;
        Fri, 30 Nov 2018 10:40:58 +0000 (UTC)
Received: from krava (unknown [10.43.17.17])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7350E65F62;
        Fri, 30 Nov 2018 10:40:46 +0000 (UTC)
Date:   Fri, 30 Nov 2018 11:40:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        ldv@altlinux.org, esyr@redhat.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Rough idea of implementing blocking perf calls for system call
 tracepoints
Message-ID: <20181130104044.GB3617@krava>
References: <20181128134700.212ed035@gandalf.local.home>
 <20181128141808.4b047976@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128141808.4b047976@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 30 Nov 2018 10:40:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 02:18:08PM -0500, Steven Rostedt wrote:
> 
> Adding Masami and Namhyung to this as well.
> 
> -- Steve
> 
> 
> On Wed, 28 Nov 2018 13:47:00 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > [
> >  Sorry for the late reply on this, when I got back from Plumbers, my
> >  work was really piled up, and then Turkey day came and just added more
> >  to the chaos.
> > ]
> > 
> > From our discussion at the Linux Plumbers strace talk about
> > implementing strace with perf. As strace requires to be lossless, it
> > currently can not be implemented with perf because there's always a
> > chance to lose events. The idea here is to have a way to instrument a
> > way to record system calls from perf but also block when the perf ring
> > buffer is full.
> > 
> > Below is a patch I wrote that gives an idea of what needs to be done.
> > It is by no means a real patch (wont even compile). And I left out the
> > wake up part, as I'm not familiar enough with how perf works to
> > implement it. But hopefully someone on this list can :-)
> > 
> > The idea here is that we set the tracepoints sys_enter and sys_exit
> > with a new flag called TRACE_EVENT_FL_BLOCK. When the perf code records
> > the event, if the buffer is full, it will set a "perf_block" field in
> > the current task structure to point to the tp_event, if the tp_event
> > has the BLOCK flag set.
> > 
> > Then on the exit of the syscall tracepoints, the perf_block field is
> > checked, and if it is set, it knows that the event was dropped, and
> > will add itself to a wait queue. When the reader reads the perf buffer
> > and hits a water mark, it can wake whatever is on the queue (not sure
> > where to put this queue, but someone can figure it out).
> > 
> > Once woken, it will try to write to the perf system call tracepoint
> > again (notice that it only tries perf and doesn't call the generic
> > tracepoint code, as only perf requires a repeat).
> > 
> > This is just a basic idea patch, to hopefully give someone else an idea
> > of what I envision. I think it can work, and if it does, I can imagine
> > that it would greatly improve the performance of strace!
> > 
> > Thoughts?
> > 
> > -- Steve
> > 
> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > index 3b2490b81918..57fe95950a24 100644
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -123,8 +123,22 @@ static long syscall_trace_enter(struct pt_regs *regs)
> >  	}
> >  #endif
> >  
> > -	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> > +	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT))) {
> > +		current->perf_block = NULL;
> >  		trace_sys_enter(regs, regs->orig_ax);
> > +		while (current->perf_block) {
> > +			DECLARE_WAITQUEUE(wait, current);
> > +			struct trace_event_call *tp_event = current->perf_block;
> > +
> > +			current->perf_block = NULL;
> > +
> > +			set_current_state(TASK_INTERRUPTIBLE);
> > +			add_wait_queue(&tp_event->block_queue, &wait);
> > +			perf_trace_sys_enter(tp_event, regs, regs->orig_ax);
> > +			if (current->perf_block)
> > +				schedule();

the space gets freed up by user space moving the tail pointer
so I wonder we need actualy to do some polling in here

also how about making this ring buffer feature so it's not specific
just to sys_enter/sys_exit.. I'll check

jirka
