Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278A9C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E012E20882
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mKnkHjVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E012E20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbeLGI6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:58:53 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33128 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eoB05H4Bsd5+uMEJ2pdlv2ktcpf6HHnlzEZwKlju6aQ=; b=mKnkHjVo09eGTnV0B5eWrpO5k
        9tZZvzhxVcqM3YW3EumzbHi4+zKX+spnUKHG6YX4Ii/kWjxOEcGGVUxMoVbAGuM4Ehlyyu46QmEqP
        YseZM+x90cMJYMJibT+bEYTPepSxiMxPyBCfdFZ4I6QUk8kyC+Yeewef8e2ArYLq4G/Jfkh2LEAAy
        0mplrlzs5D8GpdsjCcLTiq5bKWhBOFr1pohRN2/0GSt0oD1vvEnM9BtCvkYLAWd+y2b93+RTXLn8Q
        ulIpaavEXApAv654A30Tr7/Fwj3P3upjNhqfeWL49OQ/MgRQTzxpCp9jqCniQpiZZGvvpEMWnS60J
        iZK8uksHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVBy4-0005Yg-Fe; Fri, 07 Dec 2018 08:58:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45D2020726146; Fri,  7 Dec 2018 09:58:39 +0100 (CET)
Date:   Fri, 7 Dec 2018 09:58:39 +0100
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
Message-ID: <20181207085839.GC2237@hirez.programming.kicks-ass.net>
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
> 
> I really dislike the polling too. But because this is not a default
> case, and is a new feature, we can add more infrastructure to make it
> work properly, instead of trying to hack the current method into
> something that does something poorly.

So why are we doing this? What makes the syscall tracepoints so much
more special than many of the others that we need to overhaul our
fundamental design principles for them?

These patches give no justification *what*so*ever* for why we're doing
ugly arse things like this. And why does this, whatever this is, need to
be done in perf?

IOW, what problem are we solving ?
