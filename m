Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeESNWL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 09:22:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43585 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752201AbeESNWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 09:22:07 -0400
Date: Sat, 19 May 2018 06:21:47 -0700
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-78ce241099bb363b19dbd0245442e66c8de8f567@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        yazen.ghannam@amd.com, bp@suse.de, johannes.hirte@datenkhaos.de,
        tglx@linutronix.de
Reply-To: yazen.ghannam@amd.com, bp@suse.de, johannes.hirte@datenkhaos.de,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180414004230.GA2033@probook>
References: <20180414004230.GA2033@probook>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/urgent] x86/MCE/AMD: Cache SMCA MISC block addresses
Git-Commit-ID: 78ce241099bb363b19dbd0245442e66c8de8f567
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

Commit-ID:  78ce241099bb363b19dbd0245442e66c8de8f567
Gitweb:     https://git.kernel.org/tip/78ce241099bb363b19dbd0245442e66c8de8f567
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 17 May 2018 10:46:26 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 15:19:30 +0200

x86/MCE/AMD: Cache SMCA MISC block addresses

... into a global, two-dimensional array and service subsequent reads from
that cache to avoid rdmsr_on_cpu() calls during CPU hotplug (IPIs with IRQs
disabled).

In addition, this fixes a KASAN slab-out-of-bounds read due to wrong usage
of the bank->blocks pointer.

Fixes: 27bd59502702 ("x86/mce/AMD: Get address from already initialized block")
Reported-by: Johannes Hirte <johannes.hirte@datenkhaos.de>
Tested-by: Johannes Hirte <johannes.hirte@datenkhaos.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Link: http://lkml.kernel.org/r/20180414004230.GA2033@probook
---
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
 
