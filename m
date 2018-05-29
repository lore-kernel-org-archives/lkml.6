Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966168AbeE2S12 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:27:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50871 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965874AbeE2S1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:27:16 -0400
X-Google-Smtp-Source: ADUXVKIevy4ejQ2UukfuzQ/f637m8tfADPg5MT6FuQt/4fEm8CJ7sRoj1Jm+6/BF+XHgeVj3zlkA1A==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org (open list:SYNOPSYS ARC ARCHITECTURE)
Subject: [PATCH 3/7] clocksource/drivers/arc_timer: Add comments about locking while read GFRC
Date: Tue, 29 May 2018 20:26:38 +0200
Message-Id: <1527618402-31974-3-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527618402-31974-1-git-send-email-daniel.lezcano@linaro.org>
References: <1274a543-02dd-bbf0-c690-b08c788d9e91@linaro.org>
 <1527618402-31974-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

This came to light in some internal discussions and it is nice to have
this documented rather than digging up the PRM (Prog Ref Manual) again.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Acked-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arc_timer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index 471b428..20da9b1 100644
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
2.7.4
