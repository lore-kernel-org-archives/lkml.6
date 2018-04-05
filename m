Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeDEP1G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:27:06 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:44862 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEP1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:27:06 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clockevents: Fix kernel messages split across multiple lines
Date: Thu,  5 Apr 2018 17:26:58 +0200
Message-Id: <1522942018-14471-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the clockevents driver from old-style printk() to pr_info() and
pr_cont(), to fix split kernel messages like below:

    Clockevents: could not switch to one-shot mode:
     dummy_timer is not functional.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 kernel/time/tick-oneshot.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index c1f518e7aa808a28..6fe615d57ebbbe3b 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -82,16 +82,15 @@ int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *))
 	if (!dev || !(dev->features & CLOCK_EVT_FEAT_ONESHOT) ||
 		    !tick_device_is_functional(dev)) {
 
-		printk(KERN_INFO "Clockevents: "
-		       "could not switch to one-shot mode:");
+		pr_info("Clockevents: could not switch to one-shot mode:");
 		if (!dev) {
-			printk(" no tick device\n");
+			pr_cont(" no tick device\n");
 		} else {
 			if (!tick_device_is_functional(dev))
-				printk(" %s is not functional.\n", dev->name);
+				pr_cont(" %s is not functional.\n", dev->name);
 			else
-				printk(" %s does not support one-shot mode.\n",
-				       dev->name);
+				pr_cont(" %s does not support one-shot mode.\n",
+					dev->name);
 		}
 		return -EINVAL;
 	}
-- 
2.7.4
