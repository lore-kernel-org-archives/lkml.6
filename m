Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeDFU7Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:59:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36928 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeDFU66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:58:58 -0400
X-Google-Smtp-Source: AIpwx4+Spf1ZOQ8wgdZ+ISLXajHrFdDp4VmRnGVCMbsBg26AFDYRFG/Q6xB+OjSfsRC+I+MXGpYltQ==
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Henrik Weinstock <jan.weinstock@ice.rwth-aachen.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: define mb() as its mandatory
Date: Sat,  7 Apr 2018 05:58:49 +0900
Message-Id: <20180406205852.14821-1-shorne@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following Peter Z's patch ("asm-generic: Disallow no-op mb() for SMP
systems") which makes mb() mandatory for SMP architectures we define it
as l.msync.  On OpenRISC this will flush the current cores write buffer
and trigger remote cores to invalidate their caches of the written
memory.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Link: https://lkml.org/lkml/2018/1/31/254
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---

Notes:
  - Sorry, its been a while since we discussed this patch is the parent to this 
    still going in Peter?
  - I have not got around to updating our architecture spec for the TSO/PSO
    notes we discussed.

 arch/openrisc/include/asm/Kbuild    | 1 -
 arch/openrisc/include/asm/barrier.h | 8 ++++++++
 2 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 arch/openrisc/include/asm/barrier.h

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 6eb16719549e..fea95ee2fb84 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,4 +1,3 @@
-generic-y += barrier.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += checksum.h
diff --git a/arch/openrisc/include/asm/barrier.h b/arch/openrisc/include/asm/barrier.h
new file mode 100644
index 000000000000..77eaad9ba0c4
--- /dev/null
+++ b/arch/openrisc/include/asm/barrier.h
@@ -0,0 +1,8 @@
+#ifndef _ASM_OPENRISC_BARRIER_H
+#define _ASM_OPENRISC_BARRIER_H
+
+#define mb() asm volatile ("l.msync":::"memory")
+
+#include <asm-generic/barrier.h>
+
+#endif /* _ASM_OPENRISC_BARRIER_H */
-- 
2.13.6
