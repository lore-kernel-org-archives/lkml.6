Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F82C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA2E20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA2E20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLGIpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:45:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbeLGIpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:45:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9997E30A315D;
        Fri,  7 Dec 2018 08:45:00 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 955495D9C6;
        Fri,  7 Dec 2018 08:44:54 +0000 (UTC)
Date:   Fri, 7 Dec 2018 09:44:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181207084453.GA1727@krava>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
 <20181206081028.GE4234@hirez.programming.kicks-ass.net>
 <20181206083400.GA13675@hirez.programming.kicks-ass.net>
 <20181206131946.2c47f556@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206131946.2c47f556@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 07 Dec 2018 08:45:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 01:19:46PM -0500, Steven Rostedt wrote:
> On Thu, 6 Dec 2018 09:34:00 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > 
> > > I don't understand this.. why are we using schedule_timeout() and all
> > > that?  
> > 
> > Urgh.. in fact, the more I look at this the more I hate it.
> > 
> > We want to block in __perf_output_begin(), but we cannot because both
> > tracepoints and perf will have preemptability disabled down there.
> > 
> > So what we do is fail the event, fake the lost count and go all the way
> > up that callstack, detect the failure and then poll-wait and retry.
> > 
> > And only do this for a few special events...  *yuck*
> 
> Since this is a special case, we should add a new option to the perf
> system call that, 1 states that it wants the traced process to block
> (and must have PTRACE permission to do so) and 2, after it reads from
> the buffer, it needs to check a bit that says "this process is blocked,
> please wake it up" and then do another perf call to kick the process to
> continue.

so instead of polling the traced process would properly wait for tracer
to kick him again after it reads/frees the buffer

I guess we could use the control mmap page (struct perf_event_mmap_page)
to communicate the 'we are block-ed' message to the tracer and have new
ioctl to wake the waiting process

jirka

> 
> I really dislike the polling too. But because this is not a default
> case, and is a new feature, we can add more infrastructure to make it
> work properly, instead of trying to hack the current method into
> something that does something poorly.
> 
> -- Steve
