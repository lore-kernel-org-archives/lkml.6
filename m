Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbeFDH1t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:53652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbeFDHBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:01:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 08/52] x86/mce/AMD: Carve out SMCA get_block_address() code
Date: Mon,  4 Jun 2018 08:58:03 +0200
Message-Id: <20180604065606.873447352@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit 8a331f4a0863bea758561c921b94b4d28f7c4029 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce_amd.c |   57 +++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -429,6 +429,35 @@ static void deferred_error_interrupt_ena
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
@@ -449,32 +478,8 @@ static u32 get_block_address(unsigned in
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
