Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeBUTbr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:31:47 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51808 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeBUTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:31:45 -0500
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: <linux-snps-arc@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] clocksource: arc_timer: update some comments
Date: Wed, 21 Feb 2018 11:31:31 -0800
Message-ID: <1519241491-12570-1-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TIMER0 interrupt ACK is different for ARC700 and HS3x cores.

This came to light in some internal discussions and it is nice to have
this documented rather than digging up the PRM (Prog Ref Manual) again

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 drivers/clocksource/arc_timer.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index 4927355f9cbe..471b428d8034 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -251,9 +251,14 @@ static irqreturn_t timer_irq_handler(int irq, void *dev_id)
 	int irq_reenable = clockevent_state_periodic(evt);
 
 	/*
-	 * Any write to CTRL reg ACks the interrupt, we rewrite the
-	 * Count when [N]ot [H]alted bit.
-	 * And re-arm it if perioid by [I]nterrupt [E]nable bit
+	 * 1. ACK the interrupt
+	 *    - For ARC700, any write to CTRL reg ACKs it, so just rewrite
+	 *      Count when [N]ot [H]alted bit.
+	 *    - For HS3x, it is a bit subtle. On taken count-down interrupt,
+	 *      IP bit [3] is set, which needs to be cleared for ACK'ing.
+	 *      The write below can only update the other two bits, hence
+	 *      explicitly clears IP bit
+	 * 2. Re-arm interrupt if periodic by writing to IE bit [0]
 	 */
 	write_aux_reg(ARC_REG_TIMER0_CTRL, irq_reenable | TIMER_CTRL_NH);
 
-- 
2.7.4
