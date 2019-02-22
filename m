Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99784C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FEC2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfBVSvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:51:08 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39376 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfBVSvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:51:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E33C1682;
        Fri, 22 Feb 2019 10:51:06 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 635E33F5C1;
        Fri, 22 Feb 2019 10:51:03 -0800 (PST)
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
Subject: [RFC PATCH 09/20] sh: Add unconditional mmiowb() to arch_spin_unlock()
Date:   Fri, 22 Feb 2019 18:50:15 +0000
Message-Id: <20190222185026.10973-10-will.deacon@arm.com>
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
arch_spin_unlock() for sh. If this is deemed to be a performance issue,
a subsequent optimisation could make use of ARCH_HAS_MMIOWB to elide
the barrier in cases where no I/O writes were performned inside the
critical section.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/sh/include/asm/Kbuild          |  1 -
 arch/sh/include/asm/io.h            |  3 ---
 arch/sh/include/asm/mmiowb.h        | 12 ++++++++++++
 arch/sh/include/asm/spinlock-llsc.h |  2 ++
 4 files changed, 14 insertions(+), 4 deletions(-)
 create mode 100644 arch/sh/include/asm/mmiowb.h

diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index e3f6926c4b86..a6ef3fee5f85 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -13,7 +13,6 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mmiowb.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 4f7f235f15f8..c28e37a344ad 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -229,9 +229,6 @@ __BUILD_IOPORT_STRING(q, u64)
 
 #define IO_SPACE_LIMIT 0xffffffff
 
-/* synco on SH-4A, otherwise a nop */
-#define mmiowb()		wmb()
-
 /* We really want to try and get these to memcpy etc */
 void memcpy_fromio(void *, const volatile void __iomem *, unsigned long);
 void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
diff --git a/arch/sh/include/asm/mmiowb.h b/arch/sh/include/asm/mmiowb.h
new file mode 100644
index 000000000000..535d59735f1d
--- /dev/null
+++ b/arch/sh/include/asm/mmiowb.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_SH_MMIOWB_H
+#define __ASM_SH_MMIOWB_H
+
+#include <asm/barrier.h>
+
+/* synco on SH-4A, otherwise a nop */
+#define mmiowb()			wmb()
+
+#include <asm-generic/mmiowb.h>
+
+#endif	/* __ASM_SH_MMIOWB_H */
diff --git a/arch/sh/include/asm/spinlock-llsc.h b/arch/sh/include/asm/spinlock-llsc.h
index 786ee0fde3b0..7fd929cd2e7a 100644
--- a/arch/sh/include/asm/spinlock-llsc.h
+++ b/arch/sh/include/asm/spinlock-llsc.h
@@ -47,6 +47,8 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
 	unsigned long tmp;
 
+	/* This could be optimised with ARCH_HAS_MMIOWB */
+	mmiowb();
 	__asm__ __volatile__ (
 		"mov		#1, %0 ! arch_spin_unlock	\n\t"
 		"mov.l		%0, @%1				\n\t"
-- 
2.11.0

