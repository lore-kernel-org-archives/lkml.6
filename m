Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeERVJs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:09:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38247 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeERVJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:09:47 -0400
X-Google-Smtp-Source: AB8JxZrAJXpUkdtMtw08ZUO5jXM7IVULa97cP2qJG7jA7oL6thZjcc1MN9Y4VkMLXDuln32VZNmWaI0r2e9rJoWxXw8=
MIME-Version: 1.0
In-Reply-To: <20180518015902.131427-2-joelaf@google.com>
References: <20180518015902.131427-1-joelaf@google.com> <20180518015902.131427-2-joelaf@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 19 May 2018 00:09:46 +0300
Message-ID: <CAHp75Vf_zC9geRcdwD_WGLidg7Oq6rsKpL87Jhf4oQxz2=ctBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib: Add module to simulate atomic sections for
 testing {preempt,irqs}off tracers
To: Joel Fernandes <joelaf@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 4:59 AM, Joel Fernandes <joelaf@google.com> wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>
> In this patch we introduce a test module for simulating a long atomic
> section in the kernel which the preemptoff or irqsoff tracers can
> detect. This module is to be used only for test purposes and is default
> disabled.
>
> Following is the expected output (only briefly shown) that can be parsed
> to verify that the tracers are working correctly. We will use this from
> the kselftests in future patches.

> +config TEST_ATOMIC_SECTIONS
> +       tristate "Simulate atomic sections for tracers to detect"

> +       default n

n _is_ default default.

> +/*

SPDX?

> + */

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/ktime.h>
> +#include <linux/irq.h>
> +#include <linux/printk.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/string.h>
> +#include <linux/kthread.h>

Perhaps keep in order?

> +
> +static int atomic_time = 100;
> +static char atomic_mode[10] = "irq";
> +
> +module_param_named(atomic_time, atomic_time, int, S_IRUGO);
> +module_param_string(atomic_mode, atomic_mode, 10, S_IRUGO);
> +MODULE_PARM_DESC(atomic_time, "Period in microseconds (100 uS default)");
> +MODULE_PARM_DESC(atomic_mode, "Mode of the test such as preempt or irq (default irq)");

> +
> +

Extra blank line.

> +static int __init atomic_sect_init(void)
> +{
> +       char task_name[50];
> +       struct task_struct *test_task;
> +

> +       sprintf(task_name, "%s dis test", atomic_mode);

Just to be protective from dumb user.

snprintf();

> +
> +       test_task = kthread_run((void*)atomic_sect_run, NULL, task_name);
> +       if (IS_ERR(test_task)) {

> +               return -1;

return PTR_ERR() ?

> +       }
> +
> +       return 0;
> +}



-- 
With Best Regards,
Andy Shevchenko
