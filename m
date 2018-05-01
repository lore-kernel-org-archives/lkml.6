Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755825AbeEAPYF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:24:05 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51945 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755316AbeEAPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:24:04 -0400
X-Google-Smtp-Source: AB8JxZrqtjwgc5QSToCtyBiFGtLNooIWlXieqQNlJmZtTpnXoRdff1a3KW/iFfAFnqIQqwFYLKgoe+45+4C35vc+pxg=
MIME-Version: 1.0
References: <20180501014204.67548-1-joelaf@google.com> <20180501014204.67548-6-joelaf@google.com>
 <20180501102401.2cac5781@gandalf.local.home> <20180501143601.GG26088@linux.vnet.ibm.com>
 <CAJWu+op-7oyiO7p_pvWJhcy4UBBwGZRxcuoxzW_GefPr40h-xQ@mail.gmail.com> <20180501152135.GJ26088@linux.vnet.ibm.com>
In-Reply-To: <20180501152135.GJ26088@linux.vnet.ibm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 01 May 2018 15:23:52 +0000
Message-ID: <CAJWu+oqO0WQwK-iU76D0zWE-A=-pHRPwzh3WG8yWq13G=c7HhQ@mail.gmail.com>
Subject: Re: [PATCH RFC v5 5/6] tracepoint: Make rcuidle tracepoint callers
 use SRCU
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 8:20 AM Paul E. McKenney <paulmck@linux.vnet.ibm.com>
wrote:
[...]
> > > > > --- a/kernel/tracepoint.c
> > > > > +++ b/kernel/tracepoint.c
> > > > > @@ -31,6 +31,9 @@
> > > > >  extern struct tracepoint * const __start___tracepoints_ptrs[];
> > > > >  extern struct tracepoint * const __stop___tracepoints_ptrs[];
> > > > >
> > > > > +DEFINE_SRCU(tracepoint_srcu);
> > > > > +EXPORT_SYMBOL_GPL(tracepoint_srcu);
> > > > > +
> > > > >  /* Set to 1 to enable tracepoint debug output */
> > > > >  static const int tracepoint_debug;
> > > > >
> > > > > @@ -67,11 +70,16 @@ static inline void *allocate_probes(int count)
> > > > >     return p == NULL ? NULL : p->probes;
> > > > >  }
> > > > >
> > > > > -static void rcu_free_old_probes(struct rcu_head *head)
> > > > > +static void srcu_free_old_probes(struct rcu_head *head)
> > > > >  {
> > > > >     kfree(container_of(head, struct tp_probes, rcu));
> > > > >  }
> > > > >
> > > > > +static void rcu_free_old_probes(struct rcu_head *head)
> > > > > +{
> > > > > +   call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> > > >
> > > > Hmm, is it OK to call call_srcu() from a call_rcu() callback? I
guess
> > > > it would be.
> >
> > > It is perfectly legal, and quite a bit simpler than setting something
> > > up to wait for both to complete concurrently.
> >
> > Cool. Also in this case if we call both in sequence, then I felt there
> > could be a race to free the old data since both callbacks would try to
do
> > the same thing. The same thing being freeing of the same set of old
probes
> > which would need some synchronization between the 2 callbacks. With the
> > chaining, since the ordering is assured there wouldn't be a question of
> > such a race. I could add this reasoning to the changelog as well.

> Actually, as long as you have a solid happens-before between both of the
> callbacks and the freeing, you are in good shape.  A release-acquire would
> work fine, as would a lock acquired in both callbacks and then acquired
> (and possibly released) before the free.

Got it, thanks. For now, if its Ok with you and others, I will leave it in
the chained configuration. I also feel this is temporary since in the
future if we switch to single rcu mechanism for tracepoints (srcu), then we
could do with just a single callback.

thanks,

- Joel
