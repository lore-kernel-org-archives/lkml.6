Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeFBRO3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 13:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbeFBRO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 13:14:27 -0400
Date: Sat, 2 Jun 2018 13:14:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
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
        Vedang Patel <vedang.patel@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] softirq: reorder trace_softirqs_on to prevent lockdep
 splat
Message-ID: <20180602131424.3e4b3f0f@vmware.local.home>
In-Reply-To: <20180601045215.GA168630@joelaf.mtv.corp.google.com>
References: <20180502014439.87828-1-joelaf@google.com>
        <20180507142117.35310ff2@gandalf.local.home>
        <20180601045215.GA168630@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018 21:52:15 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Mon, May 07, 2018 at 02:21:17PM -0400, Steven Rostedt wrote:
> > Peter, Ingo or Thomas,
> > 
> > Can you queue this up? Or would you prefer that I take it?  
> 
> This patch is a bug fix, could it be queued for v4.17 -rc cycle or for
> linux-next?
> 
> I have also included it below again:

Thanks. I can't pull it without an ack as I'm not the softirq
maintainer.

Thomas, can you just ack it, and I'll take it, if that will be easire
for you?

-- Steve

> 
> thanks,
> 
>  - Joel
> 
> ---8<-----------------------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Date: Tue, 1 May 2018 18:44:39 -0700
> Subject: [PATCH] softirq: reorder trace_softirqs_on to prevent lockdep splat
> 
> I'm able to reproduce a lockdep splat with config options:
> CONFIG_PROVE_LOCKING=y,
> CONFIG_DEBUG_LOCK_ALLOC=y and
> CONFIG_PREEMPTIRQ_EVENTS=y
> 
> $ echo 1 > /d/tracing/events/preemptirq/preempt_enable/enable
> 
> [   26.112609] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
> [   26.112636] WARNING: CPU: 0 PID: 118 at kernel/locking/lockdep.c:3854
> [...]
> [   26.144229] Call Trace:
> [   26.144926]  <IRQ>
> [   26.145506]  lock_acquire+0x55/0x1b0
> [   26.146499]  ? __do_softirq+0x46f/0x4d9
> [   26.147571]  ? __do_softirq+0x46f/0x4d9
> [   26.148646]  trace_preempt_on+0x8f/0x240
> [   26.149744]  ? trace_preempt_on+0x4d/0x240
> [   26.150862]  ? __do_softirq+0x46f/0x4d9
> [   26.151930]  preempt_count_sub+0x18a/0x1a0
> [   26.152985]  __do_softirq+0x46f/0x4d9
> [   26.153937]  irq_exit+0x68/0xe0
> [   26.154755]  smp_apic_timer_interrupt+0x271/0x280
> [   26.156056]  apic_timer_interrupt+0xf/0x20
> [   26.157105]  </IRQ>
> 
> The issue was this:
> 
> preempt_count = 1 << SOFTIRQ_SHIFT
> 
> 	__local_bh_enable(cnt = 1 << SOFTIRQ_SHIFT) {
> 		if (softirq_count() == (cnt && SOFTIRQ_MASK)) {
> 			trace_softirqs_on() {
> 				current->softirqs_enabled = 1;
> 			}
> 		}
> 		preempt_count_sub(cnt) {
> 			trace_preempt_on() {
> 				tracepoint() {
> 					rcu_read_lock_sched() {
> 						// jumps into lockdep
> 
> Where preempt_count still has softirqs disabled, but
> current->softirqs_enabled is true, and we get a splat.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Fixes: d59158162e032 ("tracing: Add support for preempt and irq enable/disable events")
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/softirq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 177de3640c78..8a040bcaa033 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -139,9 +139,13 @@ static void __local_bh_enable(unsigned int cnt)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> +	if (preempt_count() == cnt)
> +		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
> +
>  	if (softirq_count() == (cnt & SOFTIRQ_MASK))
>  		trace_softirqs_on(_RET_IP_);
> -	preempt_count_sub(cnt);
> +
> +	__preempt_count_sub(cnt);
>  }
>  
>  /*
