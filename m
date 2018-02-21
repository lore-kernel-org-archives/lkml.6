Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966180AbeBUSCg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:02:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938969AbeBUSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:02:34 -0500
Date: Wed, 21 Feb 2018 10:01:07 -0800
From: tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-27bd59502702fe51d9eb00450a75b727ec6bfcb4@git.kernel.org>
Cc: bp@alien8.de, linux-edac@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tony.luck@intel.com, hpa@zytor.com,
        tglx@linutronix.de, bp@suse.de, yazen.ghannam@amd.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Reply-To: bp@suse.de, yazen.ghannam@amd.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, mingo@kernel.org, tony.luck@intel.com,
        hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20180221101900.10326-8-bp@alien8.de>
References: <20180221101900.10326-8-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce/AMD: Get address from already initialized
 block
Git-Commit-ID: 27bd59502702fe51d9eb00450a75b727ec6bfcb4
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

Commit-ID:  27bd59502702fe51d9eb00450a75b727ec6bfcb4
Gitweb:     https://git.kernel.org/tip/27bd59502702fe51d9eb00450a75b727ec6bfcb4
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Wed, 21 Feb 2018 11:18:59 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 17:00:55 +0100

x86/mce/AMD: Get address from already initialized block

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
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 4.14.x
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180221101900.10326-8-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index d8ba9d0..12bc286 100644
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
