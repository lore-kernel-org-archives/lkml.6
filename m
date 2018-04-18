Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbeDRJC5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751940AbeDRJCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:02:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763FE2175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Wed, 18 Apr 2018 18:02:50 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>
Subject: Re: [RFC v4 3/4] irqflags: Avoid unnecessary calls to trace_ if you
 can
Message-Id: <20180418180250.7b6038dddba46b37c94b796c@kernel.org>
In-Reply-To: <20180417040748.212236-4-joelaf@google.com>
References: <20180417040748.212236-1-joelaf@google.com>
        <20180417040748.212236-4-joelaf@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2018 21:07:47 -0700
Joel Fernandes <joelaf@google.com> wrote:

> With TRACE_IRQFLAGS, we call trace_ API too many times. We don't need
> to if local_irq_restore or local_irq_save didn't actually do anything.
> 
> This gives around a 4% improvement in performance when doing the
> following command: "time find / > /dev/null"
> 
> Also its best to avoid these calls where possible, since in this series,
> the RCU code in tracepoint.h seems to be call these quite a bit and I'd
> like to keep this overhead low.

Can we assume that the "flags" has only 1 bit irq-disable flag?
Since it skips calling raw_local_irq_restore(flags); too,
if there is any state in the flags on any arch, it may change the
result. In that case, we can do it as below (just skipping trace_hardirqs_*)

int disabled = irqs_disabled();

if (!raw_irqs_disabled_flags(flags) && disabled)
	trace_hardirqs_on();

raw_local_irq_restore(flags);

if (raw_irqs_disabled_flags(flags) && !disabled)
	trace_hardirqs_off();

Thank you,

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zilstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Glexiner <tglx@linutronix.de>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Fenguang Wu <fengguang.wu@intel.com>
> Cc: Baohong Liu <baohong.liu@intel.com>
> Cc: Vedang Patel <vedang.patel@intel.com>
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
>  include/linux/irqflags.h | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 9700f00bbc04..ea8df0ac57d3 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -104,19 +104,20 @@ do {						\
>  #define local_irq_save(flags)				\
>  	do {						\
>  		raw_local_irq_save(flags);		\
> -		trace_hardirqs_off();			\
> +		if (!raw_irqs_disabled_flags(flags))	\
> +			trace_hardirqs_off();		\
>  	} while (0)
>  
>  
> -#define local_irq_restore(flags)			\
> -	do {						\
> -		if (raw_irqs_disabled_flags(flags)) {	\
> -			raw_local_irq_restore(flags);	\
> -			trace_hardirqs_off();		\
> -		} else {				\
> -			trace_hardirqs_on();		\
> -			raw_local_irq_restore(flags);	\
> -		}					\
> +#define local_irq_restore(flags)						\
> +	do {									\
> +		if (raw_irqs_disabled_flags(flags) && !irqs_disabled()) {	\
> +			raw_local_irq_restore(flags);				\
> +			trace_hardirqs_off();					\
> +		} else if (!raw_irqs_disabled_flags(flags) && irqs_disabled()) {\
> +			trace_hardirqs_on();					\
> +			raw_local_irq_restore(flags);				\
> +		}								\
>  	} while (0)
>  
>  #define safe_halt()				\
> -- 
> 2.17.0.484.g0c8726318c-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
