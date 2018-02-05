Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeBEVk1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:40:27 -0500
Received: from terminus.zytor.com ([65.50.211.136]:51579 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbeBEVkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:40:03 -0500
Date: Mon, 5 Feb 2018 13:28:12 -0800
From: tip-bot for Mathieu Desnoyers <tipbot@zytor.com>
Message-ID: <tip-e61938a921a46347d7725badc40ec436ebfff977@git.kernel.org>
Cc: mpe@ellerman.id.au, tglx@linutronix.de, ghackmann@google.com,
        boqun.feng@gmail.com, mingo@kernel.org, peterz@infradead.org,
        parri.andrea@gmail.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        luto@kernel.org, will.deacon@arm.com, mathieu.desnoyers@efficios.com,
        linux@armlinux.org.uk, avi@scylladb.com, torvalds@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, arnd@arndb.de, davejwatson@fb.com,
        paulus@samba.org, sehr@google.com, ahh@google.com,
        maged.michael@gmail.com, benh@kernel.crashing.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, parri.andrea@gmail.com,
        peterz@infradead.org, mingo@kernel.org, boqun.feng@gmail.com,
        ghackmann@google.com, mpe@ellerman.id.au, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        avi@scylladb.com, linux@armlinux.org.uk,
        mathieu.desnoyers@efficios.com, will.deacon@arm.com, luto@kernel.org,
        maged.michael@gmail.com, sehr@google.com, ahh@google.com,
        davejwatson@fb.com, paulus@samba.org, arnd@arndb.de,
        benh@kernel.crashing.org
In-Reply-To: <20180129202020.8515-7-mathieu.desnoyers@efficios.com>
References: <20180129202020.8515-7-mathieu.desnoyers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] locking: Introduce sync_core_before_usermode()
Git-Commit-ID: e61938a921a46347d7725badc40ec436ebfff977
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

Commit-ID:  e61938a921a46347d7725badc40ec436ebfff977
Gitweb:     https://git.kernel.org/tip/e61938a921a46347d7725badc40ec436ebfff977
Author:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate: Mon, 29 Jan 2018 15:20:15 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Feb 2018 21:34:50 +0100

locking: Introduce sync_core_before_usermode()

Introduce an architecture function that ensures the current CPU
issues a core serializing instruction before returning to usermode.

This is needed for the membarrier "sync_core" command.

Architectures defining the sync_core_before_usermode() static inline
need to select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE.

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
Link: http://lkml.kernel.org/r/20180129202020.8515-7-mathieu.desnoyers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sync_core.h | 21 +++++++++++++++++++++
 init/Kconfig              |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/sync_core.h b/include/linux/sync_core.h
new file mode 100644
index 0000000..013da4b
--- /dev/null
+++ b/include/linux/sync_core.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SYNC_CORE_H
+#define _LINUX_SYNC_CORE_H
+
+#ifdef CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
+#include <asm/sync_core.h>
+#else
+/*
+ * This is a dummy sync_core_before_usermode() implementation that can be used
+ * on all architectures which return to user-space through core serializing
+ * instructions.
+ * If your architecture returns to user-space through non-core-serializing
+ * instructions, you need to write your own functions.
+ */
+static inline void sync_core_before_usermode(void)
+{
+}
+#endif
+
+#endif /* _LINUX_SYNC_CORE_H */
+
diff --git a/init/Kconfig b/init/Kconfig
index 837adcf..535421f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1918,3 +1918,6 @@ config ASN1
 	  functions to call on what tags.
 
 source "kernel/Kconfig.locks"
+
+config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
+	bool
