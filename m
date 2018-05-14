Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbeENPkT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:40:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:23867 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbeENPkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:40:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,400,1520924400";
   d="scan'208";a="224113430"
Date: Mon, 14 May 2018 23:45:23 +0800
From: Yu Chen <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH][RFC v2] ACPI: acpi_pad: Do not launch acpi_pad threads
 on idle cpus
Message-ID: <20180514154523.GA17331@sandybridge-desktop>
References: <1525521202-32519-1-git-send-email-yu.c.chen@intel.com>
 <8775668.fKKdjnIWAU@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8775668.fKKdjnIWAU@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 11:30:52AM +0200, Rafael J. Wysocki wrote:
> On Saturday, May 5, 2018 1:53:22 PM CEST Chen Yu wrote:
> > According to current implementation of acpi_pad driver,
> > it does not make sense to spawn any power saving threads
> > on the cpus which are already idle - it might bring
> > unnecessary overhead on these idle cpus and causes power
> > waste. So verify the condition that if the number of 'busy'
> > cpus exceeds the amount of the 'forced idle' cpus is met.
> > This is applicable due to round-robin attribute of the
> > power saving threads, otherwise ignore the setting/ACPI
> > notification.
> 
> OK, but CPUs are busy, because they are running tasks.  If acpi_pad
> kthreads run on them, the tasks they are running will migrate to the
> currently idle CPUs (unless they have specific CPU affinity) and the
> throttling will not really be effective.
>
OK, I think this makes sense, I missed the load balance scenario.
> I would think that acpi_pad should ensure that the requested number of
> CPUs will not run anything other than throttling kthreads.  Isn't that
> the case?
> 
Do you mean, we should check if the number of 'idle'(rather than the 'busy' one
in this patch) cpus is larger than the requested one? Then I think we should also
add a patch to use the play_idle() as power_clamp to treat the throttling kthreads
as idle threads thus to stop system tick. Such as the patch Jacob proposed:

Index: linux/drivers/acpi/acpi_pad.c
===================================================================
--- linux.orig/drivers/acpi/acpi_pad.c
+++ linux/drivers/acpi/acpi_pad.c
@@ -144,7 +144,6 @@ static unsigned int round_robin_time = 1
 static int power_saving_thread(void *data)
 {
 	struct sched_param param = {.sched_priority = 1};
-	int do_sleep;
 	unsigned int tsk_index = (unsigned long)data;
 	u64 last_jiffies = 0;
 
@@ -160,33 +159,13 @@ static int power_saving_thread(void *dat
 			round_robin_cpu(tsk_index);
 		}
 
-		do_sleep = 0;
-
-		expire_time = jiffies + HZ * (100 - idle_pct) / 100;
-
-		while (!need_resched()) {
-			if (tsc_detected_unstable && !tsc_marked_unstable) {
-				/* TSC could halt in idle, so notify users */
-				mark_tsc_unstable("TSC halts in idle");
-				tsc_marked_unstable = 1;
-			}
-			local_irq_disable();
-			tick_broadcast_enable();
-			tick_broadcast_enter();
-			stop_critical_timings();
-
-			mwait_idle_with_hints(power_saving_mwait_eax, 1);
-
-			start_critical_timings();
-			tick_broadcast_exit();
-			local_irq_enable();
-
-			if (time_before(expire_time, jiffies)) {
-				do_sleep = 1;
-				break;
-			}
+		if (tsc_detected_unstable && !tsc_marked_unstable) {
+			/* TSC could halt in idle, so notify users */
+			mark_tsc_unstable("TSC halts in idle");
+			tsc_marked_unstable = 1;
 		}
 
+		play_idle(jiffies_to_msecs(HZ * (100 - idle_pct) / 100));
 		/*
 		 * current sched_rt has threshold for rt task running time.
 		 * When a rt task uses 95% CPU time, the rt thread will be
@@ -196,8 +175,7 @@ static int power_saving_thread(void *dat
 		 * borrow CPU time from this CPU and cause RT task use > 95%
 		 * CPU time. To make 'avoid starvation' work, takes a nap here.
 		 */
-		if (unlikely(do_sleep))
-			schedule_timeout_killable(HZ * idle_pct / 100);
+		schedule_timeout_killable(HZ * idle_pct / 100);
 
 		/* If an external event has set the need_resched flag, then
 		 * we need to deal with it, or this loop will continue to
> Thanks,
> Rafael
> 
