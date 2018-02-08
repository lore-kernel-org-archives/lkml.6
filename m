Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752013AbeBHMcD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:32:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:45883 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbeBHMcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:32:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,478,1511856000";
   d="scan'208";a="29866918"
Date: Thu, 8 Feb 2018 19:20:28 +0800
From: Chao Gao <chao.gao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH] x86/kvm/vmx: Don't halt vcpu when L1 is injecting events
 to L2
Message-ID: <20180208112027.GA116170@skl-4s-chao.sh.intel.com>
References: <1518066816-7197-1-git-send-email-chao.gao@intel.com>
 <7de4e758-08cc-2c45-b0aa-dfe28dfef398@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de4e758-08cc-2c45-b0aa-dfe28dfef398@redhat.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 11:29:49AM +0100, Paolo Bonzini wrote:
>On 08/02/2018 06:13, Chao Gao wrote:
>> Although L2 is in halt state, it will be in the active state after
>> VM entry if the VM entry is vectoring. Halting the vcpu here means
>> the event won't be injected to L2 and this decision isn't reported
>> to L1. Thus L0 drops an event that should be injected to L2.
>> 
>> Because virtual interrupt delivery may wake L2 vcpu, if VID is enabled,
>> do the same thing -- don't halt L2.
>
>This second part seems wrong to me, or at least overly general.  Perhaps
>you mean if RVI>0?

Yes. It is a little general.

How about this patch:
-- 8> --
Subject: [PATCH] x86/kvm/vmx: Don't halt vcpu when L1 is injecting events to
 L2

Although L2 is in halt state, it will be in the active state after
VM entry if the VM entry is vectoring. Halting the vcpu here means
the event won't be injected to L2 and this decision isn't reported
to L1. Thus L0 drops an event that should be injected to L2.

Because virtual interrupt delivery may wake L2 vcpu, if VID is enabled
and RVI > 0, do the same thing -- don't halt L2.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/kvm/vmx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index bb5b488..fa889c8 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10985,7 +10985,13 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
        if (ret)
                return ret;

-       if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT)
+       /*
+        * If we're entering a halted L2 vcpu and the L2 vcpu won't be woken
+        * by event injection or VID, halt vcpu for optimization.
+        */
+       if ((vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) &&
+           !(vmcs12->vm_entry_intr_info_field & VECTORING_INFO_VALID_MASK) &&
+           !(nested_cpu_has_vid(vmcs12) && (vmcs12->guest_intr_status & 0xff)))
                return kvm_vcpu_halt(vcpu);

        vmx->nested.nested_run_pending = 1;
--

>
>Thanks,
>
>Paolo
>
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> ---
>>  arch/x86/kvm/vmx.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index bb5b488..e1fe4e4 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -10985,8 +10985,14 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>>  	if (ret)
>>  		return ret;
>>  
>> -	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT)
>> -		return kvm_vcpu_halt(vcpu);
>> +	if (vmcs12->guest_activity_state == GUEST_ACTIVITY_HLT) {
>> +		u32 intr_info = vmcs_read32(VM_ENTRY_INTR_INFO_FIELD);
>> +		u32 exec_control = vmcs_read32(SECONDARY_VM_EXEC_CONTROL);
>> +
>> +		if (!(intr_info & VECTORING_INFO_VALID_MASK) &&
>> +			!(exec_control & SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY))
>> +			return kvm_vcpu_halt(vcpu);
>> +	}
>
>>  	vmx->nested.nested_run_pending = 1;
>>  
>> 
>
