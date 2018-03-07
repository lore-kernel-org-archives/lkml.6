Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754608AbeCGO5O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:57:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754557AbeCGO5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:57:09 -0500
Date: Wed, 7 Mar 2018 15:56:28 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH] KVM: VMX: expose the host's ARCH_CAPABILITIES MSR to
 userspace
Message-ID: <20180307145628.GA12299@flask>
References: <1519433546-33879-1-git-send-email-pbonzini@redhat.com>
 <20180226221300.GK22024@char.us.oracle.com>
 <20180301213205.GB29001@flask>
 <ccead1df-ba70-f365-c816-7892834a290c@redhat.com>
 <20180302214212.GB13606@flask>
 <9cad32c8-fdb6-95db-2cd3-a0e3297b1811@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cad32c8-fdb6-95db-2cd3-a0e3297b1811@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-07 12:53+0100, Paolo Bonzini:
> On 02/03/2018 22:42, Radim Krčmář wrote:
> > Ok, sounds good.  I've deferred it to rc5 as I think we'll want to use
> > this to replace the auto setting:  I would not bet that it is going to
> > be safe to expose future bits, so having the userspace always sanitize
> > the capabilities would be safer (and more in line with what we do with
> > other MSRs).  i.e. this patch would also
> > 
> > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > index 051dab74e4e9..86ea4a83af1f 100644
> > --- a/arch/x86/kvm/vmx.c
> > +++ b/arch/x86/kvm/vmx.c
> > @@ -5740,9 +5740,6 @@ static void vmx_vcpu_setup(struct vcpu_vmx *vmx)
> >  		++vmx->nmsrs;
> >  	}
> >  
> > -	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
> > -		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, vmx->arch_capabilities);
> > -
> >  	vm_exit_controls_init(vmx, vmcs_config.vmexit_ctrl);
> >  
> >  	/* 22.2.1, 20.8.1 */
> 
> I don't know. There are good reasons for both behaviors, and especially
> the following two for _not_ removing the rdmsr:
> 
> 1) so far you could just pass the result of KVM_GET_SUPPORTED_CPUID to
> KVM_SET_CPUID2, and expect the result to be "as close as possible to the
> host";
>
> 2) having different behavior for VMX and ARCH_CAPABILITIES MSRs would be
> confusing.

Right, we can't just stop setting them by default ...

(I am in favor of forcing the userspace to configure everything and I'd
 accept this exception as a mistake of the past.)

> I think I'm leaning more towards the following direction: whitelist
> ARCH_CAPABILITIES, like we do for the AMD LFENCE MSR already, and
> default the AMD LFENCE MSR to the host value.

The whitelisting is a good idea and I'm ok with just that, thanks.

The MSR_F10H_DECFG default is questionable -- MSR_F10H_DECFG is an
architectural MSR, so we'd be changing the guest under the sight of
existing userspaces.
A potential security risk if they migrate the guest to a CPU that
doesn't serialize LFENCE.  ARCH_CAPABILITIES are at least hidden by a
new CPUID bit.

The feature MSR defaults are going to be a mess anyway: we have
MSR_IA32_UCODE_REV that is tightly coupled with CPUID.  Not a good
candidate for passing by default and currently also has a default value.
