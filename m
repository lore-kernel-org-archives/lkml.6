Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeCNPto (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbeCNPtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:49:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93A820779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Wed, 14 Mar 2018 16:49:39 +0100
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
Subject: Re: [RFT][PATCH v4 1/7] time: tick-sched: Reorganize idle tick
 management code
Message-ID: <20180314154934.GA3635@lerouge>
References: <2352117.3UUoYAu18A@aspire.rjw.lan>
 <2019498.YXfJVQUTuX@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2019498.YXfJVQUTuX@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:47:41AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Prepare the scheduler tick code for reworking the idle loop to
> avoid stopping the tick in some cases.
> 
> Move away the tick_nohz_start_idle() invocation from
> __tick_nohz_idle_enter(), rename the latter to
> __tick_nohz_idle_stop_tick() and define tick_nohz_idle_stop_tick()
> as a wrapper around it for calling it from the outside.
> 
> Make tick_nohz_idle_enter() only call tick_nohz_start_idle() instead
> of calling the entire __tick_nohz_idle_enter(), add another wrapper
> disabling and enabling interrupts around tick_nohz_idle_stop_tick()
> and make the current callers of tick_nohz_idle_enter() call it too
> to retain their current functionality.

Perhaps we should have a higher level description of what the patch does.
After all the low level part is already described in the diff.

Ie: we are splitting the nohz idle entry call to decouple the idle time
stats accounting and preparatory work from the actual tick stop code, that
in order to later be able to delay the tick stop once we reach more
power-knowledgeable callers.

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/xen/smp_pv.c    |    1 +
>  include/linux/tick.h     |    9 +++++++++
>  kernel/sched/idle.c      |    1 +
>  kernel/time/tick-sched.c |   46 +++++++++++++++++++++++++---------------------
>  4 files changed, 36 insertions(+), 21 deletions(-)
> 
> Index: linux-pm/include/linux/tick.h
> ===================================================================
> --- linux-pm.orig/include/linux/tick.h
> +++ linux-pm/include/linux/tick.h
> @@ -114,6 +114,7 @@ enum tick_dep_bits {
>  #ifdef CONFIG_NO_HZ_COMMON
>  extern bool tick_nohz_enabled;
>  extern int tick_nohz_tick_stopped(void);
> +extern void tick_nohz_idle_stop_tick(void);
>  extern void tick_nohz_idle_enter(void);
>  extern void tick_nohz_idle_exit(void);
>  extern void tick_nohz_irq_exit(void);
> @@ -125,6 +126,7 @@ extern u64 get_cpu_iowait_time_us(int cp
>  #else /* !CONFIG_NO_HZ_COMMON */
>  #define tick_nohz_enabled (0)
>  static inline int tick_nohz_tick_stopped(void) { return 0; }
> +static inline void tick_nohz_idle_stop_tick(void) { }
>  static inline void tick_nohz_idle_enter(void) { }
>  static inline void tick_nohz_idle_exit(void) { }
>  
> @@ -136,6 +138,13 @@ static inline u64 get_cpu_idle_time_us(i
>  static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
>  #endif /* !CONFIG_NO_HZ_COMMON */
>  
> +static inline void tick_nohz_idle_stop_tick_protected(void)
> +{
> +	local_irq_disable();
> +	tick_nohz_idle_stop_tick();
> +	local_irq_enable();
> +}

It seems that even if we have CONFIG_NO_HZ_COMMON=n, tick_nohz_idle_stop_tick_protected()
will have overhead, right?

Thanks.
