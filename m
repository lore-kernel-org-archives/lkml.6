Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbeBBDSa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:18:30 -0500
Received: from [210.13.100.6] ([210.13.100.6]:41769 "EHLO
        mail2012.asrmicro.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751730AbeBBDS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:18:26 -0500
From: Qiao Zhou <qiaozhou@asrmicro.com>
To: <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Qiao Zhou <qiaozhou@asrmicro.com>
Subject: [PATCH] tick/broadcast: set next event of bc to KTIME_MAX
Date: Fri, 2 Feb 2018 11:02:47 +0800
Message-ID: <1517540567-23599-1-git-send-email-qiaozhou@asrmicro.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.50.16]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tick_handle_oneshot_broadcast, it doesn't reprogram tick-broadcast
when no more event to set. In hardware it's true, but the next event
value on broadcast device is expired, which will be used in idle
broadcast enter. It may cause no more timer set in system in below case.

nte_l: next_timer_event on local timer 
nte_b: next_timer_event on broadcast timer
time: in ms, assume HZ = 128

     core0                core1             broadcast timer
990: nte_l = 1004         nte_l = 1004      nte_b = 1000
     enter idle           enter idle        nte_b = 1000 
-----------------------------------------------------------
     996: non-timer interrupt wake up both core0 & core1   
-----------------------------------------------------------
996: core0/1 exit idle, clear broadcast oneshot mask, set
     local timer next event(nte_l = 996 + 8 = 1004)
1000:broadcast interrupt comes, one shot mask is 0. do not
     program broadcast next time event.(nte_b = 1000)
1002:core0/1 enter idle, shut down local timer. since nte_l
     is larger than nte_b, do not program broadcast timer.
1004:no more timer interrupt, not report rcu quiescent state
     completion. no new timer is set in tick_nohz_idle_enter
     when core0/1 enter/exit idle. at last system will crash.

tick_program_event(dev->next_event, 1) is not guaranteed to generate
local timer interrupt when exiting idle. When local timer is shutdown,
we need to compare local next event to updated broadcast next event.
So when there is no broadcast next event to set on hardware, we need
to set software next_event to KTIME_MAX.

Signed-off-by: Qiao Zhou <qiaozhou@asrmicro.com>
---
 kernel/time/tick-broadcast.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index b398c2e..7648326 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -661,6 +661,14 @@ static void tick_handle_oneshot_broadcast(struct clock_event_device *dev)
 	 */
 	if (next_event != KTIME_MAX)
 		tick_broadcast_set_event(dev, next_cpu, next_event);
+	else
+		/*
+		 * not program broadcast timer, but set the value to show that
+		 * the next event is not set, which is used in
+		 * __tick_broadcast_oneshot_control in idle tick_broadcast
+		 * enter/exit control flow.
+		 */
+		dev->next_event.tv64 = KTIME_MAX;
 
 	raw_spin_unlock(&tick_broadcast_lock);
 
-- 
2.7.4
