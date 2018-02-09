Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeBIQLk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:11:40 -0500
Received: from muru.com ([72.249.23.125]:56426 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbeBIQLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:11:39 -0500
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / wakeirq: Fix unbalanced irq enable for wakeirq
Date: Fri,  9 Feb 2018 08:11:26 -0800
Message-Id: <20180209161126.18580-1-tony@atomide.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device is runtime PM suspended when we enter suspend and has
a dedicated wake irq, we can get the following warning:

WARNING: CPU: 0 PID: 108 at kernel/irq/manage.c:526 enable_irq+0x40/0x94
[  102.087860] Unbalanced enable for IRQ 147
...
(enable_irq) from [<c06117a8>] (dev_pm_arm_wake_irq+0x4c/0x60)
(dev_pm_arm_wake_irq) from [<c0618360>]
 (device_wakeup_arm_wake_irqs+0x58/0x9c)
(device_wakeup_arm_wake_irqs) from [<c0615948>]
(dpm_suspend_noirq+0x10/0x48)
(dpm_suspend_noirq) from [<c01ac7ac>]
(suspend_devices_and_enter+0x30c/0xf14)
(suspend_devices_and_enter) from [<c01adf20>]
(enter_state+0xad4/0xbd8)
(enter_state) from [<c01ad3ec>] (pm_suspend+0x38/0x98)
(pm_suspend) from [<c01ab3e8>] (state_store+0x68/0xc8)

This is because the dedicated wake irq for the device may have been
already enabled earlier by dev_pm_enable_wake_irq_check(). Fix the
issue by checking for runtime PM suspended status.

This issue can be easily reproduced by setting serial console log level
to zero, letting the serial console idle, and suspend the system from
an ssh terminal. On resume, dmesg will have the warning above.

The reason why I have not ran into this issue earlier has been that I
typically run my PM test cases from on a serial console instead over ssh.

Fixes: c84345597558 ("PM / wakeirq: Enable dedicated wakeirq for suspend")
Cc: Brian Norris <briannorris@chromium.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/power/wakeirq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -321,7 +321,8 @@ void dev_pm_arm_wake_irq(struct wake_irq *wirq)
 		return;
 
 	if (device_may_wakeup(wirq->dev)) {
-		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
+		    !pm_runtime_status_suspended(wirq->dev))
 			enable_irq(wirq->irq);
 
 		enable_irq_wake(wirq->irq);
@@ -343,7 +344,8 @@ void dev_pm_disarm_wake_irq(struct wake_irq *wirq)
 	if (device_may_wakeup(wirq->dev)) {
 		disable_irq_wake(wirq->irq);
 
-		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED)
+		if (wirq->status & WAKE_IRQ_DEDICATED_ALLOCATED &&
+		    !pm_runtime_status_suspended(wirq->dev))
 			disable_irq_nosync(wirq->irq);
 	}
 }
-- 
2.16.1
