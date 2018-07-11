Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A770C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4732F20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Oyp8j6QF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4732F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbeGKF3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:29:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45494 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeGKF3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:29:24 -0400
Received: by mail-pf0-f195.google.com with SMTP id i26-v6so6205198pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a3RsdqZG/dqfLp6B1pjuDa90GE/UllS5m83ONEvDULI=;
        b=Oyp8j6QFyRQ25/uko5m2ktfDpGPgqVP91UYFGa9Tggl2XJCdTq7eN60SdrKyYz5Ojc
         +4JDzZNkk6+UiQN/JoelFsLDoVTVfRZPasTyR0ybPyzCPYc52xPX3eImZOgTRcEBMMtH
         lAEBjlMiUsUBPoDdC7NhVJztavE5c54Sq8R70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a3RsdqZG/dqfLp6B1pjuDa90GE/UllS5m83ONEvDULI=;
        b=jftxrVMTNcn5k0bU1PiPuGNIq7mh7r+lWtA4uD6ROnmFptKqZNuHoG1Rc5Mh02MNzD
         n5axH8Rm0LgnQThJXMftT6L+rRJDx4WnIChNUZ+o7S+quFRVcG3xB2Kty2+xWBVNi61l
         5VuAT//850LpQK89g7z7nzS8kduAxtSpATsnNkt9l0n9SotflHlE6AOCgbfNd4nYUmpg
         EHZiOaNsIhFMzoitzQjJA8+YniD/V4Apdd4z9vIVkzATjtC5c5smLNNXo/alZR/u5SNw
         6VAIeFwUPAGnKV0UpwAXGzSltu5FUTvT7mJJkws9iD+eR5TnvcLI9Ozbirlsy9R+kRG5
         zneg==
X-Gm-Message-State: APt69E3aPPUpLm2/9lGvbmnLQTL+4wV+sc/oFGJFnfKr+ACH5jwDF6pU
        OnuNhanGWu/JJF7jtcV3TqNqAg==
X-Google-Smtp-Source: AAOMgpfY1gupw4iOm/thYcJ8kAtNPAbUw41RQ+SPD8UO5IebNPUOXlAg8MORg5MG6YSSSOtx3UNgLA==
X-Received: by 2002:a63:2c8e:: with SMTP id s136-v6mr17026051pgs.390.1531286814090;
        Tue, 10 Jul 2018 22:26:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id 65-v6sm27058873pfq.81.2018.07.10.22.26.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 22:26:53 -0700 (PDT)
Date:   Tue, 10 Jul 2018 22:26:52 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel-team@android.com, Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 6/7] lib: Add module to simulate atomic sections for
 testing preemptoff tracers
Message-ID: <20180711052652.GA11372@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-7-joel@joelfernandes.org>
 <20180710204707.2fbaef87@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710204707.2fbaef87@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 08:47:07PM -0400, Steven Rostedt wrote:
> On Thu, 28 Jun 2018 11:21:48 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > In this patch we introduce a test module for simulating a long atomic
> > section in the kernel which the preemptoff or irqsoff tracers can
> > detect. This module is to be used only for test purposes and is default
> > disabled.
> > 
> > Following is the expected output (only briefly shown) that can be parsed
> > to verify that the tracers are working correctly. We will use this from
> > the kselftests in future patches.
> > 
> > For the preemptoff tracer:
> > 
> > echo preemptoff > /d/tracing/current_tracer
> > sleep 1
> > insmod ./test_atomic_sections.ko atomic_mode=preempt atomic_time=500000
> > sleep 1
> > bash-4.3# cat /d/tracing/trace
> > preempt -1066    2...2    0us@: atomic_sect_run <-atomic_sect_run
> > preempt -1066    2...2 500002us : atomic_sect_run <-atomic_sect_run
> > preempt -1066    2...2 500004us : tracer_preempt_on <-atomic_sect_run
> > preempt -1066    2...2 500012us : <stack trace>
> >  => kthread
> >  => ret_from_fork  
> > 
> > For the irqsoff tracer:
> > 
> > echo irqsoff > /d/tracing/current_tracer
> > sleep 1
> > insmod ./test_atomic_sections.ko atomic_mode=irq atomic_time=500000
> > sleep 1
> > bash-4.3# cat /d/tracing/trace
> > irq dis -1069    1d..1    0us@: atomic_sect_run
> > irq dis -1069    1d..1 500001us : atomic_sect_run
> > irq dis -1069    1d..1 500002us : tracer_hardirqs_on <-atomic_sect_run
> > irq dis -1069    1d..1 500005us : <stack trace>
> >  => ret_from_fork  
> > 
> > Co-developed-by: Erick Reyes <erickreyes@google.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  lib/Kconfig.debug          |  8 ++++
> >  lib/Makefile               |  1 +
> >  lib/test_atomic_sections.c | 77 ++++++++++++++++++++++++++++++++++++++
> 
> I think this code should reside in kernel/trace directory. I already
> have modules there. See the ring_buffer_benchmark code and the test
> module for mmio tracer.

