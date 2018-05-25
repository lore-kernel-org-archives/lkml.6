Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966922AbeEYLoc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:44:32 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:39776 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966560AbeEYLo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:44:28 -0400
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Fri, 25 May 2018 20:43:39 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>, Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>, linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>, Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>, kernel-team@lge.com
Subject: Re: [PATCH v7 6/8] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180525114339.GA30990@sejong>
References: <20180524012157.181277-1-joel@joelfernandes.org>
 <20180524012157.181277-7-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524012157.181277-7-joel@joelfernandes.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Wed, May 23, 2018 at 06:21:55PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> This patch detaches the preemptirq tracepoints from the tracers and
> keeps it separate.
> 
> Advantages:
> * Lockdep and irqsoff event can now run in parallel since they no longer
> have their own calls.
> 
> * This unifies the usecase of adding hooks to an irqsoff and irqson
> event, and a preemptoff and preempton event.
>   3 users of the events exist:
>   - Lockdep
>   - irqsoff and preemptoff tracers
>   - irqs and preempt trace events
> 
> The unification cleans up several ifdefs and makes the code in preempt
> tracer and irqsoff tracers simpler. It gets rid of all the horrific
> ifdeferry around PROVE_LOCKING and makes configuration of the different
> users of the tracepoints more easy and understandable. It also gets rid
> of the time_* function calls from the lockdep hooks used to call into
> the preemptirq tracer which is not needed anymore. The negative delta in
> lines of code in this patch is quite large too.
> 
> In the patch we introduce a new CONFIG option PREEMPTIRQ_TRACEPOINTS
> as a single point for registering probes onto the tracepoints. With
> this,
> the web of config options for preempt/irq toggle tracepoints and its
> users becomes:
> 
>  PREEMPT_TRACER   PREEMPTIRQ_EVENTS  IRQSOFF_TRACER PROVE_LOCKING
>        |                 |     \         |           |
>        \    (selects)    /      \        \ (selects) /
>       TRACE_PREEMPT_TOGGLE       ----> TRACE_IRQFLAGS
>                       \                  /
>                        \ (depends on)   /
>                      PREEMPTIRQ_TRACEPOINTS
> 
> One note, I have to check for lockdep recursion in the code that calls
> the trace events API and bail out if we're in lockdep recursion
> protection to prevent something like the following case: a spin_lock is
> taken. Then lockdep_acquired is called.  That does a raw_local_irq_save
> and then sets lockdep_recursion, and then calls __lockdep_acquired. In
> this function, a call to get_lock_stats happens which calls
> preempt_disable, which calls trace IRQS off somewhere which enters my
> tracepoint code and sets the tracing_irq_cpu flag to prevent recursion.
> This flag is then never cleared causing lockdep paths to never be
> entered and thus causing splats and other bad things.
> 
> Other than the performance tests mentioned in the previous patch, I also
> ran the locking API test suite. I verified that all tests cases are
> passing.
> 
> I also injected issues by not registering lockdep probes onto the
> tracepoints and I see failures to confirm that the probes are indeed
> working.
> 
> Without probes:
> 
> [    0.000000]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> [    0.000000]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> [    0.000000]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
> [    0.000000]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
> [    0.000000]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
> [    0.000000]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
> [    0.000000]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
> [    0.000000]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> [    0.000000]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> 
> With probes:
> 
> [    0.000000]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> [    0.000000]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
> [    0.000000]        sirq-safe-A => hirqs-on/12:FAILED|FAILED|  ok  |
> [    0.000000]        sirq-safe-A => hirqs-on/21:FAILED|FAILED|  ok  |
> [    0.000000]          hard-safe-A + irqs-on/12:FAILED|FAILED|  ok  |
> [    0.000000]          soft-safe-A + irqs-on/12:FAILED|FAILED|  ok  |
> [    0.000000]          hard-safe-A + irqs-on/21:FAILED|FAILED|  ok  |
> [    0.000000]          soft-safe-A + irqs-on/21:FAILED|FAILED|  ok  |
> [    0.000000]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> [    0.000000]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---

