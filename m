Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeCVRJB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 13:09:01 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44378 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbeCVRI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 13:08:59 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Rik van Riel <riel@surriel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Thu, 22 Mar 2018 18:09:23 +0100
Message-ID: <4731938.EeADOapqQb@aspire.rjw.lan>
In-Reply-To: <1521736343.6308.25.camel@surriel.com>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan> <1521736343.6308.25.camel@surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, March 22, 2018 5:32:23 PM CET Rik van Riel wrote:
> On Wed, 2018-03-14 at 15:08 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > If poll_idle() is allowed to spin until need_resched() returns
> > 'true',
> > it may actually spin for a much longer time than expected by the idle
> > governor, since set_tsk_need_resched() is not always called by the
> > timer interrupt handler.  If that happens, the CPU may spend much
> > more time than anticipated in the "polling" state.
> > 
> > To prevent that from happening, limit the time of the spinning loop
> > in poll_idle().
> > 
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> So ... about bisecting that other patch series...
> 
> It turned out I had this patch, which looks so
> obviously correct, as patch #1 in my series.
> 
> It also turned out that this patch is responsible
> for the entire 5-10% increase in CPU use for the
> memcache style workload.
> 
> I wonder if keeping an idle HT thread much busier
> than before slows down its sibling, or something
> like that.

Uhm, sorry about this.

Does it improve if you do something like the below on top of it?

> Let me go test the nohz idle series by itself,
> without this patch.

OK

---
 drivers/cpuidle/poll_state.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/cpuidle/poll_state.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/poll_state.c
+++ linux-pm/drivers/cpuidle/poll_state.c
@@ -10,6 +10,7 @@
 #include <linux/sched/idle.h>
 
 #define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)
+#define POLL_IDLE_COUNT		1000
 
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
@@ -18,9 +19,14 @@ static int __cpuidle poll_idle(struct cp
 
 	local_irq_enable();
 	if (!current_set_polling_and_test()) {
+		unsigned int loop_count = 0;
+
 		while (!need_resched()) {
 			cpu_relax();
+			if (loop_count++ < POLL_IDLE_COUNT)
+				continue;
 
+			loop_count = 0;
 			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT)
 				break;
 		}
