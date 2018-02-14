Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966436AbeBNBtv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 20:49:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:11165 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966364AbeBNBtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 20:49:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,510,1511856000";
   d="scan'208";a="204003407"
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave@sr71.net>, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, linux-tip-commits@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, Arjan van de Ven <arjan@infradead.org>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
 <20180212165835.GO25181@hirez.programming.kicks-ass.net>
 <20180213075540.3lkikkpgjoe6ocjk@gmail.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <5c3ba123-abbe-f153-7b75-a89d31d25c72@linux.intel.com>
Date: Tue, 13 Feb 2018 17:49:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20180213075540.3lkikkpgjoe6ocjk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 11:55 PM, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Mon, Feb 12, 2018 at 08:13:31AM -0800, Dave Hansen wrote:
>>> On 02/12/2018 02:22 AM, Ingo Molnar wrote:
>>>>> +static inline void firmware_restrict_branch_speculation_end(void)
>>>>> +{
>>>>> +	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
>>>>> +			      X86_FEATURE_USE_IBRS_FW);
>>>> BTW., there's a detail that only occurred to me today, this enabling/disabling 
>>>> sequence is not NMI safe, and it might be called from NMI context:
>>>
>>> FWIW, Tim Chen and I talked about this a bunch.  We ended up just
>>> saving/restoring the MSR verbatim in the NMI handler the same way we do
>>> CR3, stashing it in a high general-purpose-register (r%12?).  That costs
>>> a RDMSR (at least) and an WRMSR (which you can optimize out).  We have a
>>> patch for that somewhere if anybody wants it.
>>
>> I would really rather not do that on the NMI path.. And if we _have_ to,
>> please keep a software shadow of that MSR state, such that we can avoid
>> touching that MSR 99% of the time.
> 
> Yeah, I'd rather avoid doing firmware calls from NMI context altogether.
> 
> Thanks,
> 
> 	Ingo
> 

Dave Hansen and I had some discussions on how to handle the nested NMI
and firmware calls.  We thought of using 
a per cpu counter to record the nesting call depth
and toggle IBRS appropriately for the depth 0->1 and 1->0
transition.  Will this change be sufficient?

Thanks.

Tim

commit 55546c27a006198630c57b900abcbd3baaabf63a
Author: Tim Chen <tim.c.chen@linux.intel.com>
Date:   Tue Feb 13 04:10:41 2018 -0800

    x86/firmware: Prevent IBRS from being turned off prematurely.
    
    Dave Woodhoue proposed to use IBRS to protect the firmware
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
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 297d457..1e9c828 100644
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
@@ -186,14 +188,16 @@ static inline void indirect_branch_prediction_barrier(void)
  */
 static inline void firmware_restrict_branch_speculation_start(void)
 {
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,
+	if (this_cpu_inc_return(spec_ctrl_ibrs_fw_depth) == 1)
+		alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,
 			      X86_FEATURE_USE_IBRS_FW);
 }
 
 static inline void firmware_restrict_branch_speculation_end(void)
 {
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
-			      X86_FEATURE_USE_IBRS_FW);
+	if (this_cpu_dec_return(spec_ctrl_ibrs_fw_depth) == 0)
+		alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
+				      X86_FEATURE_USE_IBRS_FW);
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
