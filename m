Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932117AbeB1M7l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:59:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41081 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbeB1M7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:59:40 -0500
Date: Wed, 28 Feb 2018 04:59:30 -0800
From: tip-bot for Vineet Gupta <tipbot@zytor.com>
Message-ID: <tip-a4f538573cd72e7961f4ec5eb13c171f5add58ec@git.kernel.org>
Cc: vgupta@synopsys.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, daniel.lezcano@linaro.org,
        Vineet.Gupta1@synopsys.com, hpa@zytor.com
Reply-To: hpa@zytor.com, Vineet.Gupta1@synopsys.com, mingo@kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, vgupta@synopsys.com
In-Reply-To: <1519241491-12570-1-git-send-email-vgupta@synopsys.com>
References: <1519241491-12570-1-git-send-email-vgupta@synopsys.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource/drivers/arc_timer: Update some
 comments
Git-Commit-ID: a4f538573cd72e7961f4ec5eb13c171f5add58ec
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a4f538573cd72e7961f4ec5eb13c171f5add58ec
Gitweb:     https://git.kernel.org/tip/a4f538573cd72e7961f4ec5eb13c171f5add58ec
Author:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
AuthorDate: Wed, 21 Feb 2018 11:31:31 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 13:55:14 +0100

clocksource/drivers/arc_timer: Update some comments

TIMER0 interrupt ACK is different for ARC700 and HS3x cores.

This came to light in some internal discussions and it is nice to have this
documented rather than digging up the PRM (Programmers Reference Manual).

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Link: https://lkml.kernel.org/r/1519241491-12570-1-git-send-email-vgupta@synopsys.com

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
 
