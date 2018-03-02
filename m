Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936261AbeCBLpd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:45:33 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34580 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935632AbeCBLp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:45:29 -0500
Date: Fri, 2 Mar 2018 12:45:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Save microcode revision in machine check records
Message-ID: <20180302114523.GA7406@pd.tnic>
References: <20180301233449.24311-1-tony.luck@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7B388EF7@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7B388EF7@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:40:31PM +0000, Luck, Tony wrote:
> +	c = &cpu_data(m->cpu);
> 
> Bother. Breaks on systems with >255 cpus because "cpu" is __u8.

No worries, I committed an even better version:

---
From: Tony Luck <tony.luck@intel.com>
Date: Thu, 1 Mar 2018 15:34:49 -0800
Subject: [PATCH] x86/MCE: Save microcode revision in machine check records

Updating microcode used to be relatively rare. Now that it has become
more common we should save the microcode version in a machine check
record to make sure that those people looking at the error have this
important information bundled with the rest of the logged information.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
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

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
