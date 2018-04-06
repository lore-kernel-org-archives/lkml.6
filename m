Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDFCoU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 22:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbeDFCoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 22:44:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC1B217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
Date: Fri, 6 Apr 2018 04:44:14 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v9 05/10] cpuidle: Return nohz hint from cpuidle_select()
Message-ID: <20180406024413.GB4400@lerouge>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
 <5818594.T4StF86Hkt@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5818594.T4StF86Hkt@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 10:39:50AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Index: linux-pm/kernel/time/tick-sched.c
> ===================================================================
> --- linux-pm.orig/kernel/time/tick-sched.c
> +++ linux-pm/kernel/time/tick-sched.c
> @@ -991,6 +991,20 @@ void tick_nohz_irq_exit(void)
>  }
>  
>  /**
> + * tick_nohz_idle_got_tick - Check whether or not the tick handler has run
> + */
> +bool tick_nohz_idle_got_tick(void)
> +{
> +	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +	if (ts->inidle > 1) {
> +		ts->inidle = 1;
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/**
>   * tick_nohz_get_sleep_length - return the length of the current sleep
>   *
>   * Called from power state control code with interrupts disabled
> @@ -1101,6 +1115,9 @@ static void tick_nohz_handler(struct clo
>  	struct pt_regs *regs = get_irq_regs();
>  	ktime_t now = ktime_get();
>  
> +	if (ts->inidle)
> +		ts->inidle = 2;
> +

You can move that to tick_sched_do_timer() to avoid code duplication.

Also these constants are very opaque. And even with proper symbols it wouldn't look
right to extend ts->inidle that way.

Perhaps you should add a field such as ts->got_idle_tick under the boolean fields
after the below patch:

--
>From c7b2ca5a4c512517ddfeb9f922d5999f82542ced Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Fri, 6 Apr 2018 04:32:37 +0200
Subject: [PATCH] nohz: Gather tick_sched booleans under a common flag field

This optimize the space and leave plenty of room for further flags.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 954b43d..38f24dc 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -45,14 +45,17 @@ struct tick_sched {
 	struct hrtimer			sched_timer;
 	unsigned long			check_clocks;
 	enum tick_nohz_mode		nohz_mode;
+
+	unsigned int			inidle		: 1;
+	unsigned int			tick_stopped	: 1;
+	unsigned int			idle_active	: 1;
+	unsigned int			do_timer_last	: 1;
+
 	ktime_t				last_tick;
 	ktime_t				next_tick;
-	int				inidle;
-	int				tick_stopped;
 	unsigned long			idle_jiffies;
 	unsigned long			idle_calls;
 	unsigned long			idle_sleeps;
-	int				idle_active;
 	ktime_t				idle_entrytime;
 	ktime_t				idle_waketime;
 	ktime_t				idle_exittime;
@@ -62,7 +65,6 @@ struct tick_sched {
 	unsigned long			last_jiffies;
 	u64				next_timer;
 	ktime_t				idle_expires;
-	int				do_timer_last;
 	atomic_t			tick_dep_mask;
 };
 
-- 
2.7.4
