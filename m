Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E031C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B2820989
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TPSHxGNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B2820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeLMKCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:02:06 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46304 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeLMKCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=upU6/3DRlL7qGnvecNbuZgynNoun3auT7kwd1krvQDE=; b=TPSHxGNyUR2+1BBPGXK4CMoNk
        jJbvEzZGl7GARniCiEAhFt1D0H/5c0ueJOWYs8TvC4rLCt1/AnhHO7dfq/qdfqEqlSuaBiobjYq7b
        J+ZWw21aPR3hQyFO3NTtBuLUDWsdlDY0oyOTuwljySQmShhR7155jaXjupJCSvw/fs6f5+REbV0SJ
        srMH5tTTgMH9kT1dm5Bn5feTk8Mm4Vwwvc1tjKWPM6bK8EwloFuPRjZGoFMLG1ede66RYMBrhzhuj
        96gtoSDKxXErpOXyKaMwT29lLQLr44YfEByvyk6Jq9HwFenRbiyfUizSIQ4A9cnAFql+xrCgR8o+e
        E8f2+hs1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXNoV-0002fw-3r; Thu, 13 Dec 2018 10:01:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CE72207261FC; Thu, 13 Dec 2018 11:01:49 +0100 (CET)
Date:   Thu, 13 Dec 2018 11:01:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>, Jiri Olsa <jolsa@kernel.org>,
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
Message-ID: <20181213100149.GF5289@hirez.programming.kicks-ass.net>
References: <20181206131946.2c47f556@vmware.local.home>
 <20181207085839.GC2237@hirez.programming.kicks-ass.net>
 <20181207072701.5bc564c7@vmware.local.home>
 <20181207151105.GB5289@hirez.programming.kicks-ass.net>
 <20181207151433.20bf0399@vmware.local.home>
 <20181208104423.GE5289@hirez.programming.kicks-ass.net>
 <20181208123805.1c158665@vmware.local.home>
 <20181210101818.GJ5289@hirez.programming.kicks-ass.net>
 <20181213003938.GD24195@altlinux.org>
 <20181212202639.1978ec88@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212202639.1978ec88@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 08:26:39PM -0500, Steven Rostedt wrote:
> On Thu, 13 Dec 2018 03:39:38 +0300
> "Dmitry V. Levin" <ldv@altlinux.org> wrote:
> 
> > btw, I didn't ask for the implementation to be ugly.
> > You don't have to introduce polling into the kernel if you don't want to,
> > userspace is perfectly capable of invoking wait4(2) in a loop.
> > Just block the tracee, notify the tracer, and let it pick up the pieces.
> 
> Note, there's been some discussion offlist to only have perf set a flag
> when it dropped an event and have the ptrace code do the heavy lifting
> of blocking the task and waking it back up. I think that would be a
> cleaner solution and wont muck with perf as badly.

It's still really horrid -- the question is not if we can come up with
something, anything, to make strace work. The question is if we can
extend something in a sane and maintainable manner to allow this.

So there's a whole bunch of problems I see with all this, in no
particular order:

 - we cannot block when writing to the actual buffer, and have to unroll
   the callstack and bolt on the blocking manualy in a few specific
   sites. This is ugly, inconsistent and maintenance heavy.

 - it only works for some 'magic' events that got the treatment, but not
   for many other you might expect it to work for with no real
   indication which and why.

 - the wakeups side is icky; the best I can come up with is making the
   data page R/O and single stepping on write fault, but that isn't
   multi-threading safe.

   Another alternative would be keeping the whole page R/O and
   using write(2) or an ioctl() to update the head pointer.

Again, if we're going to do this; it needs to be done well and
consistent and not as a special hack to enable strace-like
functionality. And without clean and sane solutions to the above I just
don't see it happening.

Note that the first 2 points are equally true for ftrace; so I don't see
how we could sanely add it there either.


One, very big maybe, would be to add a new tracepoint type that includes
a might_sleep() and we very carefully undo all the preempt_disable and
go sleep where we should. That also gives the tracepoint crud the
information it needs to publish the capability to userspace.

We also have to consider (and possibly forbid) mixing blocking and
!blocking events to the same buffer.
