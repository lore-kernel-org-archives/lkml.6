Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932850AbeBUKTf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:19:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57786 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932743AbeBUKTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:19:24 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] x86/MCE/AMD: Carve out SMCA get_block_address() code
Date: Wed, 21 Feb 2018 11:19:00 +0100
Message-Id: <20180221101900.10326-9-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180221101900.10326-1-bp@alien8.de>
References: <20180221101900.10326-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Carve out the SMCA code in get_block_address() into a separate helper
function.

No functional change.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20180215210943.11530-4-Yazen.Ghannam@amd.com
[ Save an indentation level. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 57 ++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index 12bc2863a4d6..f7666eef4a87 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -431,6 +431,35 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
 	wrmsr(MSR_CU_DEF_ERR, low, high);
 }
 
+static u32 smca_get_block_address(unsigned int cpu, unsigned int bank,
+				  unsigned int block)
+{
+	u32 low, high;
+	u32 addr = 0;
+
+	if (smca_get_bank_type(bank) == SMCA_RESERVED)
+		return addr;
+
+	if (!block)
+		return MSR_AMD64_SMCA_MCx_MISC(bank);
+
+	/*
+	 * For SMCA enabled processors, BLKPTR field of the first MISC register
+	 * (MCx_MISC0) indicates presence of additional MISC regs set (MISC1-4).
+	 */
+	if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
+		return addr;
+
+	if (!(low & MCI_CONFIG_MCAX))
+		return addr;
+
+	if (!rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high) &&
+	    (low & MASK_BLKPTR_LO))
+		return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
+
+	return addr;
+}
+
 static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 high,
 			     unsigned int bank, unsigned int block)
 {
@@ -451,32 +480,8 @@ static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 hi
 		}
 	}
 
-	if (mce_flags.smca) {
-		if (smca_get_bank_type(bank) == SMCA_RESERVED)
-			return addr;
-
-		if (!block) {
-			addr = MSR_AMD64_SMCA_MCx_MISC(bank);
-		} else {
-			/*
-			 * For SMCA enabled processors, BLKPTR field of the
-			 * first MISC register (MCx_MISC0) indicates presence of
-			 * additional MISC register set (MISC1-4).
-			 */
-			u32 low, high;
-
-			if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
-				return addr;
-
-			if (!(low & MCI_CONFIG_MCAX))
-				return addr;
-
-			if (!rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high) &&
-			    (low & MASK_BLKPTR_LO))
-				addr = MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
-		}
-		return addr;
-	}
+	if (mce_flags.smca)
+		return smca_get_block_address(cpu, bank, block);
 
 	/* Fall back to method we used for older processors: */
 	switch (block) {
-- 
2.13.0
