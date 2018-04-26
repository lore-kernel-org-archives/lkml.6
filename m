Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932195AbeDZPUS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:20:18 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37034 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbeDZPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:20:06 -0400
X-Google-Smtp-Source: AB8JxZq2WF5upE2KM8qwCb5tKpz+9boaT04zy5yHbFEZ+8mMOgrIJGCDNfUUiB9QMIPZhFc9Od5pUgEpzKp1MJEVKZw=
MIME-Version: 1.0
In-Reply-To: <2099399401.1995.1524755596613.JavaMail.zimbra@efficios.com>
References: <20180423172244.694dbc9d@gandalf.local.home> <849066633.939.1524612064698.JavaMail.zimbra@efficios.com>
 <68e4c123-a223-5e26-e57a-da2515041bf3@google.com> <20180425001049.GX26088@linux.vnet.ibm.com>
 <20180425042056.GA21412@linux.vnet.ibm.com> <CAJWu+orWC=W0Jn2Jo7f+u5mbHMi+D1yuCmhD-xSgjWZ6Ynw32Q@mail.gmail.com>
 <1267842641.1791.1524692456344.JavaMail.zimbra@efficios.com>
 <CAJWu+oq7dqn4PEySyrrETaGNg4TsJvHobu=UdMEves+V3fgVZQ@mail.gmail.com> <2099399401.1995.1524755596613.JavaMail.zimbra@efficios.com>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 26 Apr 2018 08:20:03 -0700
Message-ID: <CAJWu+opff+qtLixJgK79FFos17oe2-N16THoDFvg7zCpwNjUCQ@mail.gmail.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you can
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        rostedt <rostedt@goodmis.org>, Namhyung Kim <namhyung@kernel.org>,
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
        kernel-team <kernel-team@lge.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 8:13 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
[...]
>>> Regarding the name, I'm OK with having something along the lines of
>>> trace_*event*_blocking or such. Please don't use "srcu" or other naming
>>> that is explicitly tied to the underlying mechanism used internally
>>> however: what we want to convey is that this specific tracepoint probe
>>
>> Problem is that _blocking isn't the right word either. In my IRQ trace
>> point case, it will look something like this then:
>>
>> local_irq_disable();
>> // IRQs are now off.
>> trace_irq_disable_blocking(..);
>>
>> This wouldn't make sense. What we really want is to use the SRCU
>> implementation so that its low overhead...
>>
>> So it would be something like:
>>
>> local_irq_disable();
>> // IRQs are now off.
>> trace_irq_disable_srcu(..);
>>
>> I also Ok if, as Paul was saying in his last email, that just for
>> _rcuidle, we use SRCU so that we don't have to do the rcu_enter_irq
>> stuff. Or we kill the _rcuidle API completely and use _srcu for those
>> users instead. We already have 1 implementation specific name anyway
>> (rcuidle), we're just replacing it with another one. If in the future,
>> if we want to change that name we can always do so (Also if you will,
>> correcting the existing already bad naming is a different problem and
>> we're not making it any worse tbh).
>
> Using SRCU rather than the sched-rcu tracepoint synchronization in your
> use-case it caused by a limitation of sched-rcu: it cannot be efficiently
> used within idle code. So you don't care about the "can_sleep" property
> of SRCU. You could event mix SRCU and sched-rcu callsites for the same
> probe name, and it would be perfectly valid.
>
> So even though both "can_sleep" and "rcuidle" caller variants would end
> up using SRCU under the hood, each can have its own caller API, e.g.:
>
> * trace_<event>() -> only non-sleeping probes can register to those.
>                      Uses sched-rcu under the hood.
>
> * trace_<event>_can_sleep() -> both sleeping and non-sleeping probes can
>                                register to those. Uses SRCU under the hood.
>
> * trace_<event>_rcuidle() -> only non-sleeping probes can register to those,
>                              uses SRCU under the hood.
>

Cool, sounds good to me!
For starters I was thinking of changing the _rcuidle underlying
implementation as you pointed. This should be simple enough and needs
no further additional APIs. I'll work on a patch along these lines and
send it out soon. Also would love to work on your sleeping callback
case in the future as well incase you wanted to spend your cycles
working on other things.

thanks,

- Joel
