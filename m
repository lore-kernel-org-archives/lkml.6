Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeDSPxN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:53:13 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:48744 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752514AbeDSPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:53:12 -0400
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2] clocksource: arc_timer: add comments about locking while read GFRC
Date: Thu, 19 Apr 2018 18:53:05 +0300
Message-Id: <20180419155305.32402-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This came to light in some internal discussions and it is nice to have
this documented rather than digging up the PRM (Prog Ref Manual) again.

Acked-by: Vineet Gupta <vgupta@synopsys.com>

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2:
 * Minor comment fix.

 drivers/clocksource/arc_timer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index 4927355f9cbe..e997e2be6287 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -61,6 +61,20 @@ static u64 arc_read_gfrc(struct clocksource *cs)
 	unsigned long flags;
 	u32 l, h;
 
+	/*
+	 * From a programming model pov, there seems to be just one instance of
+	 * MCIP_CMD/MCIP_READBACK however micro-architecturally there's
+	 * an instance PER ARC CORE (not per cluster), and there are dedicated
+	 * hardware decode logic (per core) inside ARConnect to handle
+	 * simultaneous read/write accesses from cores via those two registers.
+	 * So several concurrent commands to ARConnect are OK if they are
+	 * trying to access two different sub-components (like GFRC,
+	 * inter-core interrupt, etc...). HW also supports simultaneously
+	 * accessing GFRC by multiple cores.
+	 * That's why it is safe to disable hard interrupts on the local CPU
+	 * before access to GFRC instead of taking global MCIP spinlock
+	 * defined in arch/arc/kernel/mcip.c
+	 */
 	local_irq_save(flags);
 
 	__mcip_cmd(CMD_GFRC_READ_LO, 0);
-- 
2.14.3
