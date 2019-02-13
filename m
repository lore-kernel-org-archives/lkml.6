Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAA4C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746762190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="faK+Gtoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbfBMKRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:17:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfBMKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/oU9SvWlCnENZtlKtyyf5ybjpGtKB+WJ4OcFd68pSLE=; b=faK+GtooOLXw0HoqcqlCstdHj
        3BemihliwlQmy6br5kGRzdLHlke/gkiZWQP+McQUYoS+VOoP6N3rR//Fef8I51PxMThSci9cTmwDx
        8OmxQx5j5EmUc3MQ7pekv8tWFAbhQLR9MpgE2dEr6vkaEVdDhVjIOhKLYxSkIMMpq/KcJNfdGyi0a
        6P8X2chPxSwhoN5ZOypRLJWLgqxbdWlsfsy2I/HJySMJ1Ig5v5Vp9Pp75iPxbSNNS88mCQyLjZxEi
        mM5HgIHC9HJRY7ldKRPS+awBr/U6YLtMntRNDix/kpp7wP7DRvECtabpFmNUFuWHSTOsXIh6GyXCA
        TRX3ckFTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtraw-00031b-Gw; Wed, 13 Feb 2019 10:16:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEDC320F51B0C; Wed, 13 Feb 2019 11:16:44 +0100 (CET)
Date:   Wed, 13 Feb 2019 11:16:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+352bd10e338d9a90e5e0@syzkaller.appspotmail.com>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in event_function_local
Message-ID: <20190213101644.GN32534@hirez.programming.kicks-ass.net>
References: <001a1140589435c9b60563c76e3f@google.com>
 <CACT4Y+bVG7eoLWndM3McQpf3FN+JxEm9Xyrg0H0gg6UiUFC62A@mail.gmail.com>
 <CAGXu5jJ-+P+p_SsO1X-LJ43RbEG2cYbiV_EYubWoh3mUVRBK9A@mail.gmail.com>
 <20190212211449.5f48bee1@gandalf.local.home>
 <CAGXu5j+Z=ns37DdNU-mYtfio1cW4c25jyAGwFx74YFXKM5SD1A@mail.gmail.com>
 <20190213095158.GM32494@hirez.programming.kicks-ass.net>
 <20190213095726.GM32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213095726.GM32534@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:57:26AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 13, 2019 at 10:51:58AM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 12, 2019 at 07:40:12PM -0800, Kees Cook wrote:
> > 
> > > > > Is this maybe just an unlucky condition with the event loop running in
> > > > > an IRQ? Should the WARN be expected, or is running under an IRQ
> > > > > unexpected?
> > > 
> > > Is perf expected to fire during an IRQ? The task == current test seems
> > > suspicious if so...
> > 
> > So the only possible callchain here is:
> > 
> >   <PMI>
> >     ...
> >       perf_event_disable_inatomic()
> >         irq_work_queue()
> > 
> >   <irq_work-IPI>
> >     perf_pending_event()
> >       perf_event_disable_local()
> >         event_function_local()
> > 
> > 
> > The assertion states that:
> > 
> >   if the event is a task event; and the context is active, it _must_ be
> >   the same task.
> > 
> > Because: if the PMI happens during ctxsw (which has IRQs disabled), the
> > IPI will not happen until after the ctxsw, at which point we'll also
> > have switched out the perf context of that task -- IOW the context
> > should be inactive.
> > 
> > 
> > Anyway, it looks like a virt issue; I'll start caring once you can
> > reproduce on real hardware.
> 
> Hurm.. I might have spoken too soon. I still don't give a crap about
> virt, but I think I might see an actual problem.
> 
> The moment we re-enable IRQs after ctxsw, the task can already be
> running on another CPU, and _that_ would trigger failure here.
> 
> Let me think a little about that.

Humm, but in that case:

  context_switch()
    prepare_task_switch()
      perf_event_task_sched_out()
        __perf_event_task_sched_out()
	  perf_event_context_sched_out()
	    task_ctx_sched_out()
	      ctx_sched_out()
	        group_sched_out()
		  event_sched_out()
		    if (event->pending_disable)

Would have already cleared the pending_disable state, so the IPI would
not have ran perf_event_disable_local() in the first place.


