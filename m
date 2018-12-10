Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A580C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4266620821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mNJp2Z7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4266620821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeLJKSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:18:42 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56618 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeLJKSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=itu9hc9/z9YcrGCrf9vsiWkRxeMGVAIeV48qvUZMUlg=; b=mNJp2Z7pRBP3RW/TTTP3hz6Ga
        NyHiT+mE4Q9t/sUfSaLIGYt9DTXBqDejpiD1haNGcMsk6z2CZ5UYqPHUnQo0DRlPuBdDG/i9wgqHn
        x8XqUeOROq+ob3gD0YixmiGEjAnLSteTli+MymAFDq0sYixP9ayNkE97Y86OgZ7nqej1Y0yT0K7jJ
        Rw699Z24rCYAYWyTSbdih+S2HuqkdSQuJcMBYS+EqDTpcX1WrJpJXSTvmn/Xrkt+eKnpGjEgbky6O
        OJu4qRg8ubMVNu6yqY8jhqPgvsxX0DxwkTMI8AGQAMLMOg+0U6oZKLTlDjtFnHJNoqGUXFkJE1uaY
        uVZhWqTcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWIdn-0003FW-QR; Mon, 10 Dec 2018 10:18:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 292132075A8BB; Mon, 10 Dec 2018 11:18:18 +0100 (CET)
Date:   Mon, 10 Dec 2018 11:18:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20181210101818.GJ5289@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-2-jolsa@kernel.org>
 <20181206081028.GE4234@hirez.programming.kicks-ass.net>
 <20181206083400.GA13675@hirez.programming.kicks-ass.net>
 <20181206131946.2c47f556@vmware.local.home>
 <20181207085839.GC2237@hirez.programming.kicks-ass.net>
 <20181207072701.5bc564c7@vmware.local.home>
 <20181207151105.GB5289@hirez.programming.kicks-ass.net>
 <20181207151433.20bf0399@vmware.local.home>
 <20181208104423.GE5289@hirez.programming.kicks-ass.net>
 <20181208123805.1c158665@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208123805.1c158665@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 12:38:05PM -0500, Steven Rostedt wrote:
> On Sat, 8 Dec 2018 11:44:23 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:

> > > Why do we care about lost events? Because strace records *all* events,
> > > as that's what it does and that's what it always has done. It would be
> > > a break in functionality (a regression) if it were to start losing
> > > events. I use strace to see everything that an application is doing.  
> > 
> > So make a new tool; break the expectation of all events. See if there's
> > anybody that really cares.
> 
> Basically you are saying, break strace and see if anyone notices?

Nah, give it a new name. Clearly mark this is a new tool.

> > > When we discussed this at plumbers, Oracle people came to me and said
> > > how awesome it would be to run strace against their database accesses.
> > > The problem today is that strace causes such a large overhead that it
> > > isn't feasible to trace any high speed applications, especially if
> > > there are time restraints involved.  
> > 
> > So have them run that perf thing acme pointed to.
> > 
> > So far nobody's made a good argument for why we cannot have LOST events.
> 
> If you don't see the use case, I'm not sure anyone can convince you.
> Again, I like the fact that when I do a strace of an application I know
> that all system calls that the application I'm tracing is recorded. I
> don't need to worry about what happened in the "lost events" space.

You're the one pushing for this crap without _any_ justification. Why
are you getting upset if I ask for some?

If people care so much, it shouldn't be hard to write up a coherent
story on this, so far all I seem to get is: because it's always been
like that.

Which really isn't much of an argument.
