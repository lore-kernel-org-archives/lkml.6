Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeEABSX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 21:18:23 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:54126 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeEABSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 21:18:21 -0400
X-Google-Smtp-Source: AB8JxZqN/Da72/72uCpCDYT758Mp6hJLse2Lsvt7j2dV6ALyjeA805QDJZWHxFKnDUd8MtyNTZ7vUVUl6kcuhRfeqA8=
MIME-Version: 1.0
References: <20180417040748.212236-1-joelaf@google.com> <20180417040748.212236-4-joelaf@google.com>
 <20180418180250.7b6038dddba46b37c94b796c@kernel.org>
In-Reply-To: <20180418180250.7b6038dddba46b37c94b796c@kernel.org>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 01 May 2018 01:18:09 +0000
Message-ID: <CAJWu+ooJLUJZ5nArFPbxsoRy6Rbp4ipR3njdZUXSPT0Ng1yy6A@mail.gmail.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you can
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 2:02 AM Masami Hiramatsu <mhiramat@kernel.org>
wrote:

> On Mon, 16 Apr 2018 21:07:47 -0700
> Joel Fernandes <joelaf@google.com> wrote:

> > With TRACE_IRQFLAGS, we call trace_ API too many times. We don't need
> > to if local_irq_restore or local_irq_save didn't actually do anything.
> >
> > This gives around a 4% improvement in performance when doing the
> > following command: "time find / > /dev/null"
> >
> > Also its best to avoid these calls where possible, since in this series,
> > the RCU code in tracepoint.h seems to be call these quite a bit and I'd
> > like to keep this overhead low.

> Can we assume that the "flags" has only 1 bit irq-disable flag?
> Since it skips calling raw_local_irq_restore(flags); too,
> if there is any state in the flags on any arch, it may change the
> result. In that case, we can do it as below (just skipping
trace_hardirqs_*)

> int disabled = irqs_disabled();

> if (!raw_irqs_disabled_flags(flags) && disabled)
>          trace_hardirqs_on();

> raw_local_irq_restore(flags);

> if (raw_irqs_disabled_flags(flags) && !disabled)
>          trace_hardirqs_off();

With changes to the tracepoint implementation which uses srcu instead of
rcu, I'm not able to see a performance improvement with the above patch.
For this reason, I will drop this patch from next series. thanks,

- Joel
