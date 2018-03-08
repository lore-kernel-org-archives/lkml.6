Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754780AbeCHOkH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:40:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34295 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751773AbeCHOkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:40:05 -0500
Date: Thu, 8 Mar 2018 06:39:52 -0800
From: tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-fa94d0c6e0f3431523f5701084d799c77c7d4a4f@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, yazen.ghannam@amd.com, mingo@kernel.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com, bp@suse.de,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: tony.luck@intel.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, yazen.ghannam@amd.com,
        hpa@zytor.com, tglx@linutronix.de, bp@suse.de
In-Reply-To: <20180301233449.24311-1-tony.luck@intel.com>
References: <20180301233449.24311-1-tony.luck@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/urgent] x86/MCE: Save microcode revision in machine check
 records
Git-Commit-ID: fa94d0c6e0f3431523f5701084d799c77c7d4a4f
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

Commit-ID:  fa94d0c6e0f3431523f5701084d799c77c7d4a4f
Gitweb:     https://git.kernel.org/tip/fa94d0c6e0f3431523f5701084d799c77c7d4a4f
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Tue, 6 Mar 2018 15:21:41 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 15:34:49 +0100

x86/MCE: Save microcode revision in machine check records

Updating microcode used to be relatively rare. Now that it has become
more common we should save the microcode version in a machine check
record to make sure that those people looking at the error have this
important information bundled with the rest of the logged information.

[ Borislav: Simplify a bit. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180301233449.24311-1-tony.luck@intel.com
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
index 8ff94d1e2dce..b3323cab9139 100644
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
