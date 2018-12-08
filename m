Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA65C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ADC2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 10:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JjpzWuMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09ADC2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeLHKoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 05:44:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHKo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 05:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wtnpj+V4bXR6i59tlZfOVpAx4HX14ogX7voqGyFBYB0=; b=JjpzWuMR66L7oA5fL9jWbjTeQ
        9i2uJU9qpCvzKNkfuy9QBi2Qqlia/EvFSr4fYhPVd/DfGq2FaZSA8bqz2+D0vyzlvRXOA0EZJs+6N
        KysdE9Zf+gbFcywRgxm7hs86oGpR5IqfnzUCsRS5YEtcVqzfMq/vy7BWDWmaAOfPuJLq1lNXvz+6u
        QlbbXYZKtBPQpH1/ltf2GcDnlxF0t2KrGuOVvcM7V3MeICOqylmFKhsOdEMzz5gpMP3JBl6m8PZaT
        kYdQm4bM0C8J6dj6aKVgfSxTt4yb6WPBNvXhsIaRd+anK6vF8PmonrYc+Gvy2fOqr7qMOJCYYEDq9
        jpMxqzKzA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVa5x-0002hG-5B; Sat, 08 Dec 2018 10:44:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9996200C3E0F; Sat,  8 Dec 2018 11:44:23 +0100 (CET)
Date:   Sat, 8 Dec 2018 11:44:23 +0100
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
Message-ID: <20181208104423.GE5289@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
 <20181206081028.GE4234@hirez.programming.kicks-ass.net>
 <20181206083400.GA13675@hirez.programming.kicks-ass.net>
 <20181206131946.2c47f556@vmware.local.home>
 <20181207085839.GC2237@hirez.programming.kicks-ass.net>
 <20181207072701.5bc564c7@vmware.local.home>
 <20181207151105.GB5289@hirez.programming.kicks-ass.net>
 <20181207151433.20bf0399@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207151433.20bf0399@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 03:14:33PM -0500, Steven Rostedt wrote:
> On Fri, 7 Dec 2018 16:11:05 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Dec 07, 2018 at 08:41:18AM -0500, Steven Rostedt wrote:
> > > On Fri, 7 Dec 2018 09:58:39 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > >   
> > > > These patches give no justification *what*so*ever* for why we're doing
> > > > ugly arse things like this. And why does this, whatever this is, need to
> > > > be done in perf?
> > > > 
> > > > IOW, what problem are we solving ?  
> > > 
> > > I guess the cover letter should have had a link (or copy) of this:
> > > 
> > >  http://lkml.kernel.org/r/20181128134700.212ed035@gandalf.local.home  
> > 
> > That doesn't even begin to explain. Who cares about strace and why? And
> > why is it such a bad thing to loose the occasional record etc..
> 
> Who cares about strace? Do I really need to answer that? It's one of
> the most used tools for seeing what a program is doing.

It's a tool I haven't used in years, given we have so many better tools
around these days.

> Why do we care about lost events? Because strace records *all* events,
> as that's what it does and that's what it always has done. It would be
> a break in functionality (a regression) if it were to start losing
> events. I use strace to see everything that an application is doing.

So make a new tool; break the expectation of all events. See if there's
anybody that really cares.

> When we discussed this at plumbers, Oracle people came to me and said
> how awesome it would be to run strace against their database accesses.
> The problem today is that strace causes such a large overhead that it
> isn't feasible to trace any high speed applications, especially if
> there are time restraints involved.

So have them run that perf thing acme pointed to.

So far nobody's made a good argument for why we cannot have LOST events.
