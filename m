Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A904C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3546921A3A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3546921A3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbeGEPun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:50:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50994 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753859AbeGEPul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:50:41 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fb6Wg-0006Pd-Ub; Thu, 05 Jul 2018 17:50:35 +0200
Date:   Thu, 5 Jul 2018 17:50:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Julia Cartwright <julia@ni.com>, tglx@linutronix.de,
        rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RT] sched/migrate_disable: fallback to preempt_disable()
 instead barrier()
Message-ID: <20180705155034.s6q2lsqc3o7srzwp@linutronix.de>
References: <20180704173519.GA24614@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180704173519.GA24614@zipoli.concurrent-rt.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

migrate_disable() does nothing !SMP && !RT. This is bad for two reasons:
- The futex code relies on the fact migrate_disable() is part of spin_lock().
  There is a workaround for the !in_atomic() case in migrate_disable() which
  work-arounds the different ordering (non-atomic lock and atomic unlock).

- we have a few instances where preempt_disable() is replaced with
  migrate_disable().

For both cases it is bad if migrate_disable() ends up as barrier() instead of
preempt_disable(). Let migrate_disable() fallback to preempt_disable().

Cc: stable-rt@vger.kernel.org
Reported-by: joe.korty@concurrent-rt.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/preempt.h | 4 ++--
 kernel/sched/core.c     | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 043e431a7e8e..d46688d521e6 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -241,8 +241,8 @@ static inline int __migrate_disabled(struct task_struct *p)
 }
 
 #else
-#define migrate_disable()		barrier()
-#define migrate_enable()		barrier()
+#define migrate_disable()		preempt_disable()
+#define migrate_enable()		preempt_enable()
 static inline int __migrate_disabled(struct task_struct *p)
 {
 	return 0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ac3fb8495bd5..626a62218518 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7326,6 +7326,7 @@ void migrate_disable(void)
 #endif
 
 	p->migrate_disable++;
+	preempt_disable();
 }
 EXPORT_SYMBOL(migrate_disable);
 
@@ -7349,6 +7350,7 @@ void migrate_enable(void)
 
 	WARN_ON_ONCE(p->migrate_disable <= 0);
 	p->migrate_disable--;
+	preempt_enable();
 }
 EXPORT_SYMBOL(migrate_enable);
 #endif
-- 
2.18.0

