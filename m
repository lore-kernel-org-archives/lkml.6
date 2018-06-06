Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 813D6601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeFFNbp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:31:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35913 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeFFNbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:31:43 -0400
Date: Wed, 6 Jun 2018 06:30:56 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-80ae7b1a918e78b0bae88b0c0ad413d3fdced968@git.kernel.org>
Cc: liu.song.a23@gmail.com, peterz@infradead.org, jroedel@suse.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, songliubraving@fb.com,
        tglx@linutronix.de, 0x7f454c46@gmail.com, bp@alien8.de,
        tariqt@mellanox.com, mingo@kernel.org, mike.travis@hpe.com
Reply-To: liu.song.a23@gmail.com, peterz@infradead.org, hpa@zytor.com,
          jroedel@suse.de, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, songliubraving@fb.com, tariqt@mellanox.com,
          0x7f454c46@gmail.com, bp@alien8.de, mike.travis@hpe.com,
          mingo@kernel.org
In-Reply-To: <20180604162224.303870257@linutronix.de>
References: <20180604162224.303870257@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/apic/vector: Prevent hlist corruption and
 leaks
Git-Commit-ID: 80ae7b1a918e78b0bae88b0c0ad413d3fdced968
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

Commit-ID:  80ae7b1a918e78b0bae88b0c0ad413d3fdced968
Gitweb:     https://git.kernel.org/tip/80ae7b1a918e78b0bae88b0c0ad413d3fdced968
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 4 Jun 2018 17:33:53 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Jun 2018 15:18:19 +0200

x86/apic/vector: Prevent hlist corruption and leaks

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
Tested-by: Song Liu <songliubraving@fb.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Cc: Mike Travis <mike.travis@hpe.com>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20180604162224.303870257@linutronix.de

---
 arch/x86/kernel/apic/vector.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bb6f7a2148d7..72b575a0b662 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -235,6 +235,15 @@ static int allocate_vector(struct irq_data *irqd, const struct cpumask *dest)
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
