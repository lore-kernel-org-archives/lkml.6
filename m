Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758796AbeD0QaI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:30:08 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:46183 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758550AbeD0QaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:30:06 -0400
X-Google-Smtp-Source: AB8JxZo00TeUHuDa48PKtYv7/SzbBvhs/0iMqg/1o3m9TAlK3Zntf/1Uqn/zhQ3pPfgmIW0v5aNOnfRKQnmdnaVt6zA=
MIME-Version: 1.0
In-Reply-To: <20180427104747.2d965925@gandalf.local.home>
References: <20180427042656.190746-1-joelaf@google.com> <1169911546.5820.1524839189395.JavaMail.zimbra@efficios.com>
 <20180427104747.2d965925@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 27 Apr 2018 09:30:05 -0700
Message-ID: <CAJWu+ortS=BQ98BSmExHPz_vQ6-rgcKQC7dhSR2_3e6714QVzA@mail.gmail.com>
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks executing
 with preempt on
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        fweisbec <fweisbec@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 7:47 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 27 Apr 2018 10:26:29 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>
>> The general approach and the implementation look fine, except for
>> one small detail: I would be tempted to explicitly disable preemption
>> around the call to the tracepoint callback for the rcuidle variant,
>> unless we plan to audit every tracer right away to remove any assumption
>> that preemption is disabled in the callback implementation.
>
> I'm thinking that we do that audit. There shouldn't be many instances
> of it. I like the idea that a tracepoint callback gets called with
> preemption enabled.

Here is the list of all callers of the _rcuidle :

trace_clk_disable_complete_rcuidle
trace_clk_disable_rcuidle
trace_clk_enable_complete_rcuidle
trace_clk_enable_rcuidle
trace_console_rcuidle
trace_cpu_idle_rcuidle
trace_ipi_entry_rcuidle
trace_ipi_exit_rcuidle
trace_ipi_raise_rcuidle
trace_irq_disable_rcuidle
trace_irq_enable_rcuidle
trace_power_domain_target_rcuidle
trace_preempt_disable_rcuidle
trace_preempt_enable_rcuidle
trace_rpm_idle_rcuidle
trace_rpm_resume_rcuidle
trace_rpm_return_int_rcuidle
trace_rpm_suspend_rcuidle
trace_tlb_flush_rcuidle

All of these are either called from irqs or preemption disabled
already. So I think it should be fine to keep preemption on. But I'm
Ok with disabling it before callback execution if we agree that we
want that.

(and the ring buffer code is able to cope anyway Steven pointed).

thanks,

 - Joel
