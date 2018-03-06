Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753865AbeCFOWu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:22:50 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44026 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753487AbeCFOWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:22:01 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] x86/MCE: Save microcode revision in machine check records
Date: Tue,  6 Mar 2018 15:21:41 +0100
Message-Id: <20180306142143.19990-2-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180306142143.19990-1-bp@alien8.de>
References: <20180306142143.19990-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Updating microcode used to be relatively rare. Now that it has become
more common we should save the microcode version in a machine check
record to make sure that those people looking at the error have this
important information bundled with the rest of the logged information.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180301233449.24311-1-tony.luck@intel.com
[ Simplify a bit. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/uapi/asm/mce.h  | 1 +
 arch/x86/kernel/cpu/mcheck/mce.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 91723461dc1f..435db58a7bad 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -30,6 +30,7 @@ struct mce {
 	__u64 synd;	/* MCA_SYND MSR: only valid on SMCA systems */
 	__u64 ipid;	/* MCA_IPID MSR: only valid on SMCA systems */
 	__u64 ppin;	/* Protected Processor Inventory Number */
+	__u32 microcode;/* Microcode revision */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 3c9a25b93538..181f6cf25895 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -130,6 +130,8 @@ void mce_setup(struct mce *m)
 
 	if (this_cpu_has(X86_FEATURE_INTEL_PPIN))
 		rdmsrl(MSR_PPIN, m->ppin);
+
+	m->microcode = boot_cpu_data.microcode;
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
@@ -262,7 +264,7 @@ static void __print_mce(struct mce *m)
 	 */
 	pr_emerg(HW_ERR "PROCESSOR %u:%x TIME %llu SOCKET %u APIC %x microcode %x\n",
 		m->cpuvendor, m->cpuid, m->time, m->socketid, m->apicid,
-		cpu_data(m->extcpu).microcode);
+		m->microcode);
 }
 
 static void print_mce(struct mce *m)
-- 
2.13.0
