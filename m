Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754254AbeBGOQy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:16:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753796AbeBGOQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:16:52 -0500
Subject: Re: [PATCH] KVM: X86: Fix SMRAM accessing even if VM is shutdown
To: Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <1517984706-47244-1-git-send-email-wanpengli@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <233cfca3-971e-c3c2-f0fe-b50dd69d2546@redhat.com>
Date: Wed, 7 Feb 2018 15:16:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1517984706-47244-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 07:25, Wanpeng Li wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 786cd00..445e702 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7458,6 +7458,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>  		goto out;
>  	}
>  
> +	if (unlikely(vcpu->run->exit_reason == KVM_EXIT_SHUTDOWN)) {
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
>  	if (vcpu->run->kvm_dirty_regs) {
>  		r = sync_regs(vcpu);
>  		if (r != 0)
> 

This most likely breaks triple faults in the usual case where they
should result in resetting the system; the KVM API doesn't say that you
should clear vcpu->run->exit_reason before entering.

What exactly causes the EPT misconfig to reach the WARN?  That is, how
does kvm_mmu_page_fault end up returning a negative errno value?  If I
read the code correctly only tdp_page_fault can do so, so my guess would
be kvm_handle_bad_page:

        if (pfn == KVM_PFN_ERR_RO_FAULT)
                return RET_PF_EMULATE;

        if (pfn == KVM_PFN_ERR_HWPOISON) {
                kvm_send_hwpoison_signal(kvm_vcpu_gfn_to_hva(vcpu, gfn),
current);
                return RET_PF_RETRY;
        }

	/* KVM_PFN_ERR_FAULT */
        return -EFAULT;

Maybe it should return RET_PF_EMULATE, which would cause an emulation
failure and then an exit with KVM_EXIT_INTERNAL_ERROR.

Thanks,

Paolo
