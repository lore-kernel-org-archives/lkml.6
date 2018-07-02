Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1B5C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9965325C76
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9965325C76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030238AbeGBK0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:26:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965239AbeGBK0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEBDA7C6A9;
        Mon,  2 Jul 2018 10:26:29 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDDF52166B5D;
        Mon,  2 Jul 2018 10:26:28 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: X86: Implement PV IPI in linux guest
References: <1530526462-920-1-git-send-email-wanpengli@tencent.com>
        <1530526462-920-2-git-send-email-wanpengli@tencent.com>
Date:   Mon, 02 Jul 2018 12:26:27 +0200
In-Reply-To: <1530526462-920-2-git-send-email-wanpengli@tencent.com> (Wanpeng
        Li's message of "Mon, 2 Jul 2018 18:14:21 +0800")
Message-ID: <87sh52aq7g.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 02 Jul 2018 10:26:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 02 Jul 2018 10:26:29 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
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
>  arch/x86/kernel/kvm.c         | 99 +++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm_para.h |  1 +
>  2 files changed, 100 insertions(+)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 5b2300b..7e3ee25 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -47,6 +47,7 @@
>  #include <asm/hypervisor.h>
>  #include <asm/kvm_guest.h>
>
> +static struct apic orig_apic;
>  static int kvmapf = 1;
>
>  static int __init parse_no_kvmapf(char *arg)
> @@ -454,6 +455,89 @@ static void __init sev_map_percpu_data(void)
>  }
>
>  #ifdef CONFIG_SMP
> +
> +#ifdef CONFIG_X86_64
> +static bool __send_ipi_mask(const struct cpumask *mask, int vector)
> +{
> +	unsigned long flags, ipi_bitmap_low = 0, ipi_bitmap_high = 0, icr = 0;
> +	int cpu, apic_id, ret = 1;
> +
> +	if (cpumask_empty(mask))
> +		return true;
> +
> +	local_irq_save(flags);
> +
> +	for_each_cpu(cpu, mask) {
> +		apic_id = per_cpu(x86_cpu_to_apicid, cpu);
> +		if (apic_id < BITS_PER_LONG)
> +			__set_bit(apic_id, &ipi_bitmap_low);
> +		else if (apic_id < 2 * BITS_PER_LONG)
> +			__set_bit(apic_id - BITS_PER_LONG, &ipi_bitmap_high);
> +		else
> +			goto ipi_mask_done;

Nit:

Both the fact that we don't set 'ret' here and the fact that the label
is named 'ipi_mask_done' -- which sounds like 'all OK' at least to me --
contribute to the feeling that we just skip sending IPIs in some cases.

I would prefer to see something like

else {
   ret = -EFAULT;
   goto irq_restore_exit;
}

> +	}
> +
> +	switch (vector) {
> +	default:
> +		icr = APIC_DM_FIXED | vector;
> +		break;
> +	case NMI_VECTOR:
> +		icr = APIC_DM_NMI;
> +		break;
> +	}
> +
> +	ret = kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, icr);
> +
> +ipi_mask_done:
> +	local_irq_restore(flags);
> +	return ((ret == 0) ? true : false);

... and why in the first place do we need to make this function return
'bool' then? Let's just make it return 'int'.

> +}
> +
> +static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
> +{
> +	if (!__send_ipi_mask(mask, vector))
> +		orig_apic.send_IPI_mask(mask, vector);
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
> +	if (!__send_ipi_mask(local_mask, vector))
> +		orig_apic.send_IPI_mask_allbutself(mask, vector);
> +}
> +
> +static void kvm_send_ipi_allbutself(int vector)
> +{
> +	kvm_send_ipi_mask_allbutself(cpu_online_mask, vector);
> +}
> +
> +static void kvm_send_ipi_all(int vector)
> +{
> +	if (!__send_ipi_mask(cpu_online_mask, vector))
> +		orig_apic.send_IPI_all(vector);
> +}
> +
> +/*
> + * Set the IPI entry points
> + */
> +static void kvm_setup_pv_ipi(void)
> +{
> +	orig_apic = *apic;
> +
> +	apic->send_IPI_mask = kvm_send_ipi_mask;
> +	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
> +	apic->send_IPI_allbutself = kvm_send_ipi_allbutself;
> +	apic->send_IPI_all = kvm_send_ipi_all;
> +	pr_info("KVM setup pv IPIs\n");
> +}
> +#endif
> +
>  static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
>  {
>  	native_smp_prepare_cpus(max_cpus);
> @@ -624,12 +708,27 @@ static uint32_t __init kvm_detect(void)
>  	return kvm_cpuid_base();
>  }
>
> +static void __init kvm_apic_init(void)
> +{
> +#if defined(CONFIG_SMP) && defined(CONFIG_X86_64)
> +	if (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI) &&
> +		num_possible_cpus() <= 2 * BITS_PER_LONG)
> +		kvm_setup_pv_ipi();
> +#endif
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
> +	.init.init_platform	= kvm_init_platform,
>  };
>
>  static __init int activate_jump_labels(void)
> diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
> index dcf629d..7395f38 100644
> --- a/include/uapi/linux/kvm_para.h
> +++ b/include/uapi/linux/kvm_para.h
> @@ -26,6 +26,7 @@
>  #define KVM_HC_MIPS_EXIT_VM		7
>  #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
>  #define KVM_HC_CLOCK_PAIRING		9
> +#define KVM_HC_SEND_IPI			10
>
>  /*
>   * hypercalls use architecture specific

-- 
  Vitaly
