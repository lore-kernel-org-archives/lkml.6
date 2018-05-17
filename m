Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeEQKls (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:41:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:49872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeEQKlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:41:46 -0400
Date: Thu, 17 May 2018 12:41:24 +0200
From: Borislav Petkov <bp@suse.de>
To: Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
 block
Message-ID: <20180517104124.GA25595@pd.tnic>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180201184813.82253-3-Yazen.Ghannam@amd.com>
 <20180414004230.GA2033@probook>
 <20180416115624.GA1543@probook>
 <CY4PR12MB1557FB8EB5C17E55A9B405D8F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180515093953.GA1746@probook>
 <20180516224641.GA31929@pd.tnic>
 <20180517064930.GA26421@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180517064930.GA26421@probook>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 08:49:31AM +0200, Johannes Hirte wrote:
> Maybe I'm missing something, but those RDMSR IPSs don't happen on
> pre-SMCA systems, right? So the caching should be avoided here, cause
> the whole lookup looks more expensive to me than the simple switch-block
> in get_block_address.

Yeah, and we should simply cache all those MSR values as I suggested then.

The patch at the end should fix your issue.

Yazen, so I'm working on the assumption that all addresses are the same
on every core - I dumped them and it looks like this:

    128 bank: 00, block: 0 : 0xc0002003
    128 bank: 00, block: 1 : 0x0
    128 bank: 01, block: 0 : 0xc0002013
    128 bank: 01, block: 1 : 0x0
    128 bank: 02, block: 0 : 0xc0002023
    128 bank: 02, block: 1 : 0x0
    128 bank: 03, block: 0 : 0xc0002033
    128 bank: 03, block: 1 : 0x0
    128 bank: 04, block: 0 : 0x0
    128 bank: 05, block: 0 : 0xc0002053
    128 bank: 05, block: 1 : 0x0
    128 bank: 06, block: 0 : 0xc0002063
    128 bank: 06, block: 1 : 0x0
    128 bank: 07, block: 0 : 0xc0002073
    128 bank: 07, block: 1 : 0x0
    128 bank: 08, block: 0 : 0xc0002083
    128 bank: 08, block: 1 : 0x0
    128 bank: 09, block: 0 : 0xc0002093
    128 bank: 09, block: 1 : 0x0
    128 bank: 10, block: 0 : 0xc00020a3
    128 bank: 10, block: 1 : 0x0
    128 bank: 11, block: 0 : 0xc00020b3
    128 bank: 11, block: 1 : 0x0
    128 bank: 12, block: 0 : 0xc00020c3
    128 bank: 12, block: 1 : 0x0
    128 bank: 13, block: 0 : 0xc00020d3
    128 bank: 13, block: 1 : 0x0
    128 bank: 14, block: 0 : 0xc00020e3
    128 bank: 14, block: 1 : 0x0
    128 bank: 15, block: 0 : 0xc00020f3
    128 bank: 15, block: 1 : 0x0
    128 bank: 16, block: 0 : 0xc0002103
    128 bank: 16, block: 1 : 0x0
    128 bank: 17, block: 0 : 0xc0002113
    128 bank: 17, block: 1 : 0x0
    128 bank: 18, block: 0 : 0xc0002123
    128 bank: 18, block: 1 : 0x0
    128 bank: 19, block: 0 : 0xc0002133
    128 bank: 19, block: 1 : 0x0
    128 bank: 20, block: 0 : 0xc0002143
    128 bank: 20, block: 1 : 0x0
    128 bank: 21, block: 0 : 0xc0002153
    128 bank: 21, block: 1 : 0x0
    128 bank: 22, block: 0 : 0xc0002163
    128 bank: 22, block: 1 : 0x0

so you have 128 times the same address on a 128 core Zen box.

If that is correct, then we can use this nice simplification and cache
them globally and not per-CPU. Seems to work here. Scream if something's
amiss.

Thx.

---
>From d8614e904d8f63b89d2d204d6fa247c4c416a1b6 Mon Sep 17 00:00:00 2001
From: Borislav Petkov <bp@susede>
Date: Thu, 17 May 2018 10:46:26 +0200
Subject: [PATCH] array caching

Not-Signed-off-by: Borislav Petkov <bp@suse.de>
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
