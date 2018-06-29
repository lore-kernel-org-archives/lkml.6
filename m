Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D6FC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC416249BF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC416249BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935094AbeF2KKW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:10:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751901AbeF2KKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:10:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4767D818F042;
        Fri, 29 Jun 2018 10:10:20 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63B872156700;
        Fri, 29 Jun 2018 10:10:19 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH 1/2] KVM: X86: Implement PV IPI in linux guest
References: <1530265876-18136-1-git-send-email-wanpengli@tencent.com>
        <1530265876-18136-2-git-send-email-wanpengli@tencent.com>
Date:   Fri, 29 Jun 2018 12:10:18 +0200
In-Reply-To: <1530265876-18136-2-git-send-email-wanpengli@tencent.com>
        (Wanpeng Li's message of "Fri, 29 Jun 2018 17:51:15 +0800")
Message-ID: <877emhewdx.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 29 Jun 2018 10:10:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 29 Jun 2018 10:10:20 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Implement PV IPIs in guest kernel.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/include/uapi/asm/kvm_para.h |  1 +
>  arch/x86/kernel/kvm.c                | 63 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 0ede697..19980ec 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -28,6 +28,7 @@
>  #define KVM_FEATURE_PV_UNHALT		7
>  #define KVM_FEATURE_PV_TLB_FLUSH	9
>  #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
> +#define KVM_FEATURE_PV_SEND_IPI	11
>
>  #define KVM_HINTS_REALTIME      0
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 5b2300b..b4f8dc3 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -454,6 +454,57 @@ static void __init sev_map_percpu_data(void)
>  }
>
>  #ifdef CONFIG_SMP
> +
> +static void __send_ipi_mask(const struct cpumask *mask, int vector)
> +{
> +	unsigned long flags, ipi_bitmap = 0;
> +	int cpu;
> +
> +	local_irq_save(flags);
> +
> +	for_each_cpu(cpu, mask)
> +		__set_bit(per_cpu(x86_cpu_to_apicid, cpu), &ipi_bitmap);

We need a protection against per_cpu(x86_cpu_to_apicid, cpu) > here.

> +	kvm_hypercall2(KVM_HC_SEND_IPI, ipi_bitmap, vector);
> +
> +	local_irq_restore(flags);
> +}
> +
> +static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
> +{
> +	__send_ipi_mask(mask, vector);
> +}
> +
> +static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
> +{
> +	unsigned int this_cpu = smp_processor_id();
> +	struct cpumask new_mask;
> +	const struct cpumask *local_mask;
> +
> +	cpumask_copy(&new_mask, mask);
> +	cpumask_clear_cpu(this_cpu, &new_mask);
> +	local_mask = &new_mask;
> +	__send_ipi_mask(local_mask, vector);
> +}
> +
> +static void kvm_send_ipi_allbutself(int vector)
> +{
> +	kvm_send_ipi_mask_allbutself(cpu_online_mask, vector);
> +}
> +
> +static void kvm_send_ipi_all(int vector)
> +{
> +	__send_ipi_mask(cpu_online_mask, vector);
> +}
> +
> +static void kvm_setup_pv_ipi(void)
> +{
> +	apic->send_IPI_mask = kvm_send_ipi_mask;
> +	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
> +	apic->send_IPI_allbutself = kvm_send_ipi_allbutself;
> +	apic->send_IPI_all = kvm_send_ipi_all;
> +	printk("KVM setup pv IPIs\n");
> +}
> +
>  static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	native_smp_prepare_cpus(max_cpus);
> @@ -624,12 +675,24 @@ static uint32_t __init kvm_detect(void)
>  	return kvm_cpuid_base();
>  }
>
> +static void __init kvm_apic_init(void)
> +{
> +	if (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI))
> +		kvm_setup_pv_ipi();
> +}
> +
> +static void __init kvm_init_platform(void)
> +{
> +	x86_platform.apic_post_init = kvm_apic_init;
> +}
> +
>  const __initconst struct hypervisor_x86 x86_hyper_kvm = {
>  	.name			= "KVM",
>  	.detect			= kvm_detect,
>  	.type			= X86_HYPER_KVM,
>  	.init.guest_late_init	= kvm_guest_init,
>  	.init.x2apic_available	= kvm_para_available,
> +	.init.init_platform 	= kvm_init_platform,
>  };
>
>  static __init int activate_jump_labels(void)

-- 
  Vitaly
