Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756836AbeDZQID (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:08:03 -0400
Received: from mail.efficios.com ([167.114.142.138]:40896 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756519AbeDZQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:08:02 -0400
Date: Thu, 26 Apr 2018 12:08:00 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelaf@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>, fweisbec <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>,
        kernel-team <kernel-team@lge.com>
Message-ID: <749188693.2028.1524758880738.JavaMail.zimbra@efficios.com>
In-Reply-To: <1609895968.1947.1524754982656.JavaMail.zimbra@efficios.com>
References: <20180423172244.694dbc9d@gandalf.local.home> <68e4c123-a223-5e26-e57a-da2515041bf3@google.com> <20180425001049.GX26088@linux.vnet.ibm.com> <20180425042056.GA21412@linux.vnet.ibm.com> <CAJWu+orWC=W0Jn2Jo7f+u5mbHMi+D1yuCmhD-xSgjWZ6Ynw32Q@mail.gmail.com> <1267842641.1791.1524692456344.JavaMail.zimbra@efficios.com> <20180425185149.64f89922@vmware.local.home> <1609895968.1947.1524754982656.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: irqflags: Avoid unnecessary calls to trace_ if you can
Thread-Index: mybaxXBBKgbWEr/xuPnyKoKZZ+t8+0wkJ/6Q
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 26, 2018, at 11:03 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 25, 2018, at 6:51 PM, rostedt rostedt@goodmis.org wrote:
> 
>> On Wed, 25 Apr 2018 17:40:56 -0400 (EDT)
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> 
>>> One problem with your approach is that you can have multiple callers
>>> for the same tracepoint name, where some could be non-preemptible and
>>> others blocking. Also, there is then no clear way for the callback
>>> registration API to enforce whether the callback expects the tracepoint
>>> to be blocking or non-preemptible. This can introduce hard to diagnose
>>> issues in a kernel without debug options enabled.
>> 
>> I agree that it should not be tied to an implementation name. But
>> "blocking" is confusing. I would say "can_sleep" or some such name that
>> states that the trace point caller is indeed something that can sleep.
> 
> "trace_*event*_{can,might,may}_sleep" are all acceptable candidates for
> me.
> 
>> 
>>> 
>>> Regarding the name, I'm OK with having something along the lines of
>>> trace_*event*_blocking or such. Please don't use "srcu" or other naming
>>> that is explicitly tied to the underlying mechanism used internally
>>> however: what we want to convey is that this specific tracepoint probe
>>> can be preempted and block. The underlying implementation could move to
>>> a different RCU flavor brand in the future, and it should not impact
>>> users of the tracepoint APIs.
>>> 
>>> In order to ensure that probes that may block only register themselves
>>> to tracepoints that allow blocking, we should introduce new tracepoint
>>> declaration/definition *and* registration APIs also contain the
>>> "BLOCKING/blocking" keywords (or such), so we can ensure that a
>>> tracepoint probe being registered to a "blocking" tracepoint is indeed
>>> allowed to block.
>> 
>> I'd really don't want to add more declaration/definitions, as we
>> already have too many as is, and with different meanings and the number
>> is of incarnations is n! in growth.
>> 
>> I'd say we just stick with a trace_<event>_can_sleep() call, and make
>> sure that if that is used that no trace_<event>() call is also used, and
>> enforce this with linker or compiler tricks.
> 
> My main concern is not about having both trace_<event>_can_sleep() mixed
> with trace_<event>() calls. It's more about having a registration API allowing
> modules registering probes that may need to sleep to explicitly declare it,
> and enforce that tracepoint never connects a probe that may need to sleep
> with an instrumentation site which cannot sleep.
> 
> I'm unsure what's the best way to achieve this goal though. We could possibly
> extend the tracepoint_probe_register_* APIs to introduce e.g.
> tracepoint_probe_register_prio_flags() and provide a TRACEPOINT_PROBE_CAN_SLEEP
> as parameter upon registration. If this flag is provided, then we could figure
> out
> an way to iterate on all callers, and ensure they are all "can_sleep" type of
> callers.

Iteration on all callers would require that we add some separate section data
for each caller, which we don't have currently. At the moment, the only data
we need is at the tracepoint definition. If we have tons of callers for a given
tracepoint (which might be the case for lockdep), we'd end up consuming a lot of
useless space.

This is one reason why I would prefer to have separate tracepoint definitions
for each of rcuidle, can_sleep, and nonpreemptible (nmi-safe) tracepoints.

Thanks,

Mathieu


> 
> Thoughts ?
> 
> Thanks,
> 
> Mathieu
> 
> 
> 
>> 
>> -- Steve
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
