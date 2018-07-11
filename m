Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A445FC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D6A208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D6A208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbeGKNEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732544AbeGKNEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:04:20 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D53AF2086B;
        Wed, 11 Jul 2018 13:00:04 +0000 (UTC)
Date:   Wed, 11 Jul 2018 09:00:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20180711090003.42596c2b@gandalf.local.home>
In-Reply-To: <20180711124954.GE2476@hirez.programming.kicks-ass.net>
References: <20180628182149.226164-1-joel@joelfernandes.org>
        <20180628182149.226164-5-joel@joelfernandes.org>
        <20180711124954.GE2476@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 14:49:54 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:
> > -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\  
> 
> I would convert to rcu_dereference_raw() to appease sparse. The fancy
> stuff below is pointless if you then turn off all checking.

The problem with doing this is if we use a trace event without the
proper _idle() or whatever, we wont get a warning that it is used
incorrectly with lockdep. Or does lockdep still check if "rcu is
watching" with rcu_dereference_raw()?

-- Steve

> 
> > +									\
> > +		/*							\
> > +		 * For rcuidle callers, use srcu since sched-rcu	\
> > +		 * doesn't work from the idle path.			\
> > +		 */							\
> > +		if (rcuidle) {						\
> > +			if (in_nmi()) {					\
> > +				WARN_ON_ONCE(1);			\
> > +				return; /* no srcu from nmi */		\
> > +			}						\
> > +									\
> > +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> > +			it_func_ptr =					\
> > +				srcu_dereference_notrace((tp)->funcs,	\
> > +						&tracepoint_srcu);	\
> > +			/* To keep it consistent with !rcuidle path */	\
> > +			preempt_disable_notrace();			\
> > +		} else {						\
> > +			rcu_read_lock_sched_notrace();			\
> > +			it_func_ptr =					\
> > +				rcu_dereference_sched((tp)->funcs);	\
> > +		}							\  

