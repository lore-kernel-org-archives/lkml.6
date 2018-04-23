Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbeDWRYP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:24:15 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37489 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755286AbeDWRYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:24:13 -0400
X-Google-Smtp-Source: AB8JxZpHCdRR4317Gsa2HGl6FPwTFgIvaxIvHdhGSzt4/RYWINvKTHmUd3Mh/Xy8cVx+6JDhzV5kDcadg73MIxOsO18=
MIME-Version: 1.0
In-Reply-To: <1212130312.14753.1524503541789.JavaMail.zimbra@efficios.com>
References: <20180417040748.212236-1-joelaf@google.com> <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com>
 <CAJWu+opGN5+h4=ggKcQGnqG8h1LvtMjD_XQywU7=ULjjyS-v6w@mail.gmail.com>
 <20180423031926.GF26088@linux.vnet.ibm.com> <409016827.14587.1524493888181.JavaMail.zimbra@efficios.com>
 <20180423105325.7d5d245b@gandalf.local.home> <1045420715.14686.1524495583859.JavaMail.zimbra@efficios.com>
 <20180423121800.47b173af@gandalf.local.home> <1212130312.14753.1524503541789.JavaMail.zimbra@efficios.com>
From: Joel Fernandes <joelaf@google.com>
Date: Mon, 23 Apr 2018 10:24:11 -0700
Message-ID: <CAJWu+orGDvo77vG9k9AZBBQ7WCNPyVj0yAfr5BNqw7=ASaJd3g@mail.gmail.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you can
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rostedt <rostedt@goodmis.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Mon, Apr 23, 2018 at 10:12 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- On Apr 23, 2018, at 12:18 PM, rostedt rostedt@goodmis.org wrote:
>
>> On Mon, 23 Apr 2018 10:59:43 -0400 (EDT)
>> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>>> The main open question here is whether we want one SRCU grace period
>>> domain per SRCU tracepoint definition, or just one SRCU domain for all
>>> SRCU tracepoints would be fine.
>>>
>>> I'm not sure what we would gain by having the extra granularity provided
>>> by one SRCU grace period domain per tracepoint, and having a single SRCU
>>> domain for all SRCU tracepoints makes it easy to batch grace period after
>>> bulk tracepoint modifications.
>>>
>>> Thoughts ?
>>
>> I didn't think too much depth in this. It was more of just a brain
>> storming idea. Yeah, one singe RCU domain may be good enough. I was
>> thinking more of how to know when a tracepoint required the SRCU domain
>> as supposed to a preempt disabled domain, and wanted to just suggest
>> the linker script approach.
>>
>> This is how I detect if trace_printk() is used anywhere in the kernel
>> (and do that big warning if it is). That way the trace events don't
>> need to be created any special way. You just use the trace_##event##_X
>> flavor and it automatically detects what to do. But we need to make
>> sure the same event isn't used for multiple flavors (SRCU vs schedule),
>> or maybe we can, and any change would have to do both synchronizations.
>
> The approach I used for synchronize rcu a few years ago when I did a srcu
> tracepoint prototype [1] was simply this:
>
>  static inline void tracepoint_synchronize_unregister(void)
>  {
> +       synchronize_srcu(&tracepoint_srcu);
>         synchronize_sched();
>  }
>
> So whenever we synchronize after tracepoint unregistration, the tracepoint
> code always issue both synchronize_sched() and SRCU synchronize. This way,
> tracepoint API users don't have to care about the kind of tracepoint they
> are updating.
>
> I'm inclined to explicitly declare the tracepoints with their given
> synchronization method. Tracepoint probe callback functions for currently
> existing tracepoints expect to have preemption disabled when invoked.
> This assumption will not be true anymore for srcu-tracepoints.

Nice thing about your patch is it defines at declaration time that its
an srcu-tracepoint. The API users don't need care about which
synchronization method to use which will probably prevent bugs like,
if someone forget to use the _rcuidle variable for a tracepoint or
something.

I carved out some of my time to test this patch today :-)

thanks,

- Joel
