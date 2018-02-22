Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752821AbeBVHIn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:08:43 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34914 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeBVHGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:22 -0500
X-Google-Smtp-Source: AH8x225rVJ03ZwtJLKgEeBcihXxz5n684sUP+dr0xYlsxLMeKrPFMjAIbU3ZeQQMuQIoYxtpOAobqw==
X-ME-Sender: <xms:62uOWtJTrUqWAL3k-TkHTpB4W60kpWXIoT8NjC5BxBWpyXNosqVh1Q>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v5 08/17] lockdep: Fix recursive read lock related safe->unsafe detection
Date: Thu, 22 Feb 2018 15:08:55 +0800
Message-Id: <20180222070904.548-9-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are four cases for recursive read lock realted deadlocks:

(--(X..Y)--> means a strong dependency path starts with a --(X*)-->
dependency and ends with a --(*Y)-- dependency.)

1.	An irq-safe lock L1 has a dependency --(*..*)--> to an
	irq-unsafe lock L2.

2.	An irq-read-safe lock L1 has a dependency --(N..*)--> to an
	irq-unsafe lock L2.

3.	An irq-safe lock L1 has a dependency --(*..N)--> to an
	irq-read-unsafe lock L2.

4.	An irq-read-safe lock L1 has a dependency --(N..N)--> to an
	irq-read-unsafe lock L2.

The current check_usage() only checks 1) and 2), so this patch adds
checks for 3) and 4) and makes sure when find_usage_{back,for}wards find
an irq-read-{,un}safe lock, the traverse path should ends at a
dependency --(*N)-->. Note when we search backwards, --(*N)--> indicates
a real dependency --(N*)-->.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0b0ad3db78b4..bd3eef664f9d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1504,7 +1504,14 @@ check_redundant(struct lock_list *root, struct held_lock *target,
 
 static inline int usage_match(struct lock_list *entry, void *bit)
 {
-	return entry->class->usage_mask & (1 << (enum lock_usage_bit)bit);
+	enum lock_usage_bit ub = (enum lock_usage_bit)bit;
+
+
+	if (ub & 1)
+		return entry->class->usage_mask & (1 << ub) &&
+		       !entry->is_rr;
+	else
+		return entry->class->usage_mask & (1 << ub);
 }
 
 
@@ -1815,6 +1822,10 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 			   exclusive_bit(bit), state_name(bit)))
 		return 0;
 
+	if (!check_usage(curr, prev, next, bit,
+			   exclusive_bit(bit) + 1, state_name(bit)))
+		return 0;
+
 	bit++; /* _READ */
 
 	/*
@@ -1827,6 +1838,10 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 			   exclusive_bit(bit), state_name(bit)))
 		return 0;
 
+	if (!check_usage(curr, prev, next, bit,
+			   exclusive_bit(bit) + 1, state_name(bit)))
+		return 0;
+
 	return 1;
 }
 
-- 
2.16.1
