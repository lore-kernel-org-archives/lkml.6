Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbeELAdJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 20:33:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41777 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeELAdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 20:33:08 -0400
X-Google-Smtp-Source: AB8JxZqDP7rLgnD2WpNoFq7OAXHfXKPfYnEOOvNYbzutZ87ps1/1bqRZke1uuwT0iC59GO7AonyWnw==
Date: Fri, 11 May 2018 17:33:06 -0700
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com
Subject: [PATCH] rcu: Add comment documenting how rcu_seq_snap works
Message-ID: <20180512003306.GA170941@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_seq_snap may be tricky for someone looking at it for the first time.
Lets document how it works with an example to make it easier.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 003671825d62..004ace3d22c2 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -91,7 +91,28 @@ static inline void rcu_seq_end(unsigned long *sp)
 	WRITE_ONCE(*sp, rcu_seq_endval(sp));
 }
 
-/* Take a snapshot of the update side's sequence number. */
+/*
+ * Take a snapshot of the update side's sequence number.
+ *
+ * This function predicts what the grace period number will be the next
+ * time an RCU callback will be executed, given the current grace period's
+ * number. This can be gp+1 if RCU is idle, or gp+2 if a grace period is
+ * already in progress.
+ *
+ * We do this with a single addition and masking.
+ * For example, if RCU_SEQ_STATE_MASK=1 and the least significant bit (LSB) of
+ * the seq is used to track if a GP is in progress or not, its sufficient if we
+ * add (2+1) and mask with ~1. Lets see why with an example:
+ *
+ * Say the current seq is 6 which is 0x110 (gp is 3 and state bit is 0).
+ * To get the next GP number, we have to atleast add 0x10 to this (0x1 << 1) to
+ * account for the state bit. However, if the current seq is 7 (GP num is 3
+ * and state bit is 1), then it means the current grace period is already
+ * in progress so the next the callback will run is at gp+2. To account for
+ * the extra +1, we just overflow the LSB by adding another 0x1 and masking
+ * with ~0x1. Incase no GP was in progress (RCU is idle), then the adding
+ * by 0x1 and masking will have no effect. This is calculated as below.
+ */
 static inline unsigned long rcu_seq_snap(unsigned long *sp)
 {
 	unsigned long s;
-- 
2.17.0.441.gb46fe60e1d-goog
