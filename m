Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95CCC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9603C2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9603C2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbeK1Gtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbeK1Gtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:49:46 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D58B220873;
        Tue, 27 Nov 2018 19:50:45 +0000 (UTC)
Date:   Tue, 27 Nov 2018 14:50:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC][PATCH 03/14] arm64: function_graph: Remove use of
 FTRACE_NOTRACE_DEPTH
Message-ID: <20181127145044.53ddb58a@gandalf.local.home>
In-Reply-To: <20181127193149.GJ5641@arm.com>
References: <20181122012708.491151844@goodmis.org>
        <20181122012803.040221352@goodmis.org>
        <20181127193149.GJ5641@arm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 19:31:50 +0000
Will Deacon <will.deacon@arm.com> wrote:

> Hi Steve,
> 
> On Wed, Nov 21, 2018 at 08:27:11PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > The curr_ret_stack is no longer set to -1 when not tracing a function. It is
> > now done differently, and the FTRACE_NOTRACE_DEPTH value is no longer used.
> > Remove the reference to it.  
> 
> Do you have a pointer to the commit that changed that behaviour? I just want
> to make sure we're not missing something in our unwind_frame() code.

The commit log is slightly wrong. The -1 goes away in patch 11 of this
series (and this is patch 3). But the FTRACE_NOTRACE_DEPTH is going
away, which is why we need this patch.

> 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/arm64/kernel/stacktrace.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> > index 4989f7ea1e59..7723dadf25be 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -61,9 +61,6 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
> >  			(frame->pc == (unsigned long)return_to_handler)) {
> >  		if (WARN_ON_ONCE(frame->graph == -1))
> >  			return -EINVAL;  
> 
> Hmm, so is this code redundant too ^^ ?

Actually, it is fine before patch 11 (which I'm only going to take the
first 10 patches for the next merge window, after they are cleaned up).


> 
> > -		if (frame->graph < -1)
> > -			frame->graph += FTRACE_NOTRACE_DEPTH;
> > -  
> 
> Do we still need to initialise frame->graph in __save_stack_trace()?

You are fine till patch 11, which will probably break all this (another
reason why I'm not going to push that in the next merge window).

Ideally, we need to get rid of all users of curr_ret_stack outside of
the function graph logic. As it's going to change drastically. We need
this in order to combine function graph and kretprobes.

I'm working on a v2 that's going to be aimed at the next merge window,
that will only contain patches 1-10 of this series (and some other
updates). I'll Cc you on that entire set.

-- Steve
