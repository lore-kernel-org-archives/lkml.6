Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F87C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6041121902
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991705;
	bh=37wLl+qGaLkhNOf/0Cu/ooO2J2zQiKMMy9K3IpwJmAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ibZLm6fDUCuPItHHiWbn7Q8V76ml/zVoYHRNF94KaP1zM1AlaRWeXSDaPpAzpglv2
	 M6UOyMr6m3QvOI350XrvDMSBpnh4mVorZ3SkpuA8gD4egEU/BZtY/J/pkBveNoIV9w
	 hCT2y6VPlZvoBxRBibSKjBuX2rXfJa4OkVgN+6pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfBLRPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731425AbfBLRPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:00 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 871A9218D8;
        Tue, 12 Feb 2019 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991699;
        bh=37wLl+qGaLkhNOf/0Cu/ooO2J2zQiKMMy9K3IpwJmAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2KTxtUS2O2Rx3bRAUqDB/XTrqvPWznaqAelwsI7sfsuiTp1aU+jfykK6jo8PwqEv
         JrjYZPH5K2tCGzHJA9VOGzrs/b2VQOKDOnYs39k0XRJ9AMEWrUUg8XujCDqT6KDBj5
         Wvbk0AIYxqOLRfKJALQsp+qkVnxjygioaFx3SxvI=
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
Subject: [PATCH 09/32] locking/lockdep: Save stack trace for each softirq vector involved
Date:   Tue, 12 Feb 2019 18:14:00 +0100
Message-Id: <20190212171423.8308-10-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to save as much traces as we have softirq vectors involved
in a given usage. Expand the stack trace record code accordingly.

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
 include/linux/lockdep.h  |  3 ++-
 kernel/locking/lockdep.c | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 06669f20a30a..69d2dac3d821 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -31,8 +31,9 @@ extern int lock_stat;
 /*
  * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
  * the total number of states... :-(
+ * 1 bit for LOCK_USED, 4 bits for hardirqs and 4 * NR_SOFTIRQS bits
  */
-#define XXX_LOCK_USAGE_STATES		(1+2*4)
+#define XXX_LOCK_USAGE_STATES		(1 + (1 + 10) * 4)
 
 /*
  * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9194f11d3dfb..4bac8c1a3929 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3145,6 +3145,22 @@ static inline int separate_irq_context(struct task_struct *curr,
 
 #endif /* defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING) */
 
+static int save_trace_mask(struct lock_class *class, u64 mask)
+{
+	int bit = 0;
+
+	while (mask) {
+		long fs = __ffs64(mask) + 1;
+
+		mask >>= fs;
+		bit += fs;
+		if (!save_trace(class->usage_traces + bit - 1))
+			return -1;
+	}
+
+	return 0;
+}
+
 /*
  * Mark a lock with a usage bit, and validate the state transition:
  */
@@ -3172,7 +3188,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 
 	hlock_class(this)->usage_mask |= new_mask;
 
-	if (!save_trace(hlock_class(this)->usage_traces + new_usage->bit))
+	if (save_trace_mask(hlock_class(this), new_mask) < 0)
 		return 0;
 
 	switch (new_usage->bit) {
-- 
2.17.1

