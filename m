Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75940C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3984220838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XwoLGFMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3984220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeLFKcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:32:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47346 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbeLFKcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DGYQk7vI3DnBFbptreoayds/ya7DdrjWY71T0XCzcPI=; b=XwoLGFMstNUyf1MdeanKQJJRp
        CDWnpm70n6Tnv8Kjvv+Z3iLLpIo/yZdLKg8dyhMP+XK4EdTLzpxkTuA8VO1o3g/Z2j3T6gdaPxWh5
        BWlZAcfCGJ6ZSkgDB8/veHcj67iUOhOCDxjjcVYi72S10vs5IQP51+7PZSzMu/P7tncjhLSLzYROQ
        /daki4SZdhx/8zHgC9A4mnHKbD0+XtAkAHFmvurXc43drF1CCsxYN5Rl2sjN8Q1dQDEy70cGelPwC
        IzRbjbHhQko7ekOciEKw8TGZ9q0CFOO+jvU3J1xINaeSD5L1xRYZTBHYcF15hpoXjnIr5CFheZIE9
        MSjUDQ1hQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUqwi-0005aC-CO; Thu, 06 Dec 2018 10:31:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D4FE200F9F91; Thu,  6 Dec 2018 11:31:51 +0100 (CET)
Date:   Thu, 6 Dec 2018 11:31:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181206103151.GH13538@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
 <20181206081028.GE4234@hirez.programming.kicks-ass.net>
 <20181206082455.GA22061@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206082455.GA22061@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:24:55AM +0100, Jiri Olsa wrote:
> On Thu, Dec 06, 2018 at 09:10:28AM +0100, Peter Zijlstra wrote:
> > On Wed, Dec 05, 2018 at 05:05:02PM +0100, Jiri Olsa wrote:
> > > +static void trace_block_syscall(struct pt_regs *regs, bool enter)
> > > +{
> > > +	current->perf_blocked = true;
> > > +
> > > +	do {
> > > +		schedule_timeout(100 * HZ);
> > > +		current->perf_blocked_cnt = 0;
> > > +
> > > +		if (enter) {
> > > +			/* perf syscalls:* enter */
> > > +			perf_trace_syscall_enter(regs);
> > > +
> > > +			/* perf raw_syscalls:* enter */
> > > +			perf_trace_sys_enter(&event_sys_enter, regs, regs->orig_ax);
> > > +		} else {
> > > +			/* perf syscalls:* enter */
> > > +			perf_trace_syscall_exit(regs);
> > > +
> > > +			/* perf raw_syscalls:* enter */
> > > +			perf_trace_sys_exit(&event_sys_exit, regs, regs->ax);
> > > +		}
> > > +	} while (current->perf_blocked_cnt);
> > > +
> > > +	current->perf_blocked = false;
> > > +}
> > 
> > I don't understand this.. why are we using schedule_timeout() and all
> > that?
> 
> the idea is to block the process and try to deliver the event later
> 
> the ring buffer space is freed by user space process moving the tail
> pointer, so I can't see doing this other way than polling

Right, figured that out.

I really really hate this stuff. poll-waiting fundamentally stinks, but
also perf is designed to not/minimally interfere with the observed
tasks, as is ftrace.

And bolting, as it really doesn't fit in the fundamental design, this
fugly thing on top for this special case.. urgh.
