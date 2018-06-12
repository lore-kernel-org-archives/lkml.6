Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67F5AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278EB208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 15:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 278EB208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934323AbeFLPFl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 11:05:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58086 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932803AbeFLPFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 11:05:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B2B881A6D3A;
        Tue, 12 Jun 2018 15:05:40 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79F4420284D6;
        Tue, 12 Jun 2018 15:05:38 +0000 (UTC)
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
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [RFC Patch 3/3] KVM/x86: Add tlb_remote_flush callback support for vmcs
References: <20180604090749.489-1-Tianyu.Lan@microsoft.com>
        <20180604090749.489-4-Tianyu.Lan@microsoft.com>
Date:   Tue, 12 Jun 2018 17:05:37 +0200
In-Reply-To: <20180604090749.489-4-Tianyu.Lan@microsoft.com> (Tianyu Lan's
        message of "Mon, 4 Jun 2018 09:08:34 +0000")
Message-ID: <87lgbkqc3i.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 12 Jun 2018 15:05:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 12 Jun 2018 15:05:40 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <Tianyu.Lan@microsoft.com> writes:

> Register tlb_remote_flush callback for vmcs when hyperv capability of
> nested guest mapping flush is detected. The interface can help to reduce
> overhead when flush ept table among vcpus for nested VM. The tradition way
> is to send IPIs to all affected vcpus and executes INVEPT on each vcpus.
> It will trigger several vmexits for IPI and INVEPT emulation. Hyperv provides
> such hypercall to do flush for all vcpus.
>
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/kvm/vmx.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index e50beb76d846..6cb241c05690 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -4737,6 +4737,17 @@ static inline void __vmx_flush_tlb(struct kvm_vcpu *vcpu, int vpid,
>  	}
>  }
>
> +static int vmx_remote_flush_tlb(struct kvm *kvm)
> +{
> +	struct kvm_vcpu *vcpu = kvm_get_vcpu(kvm, 0);
> +
> +	if (!VALID_PAGE(vcpu->arch.mmu.root_hpa))
> +		return -1;
> +
> +	return hyperv_flush_guest_mapping(construct_eptp(vcpu,
> +		vcpu->arch.mmu.root_hpa));
> +}
> +
>  static void vmx_flush_tlb(struct kvm_vcpu *vcpu, bool invalidate_gpa)
>  {
>  	__vmx_flush_tlb(vcpu, to_vmx(vcpu)->vpid, invalidate_gpa);
> @@ -7495,6 +7506,10 @@ static __init int hardware_setup(void)
>  	if (enable_ept && !cpu_has_vmx_ept_2m_page())
>  		kvm_disable_largepages();
>
> +	if (ms_hyperv.nested_features & HV_X64_NESTED_GUSET_MAPPING_FLUSH
> +	    && enable_ept)
> +		kvm_x86_ops->tlb_remote_flush = vmx_remote_flush_tlb;
> +

You'll need to surround the above with #if IS_ENABLED(CONFIG_HYPERV) as
ms_hyperv is otherwise unavailable.

>  	if (!cpu_has_vmx_ple()) {
>  		ple_gap = 0;
>  		ple_window = 0;

-- 
  Vitaly
