Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeDJHh1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:37:27 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:23404 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDJHhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:37:24 -0400
X-IronPort-AV: E=Sophos;i="5.48,431,1517875200";
   d="scan'208";a="725378616"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>
CC: "jmattson@google.com" <jmattson@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2] kvm: nVMX: Introduce KVM_CAP_STATE
Thread-Topic: [PATCH v2] kvm: nVMX: Introduce KVM_CAP_STATE
Thread-Index: AQHTz94H5aEcX8JiNUeIeNpvvjdXzqP4S3UAgAFSSoA=
Date: Tue, 10 Apr 2018 07:37:13 +0000
Message-ID: <1523345833.5178.5.camel@amazon.de>
References: <1523263049-31993-1-git-send-email-karahmed@amazon.de>
         <4c04756b-d72c-1ff3-5ede-e70fa83d20e5@redhat.com>
In-Reply-To: <4c04756b-d72c-1ff3-5ede-e70fa83d20e5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.193]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B72C0EB24870C244ABCC54E5DF1D028D@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3A7bV6f001404

On Mon, 2018-04-09 at 13:26 +0200, David Hildenbrand wrote:
> On 09.04.2018 10:37, KarimAllah Ahmed wrote:
> > 
> > From: Jim Mattson <jmattson@google.com>
> > 
> > For nested virtualization L0 KVM is managing a bit of state for L2 guests,
> > this state can not be captured through the currently available IOCTLs. In
> > fact the state captured through all of these IOCTLs is usually a mix of L1
> > and L2 state. It is also dependent on whether the L2 guest was running at
> > the moment when the process was interrupted to save its state.
> > 
> > With this capability, there are two new vcpu ioctls: KVM_GET_VMX_STATE and
> > KVM_SET_VMX_STATE. These can be used for saving and restoring a VM that is
> > in VMX operation.
> > 
> 
> Very nice work!
> 
> > 
> >  
> > +static int get_vmcs_cache(struct kvm_vcpu *vcpu,
> > +			  struct kvm_state __user *user_kvm_state)
> > +{
> > +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> > +	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> > +
> > +	/*
> > +	 * When running L2, the authoritative vmcs12 state is in the
> > +	 * vmcs02. When running L1, the authoritative vmcs12 state is
> > +	 * in the shadow vmcs linked to vmcs01, unless
> > +	 * sync_shadow_vmcs is set, in which case, the authoritative
> > +	 * vmcs12 state is in the vmcs12 already.
> > +	 */
> > +	if (is_guest_mode(vcpu))
> > +		sync_vmcs12(vcpu, vmcs12);
> > +	else if (enable_shadow_vmcs && !vmx->nested.sync_shadow_vmcs)
> > +		copy_shadow_to_vmcs12(vmx);
> > +
> > +	if (copy_to_user(user_kvm_state->data, vmcs12, sizeof(*vmcs12)))
> > +		return -EFAULT;
> > +
> > +	/*
> > +	 * Force a nested exit that guarantees that any state capture
> > +	 * afterwards by any IOCTLs (MSRs, etc) will not capture a mix of L1
> > +	 * and L2 state.> +	 *
> 
> I totally understand why this is nice, I am worried about the
> implications. Let's assume migration fails and we want to continue
> running the guest on the source. We would now have a "bad" state.
> 
> How is this to be handled (e.g. is a SET_STATE necessary?)? I think this
> implication should be documented for KVM_GET_STATE.

Yup, I SET_STATE will be needed. That being said, I guess I will do 
what Jim mentioned and just fix the issue outlined here and then I can 
remove this VMExit.

> > 
> > +	 * One example where that would lead to an issue is the TSC DEADLINE
> > +	 * MSR vs the guest TSC. If the L2 guest is running, the guest TSC will
> > +	 * be the L2 TSC while the TSC deadline MSR will contain the L1 TSC
> > +	 * deadline MSR. That would lead to a very large (and wrong) "expire"
> > +	 * diff when LAPIC is initialized during instance restore (i.e. the
> > +	 * instance will appear to have hanged!).
> > +	 */
> > +	if (is_guest_mode(vcpu))
> > +		nested_vmx_vmexit(vcpu, -1, 0, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int get_vmx_state(struct kvm_vcpu *vcpu,
> > +			 struct kvm_state __user *user_kvm_state)
> > +{
> > +	u32 user_data_size;
> > +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> > +	struct kvm_state kvm_state = {
> > +		.flags = 0,
> > +		.format = 0,
> > +		.size = sizeof(kvm_state),
> > +		.vmx.vmxon_pa = -1ull,
> > +		.vmx.vmcs_pa = -1ull,
> > +	};
> > +
> > +	if (copy_from_user(&user_data_size, &user_kvm_state->size,
> > +			   sizeof(user_data_size)))
> > +		return -EFAULT;
> > +
> > +	if (nested_vmx_allowed(vcpu) && vmx->nested.vmxon) {
> > +		kvm_state.vmx.vmxon_pa = vmx->nested.vmxon_ptr;
> > +		kvm_state.vmx.vmcs_pa = vmx->nested.current_vmptr;
> > +
> > +		if (vmx->nested.current_vmptr != -1ull)
> > +			kvm_state.size += VMCS12_SIZE;
> > +
> > +		if (is_guest_mode(vcpu)) {
> > +			kvm_state.flags |= KVM_STATE_GUEST_MODE;
> > +
> > +			if (vmx->nested.nested_run_pending)
> > +				kvm_state.flags |= KVM_STATE_RUN_PENDING;
> > +		}
> > +	}
> > +
> > +	if (user_data_size < kvm_state.size) {
> > +		if (copy_to_user(&user_kvm_state->size, &kvm_state.size,
> > +				 sizeof(kvm_state.size)))
> > +			return -EFAULT;
> > +		return -E2BIG;
> > +	}
> > +
> > +	if (copy_to_user(user_kvm_state, &kvm_state, sizeof(kvm_state)))
> > +		return -EFAULT;
> > +
> > +	if (vmx->nested.current_vmptr == -1ull)
> > +		return 0;
> > +
> > +	return get_vmcs_cache(vcpu, user_kvm_state);
> > +}
> > +
> > +static int set_vmcs_cache(struct kvm_vcpu *vcpu,
> > +			  struct kvm_state __user *user_kvm_state,
> > +			  struct kvm_state *kvm_state)
> > +
> > +{
> > +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> > +	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> > +	u32 exit_qual;
> > +	int ret;
> > +
> > +	if ((kvm_state->size < (sizeof(*vmcs12) + sizeof(*kvm_state))) ||
> > +	    kvm_state->vmx.vmcs_pa == kvm_state->vmx.vmxon_pa ||
> > +	    !page_address_valid(vcpu, kvm_state->vmx.vmcs_pa))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_user(vmcs12, user_kvm_state->data, sizeof(*vmcs12)))
> > +		return -EFAULT;
> > +
> > +	if (vmcs12->revision_id != VMCS12_REVISION)
> > +		return -EINVAL;
> > +
> > +	set_current_vmptr(vmx, kvm_state->vmx.vmcs_pa);
> > +
> > +	if (!(kvm_state->flags & KVM_STATE_GUEST_MODE))
> > +		return 0;
> > +
> > +	if (check_vmentry_prereqs(vcpu, vmcs12) ||
> > +	    check_vmentry_postreqs(vcpu, vmcs12, &exit_qual))
> > +		return -EINVAL;
> > +
> > +	ret = enter_vmx_non_root_mode(vcpu, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * This request will result in a call to
> > +	 * nested_get_vmcs12_pages before the next VM-entry.
> > +	 */
> > +	kvm_make_request(KVM_REQ_GET_VMCS12_PAGES, vcpu);
> 
> Can you elaborate (+document) why this is needed instead of trying to
> get the page right away?

Because at this point, the MMU is not initialized to point at the
right entities yet and "get pages" would need to read data from the 
guest (i.e. we will need to performance gpa to hpa translation).

Ack! will update the comment in v3.

Thank you!

> 
> Thanks!
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
