Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939008AbeBUSCJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:02:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57375 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938970AbeBUSCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:02:08 -0500
Date: Wed, 21 Feb 2018 10:00:37 -0800
From: tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-68627a697c195937672ce07683094c72b1174786@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, yazen.ghannam@amd.com,
        peterz@infradead.org, bp@alien8.de, bp@suse.de,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com
Reply-To: bp@suse.de, bp@alien8.de, yazen.ghannam@amd.com,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tony.luck@intel.com,
        torvalds@linux-foundation.org, linux-edac@vger.kernel.org
In-Reply-To: <20180221101900.10326-7-bp@alien8.de>
References: <20180221101900.10326-7-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce/AMD, EDAC/mce_amd: Enumerate Reserved SMCA
 bank type
Git-Commit-ID: 68627a697c195937672ce07683094c72b1174786
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

Commit-ID:  68627a697c195937672ce07683094c72b1174786
Gitweb:     https://git.kernel.org/tip/68627a697c195937672ce07683094c72b1174786
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Wed, 21 Feb 2018 11:18:58 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 17:00:54 +0100

x86/mce/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type

Currently, bank 4 is reserved on Fam17h, so we chose not to initialize
bank 4 in the smca_banks array. This means that when we check if a bank
is initialized, like during boot or resume, we will see that bank 4 is
not initialized and try to initialize it.

This will cause a call trace, when resuming from suspend, due to
rdmsr_*on_cpu() calls in the init path. The rdmsr_*on_cpu() calls issue
an IPI but we're running with interrupts disabled. This triggers:

  WARNING: CPU: 0 PID: 11523 at kernel/smp.c:291 smp_call_function_single+0xdc/0xe0
  ...

Reserved banks will be read-as-zero, so their MCA_IPID register will be
zero. So, like the smca_banks array, the threshold_banks array will not
have an entry for a reserved bank since all its MCA_MISC* registers will
be zero.

Enumerate a "Reserved" bank type that matches on a HWID_MCATYPE of 0,0.

Use the "Reserved" type when checking if a bank is reserved. It's
possible that other bank numbers may be reserved on future systems.

Don't try to find the block address on reserved banks.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 4.14.x
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180221101900.10326-7-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/mce.h           |  1 +
 arch/x86/kernel/cpu/mcheck/mce_amd.c |  7 +++++++
 drivers/edac/mce_amd.c               | 11 +++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index c3fb9a7..8c7b3e5 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -294,6 +294,7 @@ enum smca_bank_types {
 	SMCA_IF,	/* Instruction Fetch */
 	SMCA_L2_CACHE,	/* L2 Cache */
 	SMCA_DE,	/* Decoder Unit */
+	SMCA_RESERVED,	/* Reserved */
 	SMCA_EX,	/* Execution Unit */
 	SMCA_FP,	/* Floating Point */
 	SMCA_L3_CACHE,	/* L3 Cache */
diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index 7fbb19c..d8ba9d0 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -82,6 +82,7 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_IF]	= { "insn_fetch",	"Instruction Fetch Unit" },
 	[SMCA_L2_CACHE]	= { "l2_cache",		"L2 Cache" },
 	[SMCA_DE]	= { "decode_unit",	"Decode Unit" },
+	[SMCA_RESERVED]	= { "reserved",		"Reserved" },
 	[SMCA_EX]	= { "execution_unit",	"Execution Unit" },
 	[SMCA_FP]	= { "floating_point",	"Floating Point Unit" },
 	[SMCA_L3_CACHE]	= { "l3_cache",		"L3 Cache" },
@@ -127,6 +128,9 @@ static enum smca_bank_types smca_get_bank_type(unsigned int bank)
 static struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype, xec_bitmap } */
 
+	/* Reserved type */
+	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0), 0x0 },
+
 	/* ZN Core (HWID=0xB0) MCA types */
 	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFEF },
 	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1), 0x3FFF },
@@ -433,6 +437,9 @@ static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 hi
 	u32 addr = 0, offset = 0;
 
 	if (mce_flags.smca) {
+		if (smca_get_bank_type(bank) == SMCA_RESERVED)
+			return addr;
+
 		if (!block) {
 			addr = MSR_AMD64_SMCA_MCx_MISC(bank);
 		} else {
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index a11a671..2ab4d61 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -854,21 +854,24 @@ static void decode_mc6_mce(struct mce *m)
 static void decode_smca_error(struct mce *m)
 {
 	struct smca_hwid *hwid;
-	unsigned int bank_type;
+	enum smca_bank_types bank_type;
 	const char *ip_name;
 	u8 xec = XEC(m->status, xec_mask);
 
 	if (m->bank >= ARRAY_SIZE(smca_banks))
 		return;
 
-	if (x86_family(m->cpuid) >= 0x17 && m->bank == 4)
-		pr_emerg(HW_ERR "Bank 4 is reserved on Fam17h.\n");
-
 	hwid = smca_banks[m->bank].hwid;
 	if (!hwid)
 		return;
 
 	bank_type = hwid->bank_type;
+
+	if (bank_type == SMCA_RESERVED) {
+		pr_emerg(HW_ERR "Bank %d is reserved.\n", m->bank);
+		return;
+	}
+
 	ip_name = smca_get_long_name(bank_type);
 
 	pr_emerg(HW_ERR "%s Extended Error Code: %d\n", ip_name, xec);
