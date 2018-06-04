Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeFDKKO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:10:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38987 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeFDKKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:10:13 -0400
Date: Mon, 4 Jun 2018 12:10:11 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] RAS updates for 4.18
Message-ID: <alpine.DEB.2.21.1806041152070.2646@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest ras-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

A small set of updates for RAS/MCE:

 - Fix a stack out of bounds write in the MCE error injection code.

 - Avoid IPIs during CPU hotplug to read the MCx_MISC block address from a
   remote CPU. That's fragile and pointless because the block addresses are
   the same on all CPUs. So they can be read once and local.

 - Add support for MCE broadcasting on newer VIA Centaur CPUs.

Thanks,

	tglx

------------------>
Borislav Petkov (1):
      x86/MCE/AMD: Read MCx_MISC block addresses on any CPU

David Wang (1):
      x86/MCE: Enable MCE broadcasting on new Centaur CPUs

Tony Luck (1):
      x86/MCE: Fix stack out-of-bounds write in mce-inject.c: Flags_read()


 arch/x86/kernel/cpu/mcheck/mce-inject.c |  2 +-
 arch/x86/kernel/cpu/mcheck/mce.c        | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/mcheck/mce_amd.c    | 15 +++++++--------
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-inject.c b/arch/x86/kernel/cpu/mcheck/mce-inject.c
index 475cb4f5f14f..c805a06e14c3 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-inject.c
@@ -48,7 +48,7 @@ static struct dentry *dfs_inj;
 
 static u8 n_banks;
 
-#define MAX_FLAG_OPT_SIZE	3
+#define MAX_FLAG_OPT_SIZE	4
 #define NBCFG			0x44
 
 enum injection_type {
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 42cf2880d0ed..cd76380af79f 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1727,6 +1727,21 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 	}
 }
 
+static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
+{
+	struct mca_config *cfg = &mca_cfg;
+
+	 /*
+	  * All newer Centaur CPUs support MCE broadcasting. Enable
+	  * synchronization with a one second timeout.
+	  */
+	if ((c->x86 == 6 && c->x86_model == 0xf && c->x86_stepping >= 0xe) ||
+	     c->x86 > 6) {
+		if (cfg->monarch_timeout < 0)
+			cfg->monarch_timeout = USEC_PER_SEC;
+	}
+}
+
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
@@ -1739,6 +1754,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_amd_feature_init(c);
 		break;
 		}
+	case X86_VENDOR_CENTAUR:
+		mce_centaur_feature_init(c);
+		break;
 
 	default:
 		break;
diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index c8e038800591..f591b01930db 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -436,8 +436,7 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
 	wrmsr(MSR_CU_DEF_ERR, low, high);
 }
 
-static u32 smca_get_block_address(unsigned int cpu, unsigned int bank,
-				  unsigned int block)
+static u32 smca_get_block_address(unsigned int bank, unsigned int block)
 {
 	u32 low, high;
 	u32 addr = 0;
@@ -456,13 +455,13 @@ static u32 smca_get_block_address(unsigned int cpu, unsigned int bank,
 	 * For SMCA enabled processors, BLKPTR field of the first MISC register
 	 * (MCx_MISC0) indicates presence of additional MISC regs set (MISC1-4).
 	 */
-	if (rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
+	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
 		goto out;
 
 	if (!(low & MCI_CONFIG_MCAX))
 		goto out;
 
-	if (!rdmsr_safe_on_cpu(cpu, MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high) &&
+	if (!rdmsr_safe(MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high) &&
 	    (low & MASK_BLKPTR_LO))
 		addr = MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
 
@@ -471,7 +470,7 @@ static u32 smca_get_block_address(unsigned int cpu, unsigned int bank,
 	return addr;
 }
 
-static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 high,
+static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 			     unsigned int bank, unsigned int block)
 {
 	u32 addr = 0, offset = 0;
@@ -480,7 +479,7 @@ static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 hi
 		return addr;
 
 	if (mce_flags.smca)
-		return smca_get_block_address(cpu, bank, block);
+		return smca_get_block_address(bank, block);
 
 	/* Fall back to method we used for older processors: */
 	switch (block) {
@@ -558,7 +557,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 			smca_configure(bank, cpu);
 
 		for (block = 0; block < NR_BLOCKS; ++block) {
-			address = get_block_address(cpu, address, low, high, bank, block);
+			address = get_block_address(address, low, high, bank, block);
 			if (!address)
 				break;
 
@@ -1175,7 +1174,7 @@ static int allocate_threshold_blocks(unsigned int cpu, unsigned int bank,
 	if (err)
 		goto out_free;
 recurse:
-	address = get_block_address(cpu, address, low, high, bank, ++block);
+	address = get_block_address(address, low, high, bank, ++block);
 	if (!address)
 		return 0;
 
