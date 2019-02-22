Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED01207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 01:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfBVBaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 20:30:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:8835 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfBVBaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 20:30:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 17:30:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,397,1544515200"; 
   d="scan'208";a="124292397"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga007.fm.intel.com with ESMTP; 21 Feb 2019 17:30:10 -0800
Date:   Thu, 21 Feb 2019 17:30:10 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH RFC 01/39] KVM: x86: fix Xen hypercall page msr handling
Message-ID: <20190222013008.GG7224@linux.intel.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <20190220201609.28290-2-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220201609.28290-2-joao.m.martins@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 08:15:31PM +0000, Joao Martins wrote:
> Xen usually places its MSR at 0x4000000 or 0x4000200 depending on
> whether it is running in viridian mode or not. Note that this is not
> ABI guaranteed, so it is possible for Xen to advertise the MSR some
> place else.
> 
> Given the way xen_hvm_config() is handled, if the former address is
> selected, this will conflict with HyperV's MSR
> (HV_X64_MSR_GUEST_OS_ID) which uses the same address.

Unconditionally servicing Hyper-V and KVM MSRs seems wrong, i.e. KVM
should only expose MSRs specific to a hypervisor if userspace has
configured CPUID to advertise support for said hypervisor.  If we do the
same thing for Xen, then the common MSR code looks like:

	if (kvm_advertise_kvm()) {
		if (<handle kvm msr>)
			return ...;
	} else if (kvm_advertise_hyperv()) {
		if (<handle hyperv msr>)
			return ...;
	} else if (kvm_advertise_xen()) {
		if (<handle xen msrs>)
			return ...;
	}

	<fall through to main switch statement>

Obviously assumes KVM only advertises itself as one hypervisor, and so
the ordering is arbitrary.

> Given that the MSR location is arbitrary, move the xen_hvm_config()
> handling to the top of kvm_set_msr_common() before falling through.
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  arch/x86/kvm/x86.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 65e4559eef2f..47360a4b0d42 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2429,6 +2429,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	u32 msr = msr_info->index;
>  	u64 data = msr_info->data;
>  
> +	if (msr && (msr == vcpu->kvm->arch.xen_hvm_config.msr))
> +		return xen_hvm_config(vcpu, data);
> +
>  	switch (msr) {
>  	case MSR_AMD64_NB_CFG:
>  	case MSR_IA32_UCODE_WRITE:
> @@ -2644,8 +2647,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		vcpu->arch.msr_misc_features_enables = data;
>  		break;
>  	default:
> -		if (msr && (msr == vcpu->kvm->arch.xen_hvm_config.msr))
> -			return xen_hvm_config(vcpu, data);
>  		if (kvm_pmu_is_valid_msr(vcpu, msr))
>  			return kvm_pmu_set_msr(vcpu, msr_info);
>  		if (!ignore_msrs) {
> -- 
> 2.11.0
> 
