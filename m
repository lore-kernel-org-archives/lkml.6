Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936042AbeCHQ4y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:56:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932100AbeCHQ4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:56:52 -0500
Date: Thu, 8 Mar 2018 17:56:10 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
Message-ID: <20180308165610.GI12290@flask>
References: <20180226171121.18974-1-vkuznets@redhat.com>
 <20180226171121.18974-6-vkuznets@redhat.com>
 <20180307175611.GF12290@flask>
 <87h8pqyif4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8pqyif4.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-08 11:23+0100, Vitaly Kuznetsov:
> Radim Krčmář <rkrcmar@redhat.com> writes:
> > 2018-02-26 18:11+0100, Vitaly Kuznetsov:
> >> @@ -3828,7 +4302,12 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
> >>  	vmcs_conf->size = vmx_msr_high & 0x1fff;
> >>  	vmcs_conf->order = get_order(vmcs_conf->size);
> >>  	vmcs_conf->basic_cap = vmx_msr_high & ~0x1fff;
> >> -	vmcs_conf->revision_id = vmx_msr_low;
> >> +
> >> +	/* KVM supports Enlightened VMCS v1 only */
> >> +	if (static_branch_unlikely(&enable_evmcs))
> >> +		vmcs_conf->revision_id = 1;
> >
> > I think we have to put the bottom bits from ms_hyperv.nested_features
> > here. 16.5.1 Enlightened VMCS Versioning:
> >
> >   Each enlightened VMCS structure contains a version field, which is
> >   reported by the L0 hypervisor (see 2.4.11)
> 
> see below
> 
> >
> >> +	else
> >> +		vmcs_conf->revision_id = vmx_msr_low;
> >>  
> >>  	vmcs_conf->pin_based_exec_ctrl = _pin_based_exec_control;
> >>  	vmcs_conf->cpu_based_exec_ctrl = _cpu_based_exec_control;
> >> @@ -12414,7 +12908,35 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
> >>  
> >>  static int __init vmx_init(void)
> >>  {
> >> -	int r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
> >> +	int r;
> >> +
> >> +#if IS_ENABLED(CONFIG_HYPERV)
> >> +	/*
> >> +	 * Enlightened VMCS usage should be recommended and the host needs
> >> +	 * to support eVMCS v1 or above. We can also disable eVMCS support
> >> +	 * with module parameter.
> >> +	 */
> >> +	if (enlightened_vmcs &&
> >> +	    ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED &&
> >> +	    (ms_hyperv.nested_features & 0xff) >= 1) {
> 
> > I think we should not proceed with version other than 1 for now -- there
> > is no mention of backward compatibility in the spec.
> 
> I think the check is correct. eVMCS version represents the format of the
> structure in memory. New versions may have nothing in common but at the
> same time Ver1 support can't be dropped from future Hyper-V versions
> without regressing L1s which don't support new version.

I am concerned because Intel doesn't and eVMCS is based on VMCS, so
maybe they are going to use the live migration notifier to disable eVMCS
on incompatible versions.  TLFS points that they plan to handle eVMCS
versions the same as Intel, but the spec might just be misleading.

> So currently we check that L0 supports at least ver1 (or some newer
> version which implies all previously released versions are supported
> too) and we declare that KVM supports ver1 exactly (this is the format
> of the structure we put to memory and share with L0). We can't declare
> support for any other version.

Yes, I'm saying that we don't proceed with any other version than 1.

> Currently, it is only Ver1 on WS2016.

Right.  It should be an easy bug to spot, so I'm ok with the current
version.
