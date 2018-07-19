Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC23C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2871C204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2871C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbeGSRM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:12:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731711AbeGSRM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C759C81A88DE;
        Thu, 19 Jul 2018 16:28:29 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id DAAA0111DCEC;
        Thu, 19 Jul 2018 16:28:27 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 19 Jul 2018 18:28:27 +0200
Date:   Thu, 19 Jul 2018 18:28:27 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 2/6] KVM: X86: Implement PV IPIs in linux guest
Message-ID: <20180719162826.GB11749@flask>
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-3-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1530598891-21370-3-git-send-email-wanpengli@tencent.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 19 Jul 2018 16:28:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 19 Jul 2018 16:28:29 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-03 14:21+0800, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Implement paravirtual apic hooks to enable PV IPIs.
> 
> apic->send_IPI_mask
> apic->send_IPI_mask_allbutself
> apic->send_IPI_allbutself
> apic->send_IPI_all
> 
> The PV IPIs supports maximal 128 vCPUs VM, it is big enough for cloud 
> environment currently, supporting more vCPUs needs to introduce more 
> complex logic, in the future this might be extended if needed.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> @@ -454,6 +454,71 @@ static void __init sev_map_percpu_data(void)
>  }
>  
>  #ifdef CONFIG_SMP
> +
> +#ifdef CONFIG_X86_64
> +static void __send_ipi_mask(const struct cpumask *mask, int vector)
> +{
> +	unsigned long flags, ipi_bitmap_low = 0, ipi_bitmap_high = 0;
> +	int cpu, apic_id;
> +
> +	if (cpumask_empty(mask))
> +		return;
> +
> +	local_irq_save(flags);
> +
> +	for_each_cpu(cpu, mask) {
> +		apic_id = per_cpu(x86_cpu_to_apicid, cpu);
> +		if (apic_id < BITS_PER_LONG)
> +			__set_bit(apic_id, &ipi_bitmap_low);
> +		else if (apic_id < 2 * BITS_PER_LONG)
> +			__set_bit(apic_id - BITS_PER_LONG, &ipi_bitmap_high);

It'd be nicer with 'unsigned long ipi_bitmap[2]' and a single

	__set_bit(apic_id, ipi_bitmap);

> +	}
> +
> +	kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, vector);

and

	kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap[0], ipi_bitmap[1], vector);

Still, the main problem is that we can only address 128 APICs.

A simple improvement would reuse the vector field (as we need only 8
bits) and put a 'offset' in the rest.  The offset would say which
cluster of 128 are we addressing.  24 bits of offset results in 2^31
total addressable CPUs (we probably should even use that many bits).
The downside of this is that we can only address 128 at a time.

It's basically the same as x2apic cluster mode, only with 128 cluster
size instead of 16, so the code should be a straightforward port.
And because x2apic code doesn't seem to use any division by the cluster
size, we could even try to use kvm_hypercall4, add ipi_bitmap[2], and
make the cluster size 192. :)

But because it is very similar to x2apic, I'd really need some real
performance data to see if this benefits a real workload.
Hardware could further optimize LAPIC (apicv, vapic) in the future,
which we'd lose by using paravirt.

e.g. AMD's acceleration should be superior to this when using < 8 VCPUs
as they can use logical xAPIC and send without VM exits (when all VCPUs
are running).

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

These should be faster when using the native APIC shorthand -- is this
the "Broadcast" in your tests?

> +}
> +
> +/*
> + * Set the IPI entry points
> + */
> +static void kvm_setup_pv_ipi(void)
> +{
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
> @@ -626,6 +691,11 @@ static uint32_t __init kvm_detect(void)
>  
>  static void __init kvm_apic_init(void)
>  {
> +#if defined(CONFIG_SMP) && defined(CONFIG_X86_64)
> +	if (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI) &&
> +		num_possible_cpus() <= 2 * BITS_PER_LONG)

It looks that num_possible_cpus() is actually NR_CPUS, so the feature
would never be used on a standard Linux distro.
And we're using APIC_ID, which can be higher even if maximum CPU the
number is lower.  Just remove it.
