Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162812AbeBNTUw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 14:20:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:41685 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162781AbeBNTUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 14:20:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,513,1511856000";
   d="scan'208";a="204241472"
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave@sr71.net>,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@infradead.org>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
 <20180212165835.GO25181@hirez.programming.kicks-ass.net>
 <20180213075540.3lkikkpgjoe6ocjk@gmail.com>
 <5c3ba123-abbe-f153-7b75-a89d31d25c72@linux.intel.com>
 <20180214085614.GT25181@hirez.programming.kicks-ass.net>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <1fd7c8ef-a50c-53d8-7159-d992e669c2f2@linux.intel.com>
Date: Wed, 14 Feb 2018 11:20:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20180214085614.GT25181@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 12:56 AM, Peter Zijlstra wrote:

> 
> At the very least this must disable and re-enable preemption, such that
> we guarantee we inc/dec the same counter. ISTR some firmware calls (EFI)
> actually are preemptible so that wouldn't work.
> 
> Further, consider:
> 
> 	this_cpu_inc_return()		// 0->1
> 	<NMI>
> 		this_cpu_inc_return()	// 1->2
> 		call_broken_arse_firmware()
> 		this_cpu_dec_return()	// 2->1
> 	</NMI>
> 	wrmsr(SPEC_CTRL, IBRS);
> 
> 	/* from dodgy firmware crap */
> 
> 	this_cpu_dec_return()		// 1->0
> 	wrmsr(SPEC_CTRL, 0);
> 

How about the following patch.

Thanks.

Tim

---
>From a37d28622781acf2789dd63f2fdb57be733f15a4 Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Tue, 13 Feb 2018 04:10:41 -0800
Subject: [PATCH] x86/firmware: Prevent IBRS from being turned off prematurely.

Dave Woodhoue proposed using IBRS to protect the firmware
call path against Spectre exploit.  However, firmware path
can go through NMI and we can get nested calls, causing
unsafe firmware calls with missing IBRS as illustrated below:

	firmware_restrict_branch_speculation_start (set IBRS=1)
	NMI
	    firmware_restrict_branch_speculation_start (set IBRS=1)
	    firmware call
	    firmware_restrict_branch_speculation_end (set IBRS=0)
	NMI return
	firmware call (with IBRS=0)  <---- unsafe call, premature IBRS disabling
	firmware_restrict_branch_speculation_end (set IBRS=0)

This patch proposes using a per cpu counter to track the IBRS
firmware call nesting depth, to ensure that we don't turn off
IBRS prematurely before calling firmware.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/include/asm/nospec-branch.h | 10 ++++++++--
 arch/x86/kernel/cpu/bugs.c           |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 297d457..a8dd9ea 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -146,6 +146,8 @@ enum spectre_v2_mitigation {
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
+DECLARE_PER_CPU(int, spec_ctrl_ibrs_fw_depth);
+
 /*
  * On VMEXIT we must ensure that no RSB predictions learned in the guest
  * can be followed in the host, by overwriting the RSB completely. Both
@@ -186,14 +188,18 @@ static inline void indirect_branch_prediction_barrier(void)
  */
 static inline void firmware_restrict_branch_speculation_start(void)
 {
+	preempt_disable();
+	this_cpu_inc(spec_ctrl_ibrs_fw_depth);
 	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,
 			      X86_FEATURE_USE_IBRS_FW);
 }
 
 static inline void firmware_restrict_branch_speculation_end(void)
 {
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
-			      X86_FEATURE_USE_IBRS_FW);
+	if (this_cpu_dec_return(spec_ctrl_ibrs_fw_depth) == 0)
+		alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
+				      X86_FEATURE_USE_IBRS_FW);
+	preempt_enable();
 }
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_X86_NOSPEC_BRANCH_H_ */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c994dab..4ab13f0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -27,6 +27,8 @@
 #include <asm/intel-family.h>
 
 static void __init spectre_v2_select_mitigation(void);
+DEFINE_PER_CPU(int, spec_ctrl_ibrs_fw_depth);
+EXPORT_PER_CPU_SYMBOL(spec_ctrl_ibrs_fw_depth);
 
 void __init check_bugs(void)
 {
-- 
2.7.4
