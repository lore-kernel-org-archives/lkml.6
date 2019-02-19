Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B78DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2CE217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfBSQH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:07:59 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33941 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBSQH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:07:59 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gw7w4-00016W-8D; Tue, 19 Feb 2019 17:07:56 +0100
Date:   Tue, 19 Feb 2019 17:07:56 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 3/2] softirq: Avoid "local_softirq_pending" messages if
 task is in cpu_chill()
Message-ID: <20190219160755.fn4c65ph4lzqflw2@linutronix.de>
References: <20190218163107.iwdpngwmbs6xyk7x@linutronix.de>
 <20190218163137.cmor4ek3odus5m6j@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190218163137.cmor4ek3odus5m6j@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the softirq thread enters cpu_chill() then ->state is UNINTERRUPTIBLE
and has no ->pi_blocked_on set and so its mask is not taken into account.

->sleeping_lock is increased by cpu_chill() since it is also requried to
avoid a splat by RCU in case cpu_chill() is used while a RCU-read lock
is held. Use the same mechanism for the softirq-pending check.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 48ae7dae81b9c..25bcf2f2714ba 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -105,9 +105,12 @@ static bool softirq_check_runner_tsk(struct task_struct *tsk,
 	 * _before_ it sets pi_blocked_on to NULL under
 	 * tsk->pi_lock. So we need to check for both: state
 	 * and pi_blocked_on.
+	 * The test against UNINTERRUPTIBLE + ->sleeping_lock is in case the
+	 * task does cpu_chill().
 	 */
 	raw_spin_lock(&tsk->pi_lock);
-	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING) {
+	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING ||
+	    (tsk->state == TASK_UNINTERRUPTIBLE && tsk->sleeping_lock)) {
 		/* Clear all bits pending in that task */
 		*pending &= ~(tsk->softirqs_raised);
 		ret = true;
-- 
2.20.1

