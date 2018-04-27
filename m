Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758679AbeD0QWg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:22:36 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45881 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932901AbeD0QWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:22:06 -0400
X-Google-Smtp-Source: AB8JxZoO4ugQ0vwYhbwSefAh8VSq74IEAI81rKgkjrnsAFN/LVfJeFdKEt4NhMaBml9URGs2WEC+kceaZRe0utvUZ7w=
MIME-Version: 1.0
In-Reply-To: <20180427121330.40b7ef15@gandalf.local.home>
References: <20180427042656.190746-1-joelaf@google.com> <20180427155701.GL26088@linux.vnet.ibm.com>
 <20180427121330.40b7ef15@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 27 Apr 2018 09:22:04 -0700
Message-ID: <CAJWu+oqcbdvnN=wdas9CYykCmqUKChnWWk6HScb=6VJO03eG4w@mail.gmail.com>
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks executing
 with preempt on
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
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

On Fri, Apr 27, 2018 at 9:13 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 27 Apr 2018 08:57:01 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>
>> > +           if (preempt_on) {                                       \
>> > +                   WARN_ON_ONCE(in_nmi()); /* no srcu from nmi */  \
>>
>> Very good on this check, thank you!
>
> I think you need to return and not call the read lock.
>
>                         if (WARN_ON_ONCE(in_nmi()))
>                                 return;

Cool, I'll do that.

>>
>> > +                   idx = srcu_read_lock(&tracepoint_srcu);         \
>>
>> Hmmm...  Do I need to create a _notrace variant of srcu_read_lock()
>> and srcu_read_unlock()?
>
> I think so.

Oh yes, since otherwise we call into lockdep.

Paul, then I think that's true we'd need srcu _notrace variants that
don't do the rcu_lock_acquire. Sorry for my earlier email saying its
not needed. Thanks,

- Joel
