Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeCOQKm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbeCOQKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:10:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7D0204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Thu, 15 Mar 2018 17:10:36 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH v4 2/7] sched: idle: Do not stop the tick upfront in
 the idle loop
Message-ID: <20180315161031.GA12313@lerouge>
References: <2352117.3UUoYAu18A@aspire.rjw.lan>
 <2177770.i4UbKDJpnI@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2177770.i4UbKDJpnI@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:51:11AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Push the decision whether or not to stop the tick somewhat deeper
> into the idle loop.
> 
> Stopping the tick upfront leads to unpleasant outcomes in case the
> idle governor doesn't agree with the timekeeping code on the duration
> of the upcoming idle period.

Looks like you meant "nohz" instead of "timekeeping"?


> Specifically, if the tick has been
> stopped and the idle governor predicts short idle, the situation is
> bad regardless of whether or not the prediction is accurate.  If it
> is accurate, the tick has been stopped unnecessarily which means
> excessive overhead.  If it is not accurate, the CPU is likely to
> spend too much time in the (shallow, because short idle has been
> predicted) idle state selected by the governor [1].
> 
> As the first step towards addressing this problem, change the code
> to make the tick stopping decision inside of the loop in do_idle().
> In particular, do not stop the tick in the cpu_idle_poll() code path.
> Also don't do that in tick_nohz_irq_exit() which doesn't really have
> enough information on whether or not to stop the tick.
> 
> Link: https://marc.info/?l=linux-pm&m=150116085925208&w=2 # [1]
> Link: https://tu-dresden.de/zih/forschung/ressourcen/dateien/projekte/haec/powernightmares.pdf
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/idle.c      |    8 +++++---
>  kernel/time/tick-sched.c |    6 ++----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -241,10 +241,12 @@ static void do_idle(void)
>  		 * broadcast device expired for us, we don't want to go deep
>  		 * idle as we know that the IPI is going to arrive right away.
>  		 */
> -		if (cpu_idle_force_poll || tick_check_broadcast_expired())
> +		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
>  			cpu_idle_poll();
> -		else
> +		} else {
> +			tick_nohz_idle_stop_tick();
>  			cpuidle_idle_call();
> +		}

I'm worried about one thing here. Say we enter cpuidle_idle_call() and the tick is stopped.
Later on, we get a tick, so we exit cpuidle_idle_call(), then we find cpu_idle_force_poll
or tick_check_broadcast_expired() to be true. So we poll but the tick hasn't been updated
to fire again.

I don't know if it can happen but cpu_idle_poll_ctrl() seem to be callable anytime.
It looks like it's only used on __init code or on power suspend/resume, not sure about
the implications on the latter, still there could be further misuse in the future.

Concerning tick_check_broadcast_expired(), it's hard to tell if it can be enabled
concurrently from another CPU or from interrupts.

Anyway perhaps we should have, out of paranoia:

+		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
+			tick_nohz_idle_restart_tick();
  			cpu_idle_poll();
-		else

...where tick_nohz_idle_restart_tick() would be:

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 29a5733..9ae1ef5 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1046,6 +1046,18 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 #endif
 }
 
+static void __tick_nohz_idle_restart_tick(struct tick_sched *ts, ktime_t now)
+{
+	tick_nohz_restart_sched_tick(ts, now);
+	tick_nohz_account_idle_ticks(ts);
+}
+
+void tick_nohz_idle_restart_tick(void)
+{
+	if (ts->tick_stopped)
+		__tick_nohz_idle_restart_tick(this_cpu_ptr(&tick_cpu_sched), ktime_get());
+}
+
 /**
  * tick_nohz_idle_exit - restart the idle tick from the idle task
  *
@@ -1070,10 +1082,8 @@ void tick_nohz_idle_exit(void)
 	if (ts->idle_active)
 		tick_nohz_stop_idle(ts, now);
 
-	if (ts->tick_stopped) {
-		tick_nohz_restart_sched_tick(ts, now);
-		tick_nohz_account_idle_ticks(ts);
-	}
+	if (ts->tick_stopped())
+		__tick_nohz_idle_restart_tick(ts, now)
 
 	local_irq_enable();
 }


Thanks.
