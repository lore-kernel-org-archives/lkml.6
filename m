Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbeBEVkm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:40:42 -0500
Received: from terminus.zytor.com ([65.50.211.136]:45547 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752489AbeBEVk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:40:29 -0500
Date: Mon, 5 Feb 2018 13:28:41 -0800
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-ac1ab12a3e6e878274e7107c8c6f326694a1c1f3@git.kernel.org>
Cc: paulmck@linux.vnet.ibm.com, hpa@zytor.com, tglx@linutronix.de,
        linux@armlinux.org.uk, paulus@samba.org, parri.andrea@gmail.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, sehr@google.com, ahh@google.com,
        luto@kernel.org, avi@scylladb.com, mathieu.desnoyers@efficios.com,
        mingo@kernel.org, mpe@ellerman.id.au, will.deacon@arm.com,
        davejwatson@fb.com, benh@kernel.crashing.org, arnd@arndb.de,
        ghackmann@google.com, maged.michael@gmail.com, boqun.feng@gmail.com
Reply-To: hpa@zytor.com, paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        sehr@google.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, parri.andrea@gmail.com,
        paulus@samba.org, linux@armlinux.org.uk, ahh@google.com,
        avi@scylladb.com, luto@kernel.org, mathieu.desnoyers@efficios.com,
        arnd@arndb.de, benh@kernel.crashing.org, will.deacon@arm.com,
        davejwatson@fb.com, mpe@ellerman.id.au, mingo@kernel.org,
        boqun.feng@gmail.com, maged.michael@gmail.com, ghackmann@google.com
In-Reply-To: <20180129202020.8515-8-mathieu.desnoyers@efficios.com>
References: <20180129202020.8515-8-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] lockin/x86: Implement
 sync_core_before_usermode()
Git-Commit-ID: ac1ab12a3e6e878274e7107c8c6f326694a1c1f3
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

Commit-ID:  ac1ab12a3e6e878274e7107c8c6f326694a1c1f3
Gitweb:     https://git.kernel.org/tip/ac1ab12a3e6e878274e7107c8c6f326694a1c1f3
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 29 Jan 2018 15:20:16 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Feb 2018 21:34:57 +0100

lockin/x86: Implement sync_core_before_usermode()

Ensure that a core serializing instruction is issued before returning to
user-mode. x86 implements return to user-space through sysexit, sysrel,
and sysretq, which are not core serializing.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Andrew Hunter <ahh@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
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
Link: http://lkml.kernel.org/r/20180129202020.8515-8-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig                 |  1 +
 arch/x86/include/asm/sync_core.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 423e4b6..31030ad 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -61,6 +61,7 @@ config X86
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
+	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_ZONE_DEVICE		if X86_64
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
new file mode 100644
index 0000000..c67caaf
--- /dev/null
+++ b/arch/x86/include/asm/sync_core.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SYNC_CORE_H
+#define _ASM_X86_SYNC_CORE_H
+
+#include <linux/preempt.h>
+#include <asm/processor.h>
+#include <asm/cpufeature.h>
+
+/*
+ * Ensure that a core serializing instruction is issued before returning
+ * to user-mode. x86 implements return to user-space through sysexit,
+ * sysrel, and sysretq, which are not core serializing.
+ */
+static inline void sync_core_before_usermode(void)
+{
+	/* With PTI, we unconditionally serialize before running user code. */
+	if (static_cpu_has(X86_FEATURE_PTI))
+		return;
+	/*
+	 * Return from interrupt and NMI is done through iret, which is core
+	 * serializing.
+	 */
+	if (in_irq() || in_nmi())
+		return;
+	sync_core();
+}
+
+#endif /* _ASM_X86_SYNC_CORE_H */
