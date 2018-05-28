Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161175AbeE1Kap (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:30:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161117AbeE1Kai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:30:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 099/329] locking/qspinlock: Ensure node->count is updated before initialising node
Date: Mon, 28 May 2018 12:00:28 +0200
Message-Id: <20180528100251.057133987@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 11dc13224c975efcec96647a4768a6f1bb7a19a8 ]

When queuing on the qspinlock, the count field for the current CPU's head
node is incremented. This needn't be atomic because locking in e.g. IRQ
context is balanced and so an IRQ will return with node->count as it
found it.

However, the compiler could in theory reorder the initialisation of
node[idx] before the increment of the head node->count, causing an
IRQ to overwrite the initialised node and potentially corrupt the lock
state.

Avoid the potential for this harmful compiler reordering by placing a
barrier() between the increment of the head node->count and the subsequent
node initialisation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1518528177-19169-3-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/qspinlock.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -495,6 +495,14 @@ queue:
 	tail = encode_tail(smp_processor_id(), idx);
 
 	node += idx;
+
+	/*
+	 * Ensure that we increment the head node->count before initialising
+	 * the actual node. If the compiler is kind enough to reorder these
+	 * stores, then an IRQ could overwrite our assignments.
+	 */
+	barrier();
+
 	node->locked = 0;
 	node->next = NULL;
 	pv_init_node(node);
