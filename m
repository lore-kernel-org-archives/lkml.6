Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeEQKWS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:22:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45539 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQKWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:22:17 -0400
Date: Thu, 17 May 2018 12:22:14 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] sched: let softirq_count() return !0 if inside
 local_bh_disable()ed section
Message-ID: <20180517102214.orea3ol6dj7wvpf5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see a reason why softirq_count() shouldn't reflect the fact that
we are within a local_bh_disable() section. I *think* it was done
primary because in RT the softirq is slightly different (and
preemptible) and it broke some of RCU's assumptions.
I don't see any fallout with this change. Furthermore, all checks like
"WARN_ON(!softirq_count())" will work and we can drop the workaround we
currently have in the queue.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/preempt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 0591df500e9d..d8c05a2626ca 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -91,7 +91,7 @@
 # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
 # define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
 #else
-# define softirq_count()	(0UL)
+# define softirq_count()	(current->softirq_nestcnt)
 extern int in_serving_softirq(void);
 #endif
 
-- 
2.17.0
