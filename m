Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeBEVoD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:44:03 -0500
Received: from terminus.zytor.com ([65.50.211.136]:46529 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeBEVn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:43:56 -0500
Date: Mon, 5 Feb 2018 13:30:00 -0800
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-f1e3a12b6543a73cfd47aa7da16d3d73d297795e@git.kernel.org>
Cc: sehr@google.com, avi@scylladb.com, linux@armlinux.org.uk,
        peterz@infradead.org, parri.andrea@gmail.com, hpa@zytor.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, boqun.feng@gmail.com,
        davejwatson@fb.com, torvalds@linux-foundation.org, mingo@kernel.org,
        mathieu.desnoyers@efficios.com, will.deacon@arm.com,
        ghackmann@google.com, paulmck@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, maged.michael@gmail.com, ahh@google.com,
        tglx@linutronix.de, paulus@samba.org, luto@kernel.org
Reply-To: mathieu.desnoyers@efficios.com, torvalds@linux-foundation.org,
        mingo@kernel.org, ahh@google.com, linux-kernel@vger.kernel.org,
        maged.michael@gmail.com, paulmck@linux.vnet.ibm.com,
        ghackmann@google.com, will.deacon@arm.com, tglx@linutronix.de,
        paulus@samba.org, luto@kernel.org, parri.andrea@gmail.com,
        peterz@infradead.org, linux@armlinux.org.uk, avi@scylladb.com,
        sehr@google.com, mpe@ellerman.id.au, hpa@zytor.com,
        benh@kernel.crashing.org, davejwatson@fb.com, boqun.feng@gmail.com
In-Reply-To: <20180129202020.8515-11-mathieu.desnoyers@efficios.com>
References: <20180129202020.8515-11-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] membarrier/arm64: Provide core serializing
 command
Git-Commit-ID: f1e3a12b6543a73cfd47aa7da16d3d73d297795e
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

Commit-ID:  f1e3a12b6543a73cfd47aa7da16d3d73d297795e
Gitweb:     https://git.kernel.org/tip/f1e3a12b6543a73cfd47aa7da16d3d73d297795e
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 29 Jan 2018 15:20:19 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Feb 2018 21:35:17 +0100

membarrier/arm64: Provide core serializing command

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Andrew Hunter <ahh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Dave Watson <davejwatson@fb.com>
Cc: David Sehr <sehr@google.com>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maged Michael <maged.michael@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/20180129202020.8515-11-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm64/Kconfig        | 1 +
 arch/arm64/kernel/entry.S | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c9a7e9e..5b0c06d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -16,6 +16,7 @@ config ARM64
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6d14b8f..5edde1c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -302,6 +302,10 @@ alternative_else_nop_endif
 	ldp	x28, x29, [sp, #16 * 14]
 	ldr	lr, [sp, #S_LR]
 	add	sp, sp, #S_FRAME_SIZE		// restore sp
+	/*
+	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on eret context synchronization
+	 * when returning from IPI handler, and when returning to user-space.
+	 */
 	eret					// return to kernel
 	.endm
 
