Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01717C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A0521A14
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A0521A14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeHHRrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeHHRrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:47:18 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 545E721990;
        Wed,  8 Aug 2018 15:27:07 +0000 (UTC)
Date:   Wed, 8 Aug 2018 11:27:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180808112705.22e6a96d@gandalf.local.home>
In-Reply-To: <20180808144200.GM24813@linux.vnet.ibm.com>
References: <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
        <20180807204820.50b83c6d@vmware.local.home>
        <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
        <20180807215522.04114097@vmware.local.home>
        <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
        <20180807222856.3ede96e7@vmware.local.home>
        <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
        <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
        <20180808130041.GI24813@linux.vnet.ibm.com>
        <20180808102700.38c4169d@gandalf.local.home>
        <20180808144200.GM24813@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2018 07:42:00 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > There's also a local_inc() if you are using per cpu pointers, that is
> > suppose to guarantee atomicity for single cpu operations. That's what
> > the ftrace ring buffer uses.  
> 
> Good point, that becomes atomic_long_inc() or equivalent on most
> architectures, but an incl instruction (not locked) on x86.  So updating
> my earlier still-untested thought:
> 
> int __srcu_read_lock_nmi(struct srcu_struct *sp)  /* UNTESTED. */
> {
> 	int idx;
> 
> 	idx = READ_ONCE(sp->srcu_idx) & 0x1;
> 	local_inc(&sp->sda->srcu_lock_count[idx]);
> 	smp_mb__after_atomic(); /* B */  /* Avoid leaking critical section. */
> 	return idx;
> }
> 
> void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
> {
> 	smp_mb__before_atomic(); /* C */  /* Avoid leaking critical section. */
> 	local_inc(&sp->sda->srcu_unlock_count[idx]);
> }
> 
> Would that work, or is there a better way to handle this?

This would work much better than using the atomic ops, and I think it
would be doable.

I may need to revert the srcu for trace_*_rcidle() for now, as I want
most of the other changes in this merge window, and it's getting too
late to do it with these updates.

-- Steve

