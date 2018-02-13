Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933917AbeBMP3O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:29:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933434AbeBMP3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:29:11 -0500
Date: Tue, 13 Feb 2018 07:27:51 -0800
From: tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-11dc13224c975efcec96647a4768a6f1bb7a19a8@git.kernel.org>
Cc: will.deacon@arm.com, peterz@infradead.org, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com
In-Reply-To: <1518528177-19169-3-git-send-email-will.deacon@arm.com>
References: <1518528177-19169-3-git-send-email-will.deacon@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] locking/qspinlock: Ensure node->count is
 updated before initialising node
Git-Commit-ID: 11dc13224c975efcec96647a4768a6f1bb7a19a8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  11dc13224c975efcec96647a4768a6f1bb7a19a8
Gitweb:     https://git.kernel.org/tip/11dc13224c975efcec96647a4768a6f1bb7a19a8
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Tue, 13 Feb 2018 13:22:57 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 14:50:14 +0100

locking/qspinlock: Ensure node->count is updated before initialising node

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
---
 kernel/locking/qspinlock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 348c8ce..d880296 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -379,6 +379,14 @@ queue:
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
