Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AAAC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594D720685
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="teBd8OLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594D720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbeKHAdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:33:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbeKHAdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BajKpttSdO7/u9+SqfsSWgXtf+a5roYCBshOi+zDIoE=; b=teBd8OLTjDM6u7Dj5SPgIGPGH
        sq1f81gjG0CGgek4t+6tUdmPzfRxai9NdmiFoZuztBE4GQGGmxwg4Cn2NHuCA20VgOdRqju6i6I0J
        O4H9b2J2y4S/v6tcIBc0qk7OuMGhH+IaKoiKZIr6MGrZmMA4d4PfQmSe6RsDFOTArwCN5MDbIVwvf
        sghwIQQTz2yBn9xTNlDI9aJqyAuWP5rHRdnDx3C8SuAetC07z4YpmDfM2V+cNCPjxBSAktfu2/CgO
        MXVCuC2jbQBlInALAFyo75DZGDdx8pZKRdpPWi8acObalLW34DVkUWbtE7vdoOSPIuAz3LLagKzyV
        pjkWW+k7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKPLc-0004Zd-EV; Wed, 07 Nov 2018 15:02:24 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D4E0F20284F94; Wed,  7 Nov 2018 16:02:21 +0100 (CET)
Date:   Wed, 7 Nov 2018 16:02:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        bristot@redhat.com, linux-rt-users@vger.kernel.org,
        mtk.manpages@gmail.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] kernel/time/posix-cpu-timers: Remove useless call to
 check_dl_overrun
Message-ID: <20181107150221.GJ9761@hirez.programming.kicks-ass.net>
References: <20181107111032.32291-1-juri.lelli@redhat.com>
 <20181107095627.13e9c187@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181107095627.13e9c187@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 09:56:27AM -0500, Steven Rostedt wrote:
> On Wed,  7 Nov 2018 12:10:32 +0100
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > check_dl_overrun is used to send a SIGXCPU to users that asked to be
> > informed when SCHED_DEADLINE runtime overruns occur.
> > 
> > The function is called by check_thread_timers already, so the call in
> > check_process_timers is redundant/wrong (even though harmless).
> > 
> > Remove it.
> > 
> > Fixes: 34be39305a77 ("sched/deadline: Implement "runtime overrun signal" support")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Luca Abeni <luca.abeni@santannapisa.it>
> > Cc: Claudio Scordino <claudio@evidence.eu.com>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  kernel/time/posix-cpu-timers.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> > index ce32cf741b25..8f0644af40be 100644
> > --- a/kernel/time/posix-cpu-timers.c
> > +++ b/kernel/time/posix-cpu-timers.c
> > @@ -917,9 +917,6 @@ static void check_process_timers(struct task_struct *tsk,
> >  	struct task_cputime cputime;
> >  	unsigned long soft;
> >  
> > -	if (dl_task(tsk))
> > -		check_dl_overrun(tsk);
> > -
> 
> Hmm, I wonder if we should just move this check directly into
> run_posix_cpu_timers() directly. Why is it hidden in this call?

It is not; it is duplicated in this call. The one in
check_thread_timeres() makes sense (it is a thread property).
