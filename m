Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CECC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474A5244AB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474A5244AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934981AbeF2KKB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:10:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932085AbeF2KJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:09:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4471C4059FEC;
        Fri, 29 Jun 2018 10:09:59 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ABB72156700;
        Fri, 29 Jun 2018 10:09:58 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 2/2] KVM: X86: Implement PV send IPI support
References: <1530265876-18136-1-git-send-email-wanpengli@tencent.com>
        <1530265876-18136-3-git-send-email-wanpengli@tencent.com>
Date:   Fri, 29 Jun 2018 12:09:57 +0200
In-Reply-To: <1530265876-18136-3-git-send-email-wanpengli@tencent.com>
        (Wanpeng Li's message of "Fri, 29 Jun 2018 17:51:16 +0800")
Message-ID: <878t6xewei.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 29 Jun 2018 10:09:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 29 Jun 2018 10:09:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Using hypercall to send IPIs by one vmexit instead of one by one for
> xAPIC/x2APIC physical mode and one vmexit per-cluster for x2APIC cluster 
> mode. 
>
> Even if enable qemu interrupt remapping and PV TLB Shootdown, I can still 
> observe ~14% performance boost by ebizzy benchmark for 64 vCPUs VM, the 
> total msr-induced vmexits reduce ~70%.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  Documentation/virtual/kvm/cpuid.txt |  4 ++++
>  arch/x86/kvm/cpuid.c                |  3 ++-
>  arch/x86/kvm/x86.c                  | 25 +++++++++++++++++++++++++
>  include/uapi/linux/kvm_para.h       |  1 +
>  4 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
> index ab022dc..d72359f 100644
> --- a/Documentation/virtual/kvm/cpuid.txt
> +++ b/Documentation/virtual/kvm/cpuid.txt
> @@ -62,6 +62,10 @@ KVM_FEATURE_ASYNC_PF_VMEXIT        ||    10 || paravirtualized async PF VM exit
>                                     ||       || can be enabled by setting bit 2
>                                     ||       || when writing to msr 0x4b564d02
>  ------------------------------------------------------------------------------
> +KVM_FEATURE_PV_SEND_IPI            ||    11 || guest checks this feature bit
> +                                   ||       || before enabling paravirtualized
> +                                   ||       || send IPIs.

In case we decide to apply this as-is we'll likely need a new feature
for PV IPI with > 64 vCPUs (or how else would the guest know if the host
is capable or not?)

> +------------------------------------------------------------------------------
>  KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
>                                     ||       || per-cpu warps are expected in
>                                     ||       || kvmclock.
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 7e042e3..7bcfa61 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -621,7 +621,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
>  			     (1 << KVM_FEATURE_CLOCKSOURCE_STABLE_BIT) |
>  			     (1 << KVM_FEATURE_PV_UNHALT) |
>  			     (1 << KVM_FEATURE_PV_TLB_FLUSH) |
> -			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT);
> +			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT) |
> +			     (1 << KVM_FEATURE_PV_SEND_IPI);
>
>  		if (sched_info_on())
>  			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0046aa7..c2e6cdb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6689,6 +6689,27 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
>  	kvm_irq_delivery_to_apic(kvm, NULL, &lapic_irq, NULL);
>  }
>
> +static void kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap, u8 vector)
> +{
> +	struct kvm_apic_map *map;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_lapic_irq lapic_irq = {0};
> +	int i;
> +
> +	lapic_irq.delivery_mode = APIC_DM_FIXED;
> +	lapic_irq.vector = vector;
> +
> +	rcu_read_lock();
> +	map = rcu_dereference(kvm->arch.apic_map);
> +
> +	for_each_set_bit(i, &ipi_bitmap, sizeof(unsigned long)) {
> +		vcpu = map->phys_map[i]->vcpu;
> +		kvm_apic_set_irq(vcpu, &lapic_irq, NULL);
> +	}
> +
> +	rcu_read_unlock();
> +}
> +
>  void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu)
>  {
>  	vcpu->arch.apicv_active = false;
> @@ -6738,6 +6759,10 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>  		ret = kvm_pv_clock_pairing(vcpu, a0, a1);
>  		break;
>  #endif
> +	case KVM_HC_SEND_IPI:
> +		kvm_pv_send_ipi(vcpu->kvm, a0, a1);
> +		ret = 0;
> +		break;
>  	default:
>  		ret = -KVM_ENOSYS;
>  		break;
> diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
> index dcf629d..7395f38 100644
> --- a/include/uapi/linux/kvm_para.h
> +++ b/include/uapi/linux/kvm_para.h
> @@ -26,6 +26,7 @@
>  #define KVM_HC_MIPS_EXIT_VM		7
>  #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
>  #define KVM_HC_CLOCK_PAIRING		9
> +#define KVM_HC_SEND_IPI         	10
>
>  /*
>   * hypercalls use architecture specific

-- 
  Vitaly
