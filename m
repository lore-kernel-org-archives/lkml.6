Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751067AbeETInE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:43:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58357 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbeETInD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:43:03 -0400
Date: Sun, 20 May 2018 10:43:01 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] timer fix for 4.17
Message-ID: <alpine.DEB.2.21.1805201039490.1599@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

Address the for_each_cpu() oddity on UP kernels in the tick broadcast code
which causes boot failures because the CPU0 bit is always reported as set
independent of the cpumask content.

Thanks,

	tglx

------------------>
Dexuan Cui (1):
      tick/broadcast: Use for_each_cpu() specially on UP kernels


 kernel/time/tick-broadcast.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index b398c2ea69b2..aa2094d5dd27 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -612,6 +612,14 @@ static void tick_handle_oneshot_broadcast(struct clock_event_device *dev)
 	now = ktime_get();
 	/* Find all expired events */
 	for_each_cpu(cpu, tick_broadcast_oneshot_mask) {
+		/*
+		 * Required for !SMP because for_each_cpu() reports
+		 * unconditionally CPU0 as set on UP kernels.
+		 */
+		if (!IS_ENABLED(CONFIG_SMP) &&
+		    cpumask_empty(tick_broadcast_oneshot_mask))
+			break;
+
 		td = &per_cpu(tick_cpu_device, cpu);
 		if (td->evtdev->next_event <= now) {
 			cpumask_set_cpu(cpu, tmpmask);