Ok, I'll move it to there.

> >  3 files changed, 86 insertions(+)
> >  create mode 100644 lib/test_atomic_sections.c
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 8838d1158d19..622c90e1e066 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1956,6 +1956,14 @@ config TEST_KMOD
> >  
> >  	  If unsure, say N.
> >  
> > +config TEST_ATOMIC_SECTIONS
> > +	tristate "Simulate atomic sections for tracers to detect"
> 
> Hmm, I don't like this title. It's not very obvious to what it is
> about. What about "Preempt / IRQ disable delay thread to test latency
> tracers" ? Or something along those lines.

Sure, I'll change it to that. I agree its better. I'll change the text to
that and call the config TEST_PREEMPT_IRQ_DISABLE_DELAY.

> > +	depends on m
> > +	help
> > +	  Select this option to build a test module that can help test atomic
> > +	  sections by simulating them with a duration supplied as a module
> > +	  parameter. Preempt disable and irq disable modes can be requested.
> 
> "If unsure say N"

Sure, sounds good.

> > +
> >  config TEST_DEBUG_VIRTUAL
> >  	tristate "Test CONFIG_DEBUG_VIRTUAL feature"
> >  	depends on DEBUG_VIRTUAL
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 90dc5520b784..7831e747bf72 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -44,6 +44,7 @@ obj-y += string_helpers.o
> >  obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
> >  obj-y += hexdump.o
> >  obj-$(CONFIG_TEST_HEXDUMP) += test_hexdump.o
> > +obj-$(CONFIG_TEST_ATOMIC_SECTIONS) += test_atomic_sections.o
> >  obj-y += kstrtox.o
> >  obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
> >  obj-$(CONFIG_TEST_BPF) += test_bpf.o
> > diff --git a/lib/test_atomic_sections.c b/lib/test_atomic_sections.c
> > new file mode 100644
> > index 000000000000..1eef518f0974
> > --- /dev/null
> > +++ b/lib/test_atomic_sections.c
> > @@ -0,0 +1,77 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Atomic section emulation test module
> > + *
> > + * Emulates atomic sections by disabling IRQs or preemption
> > + * and doing a busy wait for a specified amount of time.
> > + * This can be used for testing of different atomic section
> > + * tracers such as irqsoff tracers.
> > + *
> > + * (c) 2018. Google LLC
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kthread.h>
> > +#include <linux/ktime.h>
> > +#include <linux/module.h>
> > +#include <linux/printk.h>
> > +#include <linux/string.h>
> > +
> > +static ulong atomic_time = 100;
> > +static char atomic_mode[10] = "irq";
> > +
> > +module_param_named(atomic_time, atomic_time, ulong, S_IRUGO);
> > +module_param_string(atomic_mode, atomic_mode, 10, S_IRUGO);
> > +MODULE_PARM_DESC(atomic_time, "Period in microseconds (100 uS default)");
> 
> It's not a "Period", it's a delay. "Length of time in critical section"

Sure.

> > +MODULE_PARM_DESC(atomic_mode, "Mode of the test such as preempt or irq (default irq)");
> 
>   "Mode of the test: preempt or irq disabled (default irq)"

Ok.

> > +
> > +static void busy_wait(ulong time)
> > +{
> > +	ktime_t start, end;
> > +	start = ktime_get();
> > +	do {
> > +		end = ktime_get();
> > +		if (kthread_should_stop())
> > +			break;
> > +	} while (ktime_to_ns(ktime_sub(end, start)) < (time * 1000));
> > +}
> > +
> > +int atomic_sect_run(void *data)
> > +{
> > +	unsigned long flags;
> > +
> > +	if (!strcmp(atomic_mode, "irq")) {
> > +		local_irq_save(flags);
> > +		busy_wait(atomic_time);
> > +		local_irq_restore(flags);
> > +	} else if (!strcmp(atomic_mode, "preempt")) {
> > +		preempt_disable();
> > +		busy_wait(atomic_time);
> > +		preempt_enable();
> > +	}
> 
> So this is a one shot deal? That should be explained somewhere,
> probably in the config help message. In fact, I think the config help
> message should show how to use this.

Sounds good, I'll clarify it better. Thanks!

- Joel

