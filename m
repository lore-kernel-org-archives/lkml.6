Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeEQSbT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:31:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:35239 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeEQSbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:31:17 -0400
Date: Thu, 17 May 2018 20:30:58 +0200
From: Borislav Petkov <bp@suse.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: Johannes Hirte <johannes.hirte@datenkhaos.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 1/2] x86/MCE/AMD: Cache SMCA MISC block addresses
Message-ID: <20180517183058.GA24312@pd.tnic>
References: <20180414004230.GA2033@probook>
 <20180416115624.GA1543@probook>
 <CY4PR12MB1557FB8EB5C17E55A9B405D8F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180515093953.GA1746@probook>
 <20180516224641.GA31929@pd.tnic>
 <20180517064930.GA26421@probook>
 <20180517104124.GA25595@pd.tnic>
 <CY4PR12MB1557AB31F5F9D1ECBDAC2DA6F8910@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180517134415.GC27738@pd.tnic>
 <CY4PR12MB1557F564AF25A4F2306C7DE4F8910@CY4PR12MB1557.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR12MB1557F564AF25A4F2306C7DE4F8910@CY4PR12MB1557.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... into a global, two-dimensional array and service subsequent reads
from that cache to avoid rdmsr_on_cpu() calls during CPU hotplug (IPIs
with IRQs disabled).

In addition, this fixes a KASAN slab-out-of-bounds read due to wrong
usage of the bank->blocks pointer.

Reported-by: Johannes Hirte <johannes.hirte@datenkhaos.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Fixes: 27bd59502702 ("x86/mce/AMD: Get address from already initialized block")
Link: http://lkml.kernel.org/r/20180414004230.GA2033@probook
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 29 ++++++++++++++--------------
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
 
-- 
2.17.0.391.g1f1cddd558b5

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
