Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939031AbeBUSCM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:02:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938970AbeBUSCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:02:10 -0500
Date: Wed, 21 Feb 2018 10:01:35 -0800
From: tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-8a331f4a0863bea758561c921b94b4d28f7c4029@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com,
        torvalds@linux-foundation.org, yazen.ghannam@amd.com,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, bp@suse.de,
        peterz@infradead.org, mingo@kernel.org, linux-edac@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, tony.luck@intel.com,
        torvalds@linux-foundation.org, yazen.ghannam@amd.com,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, bp@suse.de,
        peterz@infradead.org, linux-edac@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20180215210943.11530-4-Yazen.Ghannam@amd.com>
References: <20180215210943.11530-4-Yazen.Ghannam@amd.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce/AMD: Carve out SMCA get_block_address() code
Git-Commit-ID: 8a331f4a0863bea758561c921b94b4d28f7c4029
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

Commit-ID:  8a331f4a0863bea758561c921b94b4d28f7c4029
Gitweb:     https://git.kernel.org/tip/8a331f4a0863bea758561c921b94b4d28f7c4029
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Wed, 21 Feb 2018 11:19:00 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 17:00:55 +0100

x86/mce/AMD: Carve out SMCA get_block_address() code

Carve out the SMCA code in get_block_address() into a separate helper
function.

No functional change.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
[ Save an indentation level. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180215210943.11530-4-Yazen.Ghannam@amd.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 57 ++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index 12bc286..f7666ee 100644
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
