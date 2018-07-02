Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527BFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2F82418A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2F82418A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeGBPKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:10:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751931AbeGBPKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:10:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A6EAD4021CC2;
        Mon,  2 Jul 2018 15:10:00 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 124661C4C3;
        Mon,  2 Jul 2018 15:09:58 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "hpa\@zytor.com" <hpa@zytor.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH 3/4] KVM/VMX: Add identical ept table pointer check
References: <20180702141653.88936-1-Tianyu.Lan@microsoft.com>
        <20180702141653.88936-4-Tianyu.Lan@microsoft.com>
Date:   Mon, 02 Jul 2018 17:09:57 +0200
In-Reply-To: <20180702141653.88936-4-Tianyu.Lan@microsoft.com> (Tianyu Lan's
        message of "Mon, 2 Jul 2018 14:17:29 +0000")
Message-ID: <87lgatbrne.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 02 Jul 2018 15:10:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 02 Jul 2018 15:10:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <Tianyu.Lan@microsoft.com> writes:

> This patch is to check ept table pointer of each cpus when set ept
> tables and store identical ept table pointer if all ept table pointers
> of single VM are same. This is for support of para-virt ept flush
> hypercall.
>
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/kvm/vmx.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 1689f433f3a0..0b1e4e9fef2b 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -194,6 +194,9 @@ struct kvm_vmx {
>  	unsigned int tss_addr;
>  	bool ept_identity_pagetable_done;
>  	gpa_t ept_identity_map_addr;
> +
> +	u64 identical_ept_pointer;
> +	spinlock_t ept_pointer_lock;
>  };
>
>  #define NR_AUTOLOAD_MSRS 8
> @@ -853,6 +856,7 @@ struct vcpu_vmx {
>  	 */
>  	u64 msr_ia32_feature_control;
>  	u64 msr_ia32_feature_control_valid_bits;
> +	u64 ept_pointer;
>  };
>
>  enum segment_cache_field {
> @@ -4958,6 +4962,29 @@ static u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa)
>  	return eptp;
>  }
>
> +static void check_ept_pointer(struct kvm_vcpu *vcpu, u64 eptp)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	u64 tmp_eptp = INVALID_PAGE;
> +	int i;
> +
> +	spin_lock(&to_kvm_vmx(kvm)->ept_pointer_lock);
> +	to_vmx(vcpu)->ept_pointer = eptp;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		if (!VALID_PAGE(tmp_eptp)) {
> +			tmp_eptp = to_vmx(vcpu)->ept_pointer;
> +		} else if (tmp_eptp != to_vmx(vcpu)->ept_pointer) {
> +			to_kvm_vmx(kvm)->identical_ept_pointer = INVALID_PAGE;
> +			spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
> +			return;
> +		}
> +	}
> +
> +	to_kvm_vmx(kvm)->identical_ept_pointer = tmp_eptp;
> +	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);

It seems we can get away with identical_ept_pointer being just 'bool':
go through the vCPU list and compare ept_pointer with ept_pointer for
the current vcpu. It would also make sense to rename it to something
like 'ept_pointers_match'.

I'm also not sure we need a dedicated ept_pointer_lock, can't we just
use the already existent mmu_lock from struct kvm?

> +}
> +
>  static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
>  {
>  	unsigned long guest_cr3;
> @@ -4967,6 +4994,8 @@ static void vmx_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
>  	if (enable_ept) {
>  		eptp = construct_eptp(vcpu, cr3);
>  		vmcs_write64(EPT_POINTER, eptp);
> +		check_ept_pointer(vcpu, eptp);

Do we always get here when we need? E.g, do we need to enforce
CPU_BASED_CR3_STORE_EXITING?

> +
>  		if (enable_unrestricted_guest || is_paging(vcpu) ||
>  		    is_guest_mode(vcpu))
>  			guest_cr3 = kvm_read_cr3(vcpu);
> @@ -10383,6 +10412,8 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
>
>  static int vmx_vm_init(struct kvm *kvm)
>  {
> +	spin_lock_init(&to_kvm_vmx(kvm)->ept_pointer_lock);
> +
>  	if (!ple_gap)
>  		kvm->arch.pause_in_guest = true;
>  	return 0;

-- 
  Vitaly
