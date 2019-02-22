Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FEFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAD42070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfBVSvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:51:15 -0500
Received: from foss.arm.com ([217.140.101.70]:39448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfBVSvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:51:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1A0880D;
        Fri, 22 Feb 2019 10:51:13 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 66A263F5C1;
        Fri, 22 Feb 2019 10:51:10 -0800 (PST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 11/20] ia64: Add unconditional mmiowb() to arch_spin_unlock()
Date:   Fri, 22 Feb 2019 18:50:17 +0000
Message-Id: <20190222185026.10973-12-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmiowb() macro is horribly difficult to use and drivers will continue
to work most of the time if they omit a call when it is required.

Rather than rely on driver authors getting this right, push mmiowb() into
arch_spin_unlock() for ia64. If this is deemed to be a performance issue,
a subsequent optimisation could make use of ARCH_HAS_MMIOWB to elide
the barrier in cases where no I/O writes were performned inside the
critical section.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/ia64/include/asm/Kbuild     |  1 -
 arch/ia64/include/asm/io.h       |  4 ----
 arch/ia64/include/asm/mmiowb.h   | 12 ++++++++++++
 arch/ia64/include/asm/spinlock.h |  2 ++
 4 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 arch/ia64/include/asm/mmiowb.h

diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 3273d7aedfa0..43e21fe3499c 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -4,7 +4,6 @@ generic-y += exec.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += vtime.h
diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index 1e6fef69bb01..7f2371ba04a4 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -119,8 +119,6 @@ extern int valid_mmap_phys_addr_range (unsigned long pfn, size_t count);
  * Ensure ordering of I/O space writes.  This will make sure that writes
  * following the barrier will arrive after all previous writes.  For most
  * ia64 platforms, this is a simple 'mf.a' instruction.
- *
- * See Documentation/driver-api/device-io.rst for more information.
  */
 static inline void ___ia64_mmiowb(void)
 {
@@ -296,7 +294,6 @@ __outsl (unsigned long port, const void *src, unsigned long count)
 #define __outb		platform_outb
 #define __outw		platform_outw
 #define __outl		platform_outl
-#define __mmiowb	platform_mmiowb
 
 #define inb(p)		__inb(p)
 #define inw(p)		__inw(p)
@@ -310,7 +307,6 @@ __outsl (unsigned long port, const void *src, unsigned long count)
 #define outsb(p,s,c)	__outsb(p,s,c)
 #define outsw(p,s,c)	__outsw(p,s,c)
 #define outsl(p,s,c)	__outsl(p,s,c)
-#define mmiowb()	__mmiowb()
 
 /*
  * The address passed to these functions are ioremap()ped already.
diff --git a/arch/ia64/include/asm/mmiowb.h b/arch/ia64/include/asm/mmiowb.h
new file mode 100644
index 000000000000..238d56172c6f
--- /dev/null
+++ b/arch/ia64/include/asm/mmiowb.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_IA64_MMIOWB_H
+#define _ASM_IA64_MMIOWB_H
+
+#include <asm/machvec.h>
+
+#define mmiowb()	platform_mmiowb()
+
+#include <asm-generic/mmiowb.h>
+
+#endif	/* _ASM_IA64_MMIOWB_H */
diff --git a/arch/ia64/include/asm/spinlock.h b/arch/ia64/include/asm/spinlock.h
index afd0b3121b4c..5f620e66384e 100644
--- a/arch/ia64/include/asm/spinlock.h
+++ b/arch/ia64/include/asm/spinlock.h
@@ -73,6 +73,8 @@ static __always_inline void __ticket_spin_unlock(arch_spinlock_t *lock)
 {
 	unsigned short	*p = (unsigned short *)&lock->lock + 1, tmp;
 
+	/* This could be optimised with ARCH_HAS_MMIOWB */
+	mmiowb();
 	asm volatile ("ld2.bias %0=[%1]" : "=r"(tmp) : "r"(p));
 	WRITE_ONCE(*p, (tmp + 2) & ~1);
 }
-- 
2.11.0

