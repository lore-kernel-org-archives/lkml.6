Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030819AbeEYXUk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 19:20:40 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42686 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030651AbeEYXUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 19:20:38 -0400
X-Google-Smtp-Source: ADUXVKIbgPxh8nHhsi9F4lHl/3xVirDnsrWNDkF+WDJQD8are7xxwssL70v2DQpJosL08JJAMpg/cA==
Date: Fri, 25 May 2018 16:20:36 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Boqun Feng <boqun.feng@gmail.com>,
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
Message-ID: <20180525232036.GA252027@joelaf.mtv.corp.google.com>
References: <20180524012157.181277-1-joel@joelfernandes.org>
 <20180524012157.181277-7-joel@joelfernandes.org>
 <20180525114339.GA30990@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525114339.GA30990@sejong>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 08:43:39PM +0900, Namhyung Kim wrote:
> Hi Joel,
> 
> On Wed, May 23, 2018 at 06:21:55PM -0700, Joel Fernandes wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > This patch detaches the preemptirq tracepoints from the tracers and
> > keeps it separate.
> > 
> > Advantages:
> > * Lockdep and irqsoff event can now run in parallel since they no longer
> > have their own calls.
> > 
> > * This unifies the usecase of adding hooks to an irqsoff and irqson
> > event, and a preemptoff and preempton event.
> >   3 users of the events exist:
> >   - Lockdep
> >   - irqsoff and preemptoff tracers
> >   - irqs and preempt trace events
> > 
> > The unification cleans up several ifdefs and makes the code in preempt
> > tracer and irqsoff tracers simpler. It gets rid of all the horrific
> > ifdeferry around PROVE_LOCKING and makes configuration of the different
> > users of the tracepoints more easy and understandable. It also gets rid
> > of the time_* function calls from the lockdep hooks used to call into
> > the preemptirq tracer which is not needed anymore. The negative delta in
> > lines of code in this patch is quite large too.
> > 
> [SNIP]
> >  
> >  #ifdef CONFIG_IRQSOFF_TRACER
> > +/*
> > + * We are only interested in hardirq on/off events:
> > + */
> > +static void tracer_hardirqs_on(void *none, unsigned long a0, unsigned long a1)
> > +{
> > +	if (!preempt_trace() && irq_trace())
> > +		stop_critical_timing(a0, a1);
> > +}
> > +
> > +static void tracer_hardirqs_off(void *none, unsigned long a0, unsigned long a1)
> > +{
> > +	if (!preempt_trace() && irq_trace())
> > +		start_critical_timing(a0, a1);
> > +}
> > +
> >  static int irqsoff_tracer_init(struct trace_array *tr)
> >  {
> >  	trace_type = TRACER_IRQS_OFF;
> >  
> > +	register_trace_irq_disable(tracer_hardirqs_off, NULL);
> > +	register_trace_irq_enable(tracer_hardirqs_on, NULL);
> >  	return __irqsoff_tracer_init(tr);
> >  }
> >  
> >  static void irqsoff_tracer_reset(struct trace_array *tr)
> >  {
> > +	unregister_trace_irq_disable(tracer_hardirqs_off, NULL);
> > +	unregister_trace_irq_enable(tracer_hardirqs_on, NULL);
> >  	__irqsoff_tracer_reset(tr);
> >  }
> >  
> > @@ -692,19 +650,37 @@ static struct tracer irqsoff_tracer __read_mostly =
> >  };
> >  # define register_irqsoff(trace) register_tracer(&trace)
> >  #else
> > +static inline void tracer_hardirqs_on(unsigned long a0, unsigned long a1) { }
> > +static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
> 
> Just a nitpick.  These lines seem unnecessary since they're used
> only when CONFIG_IRQSOFF_TRACER is enabled AFAICS.
> 
> 
> >  # define register_irqsoff(trace) do { } while (0)
> > -#endif
> > +#endif /*  CONFIG_IRQSOFF_TRACER */
> >  
> >  #ifdef CONFIG_PREEMPT_TRACER
> > +static void tracer_preempt_on(void *none, unsigned long a0, unsigned long a1)
> > +{
> > +	if (preempt_trace() && !irq_trace())
> > +		stop_critical_timing(a0, a1);
> > +}
> > +
> > +static void tracer_preempt_off(void *none, unsigned long a0, unsigned long a1)
> > +{
> > +	if (preempt_trace() && !irq_trace())
> > +		start_critical_timing(a0, a1);
> > +}
> > +
> >  static int preemptoff_tracer_init(struct trace_array *tr)
> >  {
> >  	trace_type = TRACER_PREEMPT_OFF;
> >  
> > +	register_trace_preempt_disable(tracer_preempt_off, NULL);
> > +	register_trace_preempt_enable(tracer_preempt_on, NULL);
> >  	return __irqsoff_tracer_init(tr);
> >  }
> >  
> >  static void preemptoff_tracer_reset(struct trace_array *tr)
> >  {
> > +	unregister_trace_preempt_disable(tracer_preempt_off, NULL);
> > +	unregister_trace_preempt_enable(tracer_preempt_on, NULL);
> >  	__irqsoff_tracer_reset(tr);
> >  }
> >  
> > @@ -729,21 +705,32 @@ static struct tracer preemptoff_tracer __read_mostly =
> >  };
> >  # define register_preemptoff(trace) register_tracer(&trace)
> >  #else
> > +static inline void tracer_preempt_on(unsigned long a0, unsigned long a1) { }
> > +static inline void tracer_preempt_off(unsigned long a0, unsigned long a1) { }
> 
> Ditto (for CONFIG_PREEMPT_TRACER).
> 
> Thanks,
> Namhyung

