Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935460AbeEIQCX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:02:23 -0400
Received: from foss.arm.com ([217.140.101.70]:45884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935445AbeEIQCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:02:20 -0400
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH] tick: prefer a lower rating device only if it's CPU local device
Date: Wed,  9 May 2018 17:02:08 +0100
Message-Id: <1525881728-4858-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking the equality of cpumask for both new and old tick device doesn't
ensure that it's CPU local device. This will cause issue if a low rating
clockevent tick device is registered first followed by the registration
of higher rating clockevent tick device.

In such case, clockevents_released list will never get emptied as both
the devices get selected as preferred one and we will loop forever in
clockevents_notify_released.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 kernel/time/tick-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Hi Thomas,

I am seeing this issue on my Juno devboard, where system wide timers
with rating 300 and 400 are registered in same order and we get stuck in
a loop in clockevents_notify_released. Let me know if this looks sane or
you have any suggestions that I can try out.

Regards,
Sudeep

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 49edc1c4f3e6..78e598334007 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -277,7 +277,8 @@ static bool tick_check_preferred(struct clock_event_device *curdev,
 	 */
 	return !curdev ||
 		newdev->rating > curdev->rating ||
-	       !cpumask_equal(curdev->cpumask, newdev->cpumask);
+	       (!cpumask_equal(curdev->cpumask, newdev->cpumask) &&
+	        !tick_check_percpu(curdev, newdev, smp_processor_id()));
 }

 /*
--
2.7.4
