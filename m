Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382C4C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E204D20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p9mTeqXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E204D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeLFIeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:34:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbeLFIeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ONFyfTx4XoHLGomaNmbNLBbW+kIFqc3btqfoGekkR3E=; b=p9mTeqXXvFRzbw2o62k3mwyC5
        Zu+FAuQ8R3XSIGEiDP+bWRPjgxcIGh82WLBdrBc5iJrJJCkAXTuF9o9iJj92uwuINJIQ5DI5xJ8ua
        oHzYzAEBWQWA9d/gm9AmwjdMHKdlzWnMYhm4dpY8+Erpm6pMC41z1IPOCVq2zSj5HLNdZ4uTavsiL
        Bb3yIAQUnB9qNIdGdFAGumHokIfz1STekkU1DpAyv6yN+Cy3CA1c2OO3F6jB32etYJc7vA/h6k3z6
        VF7hpBEItPZ/swijZQBUP6CPXw9+j/dgO3ATYkHFPsMwfj7cHZnoQsZEKnlYUQrZ1fDOSoPRt2ckn
        AGunW4EDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUp6g-00055k-Db; Thu, 06 Dec 2018 08:34:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC354205B6DA1; Thu,  6 Dec 2018 09:34:00 +0100 (CET)
Date:   Thu, 6 Dec 2018 09:34:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181206083400.GA13675@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
 <20181206081028.GE4234@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206081028.GE4234@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:10:28AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 05, 2018 at 05:05:02PM +0100, Jiri Olsa wrote:
> > +static void trace_block_syscall(struct pt_regs *regs, bool enter)
> > +{
> > +	current->perf_blocked = true;
> > +
> > +	do {
> > +		schedule_timeout(100 * HZ);
> > +		current->perf_blocked_cnt = 0;
> > +
> > +		if (enter) {
> > +			/* perf syscalls:* enter */
> > +			perf_trace_syscall_enter(regs);
> > +
> > +			/* perf raw_syscalls:* enter */
> > +			perf_trace_sys_enter(&event_sys_enter, regs, regs->orig_ax);
> > +		} else {
> > +			/* perf syscalls:* enter */
> > +			perf_trace_syscall_exit(regs);
> > +
> > +			/* perf raw_syscalls:* enter */
> > +			perf_trace_sys_exit(&event_sys_exit, regs, regs->ax);
> > +		}
> > +	} while (current->perf_blocked_cnt);
> > +
> > +	current->perf_blocked = false;
> > +}
> 
> I don't understand this.. why are we using schedule_timeout() and all
> that?

Urgh.. in fact, the more I look at this the more I hate it.

We want to block in __perf_output_begin(), but we cannot because both
tracepoints and perf will have preemptability disabled down there.

So what we do is fail the event, fake the lost count and go all the way
up that callstack, detect the failure and then poll-wait and retry.

And only do this for a few special events...  *yuck*
