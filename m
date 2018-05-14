Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752382AbeENJra (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:47:30 -0400
Received: from foss.arm.com ([217.140.101.70]:38208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752292AbeENJr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:47:29 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: [PATCH 03/18] arm64: introduce sysreg_clear_set()
Date: Mon, 14 May 2018 10:46:25 +0100
Message-Id: <20180514094640.27569-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514094640.27569-1-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have a couple of helpers to manipulate bits in particular
sysregs:

 * config_sctlr_el1(u32 clear, u32 set)

 * change_cpacr(u64 val, u64 mask)

The parameters of these differ in naming convention, order, and size,
which is unfortunate. They also differ slightly in behaviour, as
change_cpacr() skips the sysreg write if the bits are unchanged, which
is a useful optimization when sysreg writes are expensive.

Before we gain more yet another sysreg manipulation function, let's
unify these with a common helper, providing a consistent order for
clear/set operands, and the write skipping behaviour from
change_cpacr(). Code will be migrated to the new helper in subsequent
patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index bd1d1194a5e7..b52762769329 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -729,6 +729,17 @@ asm(
 	asm volatile("msr_s " __stringify(r) ", %x0" : : "rZ" (__val));	\
 } while (0)
 
+/*
+ * Modify bits in a sysreg. Bits in the clear mask are zeroed, then bits in the
+ * set mask are set. Other bits are left as-is.
+ */
+#define sysreg_clear_set(sysreg, clear, set) do {			\
+	u64 __scs_val = read_sysreg(sysreg);				\
+	u64 __scs_new = (__scs_val & ~(u64)(clear)) | (set);		\
+	if (__scs_new != __scs_val)					\
+		write_sysreg(__scs_new, sysreg);			\
+} while (0)
+
 static inline void config_sctlr_el1(u32 clear, u32 set)
 {
 	u32 val;
-- 
2.11.0
