Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FDCC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0113214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfBLOan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:30:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43824 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbfBLOal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:41 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4d-0005Af-HH; Tue, 12 Feb 2019 15:30:11 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC PATCH v1 02/25] printk-rb: add prb locking functions
Date:   Tue, 12 Feb 2019 15:29:40 +0100
Message-Id: <20190212143003.48446-3-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add processor-reentrant spin locking functions. These allow
restricting the number of possible contexts to 2, which can simplify
implementing code that also supports NMI interruptions.

    prb_lock();

    /*
     * This code is synchronized with all contexts
     * except an NMI on the same processor.
     */

    prb_unlock();

In order to support printk's emergency messages, a
processor-reentrant spin lock will be used to control raw access to
the emergency console. However, it must be the same
processor-reentrant spin lock as the one used by the ring buffer,
otherwise a deadlock can occur:

    CPU1: printk lock -> emergency -> serial lock
    CPU2: serial lock -> printk lock

By making the processor-reentrant implemtation available externally,
printk can use the same atomic_t for the ring buffer as for the
emergency console and thus avoid the above deadlock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk_ringbuffer.h | 24 ++++++++++++
 lib/Makefile                      |  2 +-
 lib/printk_ringbuffer.c           | 77 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/printk_ringbuffer.h
 create mode 100644 lib/printk_ringbuffer.c

diff --git a/include/linux/printk_ringbuffer.h b/include/linux/printk_ringbuffer.h
new file mode 100644
index 000000000000..75f5708ea902
--- /dev/null
+++ b/include/linux/printk_ringbuffer.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PRINTK_RINGBUFFER_H
+#define _LINUX_PRINTK_RINGBUFFER_H
+
+#include <linux/atomic.h>
+#include <linux/percpu.h>
+
+struct prb_cpulock {
+	atomic_t owner;
+	unsigned long __percpu *irqflags;
+};
+
+#define DECLARE_STATIC_PRINTKRB_CPULOCK(name)				\
+static DEFINE_PER_CPU(unsigned long, _##name##_percpu_irqflags);	\
+static struct prb_cpulock name = {					\
+	.owner = ATOMIC_INIT(-1),					\
+	.irqflags = &_##name##_percpu_irqflags,				\
+}
+
+/* utility functions */
+void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store);
+void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store);
+
+#endif /*_LINUX_PRINTK_RINGBUFFER_H */
diff --git a/lib/Makefile b/lib/Makefile
index e1b59da71418..77a20bfd232e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -19,7 +19,7 @@ KCOV_INSTRUMENT_dynamic_debug.o := n
 
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
-	 idr.o int_sqrt.o extable.o \
+	 idr.o int_sqrt.o extable.o printk_ringbuffer.o \
 	 sha1.o chacha.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
diff --git a/lib/printk_ringbuffer.c b/lib/printk_ringbuffer.c
new file mode 100644
index 000000000000..28958b0cf774
--- /dev/null
+++ b/lib/printk_ringbuffer.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/smp.h>
+#include <linux/printk_ringbuffer.h>
+
+static bool __prb_trylock(struct prb_cpulock *cpu_lock,
+			  unsigned int *cpu_store)
+{
+	unsigned long *flags;
+	unsigned int cpu;
+
+	cpu = get_cpu();
+
+	*cpu_store = atomic_read(&cpu_lock->owner);
+	/* memory barrier to ensure the current lock owner is visible */
+	smp_rmb();
+	if (*cpu_store == -1) {
+		flags = per_cpu_ptr(cpu_lock->irqflags, cpu);
+		local_irq_save(*flags);
+		if (atomic_try_cmpxchg_acquire(&cpu_lock->owner,
+					       cpu_store, cpu)) {
+			return true;
+		}
+		local_irq_restore(*flags);
+	} else if (*cpu_store == cpu) {
+		return true;
+	}
+
+	put_cpu();
+	return false;
+}
+
+/*
+ * prb_lock: Perform a processor-reentrant spin lock.
+ * @cpu_lock: A pointer to the lock object.
+ * @cpu_store: A "flags" pointer to store lock status information.
+ *
+ * If no processor has the lock, the calling processor takes the lock and
+ * becomes the owner. If the calling processor is already the owner of the
+ * lock, this function succeeds immediately. If lock is locked by another
+ * processor, this function spins until the calling processor becomes the
+ * owner.
+ *
+ * It is safe to call this function from any context and state.
+ */
+void prb_lock(struct prb_cpulock *cpu_lock, unsigned int *cpu_store)
+{
+	for (;;) {
+		if (__prb_trylock(cpu_lock, cpu_store))
+			break;
+		cpu_relax();
+	}
+}
+
+/*
+ * prb_unlock: Perform a processor-reentrant spin unlock.
+ * @cpu_lock: A pointer to the lock object.
+ * @cpu_store: A "flags" object storing lock status information.
+ *
+ * Release the lock. The calling processor must be the owner of the lock.
+ *
+ * It is safe to call this function from any context and state.
+ */
+void prb_unlock(struct prb_cpulock *cpu_lock, unsigned int cpu_store)
+{
+	unsigned long *flags;
+	unsigned int cpu;
+
+	cpu = atomic_read(&cpu_lock->owner);
+	atomic_set_release(&cpu_lock->owner, cpu_store);
+
+	if (cpu_store == -1) {
+		flags = per_cpu_ptr(cpu_lock->irqflags, cpu);
+		local_irq_restore(*flags);
+	}
+
+	put_cpu();
+}
-- 
2.11.0

