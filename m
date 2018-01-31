Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754042AbeAaSOa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:14:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753887AbeAaSO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:14:27 -0500
Date: Wed, 31 Jan 2018 19:14:13 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH v2 3/3] KVM: VMX: make MSR bitmaps per-VCPU
Message-ID: <20180131181413.GA660@flask>
References: <1517043027-7655-1-git-send-email-pbonzini@redhat.com>
 <1517043027-7655-4-git-send-email-pbonzini@redhat.com>
 <20180130162357.GE22015@flask>
 <fc794c7a-dec4-34dd-d7ac-6c0d49f138f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc794c7a-dec4-34dd-d7ac-6c0d49f138f1@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-31 12:37-0500, Paolo Bonzini:
> On 30/01/2018 11:23, Radim Krčmář wrote:
> > 2018-01-27 09:50+0100, Paolo Bonzini:
> >> Place the MSR bitmap in struct loaded_vmcs, and update it in place
> >> every time the x2apic or APICv state can change.  This is rare and
> >> the loop can handle 64 MSRs per iteration, in a similar fashion as
> >> nested_vmx_prepare_msr_bitmap.
> >>
> >> This prepares for choosing, on a per-VM basis, whether to intercept
> >> the SPEC_CTRL and PRED_CMD MSRs.
> >>
> >> Suggested-by: Jim Mattson <jmattson@google.com>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> >> @@ -10022,7 +10043,7 @@ static inline bool nested_vmx_merge_msr_bitmap(struct kvm_vcpu *vcpu,
> >>  	int msr;
> >>  	struct page *page;
> >>  	unsigned long *msr_bitmap_l1;
> >> -	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.msr_bitmap;
> >> +	unsigned long *msr_bitmap_l0 = to_vmx(vcpu)->nested.vmcs02.msr_bitmap;
> > 
> > The physical address of the nested msr_bitmap is never loaded into vmcs.
> > 
> > The resolution you provided had extra hunk in prepare_vmcs02_full():
> > 
> > +	vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
> > 
> > I have queued that as:
> > 
> > +	if (cpu_has_vmx_msr_bitmap())
> > +		vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
> 
> Hmm you're right, it should be in prepare_vmcs02() here (4.15-based),
> and then moved to prepare_vmcs02_full() as part of the conflict resolution.

It also makes sense to have it in nested_get_vmcs12_pages, where we call
nested_vmx_prepare_msr_bitmap() and disable MSR bitmaps.

> I'll send a v3.

Thanks.
