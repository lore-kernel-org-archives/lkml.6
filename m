Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91394C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6017A213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6017A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJCVmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:42:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:39600 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeJCVmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:42:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 07:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="268137404"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.193])
  by fmsmga005.fm.intel.com with ESMTP; 03 Oct 2018 07:53:24 -0700
Date:   Wed, 3 Oct 2018 07:53:24 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Nikita Leshchenko <nikita.leshchenko@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] kvm: nVMX: fix entry with pending interrupt if APICv is
 enabled
Message-ID: <20181003145324.GA23518@linux.intel.com>
References: <1538567267-2343-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1538567267-2343-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 01:47:47PM +0200, Paolo Bonzini wrote:
> Commit b5861e5cf2fcf83031ea3e26b0a69d887adf7d21 introduced a check on
> the interrupt-window and NMI-window CPU execution controls in order to
> inject an external interrupt vmexit before the first guest instruction
> executes.  However, when APIC virtualization is enabled the host does not
> need a vmexit in order to inject an interrupt at the next interrupt window;
> instead, it just places the interrupt vector in RVI and the processor will
> inject it as soon as possible.  Therefore, on machines with APICv it is
> not enough to check the CPU execution controls: the same scenario can also
> happen if RVI>0.
> 
> Fixes: b5861e5cf2fcf83031ea3e26b0a69d887adf7d21
> Cc: Nikita Leshchenko <nikita.leshchenko@oracle.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 6ef2d5b139b9..c0c7689f0049 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10280,6 +10280,11 @@ static void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
>  	}
>  }
>  
> +static u8 vmx_get_rvi(void)
> +{
> +	return vmcs_read16(GUEST_INTR_STATUS) & 0xff;
> +}
> +
>  static void vmx_set_rvi(int vector)
>  {
>  	u16 status;
> @@ -12593,10 +12598,13 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, u32 *exit_qual)
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>  	bool from_vmentry = !!exit_qual;
>  	u32 dummy_exit_qual;
> -	u32 vmcs01_cpu_exec_ctrl;
> +	bool evaluate_pending_interrupts;
>  	int r = 0;
>  
> -	vmcs01_cpu_exec_ctrl = vmcs_read32(CPU_BASED_VM_EXEC_CONTROL);
> +	evaluate_pending_interrupts = vmcs_read32(CPU_BASED_VM_EXEC_CONTROL) &
> +		(CPU_BASED_VIRTUAL_INTR_PENDING | CPU_BASED_VIRTUAL_NMI_PENDING);
> +	if (enable_apicv && kvm_vcpu_apicv_active(vcpu))

Isn't enable_apicv redundant with kvm_vcpu_apicv_active()?  And since
getting RVI requires a VMREAD, I think it would make sense to only
fall into this code if !evaluate_pending_interrupts, e.g.:

	if (!evaluate_pending_interrupts && kvm_vcpu_apicv_active(vcpu))
		evaluate_pending_interrupts |= vmx_get_rvi() > 0;

> +		evaluate_pending_interrupts |= vmx_get_rvi() > 0;
>  
>  	enter_guest_mode(vcpu);
>  
> @@ -12650,10 +12658,8 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, u32 *exit_qual)
>  	 * instead. Thus, we force L0 to perform pending event
>  	 * evaluation by requesting a KVM_REQ_EVENT.
>  	 */
> -	if (vmcs01_cpu_exec_ctrl &
> -		(CPU_BASED_VIRTUAL_INTR_PENDING | CPU_BASED_VIRTUAL_NMI_PENDING)) {
> +	if (evaluate_pending_interrupts)
>  		kvm_make_request(KVM_REQ_EVENT, vcpu);
> -	}
>  
>  	/*
>  	 * Note no nested_vmx_succeed or nested_vmx_fail here. At this point
> -- 
> 1.8.3.1
> 
