Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeERW6W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 18:58:22 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36500 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeERW6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 18:58:18 -0400
X-Google-Smtp-Source: AB8JxZqn6gJ2+KovPj36BD/aWeHmuzolmorGq4uycRzaSiXb7mWc7b1lr6aaVQGzHy3kwFRe0nNiUQ==
Date: Fri, 18 May 2018 15:58:17 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Joel Fernandes <joelaf@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Todd Kjos <tkjos@google.com>,
        Erick Reyes <erickreyes@google.com>, Julia Cartwright <julia@ni.com>,
        kernel-team@android.com
Subject: Re: [PATCH 1/2] lib: Add module to simulate atomic sections for
 testing {preempt,irqs}off tracers
Message-ID: <20180518225817.GA134184@joelaf.mtv.corp.google.com>
References: <20180518015902.131427-1-joelaf@google.com>
 <20180518015902.131427-2-joelaf@google.com>
 <CAHp75Vf_zC9geRcdwD_WGLidg7Oq6rsKpL87Jhf4oQxz2=ctBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf_zC9geRcdwD_WGLidg7Oq6rsKpL87Jhf4oQxz2=ctBw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 12:09:46AM +0300, Andy Shevchenko wrote:
> On Fri, May 18, 2018 at 4:59 AM, Joel Fernandes <joelaf@google.com> wrote:
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
> 
> > +config TEST_ATOMIC_SECTIONS
> > +       tristate "Simulate atomic sections for tracers to detect"
> 
> > +       default n
> 
> n _is_ default default.

I would rather be explicit, several other TEST configs also mention it. Is it
a strong desire to drop off default n?

> > +/*
> 
> SPDX?

Ok, will add.

> 
> > + */
> 
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/ktime.h>
> > +#include <linux/irq.h>
> > +#include <linux/printk.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/delay.h>
> > +#include <linux/string.h>
> > +#include <linux/kthread.h>
> 
> Perhaps keep in order?

Sure.

> > +
> > +static int atomic_time = 100;
> > +static char atomic_mode[10] = "irq";
> > +
> > +module_param_named(atomic_time, atomic_time, int, S_IRUGO);
> > +module_param_string(atomic_mode, atomic_mode, 10, S_IRUGO);
> > +MODULE_PARM_DESC(atomic_time, "Period in microseconds (100 uS default)");
> > +MODULE_PARM_DESC(atomic_mode, "Mode of the test such as preempt or irq (default irq)");
> 
> > +
> > +
> 
> Extra blank line.

Fixed

> > +static int __init atomic_sect_init(void)
> > +{
> > +       char task_name[50];
> > +       struct task_struct *test_task;
> > +
> 
> > +       sprintf(task_name, "%s dis test", atomic_mode);
> 
> Just to be protective from dumb user.
> 
> snprintf();
> 

Done.

> > +
> > +       test_task = kthread_run((void*)atomic_sect_run, NULL, task_name);
> > +       if (IS_ERR(test_task)) {
> 
> > +               return -1;
> 
> return PTR_ERR() ?

Sure, will do. Thanks for the review!

 - Joel
