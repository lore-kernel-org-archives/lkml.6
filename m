Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753902AbeDTHHX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:07:23 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:33036 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753765AbeDTHHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:07:20 -0400
X-Google-Smtp-Source: AIpwx49n4G3hOhD6ImPNobTkEJlaUdd+J/mnnkny2g/VIsY/ZkqqhTX77nQSi79CYekeIvUceclMaR+7JokaU9T17Lg=
MIME-Version: 1.0
In-Reply-To: <20180419054302.GD13370@sejong>
References: <20180417040748.212236-1-joelaf@google.com> <20180417040748.212236-4-joelaf@google.com>
 <20180418180250.7b6038dddba46b37c94b796c@kernel.org> <20180419054302.GD13370@sejong>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 20 Apr 2018 00:07:18 -0700
Message-ID: <CAJWu+ooK5jETwB-L37=8PX+A4ercM8BrVb6g23t7F_xYhH4BSw@mail.gmail.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you can
To: Namhyung Kim <namhyung@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks Matsami and Namhyung for the suggestions!

On Wed, Apr 18, 2018 at 10:43 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> On Wed, Apr 18, 2018 at 06:02:50PM +0900, Masami Hiramatsu wrote:
>> On Mon, 16 Apr 2018 21:07:47 -0700
>> Joel Fernandes <joelaf@google.com> wrote:
>>
>> > With TRACE_IRQFLAGS, we call trace_ API too many times. We don't need
>> > to if local_irq_restore or local_irq_save didn't actually do anything.
>> >
>> > This gives around a 4% improvement in performance when doing the
>> > following command: "time find / > /dev/null"
>> >
>> > Also its best to avoid these calls where possible, since in this series,
>> > the RCU code in tracepoint.h seems to be call these quite a bit and I'd
>> > like to keep this overhead low.
>>
>> Can we assume that the "flags" has only 1 bit irq-disable flag?
>> Since it skips calling raw_local_irq_restore(flags); too,
>
> I don't know how many it impacts on performance but maybe we can have
> an arch-specific config option something like below?

The flags restoration I am hoping is "cheap" but I haven't measured
specifically the cost of this though.

>
>
>> if there is any state in the flags on any arch, it may change the
>> result. In that case, we can do it as below (just skipping trace_hardirqs_*)
>>
>> int disabled = irqs_disabled();
>
>   if (disabled == raw_irqs_disabled_flags(flags)) {
> #ifndef CONFIG_ARCH_CAN_SKIP_NESTED_IRQ_RESTORE
>         raw_local_irq_restore(flags);
> #endif
>         return;
>   }

Hmm, somehow I feel this part should be written generically enough
that it applies to all architectures (as a first step).

>
>>
>> if (!raw_irqs_disabled_flags(flags) && disabled)
>>       trace_hardirqs_on();
>>
>> raw_local_irq_restore(flags);
>>
>> if (raw_irqs_disabled_flags(flags) && !disabled)
>>       trace_hardirqs_off();

I like this idea since its a good thing to do the flag restoration
just to be safe and preserve the current behaviors. Also my goal was
to reduce the trace_ calls in this series, so its probably better I
just do as you're suggesting. I will do some experiments and make the
changes for the next series.

thanks,

- Joel
