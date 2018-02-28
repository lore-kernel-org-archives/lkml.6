Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935167AbeB1Vnz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:43:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:4582 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935147AbeB1Vnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:43:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="21849941"
From: Andi Kleen <andi@firstfloor.org>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] random: Optimize add_interrupt_randomness
Date: Wed, 28 Feb 2018 13:43:28 -0800
Message-Id: <20180228214328.23108-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

add_interrupt_randomess always wakes up
code blocking on /dev/random. This wake up is done
unconditionally. Unfortunately this means all interrupts
take the wait queue spinlock, which can be rather expensive
on large systems processing lots of interrupts.

We saw 1% cpu time spinning on this on a large macro workload
running on a large system.

I believe it's a recent regression (?)

Always check if there is a waiter on the wait queue
before waking up. This check can be done without
taking a spinlock.

1.06%         10460  [kernel.vmlinux] [k] native_queued_spin_lock_slowpath
         |
         ---native_queued_spin_lock_slowpath
            |
             --0.57%--_raw_spin_lock_irqsave
                       |
                        --0.56%--__wake_up_common_lock
                                  credit_entropy_bits
                                  add_interrupt_randomness
                                  handle_irq_event_percpu
                                  handle_irq_event
                                  handle_edge_irq
                                  handle_irq
                                  do_IRQ
                                  common_interrupt

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/char/random.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index e5b3d3ba4660..64a897a2888f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -709,7 +709,8 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 		}
 
 		/* should we wake readers? */
-		if (entropy_bits >= random_read_wakeup_bits) {
+		if (entropy_bits >= random_read_wakeup_bits &&
+		    wq_has_sleeper(&random_read_wait)) {
 			wake_up_interruptible(&random_read_wait);
 			kill_fasync(&fasync, SIGIO, POLL_IN);
 		}
-- 
2.14.3
