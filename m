Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D646C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C4B214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5C4B214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeLFIZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:25:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFIZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:25:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA08A3082A25;
        Thu,  6 Dec 2018 08:25:01 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id ADA735C6BE;
        Thu,  6 Dec 2018 08:24:56 +0000 (UTC)
Date:   Thu, 6 Dec 2018 09:24:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20181206082455.GA22061@krava>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
 <20181206081028.GE4234@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206081028.GE4234@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 06 Dec 2018 08:25:02 +0000 (UTC)
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

the idea is to block the process and try to deliver the event later

the ring buffer space is freed by user space process moving the tail
pointer, so I can't see doing this other way than polling

jirka
