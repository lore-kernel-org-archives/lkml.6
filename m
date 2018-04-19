Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeDSFnH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 01:43:07 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:37228 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbeDSFnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 01:43:06 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Thu, 19 Apr 2018 14:43:02 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
Message-ID: <20180419054302.GD13370@sejong>
References: <20180417040748.212236-1-joelaf@google.com>
 <20180417040748.212236-4-joelaf@google.com>
 <20180418180250.7b6038dddba46b37c94b796c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180418180250.7b6038dddba46b37c94b796c@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 06:02:50PM +0900, Masami Hiramatsu wrote:
> On Mon, 16 Apr 2018 21:07:47 -0700
> Joel Fernandes <joelaf@google.com> wrote:
> 
> > With TRACE_IRQFLAGS, we call trace_ API too many times. We don't need
> > to if local_irq_restore or local_irq_save didn't actually do anything.
> > 
> > This gives around a 4% improvement in performance when doing the
> > following command: "time find / > /dev/null"
> > 
> > Also its best to avoid these calls where possible, since in this series,
> > the RCU code in tracepoint.h seems to be call these quite a bit and I'd
> > like to keep this overhead low.
> 
> Can we assume that the "flags" has only 1 bit irq-disable flag?
> Since it skips calling raw_local_irq_restore(flags); too,

I don't know how many it impacts on performance but maybe we can have
an arch-specific config option something like below?


> if there is any state in the flags on any arch, it may change the
> result. In that case, we can do it as below (just skipping trace_hardirqs_*)
> 
> int disabled = irqs_disabled();

  if (disabled == raw_irqs_disabled_flags(flags)) {
#ifndef CONFIG_ARCH_CAN_SKIP_NESTED_IRQ_RESTORE
        raw_local_irq_restore(flags);
#endif
        return;
  }

> 
> if (!raw_irqs_disabled_flags(flags) && disabled)
> 	trace_hardirqs_on();
> 
> raw_local_irq_restore(flags);
> 
> if (raw_irqs_disabled_flags(flags) && !disabled)
> 	trace_hardirqs_off();

Thanks,
Namhyung
