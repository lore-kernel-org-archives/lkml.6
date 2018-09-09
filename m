Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8EAC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E7A20865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E7A20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeIISCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 14:02:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37954 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeIISCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 14:02:24 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyzW6-0007ts-OD; Sun, 09 Sep 2018 15:12:42 +0200
Date:   Sun, 9 Sep 2018 15:12:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] smp/hotplug fixes for 4.19
Message-ID: <alpine.DEB.2.21.1809091512110.1402@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

Two fixes for the hotplug state machine code:

 - Move the misplaces smb() in the hotplug thread function to the proper
   place, otherwise a half update control struct could be observed

 - Prevent state corruption on error rollback, which causes the state to
   advance by one and as a consequence skip it in the bringup sequence.

Thanks,

	tglx

------------------>
Neeraj Upadhyay (1):
      cpu/hotplug: Adjust misplaced smb() in cpuhp_thread_fun()

Thomas Gleixner (1):
      cpu/hotplug: Prevent state corruption on error rollback


 kernel/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index aa7fe85ad62e..0097acec1c71 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -607,15 +607,15 @@ static void cpuhp_thread_fun(unsigned int cpu)
 	bool bringup = st->bringup;
 	enum cpuhp_state state;
 
+	if (WARN_ON_ONCE(!st->should_run))
+		return;
+
 	/*
 	 * ACQUIRE for the cpuhp_should_run() load of ->should_run. Ensures
 	 * that if we see ->should_run we also see the rest of the state.
 	 */
 	smp_mb();
 
-	if (WARN_ON_ONCE(!st->should_run))
-		return;
-
 	cpuhp_lock_acquire(bringup);
 
 	if (st->single) {
@@ -916,7 +916,8 @@ static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 		ret = cpuhp_invoke_callback(cpu, st->state, false, NULL, NULL);
 		if (ret) {
 			st->target = prev_state;
-			undo_cpu_down(cpu, st);
+			if (st->state < prev_state)
+				undo_cpu_down(cpu, st);
 			break;
 		}
 	}
@@ -969,7 +970,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 * to do the further cleanups.
 	 */
 	ret = cpuhp_down_callbacks(cpu, st, target);
-	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
+	if (ret && st->state == CPUHP_TEARDOWN_CPU && st->state < prev_state) {
 		cpuhp_reset_state(st, prev_state);
 		__cpuhp_kick_ap(st);
 	}