[SNIP]
>  
>  #ifdef CONFIG_IRQSOFF_TRACER
> +/*
> + * We are only interested in hardirq on/off events:
> + */
> +static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
> +{
> +	if (!preempt_trace() && irq_trace())
> +		stop_critical_timing(a0, a1);
> +}
> +
> +static void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
> +{
> +	if (!preempt_trace() && irq_trace())
> +		start_critical_timing(a0, a1);
> +}
> +
>  static int irqsoff_tracer_init(struct trace_array *tr)
>  {
>  	trace_type = TRACER_IRQS_OFF;
>  
> +	register_trace_irq_disable(tracer_hardirqs_off, NULL);
> +	register_trace_irq_enable(tracer_hardirqs_on, NULL);
>  	return __irqsoff_tracer_init(tr);
>  }
>  
>  static void irqsoff_tracer_reset(struct trace_array *tr)
>  {
> +	unregister_trace_irq_disable(tracer_hardirqs_off, NULL);
> +	unregister_trace_irq_enable(tracer_hardirqs_on, NULL);
>  	__irqsoff_tracer_reset(tr);
>  }
>  
> @@ -692,19 +650,37 @@ static struct tracer irqsoff_tracer __read_mostly =
>  };
>  # define register_irqsoff(trace) register_tracer(&trace)
>  #else
> +static inline void tracer_hardirqs_on(unsigned long a0, unsigned long a1) { }
> +static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }

Just a nitpick.  These lines seem unnecessary since they're used
only when CONFIG_IRQSOFF_TRACER is enabled AFAICS.


>  # define register_irqsoff(trace) do { } while (0)
> -#endif
> +#endif /*  CONFIG_IRQSOFF_TRACER */
>  
>  #ifdef CONFIG_PREEMPT_TRACER
> +static void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1)
> +{
> +	if (preempt_trace() && !irq_trace())
> +		stop_critical_timing(a0, a1);
> +}
> +
> +static void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1)
> +{
> +	if (preempt_trace() && !irq_trace())
> +		start_critical_timing(a0, a1);
> +}
> +
>  static int preemptoff_tracer_init(struct trace_array *tr)
>  {
>  	trace_type = TRACER_PREEMPT_OFF;
>  
> +	register_trace_preempt_disable(tracer_preempt_off, NULL);
> +	register_trace_preempt_enable(tracer_preempt_on, NULL);
>  	return __irqsoff_tracer_init(tr);
>  }
>  
>  static void preemptoff_tracer_reset(struct trace_array *tr)
>  {
> +	unregister_trace_preempt_disable(tracer_preempt_off, NULL);
> +	unregister_trace_preempt_enable(tracer_preempt_on, NULL);
>  	__irqsoff_tracer_reset(tr);
>  }
>  
> @@ -729,21 +705,32 @@ static struct tracer preemptoff_tracer __read_mostly =
>  };
>  # define register_preemptoff(trace) register_tracer(&trace)
>  #else
> +static inline void tracer_preempt_on(unsigned long a0, unsigned long a1) { }
> +static inline void tracer_preempt_off(unsigned long a0, unsigned long a1) { }

Ditto (for CONFIG_PREEMPT_TRACER).

Thanks,
Namhyung


>  # define register_preemptoff(trace) do { } while (0)
> -#endif
> +#endif /* CONFIG_PREEMPT_TRACER */
>  
> -#if defined(CONFIG_IRQSOFF_TRACER) && \
> -	defined(CONFIG_PREEMPT_TRACER)
> +#if defined(CONFIG_IRQSOFF_TRACER) && defined(CONFIG_PREEMPT_TRACER)
>  
>  static int preemptirqsoff_tracer_init(struct trace_array *tr)
>  {
>  	trace_type = TRACER_IRQS_OFF | TRACER_PREEMPT_OFF;
>  
> +	register_trace_irq_disable(tracer_hardirqs_off, NULL);
> +	register_trace_irq_enable(tracer_hardirqs_on, NULL);
> +	register_trace_preempt_disable(tracer_preempt_off, NULL);
> +	register_trace_preempt_enable(tracer_preempt_on, NULL);
> +
>  	return __irqsoff_tracer_init(tr);
>  }
>  
>  static void preemptirqsoff_tracer_reset(struct trace_array *tr)
>  {
> +	unregister_trace_irq_disable(tracer_hardirqs_off, NULL);
> +	unregister_trace_irq_enable(tracer_hardirqs_on, NULL);
> +	unregister_trace_preempt_disable(tracer_preempt_off, NULL);
> +	unregister_trace_preempt_enable(tracer_preempt_on, NULL);
> +
>  	__irqsoff_tracer_reset(tr);
>  }
