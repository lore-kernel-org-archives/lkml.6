Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16241ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC508208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC508208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeGMSGa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:06:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48357 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731225AbeGMSGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:06:30 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fe2DR-0004jL-JP; Fri, 13 Jul 2018 19:50:49 +0200
Date:   Fri, 13 Jul 2018 19:50:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mike Galbraith <efault@gmx.de>
Subject: [PATCH RT] locallock: add local_lock_bh()
Message-ID: <20180713175049.nx2xg4no4zbfcnfl@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the ARM64 simd locking it would be easier to have local_lock_bh()
which grabs a local_lock with BH disabled and turns into a
local_bh_disable() on !RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
obviously required by the previous one…

 include/linux/locallock.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 921eab83cd34..15aa0dea2bfb 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -47,9 +47,23 @@ static inline void __local_lock(struct local_irq_lock *lv)
 	lv->nestcnt++;
 }
 
+static inline void __local_lock_bh(struct local_irq_lock *lv)
+{
+	if (lv->owner != current) {
+		spin_lock_bh(&lv->lock);
+		LL_WARN(lv->owner);
+		LL_WARN(lv->nestcnt);
+		lv->owner = current;
+	}
+	lv->nestcnt++;
+}
+
 #define local_lock(lvar)					\
 	do { __local_lock(&get_local_var(lvar)); } while (0)
 
+#define local_lock_bh(lvar)					\
+	do { __local_lock_bh(&get_local_var(lvar)); } while (0)
+
 #define local_lock_on(lvar, cpu)				\
 	do { __local_lock(&per_cpu(lvar, cpu)); } while (0)
 
@@ -88,12 +102,29 @@ static inline void __local_unlock(struct local_irq_lock *lv)
 	spin_unlock(&lv->lock);
 }
 
+static inline void __local_unlock_bh(struct local_irq_lock *lv)
+{
+	LL_WARN(lv->nestcnt == 0);
+	LL_WARN(lv->owner != current);
+	if (--lv->nestcnt)
+		return;
+
+	lv->owner = NULL;
+	spin_unlock_bh(&lv->lock);
+}
+
 #define local_unlock(lvar)					\
 	do {							\
 		__local_unlock(this_cpu_ptr(&lvar));		\
 		put_local_var(lvar);				\
 	} while (0)
 
+#define local_unlock_bh(lvar)					\
+	do {							\
+		__local_unlock_bh(this_cpu_ptr(&lvar));		\
+		put_local_var(lvar);				\
+	} while (0)
+
 #define local_unlock_on(lvar, cpu)                       \
 	do { __local_unlock(&per_cpu(lvar, cpu)); } while (0)
 
@@ -253,6 +284,8 @@ static inline void local_irq_lock_init(int lvar) { }
 
 #define local_lock(lvar)			preempt_disable()
 #define local_unlock(lvar)			preempt_enable()
+#define local_lock_bh(lvar)			local_bh_disable()
+#define local_unlock_bh(lvar)			local_bh_enable()
 #define local_lock_irq(lvar)			local_irq_disable()
 #define local_lock_irq_on(lvar, cpu)		local_irq_disable()
 #define local_unlock_irq(lvar)			local_irq_enable()
-- 
2.18.0

