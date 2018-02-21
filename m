Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932793AbeBUKTt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:19:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57776 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932812AbeBUKTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:19:24 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] x86/MCE/AMD: Get address from already initialized block
Date: Wed, 21 Feb 2018 11:18:59 +0100
Message-Id: <20180221101900.10326-8-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180221101900.10326-1-bp@alien8.de>
References: <20180221101900.10326-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The block address is saved after the block is initialized when
threshold_init_device() is called.

Use the saved block address, if available, rather than trying to
rediscover it.

This will avoid a call trace, when resuming from suspend, due to the
rdmsr_safe_on_cpu() call in get_block_address(). The rdmsr_safe_on_cpu()
call issues an IPI but we're running with interrupts disabled. This
triggers:

    WARNING: CPU: 0 PID: 11523 at kernel/smp.c:291 smp_call_function_single+0xdc/0xe0

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Cc: <stable@vger.kernel.org> # 4.14.x
Link: https://lkml.kernel.org/r/20180215210943.11530-3-Yazen.Ghannam@amd.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index d8ba9d0c3f01..12bc2863a4d6 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -436,6 +436,21 @@ static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 hi
 {
 	u32 addr = 0, offset = 0;
 
+	if ((bank >= mca_cfg.banks) || (block >= NR_BLOCKS))
+		return addr;
+
+	/* Get address from already initialized block. */
+	if (per_cpu(threshold_banks, cpu)) {
+		struct threshold_bank *bankp = per_cpu(threshold_banks, cpu)[bank];
+
+		if (bankp && bankp->blocks) {
+			struct threshold_block *blockp = &bankp->blocks[block];
+
+			if (blockp)
+				return blockp->address;
+		}
+	}
+
 	if (mce_flags.smca) {
 		if (smca_get_bank_type(bank) == SMCA_RESERVED)
 			return addr;
-- 
2.13.0
