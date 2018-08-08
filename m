Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B70DC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E56219E6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E56219E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeHHQq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727396AbeHHQq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:46:58 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC151219C9;
        Wed,  8 Aug 2018 14:27:02 +0000 (UTC)
Date:   Wed, 8 Aug 2018 10:27:00 -0400
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
Message-ID: <20180808102700.38c4169d@gandalf.local.home>
In-Reply-To: <20180808130041.GI24813@linux.vnet.ibm.com>
References: <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
        <20180807194515.4e549c1a@gandalf.local.home>
        <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
        <20180807204820.50b83c6d@vmware.local.home>
        <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
        <20180807215522.04114097@vmware.local.home>
        <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
        <20180807222856.3ede96e7@vmware.local.home>
        <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
        <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
        <20180808130041.GI24813@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2018 06:00:41 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> I suppose that an srcu_read_lock_nmi() and srcu_read_unlock_nmi() could
> be added, which would do atomic ops on sp->sda->srcu_lock_count.  Not sure
> whether this would be fast enough to be useful, but easy to provide:
> 
> int __srcu_read_lock_nmi(struct srcu_struct *sp)  /* UNTESTED. */
> {
> 	int idx;
> 
> 	idx = READ_ONCE(sp->srcu_idx) & 0x1;
> 	atomic_inc(&sp->sda->srcu_lock_count[idx]);
> 	smp_mb__after_atomic(); /* B */  /* Avoid leaking critical section. */
> 	return idx;
> }
> 
> void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
> {
> 	smp_mb__before_atomic(); /* C */  /* Avoid leaking critical section. */
> 	atomic_inc(&sp->sda->srcu_unlock_count[idx]);
> }
> 
> With appropriate adjustments to also allow Tiny RCU to also work.
> 
> Note that you have to use _nmi() everywhere, not just in NMI handlers.
> In fact, the NMI handlers are the one place you -don't- need to use
> _nmi(), strangely enough.
> 
> Might be worth a try -- smp_mb__{before,after}_atomic() is a no-op on
> some architectures, for example.

Note this would kill the performance that srcu gives that Joel wants.
Switching from a this_cpu_inc() to a atomic_inc() would be a huge
impact.

There's also a local_inc() if you are using per cpu pointers, that is
suppose to guarantee atomicity for single cpu operations. That's what
the ftrace ring buffer uses.

-- Steve
