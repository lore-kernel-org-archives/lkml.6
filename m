Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE2FC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87DE20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87DE20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeLDTQt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDTQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:16:49 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 444B92082B;
        Tue,  4 Dec 2018 19:16:47 +0000 (UTC)
Date:   Tue, 4 Dec 2018 14:16:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Marko Pusch <marko.pusch@siemens.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        =?UTF-8?B?UsO0bXVsbw==?= Silva de Oliveira 
        <romulo.deoliveira@ufsc.br>, Ingo Molnar <mingo@redhat.com>
Subject: Re: BUG: ftrace/perf dropping events at the begin of interrupt
 handlers
Message-ID: <20181204141644.6852d450@vmware.local.home>
In-Reply-To: <a5e8182e-de6c-caaf-3106-a43b54198b97@redhat.com>
References: <a5e8182e-de6c-caaf-3106-a43b54198b97@redhat.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 10:45:05 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> While developing the automata [1], I've hit cases in which need resched
> and/or sched wakeup events were being fired with preemption and/or
> interrupts enabled. However, this is not possible because interrupts must
> be disabled to avoid concurrence with an interrupt handler, and the
> preemption must be disabled to avoid concurrence with the scheduler.
> The tool I use to validate the model is based on perf, and it was
> complaining about this situation. I’ve talked to Arnaldo about it
> two months.
> 
> Further debug on perf has shown that those cases always took place
> associated with the occurrence of interrupts. At ELC Europe
> Marko Pusch (Siemens) also mentioned hitting cases in which he saw
> missing events related to IRQ handling, but using ftrace. Steven and
> I also discussed this during the last Plumbers (Vancouver - CA) and we
> agreed that there is a problem on ftrace too.
> 
> To reproduce this problem with ftrace, one needs to enable function
> tracer and do kernel operations in a CPU in which IRQs are taking place.
> 
> For instance, in a single CPU VM, run:
> 
> # while [ 1 ]; do echo > /dev/null; done
> 
> In a shell, and 
> 
> # trace-cmd record -b [enough buff to avoid missing trace because of buffer overun] -p function sleep 5
> 
> In another shell.
> 
> Then, using trace-cmd report --debug, we can see the problem. Here is one
> example of output, first the expected one:
> 
> 


> ================ Faulty execution =================
> 
> Thus, ftrace and perf, sometimes, are dropping events at the begin of
> interrupt handlers. And that is The reason why interrupt disable and
> preempt disable were not being recorded (and causing problem in the
> automata execution) is that these events take place in the very early
> execution of the interrupt handler, in the section in which the
> perf/ftrace are dropping events [ without notifying ].
> 
> [1] This is a good demonstration of problems that can be found using the
> automata model presented in this workshop paper:
> 
> Modeling the Behavior of Threads in the PREEMPT_RT Linux Kernel Using
> Automata. Daniel Bristot de Oliveira, Tommaso Cucinotta, Rômulo Silva de
> Oliveira - EWiLi'2018 – Embedded operating system workshop Torino, Italy,
> 4 October 2018.
> 
> And in the presentations:
> "Mind the gap between real-time Linux and real-time theory"
> "How can we catch problems that can break the PREEMPT_RT preemption model?"
> At the Linux Plumbers (Vancouver - CA)
> 
> Steven is already aware of this problem, and he is working on it.

Yes, it's a simple fix. The problem is that the recursion detection of
the function tracer requires that when its called from interrupt, the
"in_interrupt" needs to be true, otherwise it thinks that the function
tracer is recursing on itself (which is common).

Looking an the dropped events, and the code in __irq_enter() we have
this:

#define __irq_enter()					\
	do {						\
		account_irq_enter_time(current);	\
		preempt_count_add(HARDIRQ_OFFSET);	\ <<-- in_interrupt() returns true here
		trace_hardirq_enter();			\
	} while (0)

Interesting enough, the dropped events happen to be in
account_irq_enter_time()!

Thus what I believe is happening is that an interrupt came in while one
event was being recorded. When account_irq_enter_time was called, the
function tracer noticed that its recursion bit for the current context
was already set, and just dropped the event because it thought it was
just tracing itself. After we add HARDIRQ_OFFSET to preempt_count, the
"in_interrupt()" will be set and the function tracer will know its in a
new context where its safe to continue tracing.

Can you try this patch to see if it fixes it for you?

-- Steve

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 0fbbcdf0c178..0290531ebe3c 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -35,8 +35,8 @@ extern void rcu_nmi_exit(void);
  */
 #define __irq_enter()					\
 	do {						\
-		account_irq_enter_time(current);	\
 		preempt_count_add(HARDIRQ_OFFSET);	\
+		account_irq_enter_time(current);	\
 		trace_hardirq_enter();			\
 	} while (0)
 
