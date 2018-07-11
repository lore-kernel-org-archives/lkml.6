Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FF0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44D520C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fek9HVl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44D520C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389011AbeGKPXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:23:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeGKPXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TmjdlVm2FSdDIyJReqTK/GYUcJaHymyseCLV45QVl5Q=; b=Fek9HVl7s5Nsc83Be6lGwEdO6
        kv/lXVkielAwYb2GF4g4I14f2gUlYqy/bkpas7qEHcUA358qdHn8YL69WImjP3JHQtaULYHoC+tFI
        3F0L/HYTSuGx83uA7nWoeSQwumYHZhyuaLIsRPE+7uM/m7jXHAYXo/8FRupX1lLR1HuPh/pR21ITe
        CW152EclHENnCtTf2gpz+37RDTcXtYE2BdsGwDVEMVXkpEoXzlYmtnng0RLIzIgdQch1hyC/DK8lg
        zpJ3OXPBu5jHTKcqjh2wCfFRQLQpHXc9lQ3oKmYkGLwrA67Sy00GJQqTrPJioOXdWffg1Ys0d+o9O
        WSIN2qNmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdGsN-0006to-M2; Wed, 11 Jul 2018 15:17:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC3F22029764D; Wed, 11 Jul 2018 17:17:51 +0200 (CEST)
Date:   Wed, 11 Jul 2018 17:17:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180711151751.GI2476@hirez.programming.kicks-ass.net>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-5-joel@joelfernandes.org>
 <20180711125647.GG2476@hirez.programming.kicks-ass.net>
 <20180711090649.68af40f9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711090649.68af40f9@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:06:49AM -0400, Steven Rostedt wrote:
> On Wed, 11 Jul 2018 14:56:47 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:
> > >  static inline void tracepoint_synchronize_unregister(void)
> > >  {
> > > +	synchronize_srcu(&tracepoint_srcu);
> > >  	synchronize_sched();
> > >  }  
> > 
> > Given you below do call_rcu_sched() and then call_srcu(), isn't the
> > above the wrong way around?
> 
> Good catch!
> 
> 	release_probes()
> 		call_rcu_sched()
> 			---> rcu_free_old_probes() queued
> 
> 	tracepoint_synchronize_unregister()
> 		synchronize_srcu(&tracepoint_srcu);
> 			< finishes right away >
> 		synchronize_sched()
> 			--> rcu_free_old_probes()
> 				--> srcu_free_old_probes() queued
> 	
> Here tracepoint_synchronize_unregister() returned before the srcu
> portion ran.

I just read the comment that goes with that function; the order doesn't
matter. All we want to ensure is that the unregistration is visible to
either sched or srcu tracepoint users.
