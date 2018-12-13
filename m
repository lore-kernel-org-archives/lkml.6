Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE4BC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FA920880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FA920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeLML3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:29:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbeLML33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:29:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2DC80C04B948;
        Thu, 13 Dec 2018 11:29:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 54FB7607BD;
        Thu, 13 Dec 2018 11:29:23 +0000 (UTC)
Date:   Thu, 13 Dec 2018 12:29:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181213112922.GD731@krava>
References: <20181207085839.GC2237@hirez.programming.kicks-ass.net>
 <20181207072701.5bc564c7@vmware.local.home>
 <20181207151105.GB5289@hirez.programming.kicks-ass.net>
 <20181207151433.20bf0399@vmware.local.home>
 <20181208104423.GE5289@hirez.programming.kicks-ass.net>
 <20181208123805.1c158665@vmware.local.home>
 <20181210101818.GJ5289@hirez.programming.kicks-ass.net>
 <20181213003938.GD24195@altlinux.org>
 <20181212202639.1978ec88@vmware.local.home>
 <20181213100149.GF5289@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213100149.GF5289@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 13 Dec 2018 11:29:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 11:01:49AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 12, 2018 at 08:26:39PM -0500, Steven Rostedt wrote:
> > On Thu, 13 Dec 2018 03:39:38 +0300
> > "Dmitry V. Levin" <ldv@altlinux.org> wrote:
> > 
> > > btw, I didn't ask for the implementation to be ugly.
> > > You don't have to introduce polling into the kernel if you don't want to,
> > > userspace is perfectly capable of invoking wait4(2) in a loop.
> > > Just block the tracee, notify the tracer, and let it pick up the pieces.
> > 
> > Note, there's been some discussion offlist to only have perf set a flag
> > when it dropped an event and have the ptrace code do the heavy lifting
> > of blocking the task and waking it back up. I think that would be a
> > cleaner solution and wont muck with perf as badly.
> 
> It's still really horrid -- the question is not if we can come up with
> something, anything, to make strace work. The question is if we can
> extend something in a sane and maintainable manner to allow this.
> 
> So there's a whole bunch of problems I see with all this, in no
> particular order:
> 
>  - we cannot block when writing to the actual buffer, and have to unroll
>    the callstack and bolt on the blocking manualy in a few specific
>    sites. This is ugly, inconsistent and maintenance heavy.
> 
>  - it only works for some 'magic' events that got the treatment, but not
>    for many other you might expect it to work for with no real
>    indication which and why.
> 
>  - the wakeups side is icky; the best I can come up with is making the
>    data page R/O and single stepping on write fault, but that isn't
>    multi-threading safe.
> 
>    Another alternative would be keeping the whole page R/O and
>    using write(2) or an ioctl() to update the head pointer.
> 
> Again, if we're going to do this; it needs to be done well and
> consistent and not as a special hack to enable strace-like
> functionality. And without clean and sane solutions to the above I just
> don't see it happening.
> 
> Note that the first 2 points are equally true for ftrace; so I don't see
> how we could sanely add it there either.
> 
> 
> One, very big maybe, would be to add a new tracepoint type that includes
> a might_sleep() and we very carefully undo all the preempt_disable and
> go sleep where we should. That also gives the tracepoint crud the
> information it needs to publish the capability to userspace.

nice, I like this one.. seems like the most clean solution

jirka
