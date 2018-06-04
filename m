Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeFDQ3c (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:29:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40694 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeFDQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:27:43 -0400
Message-Id: <20180604162224.303870257@linutronix.de>
User-Agent: quilt/0.65
Date: Mon, 04 Jun 2018 17:33:53 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Dmitry Safonov <0x7f454c46@gmail.com>,
        Tariq Toukan <tariqt@mellanox.com>, Song Liu <liu.song.a23@gmail.com>,
        Joerg Roedel <jroedel@suse.de>, Mike Travis <mike.travis@hpe.com>,
        stable@vger.kernel.org
Subject: [patch 1/8] x86/apic/vector: Prevent hlist corruption and leaks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-apic-vector--Prevent-hlist-corruption-and-leaks.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several people observed the WARN_ON() in irq_matrix_free() which triggers
when the caller tries to free an vector which is not in the allocation
range. Song provided the trace information which allowed to decode the root
cause.

The rework of the vector allocation mechanism failed to preserve a sanity
check, which prevents setting a new target vector/CPU when the previous
affinity change has not fully completed.

As a result a half finished affinity change can be overwritten, which can
cause the leak of a irq descriptor pointer on the previous target CPU and
double enqueue of the hlist head into the cleanup lists of two or more
CPUs. After one CPU cleaned up its vector the next CPU will invoke the
cleanup handler with vector 0, which triggers the out of range warning in
the matrix allocator.

Prevent this by checking the apic_data of the interrupt whether the
move_in_progress flag is false and the hlist node is not hashed. Return
-EBUSY if not.

This prevents the damage and restores the behaviour before the vector
allocation rework, but due to other changes in that area it also widens the
chance that user space can observe -EBUSY. In theory this should be fine,
but actually not all user space tools handle -EBUSY correctly. Addressing
that is not part of this fix, but will be addressed in follow up patches.

Fixes: 69cde0004a4b ("x86/vector: Use matrix allocator for vector assignment")
Reported-by: Dmitry Safonov <0x7f454c46@gmail.com>
Reported-by: Tariq Toukan <tariqt@mellanox.com>
Reported-by: Song Liu <liu.song.a23@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/apic/vector.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -235,6 +235,15 @@ static int allocate_vector(struct irq_da
 	if (vector && cpu_online(cpu) && cpumask_test_cpu(cpu, dest))
 		return 0;
 
+	/*
+	 * Careful here. @apicd might either have move_in_progress set or
+	 * be enqueued for cleanup. Assigning a new vector would either
+	 * leave a stale vector on some CPU around or in case of a pending
+	 * cleanup corrupt the hlist.
+	 */
+	if (apicd->move_in_progress || !hlist_unhashed(&apicd->clist))
+		return -EBUSY;
+
 	vector = irq_matrix_alloc(vector_matrix, dest, resvd, &cpu);
 	if (vector > 0)
 		apic_update_vector(irqd, vector, cpu);