Yes you're right, saves quite a few lines actually! I also inlined the
register_tracer macros, It seems much cleaner. I will fold the below diff but
let me know if there's anything else.

Thanks Namhyung!

 - Joel


---8<-----------------------

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index d2d8284088f0..d0bcb51d1a2a 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -648,11 +648,6 @@ static struct tracer irqsoff_tracer __read_mostly =
 	.allow_instances = true,
 	.use_max_tr	= true,
 };
-# define register_irqsoff(trace) register_tracer(&trace)
-#else
-static inline void tracer_hardirqs_on(unsigned long a0, unsigned long a1) { }
-static inline void tracer_hardirqs_off(unsigned long a0, unsigned long a1) { }
-# define register_irqsoff(trace) do { } while (0)
 #endif /*  CONFIG_IRQSOFF_TRACER */
 
 #ifdef CONFIG_PREEMPT_TRACER
@@ -703,11 +698,6 @@ static struct tracer preemptoff_tracer __read_mostly =
 	.allow_instances = true,
 	.use_max_tr	= true,
 };
-# define register_preemptoff(trace) register_tracer(&trace)
-#else
-static inline void tracer_preempt_on(unsigned long a0, unsigned long a1) { }
-static inline void tracer_preempt_off(unsigned long a0, unsigned long a1) { }
-# define register_preemptoff(trace) do { } while (0)
 #endif /* CONFIG_PREEMPT_TRACER */
 
 #if defined(CONFIG_IRQSOFF_TRACER) && defined(CONFIG_PREEMPT_TRACER)
@@ -753,18 +743,19 @@ static struct tracer preemptirqsoff_tracer __read_mostly =
 	.allow_instances = true,
 	.use_max_tr	= true,
 };
-
-# define register_preemptirqsoff(trace) register_tracer(&trace)
-#else
-# define register_preemptirqsoff(trace) do { } while (0)
 #endif
 
 __init static int init_irqsoff_tracer(void)
 {
-	register_irqsoff(irqsoff_tracer);
-	register_preemptoff(preemptoff_tracer);
-	register_preemptirqsoff(preemptirqsoff_tracer);
-
+#ifdef CONFIG_IRQSOFF_TRACER
+	register_tracer(&irqsoff_tracer);
+#endif
+#ifdef CONFIG_PREEMPT_TRACER
+	register_tracer(&preemptoff_tracer);
+#endif
+#if defined(CONFIG_IRQSOFF_TRACER) && defined(CONFIG_PREEMPT_TRACER)
+	register_tracer(&preemptirqsoff_tracer);
+#endif
 	return 0;
 }
 core_initcall(init_irqsoff_tracer);
