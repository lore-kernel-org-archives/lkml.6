Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BAEC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A1B218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfAaIXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:23:04 -0500
Received: from mga03.intel.com ([134.134.136.65]:24089 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbfAaIXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:23:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 00:23:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="140371944"
Received: from local-michael-cet-test.sh.intel.com (HELO localhost) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jan 2019 00:23:01 -0800
Date:   Wed, 30 Jan 2019 23:16:48 +0800
From:   Yang Weijiang <weijiang.yang@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com,
        yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com,
        Zhang Yi Z <yi.z.zhang@linux.intel.com>
Subject: Re: [PATCH v2 6/7] KVM:VMX: Load Guest CET via VMCS when CET is
 enabled in Guest
Message-ID: <20190130151648.GA1126@local-michael-cet-test.sh.intel.com>
References: <20190122205909.24165-1-weijiang.yang@intel.com>
 <20190122205909.24165-7-weijiang.yang@intel.com>
 <20190125225625.GF21849@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125225625.GF21849@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 02:56:25PM -0800, Sean Christopherson wrote:
> On Wed, Jan 23, 2019 at 04:59:08AM +0800, Yang Weijiang wrote:
> > "Load Guest CET state" bit controls whether guest CET states
> > will be loaded on Guest entry. Before doing that, KVM needs
> > to check if CET feature is exposed to Guest.
> > 
> > Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
> > Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> > ---
> >  arch/x86/kvm/vmx.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index 68c0e5e41cb1..9c8cecac80ea 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -55,6 +55,7 @@
> >  #include <asm/mmu_context.h>
> >  #include <asm/spec-ctrl.h>
> >  #include <asm/mshyperv.h>
> > +#include <asm/cet.h>
> >  
> >  #include "trace.h"
> >  #include "pmu.h"
> > @@ -4065,6 +4066,18 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
> >  	return !(val & ~valid_bits);
> >  }
> >  
> > +static int vmx_guest_cet_cap(struct kvm_vcpu *vcpu)
> > +{
> > +	struct kvm_cpuid_entry2 *best;
> > +	int r = 0;
> > +
> > +	best = kvm_find_cpuid_entry(vcpu, 7, 0);
> > +	if (best && best->function == 0x7)
> > +		r = (best->ecx & bit(X86_FEATURE_SHSTK)) |
> > +		    (best->edx & bit(X86_FEATURE_IBT)) ? 1 : 0;
> > +	return r;
> > +}
> > +
> >  static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
> >  {
> >  	switch (msr->index) {
> > @@ -5409,6 +5422,26 @@ static int vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
> >  			return 1;
> >  	}
> >  
> > +	/*
> > +	 * To enable Guest CET, first check if Guest CET feature is
> > +	 * available, if it's not available but its CR4.CET is being set,
> > +	 * return a fault to Guest; then check if Host CET is enabled and
> > +	 * CR4.CET is toggled, if they are, then enable loading CET state
> 
> Comment doesn't match the code.  Comment says "toggled", code is just
> looking at "enabled".
> 
> > +	 * bit in entry control, otherwise, clear the bit to
> > +	 * disable guest CET state loading.
> 
> What happens to CET state if the control is clear?  Is host state
> retained but inaccessible?
>
Hi, Sean, 
I consulted the CET arch for the feature enabling in guest, actually, it
can be enabled independent to host CET feature, i.e., guest CET feature
can work even without host CET feature off, I did experiments, it's
proved true. So, in next version, I'll remove host CET dependencies to
make the KVM code look much cleaner. Thanks for your comments.

> > +	 */
> > +	if (vmx_guest_cet_cap(vcpu)) {
> 
> Why not?
> 
> 	if (guest_cpuid_has(vcpu, X86_FEATURE_SHSTK) ||
> 	    guest_cpuid_has(vcpu, X86_FEATURE_IBT)) {
> 
> > +		if (hw_cr4 & cr4 & X86_CR4_CET) {
> > +			vmcs_set_bits(VM_ENTRY_CONTROLS,
> > +				      VM_ENTRY_LOAD_GUEST_CET_STATE);
> > +		} else {
> > +			vmcs_clear_bits(VM_ENTRY_CONTROLS,
> > +					VM_ENTRY_LOAD_GUEST_CET_STATE);
> > +		}
> > +	} else if (cr4 & X86_CR4_CET) {
> > +		return 1;
> > +	}
> > +
> >  	if (to_vmx(vcpu)->nested.vmxon && !nested_cr4_valid(vcpu, cr4))
> >  		return 1;
> >  
> > -- 
> > 2.17.1
> > 
