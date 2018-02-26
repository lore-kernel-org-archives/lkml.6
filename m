Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeBZRGi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:06:38 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:51878 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbeBZRG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:06:27 -0500
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
        "Matt Redfearn" <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] MIPS: Introduce isa-rev.h to define MIPS_ISA_REV
Date: Mon, 26 Feb 2018 17:02:42 +0000
Message-ID: <1519664565-10955-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
References: <1519664565-10955-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1519664779-637139-10615-123154-11
X-BESS-VER: 2018.2-r1802232356
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190443
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple instances in the kernel where we need to include or
exclude particular instructions based on the ISA revision of the target
processor. For MIPS32 / MIPS64, the compiler exports a __mips_isa_rev
define. However, when targeting MIPS I - V, this define is absent. This
leads to each use of __mips_isa_rev having to check that it is defined
first. To simplify this, introduce the isa-rev.h header which always
exports MIPS_ISA_REV. The name is changed so as to avoid confusion with
the compiler builtin and to avoid accidentally using the builtin.
MIPS_ISA_REV is defined to the compilers builtin if provided, or 0,
which satisfies all current usages.

Suggested-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

 arch/mips/include/asm/isa-rev.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/mips/include/asm/isa-rev.h

diff --git a/arch/mips/include/asm/isa-rev.h b/arch/mips/include/asm/isa-rev.h
new file mode 100644
index 000000000000..683ea3454dcb
--- /dev/null
+++ b/arch/mips/include/asm/isa-rev.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 MIPS Tech, LLC
+ * Author: Matt Redfearn <matt.redfearn@mips.com>
+ */
+
+#ifndef __MIPS_ASM_ISA_REV_H__
+#define __MIPS_ASM_ISA_REV_H__
+
+/*
+ * The ISA revision level. This is 0 for MIPS I to V and N for
+ * MIPS{32,64}rN.
+ */
+
+/* If the compiler has defined __mips_isa_rev, believe it. */
+#ifdef __mips_isa_rev
+#define MIPS_ISA_REV __mips_isa_rev
+#else
+/* The compiler hasn't defined the isa rev so assume it's MIPS I - V (0) */
+#define MIPS_ISA_REV 0
+#endif
+
+
+#endif /* __MIPS_ASM_ISA_REV_H__ */
-- 
2.7.4
