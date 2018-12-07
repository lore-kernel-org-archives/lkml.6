Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E21C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B1520892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B1520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeLGUOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbeLGUOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:14:39 -0500
Received: from vmware.local.home (unknown [12.174.139.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C6A62082D;
        Fri,  7 Dec 2018 20:14:37 +0000 (UTC)
Date:   Fri, 7 Dec 2018 15:14:33 -0500
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
Message-ID: <20181207151433.20bf0399@vmware.local.home>
In-Reply-To: <20181207151105.GB5289@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
        <20181205160509.1168-2-jolsa@kernel.org>
        <20181206081028.GE4234@hirez.programming.kicks-ass.net>
        <20181206083400.GA13675@hirez.programming.kicks-ass.net>
        <20181206131946.2c47f556@vmware.local.home>
        <20181207085839.GC2237@hirez.programming.kicks-ass.net>
        <20181207072701.5bc564c7@vmware.local.home>
        <20181207151105.GB5289@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Dec 2018 16:11:05 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Dec 07, 2018 at 08:41:18AM -0500, Steven Rostedt wrote:
> > On Fri, 7 Dec 2018 09:58:39 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > These patches give no justification *what*so*ever* for why we're doing
> > > ugly arse things like this. And why does this, whatever this is, need to
> > > be done in perf?
> > > 
> > > IOW, what problem are we solving ?  
> > 
> > I guess the cover letter should have had a link (or copy) of this:
> > 
> >  http://lkml.kernel.org/r/20181128134700.212ed035@gandalf.local.home  
> 
> That doesn't even begin to explain. Who cares about strace and why? And
> why is it such a bad thing to loose the occasional record etc..

Who cares about strace? Do I really need to answer that? It's one of
the most used tools for seeing what a program is doing.

Why do we care about lost events? Because strace records *all* events,
as that's what it does and that's what it always has done. It would be
a break in functionality (a regression) if it were to start losing
events. I use strace to see everything that an application is doing.

Peter, I think you've spent too much time in the kernel. There's a
whole world out there that lives in userspace ;-)

When we discussed this at plumbers, Oracle people came to me and said
how awesome it would be to run strace against their database accesses.
The problem today is that strace causes such a large overhead that it
isn't feasible to trace any high speed applications, especially if
there are time restraints involved.

If you don't like this for perf, I'll be happy to implement something in
ftrace. I just figured that the perf interface was more suitable for
something like this.

-- Steve
