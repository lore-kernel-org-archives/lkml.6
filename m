Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A7BC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2ED222B6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991754;
	bh=OfgJle/KOm+UHYoqgJd5GPYBm1s6Hq1I5Lz9K1KNvz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jeId2aDHNiNck/Mje4ZaPWXDwXkaPtMLiA+23AJvp3z/UtFQge/sd5bFcbzWTHBsS
	 oCyO+3B9DQkALTzWJWUYTvpO3ontq7VR4PtYBVyzr8++C1NhNGICJDnL7KeShpTypT
	 NO3/kFe2G5zukW0DeWHLM0TpuSducmfFL7h1pZ2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbfBLRPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbfBLRPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:52 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73567222B3;
        Tue, 12 Feb 2019 17:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991751;
        bh=OfgJle/KOm+UHYoqgJd5GPYBm1s6Hq1I5Lz9K1KNvz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSHzmnck1Tk8kIpX6vfP1ZdcRkNZNrL2fxrUX0BSkg2tAO5F4kIYc1t+mYKhoBERb
         Bx/GDxLI8cHPLoWy8OG2Nw7acqYcGq1mxEurvAw5Ol1xvZqH/Purd0NqUv9QdsU7Fd
         SyxJPb6dKVfn+lLAPZ5BioYTdrbAg5CP++i6v1q4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 25/32] softirq: Prepare for mixing all/per-vector masking
Date:   Tue, 12 Feb 2019 18:14:16 +0100
Message-Id: <20190212171423.8308-26-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to mix and nest full and per vector softirq masking,
we need to be able to track the nesting state using a "full masking"
counter and a mask of "individual disabled vectors".

Start with introducing the full masking counter. For now it's a simple
mirror of softirq_count() because there is no per vector masking API
yet.

When this full masking counter is non 0, all softirq vectors are
explicitly disabled.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/softirq.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 91dee716e139..4477a03afd94 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -57,6 +57,12 @@ static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp
 
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
 
+struct softirq_nesting {
+	unsigned int disabled_all;
+};
+
+static DEFINE_PER_CPU(struct softirq_nesting, softirq_nesting);
+
 const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
 	"TASKLET", "SCHED", "HRTIMER", "RCU"
@@ -118,11 +124,11 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	 * call the trace_preempt_off later.
 	 */
 	__preempt_count_add(cnt);
-	/*
-	 * Were softirqs turned off above:
-	 */
-	if (softirq_count() == (cnt & SOFTIRQ_MASK))
+
+	if (__this_cpu_inc_return(softirq_nesting.disabled_all) == 1) {
+		softirq_enabled_clear_mask(SOFTIRQ_ALL_MASK);
 		trace_softirqs_off(ip);
+	}
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	raw_local_irq_restore(flags);
@@ -137,6 +143,15 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
 
+static void local_bh_enable_common(unsigned long ip, unsigned int cnt)
+{
+	if (__this_cpu_dec_return(softirq_nesting.disabled_all))
+		return;
+
+	softirq_enabled_set(SOFTIRQ_ALL_MASK);
+	trace_softirqs_on(ip);
+}
+
 static void __local_bh_enable_no_softirq(unsigned int cnt)
 {
 	lockdep_assert_irqs_disabled();
@@ -144,8 +159,7 @@ static void __local_bh_enable_no_softirq(unsigned int cnt)
 	if (preempt_count() == cnt)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 
-	if (softirq_count() == (cnt & SOFTIRQ_MASK))
-		trace_softirqs_on(_RET_IP_);
+	local_bh_enable_common(_RET_IP_, cnt);
 
 	__preempt_count_sub(cnt);
 }
@@ -168,11 +182,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 #ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_disable();
 #endif
-	/*
-	 * Are softirqs going to be turned on now:
-	 */
-	if (softirq_count() == SOFTIRQ_DISABLE_OFFSET)
-		trace_softirqs_on(ip);
+	local_bh_enable_common(ip, cnt);
+
 	/*
 	 * Keep preemption disabled until we are done with
 	 * softirq processing:
-- 
2.17.1

