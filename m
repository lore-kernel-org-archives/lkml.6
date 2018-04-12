Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752923AbeDLRVM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:21:12 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:24358 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeDLRVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:21:09 -0400
X-IronPort-AV: E=Sophos;i="5.48,442,1517875200";
   d="scan'208";a="734982164"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "jmattson@google.com" <jmattson@google.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH 1/2] X86/KVM: Properly restore 'tsc_offset' when running
 an L2 guest
Thread-Topic: [PATCH 1/2] X86/KVM: Properly restore 'tsc_offset' when running
 an L2 guest
Thread-Index: AQHT0nC4lLvkNnIRDkiE27bl+IOiw6P9U6KAgAAIAICAAAS/AA==
Date: Thu, 12 Apr 2018 17:21:02 +0000
Message-ID: <1523553662.32594.29.camel@amazon.de>
References: <1523545958-28059-1-git-send-email-karahmed@amazon.de>
         <d03d253a-d184-4c95-91b2-45e94659b9bd@redhat.com>
         <1523552643.32594.18.camel@amazon.de>
In-Reply-To: <1523552643.32594.18.camel@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB9A310E3E5F3B49A66DF8F76E150177@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3CHLFeJ020579

On Thu, 2018-04-12 at 17:04 +0000, Raslan, KarimAllah wrote:
> On Thu, 2018-04-12 at 18:35 +0200, Paolo Bonzini wrote:
> > 
> > On 12/04/2018 17:12, KarimAllah Ahmed wrote:
> > > 
> > > 
> > > When the TSC MSR is captured while an L2 guest is running then restored,
> > > the 'tsc_offset' ends up capturing the L02 TSC_OFFSET instead of the L01
> > > TSC_OFFSET. So ensure that this is compensated for when storing the value.
> > > 
> > > Cc: Jim Mattson <jmattson@google.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > > Cc: kvm@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> > > ---
> > >  arch/x86/kvm/vmx.c | 12 +++++++++---
> > >  arch/x86/kvm/x86.c |  1 -
> > >  2 files changed, 9 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > > index cff2f50..2f57571 100644
> > > --- a/arch/x86/kvm/vmx.c
> > > +++ b/arch/x86/kvm/vmx.c
> > > @@ -2900,6 +2900,8 @@ static u64 guest_read_tsc(struct kvm_vcpu *vcpu)
> > >   */
> > >  static void vmx_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
> > >  {
> > > +	u64 l1_tsc_offset = 0;
> > > +
> > >  	if (is_guest_mode(vcpu)) {
> > >  		/*
> > >  		 * We're here if L1 chose not to trap WRMSR to TSC. According
> > > @@ -2908,16 +2910,20 @@ static void vmx_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
> > >  		 * to the newly set TSC to get L2's TSC.
> > >  		 */
> > >  		struct vmcs12 *vmcs12;
> > > +
> > >  		/* recalculate vmcs02.TSC_OFFSET: */
> > >  		vmcs12 = get_vmcs12(vcpu);
> > > -		vmcs_write64(TSC_OFFSET, offset +
> > > -			(nested_cpu_has(vmcs12, CPU_BASED_USE_TSC_OFFSETING) ?
> > > -			 vmcs12->tsc_offset : 0));
> > > +
> > > +		l1_tsc_offset = nested_cpu_has(vmcs12, CPU_BASED_USE_TSC_OFFSETING) ?
> > > +					vmcs12->tsc_offset : 0;
> > > +		vmcs_write64(TSC_OFFSET, offset + l1_tsc_offset);
> > >  	} else {
> > >  		trace_kvm_write_tsc_offset(vcpu->vcpu_id,
> > >  					   vmcs_read64(TSC_OFFSET), offset);
> > >  		vmcs_write64(TSC_OFFSET, offset);
> > >  	}
> > > +
> > > +	vcpu->arch.tsc_offset = offset - l1_tsc_offset;
> > 
> > Using both "offset + l1_tsc_offset" and "offset - l1_tsc_offset" in this 
> > function seems wrong to me: if vcpu->arch.tsc_offset must be "offset - 
> > l1_tsc_offset", then "offset" must be written to TSC_OFFSET.
> 
> Ooops! I forgot to remove the + l1_tsc_offset :D
> 
> > 
> > 
> > I think the bug was introduced by commit 3e3f50262.  Before,
> > vmx_read_tsc_offset returned the L02 offset; now it always contains the
> > L01 offset.  So the right fix is to adjust vcpu->arch.tsc_offset on
> > nested vmentry/vmexit.  If is_guest_mode(vcpu), kvm_read_l1_tsc must use
> > a new kvm_x86_ops callback to subtract the L12 offset from the value it
> > returns.
> 
> ack!

Now looking further at the code, it seems that everywhere in the code
tsc_offset is treated as the L01 TSC_OFFSET.

Like here:

        if (vmcs12->cpu_based_vm_exec_control &
CPU_BASED_USE_TSC_OFFSETING)
                vmcs_write64(TSC_OFFSET,
                        vcpu->arch.tsc_offset + vmcs12->tsc_offset);

and here:

        vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);

and here:

u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc)
{
        return vcpu->arch.tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
}
EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);

... would not it be simpler and more inline with the current code to
just do what I did above + remove the "+ l1_tsc_offset" + probably
document tsc_offset ?

> 
> > 
> > 
> > Thanks,
> > 
> > Paolo
> > 
> > > 
> > > 
> > >  }
> > >  
> > >  /*
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index ac42c85..1a2ed92 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -1539,7 +1539,6 @@ EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);
> > >  static void kvm_vcpu_write_tsc_offset(struct kvm_vcpu *vcpu, u64 offset)
> > >  {
> > >  	kvm_x86_ops->write_tsc_offset(vcpu, offset);
> > > -	vcpu->arch.tsc_offset = offset;
> > >  }
> > >  
> > >  static inline bool kvm_check_tsc_unstable(void)
> > > 
> > 
> > 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
