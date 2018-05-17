Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeEQScC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:32:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:35285 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbeEQScB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:32:01 -0400
Date: Thu, 17 May 2018 20:31:44 +0200
From: Borislav Petkov <bp@suse.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: Johannes Hirte <johannes.hirte@datenkhaos.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 2/2] x86/MCE/AMD: Read MCx_MISC block addresses on any CPU
Message-ID: <20180517183144.GB24312@pd.tnic>
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

We used rdmsr_safe_on_cpu() to make sure we're reading the proper CPU's
MISC block addresses. However, that caused trouble with CPU hotplug due
to the _on_cpu() helper issuing an IPI while IRQs are disabled.

But we don't have to do that: the block addresses are the same on any
CPU so we can read them on any CPU. (What practically happens is, we
read them on the BSP and cache them, and for later reads, we service
them from the cache).

Suggested-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

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
 
-- 
2.17.0.391.g1f1cddd558b5

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
