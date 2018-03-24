Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbeCXBVJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 21:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbeCXBVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 21:21:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4842183B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 23 Mar 2018 21:21:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelaf@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: rcu: Add might_sleep() check to synchronize_rcu()
Message-ID: <20180323212105.40766d1c@vmware.local.home>
In-Reply-To: <CAJWu+oqLnqGbuo9Y5DRJkskaMZ5=Krsxpbe1OhmEpd80CSG2mg@mail.gmail.com>
References: <alpine.DEB.2.21.1803232210110.1481@nanos.tec.linutronix.de>
        <20180323172843.763579a9@gandalf.local.home>
        <alpine.DEB.2.21.1803232232410.1481@nanos.tec.linutronix.de>
        <20180323174023.60579f45@gandalf.local.home>
        <CAJWu+oqLnqGbuo9Y5DRJkskaMZ5=Krsxpbe1OhmEpd80CSG2mg@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2018 15:57:04 -0700
Joel Fernandes <joelaf@google.com> wrote:

> > diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> > index 194a7483bb93..857b494bee29 100644
> > --- a/net/l2tp/l2tp_core.c
> > +++ b/net/l2tp/l2tp_core.c
> > @@ -1677,6 +1677,8 @@ void __l2tp_session_unhash(struct l2tp_session *session)
> >  {
> >         struct l2tp_tunnel *tunnel = session->tunnel;
> >
> > +       might_sleep();
> > +
> >         /* Remove the session from core hashes */
> >         if (tunnel) {
> >                 /* Remove from the per-tunnel hash */  
> 
> Thanks Thomas and Steven, also shouldn't this code be calling
> synchronize_rcu_bh instead of synchronize_rcu, to complement the
> rcu_read_lock_bh? In which situations would you call one versus the
> other?

Probably, as the comment above rcu_read_lock_bh is:

 * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
 *
 * This is equivalent of rcu_read_lock(), but to be used when updates
 * are being done using call_rcu_bh() or synchronize_rcu_bh(). Since
 * both call_rcu_bh() and synchronize_rcu_bh() consider completion of a
 * softirq handler to be a quiescent state, a process in RCU read-side
 * critical section must be protected by disabling softirqs.

It appears that the reason to use rcu_read_lock_bh() is if you are
calling synchronize_rcu_bh(). Otherwise, one could just be using
straight rcu_read_lock().

-- Steve
