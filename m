Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB0DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47942208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47942208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbeLFSTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFSTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:19:50 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE5B420868;
        Thu,  6 Dec 2018 18:19:49 +0000 (UTC)
Date:   Thu, 6 Dec 2018 13:19:46 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181206131946.2c47f556@vmware.local.home>
In-Reply-To: <20181206083400.GA13675@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
        <20181205160509.1168-2-jolsa@kernel.org>
        <20181206081028.GE4234@hirez.programming.kicks-ass.net>
        <20181206083400.GA13675@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 09:34:00 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > 
> > I don't understand this.. why are we using schedule_timeout() and all
> > that?  
> 
> Urgh.. in fact, the more I look at this the more I hate it.
> 
> We want to block in __perf_output_begin(), but we cannot because both
> tracepoints and perf will have preemptability disabled down there.
> 
> So what we do is fail the event, fake the lost count and go all the way
> up that callstack, detect the failure and then poll-wait and retry.
> 
> And only do this for a few special events...  *yuck*

Since this is a special case, we should add a new option to the perf
system call that, 1 states that it wants the traced process to block
(and must have PTRACE permission to do so) and 2, after it reads from
the buffer, it needs to check a bit that says "this process is blocked,
please wake it up" and then do another perf call to kick the process to
continue.

I really dislike the polling too. But because this is not a default
case, and is a new feature, we can add more infrastructure to make it
work properly, instead of trying to hack the current method into
something that does something poorly.

-- Steve
