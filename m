Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeETIgi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 04:36:38 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58344 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeETIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 04:36:35 -0400
Date: Sun, 20 May 2018 10:36:33 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] ras fix for 4.17
Message-ID: <alpine.DEB.2.21.1805201034030.1599@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest ras-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-urgent-for-linus

Address the regression with the new AMD SMCA code which issues an SMP
function call from the early interrupt disabled region of CPU hotplug. To
avoid that use cached block addresses which can be used directly.

Thanks,

	tglx

------------------>
Borislav Petkov (1):
      x86/MCE/AMD: Cache SMCA MISC block addresses


 arch/x86/kernel/cpu/mcheck/mce_amd.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index f7666eef4a87..c8e038800591 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -94,6 +94,11 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_SMU]	= { "smu",		"System Management Unit" },
 };
 
+static u32 smca_bank_addrs[MAX_NR_BANKS][NR_BLOCKS] __ro_after_init =
+{
+	[0 ... MAX_NR_BANKS - 1] = { [0 ... NR_BLOCKS - 1] = -1 }
+};
+
 const char *smca_get_name(enum smca_bank_types t)
 {
 	if (t >= N_SMCA_BANK_TYPES)
@@ -443,20 +448,26 @@ static u32 smca_get_block_address(unsigned int cpu, unsigned int bank,
 	if (!block)
 		return MSR_AMD64_SMCA_MCx_MISC(bank);
 
+	/* Check our cache first: */
+	if (smca_bank_addrs[bank][block] != -1)
+		return smca_bank_addrs[bank][block];
+
 	/*
 	 * For SMCA enabled processors, BLKPTR field of the first MISC register
 	 * (MCx_MISC0) indicates presence of additional MISC regs set (MISC1-4).
 	 */
 	if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
-		return addr;
+		goto out;
 
 	if (!(low & MCI_CONFIG_MCAX))
-		return addr;
+		goto out;
 
 	if (!rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high) &&
 	    (low & MASK_BLKPTR_LO))
-		return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
+		addr = MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
 
+out:
+	smca_bank_addrs[bank][block] = addr;
 	return addr;
 }
 
@@ -468,18 +479,6 @@ static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 hi
 	if ((bank >= mca_cfg.banks) || (block >= NR_BLOCKS))
 		return addr;
 
-	/* Get address from already initialized block. */
-	if (per_cpu(threshold_banks, cpu)) {
-		struct threshold_bank *bankp = per_cpu(threshold_banks, cpu)[bank];
-
-		if (bankp && bankp->blocks) {
-			struct threshold_block *blockp = &bankp->blocks[block];
-
-			if (blockp)
-				return blockp->address;
-		}
-	}
-
 	if (mce_flags.smca)
 		return smca_get_block_address(cpu, bank, block);
 
