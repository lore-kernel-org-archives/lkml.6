Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbeBQKaw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:30:52 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39786 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbeBQKav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:30:51 -0500
Date: Sat, 17 Feb 2018 11:30:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v2 4/4] x86/MCE/AMD: Carve out SMCA get_block_address()
 code
Message-ID: <20180217103044.GB25916@pd.tnic>
References: <20180215210943.11530-1-Yazen.Ghannam@amd.com>
 <20180215210943.11530-4-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180215210943.11530-4-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 03:09:43PM -0600, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Carve out the SMCA code in get_block_address() into a separate helper
> function.
> 
> No functional change.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> v1->v2:
> * New in this series.
> 
>  arch/x86/kernel/cpu/mcheck/mce_amd.c | 59 ++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 26 deletions(-)

All look ok to me, this last one I massaged a bit to save an indentation
level, see below.

Running them a bit on the boxes here...

---
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 15 Feb 2018 15:09:43 -0600
Subject: [PATCH] x86/MCE/AMD: Carve out SMCA get_block_address() code

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

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
