Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0134C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C7823C45
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C7823C45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934089AbeGDJNs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:13:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932648AbeGDJNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:13:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10AF840704A7;
        Wed,  4 Jul 2018 09:13:43 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F3BB1C59E;
        Wed,  4 Jul 2018 09:13:39 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kys@linuxonhyperv.com
Cc:     x86@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, kys@microsoft.com
Subject: Re: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI enlightenment.
References: <20180703230155.15160-1-kys@linuxonhyperv.com>
Date:   Wed, 04 Jul 2018 11:13:38 +0200
In-Reply-To: <20180703230155.15160-1-kys@linuxonhyperv.com>
        (kys@linuxonhyperv.com's message of "Tue, 3 Jul 2018 16:01:55 -0700")
Message-ID: <87bmbnbby5.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 09:13:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 09:13:43 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kys@linuxonhyperv.com writes:

> From: "K. Y. Srinivasan" <kys@microsoft.com>
>
> The IPI hypercalls depend on being able to map the Linux notion of CPU ID
> to the hypervisor's notion of the CPU ID. The array hv_vp_index[] provides
> this mapping. Code for populating this array depends on the IPI functionality.
> Break this circular dependency.
>
> Fixes: 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")
>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Tested-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/x86/hyperv/hv_apic.c       | 5 +++++
>  arch/x86/hyperv/hv_init.c       | 5 ++++-
>  arch/x86/include/asm/mshyperv.h | 2 ++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index f68855499391..63d7c196739f 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -114,6 +114,8 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
>  		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
>  		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
>  	}
> +	if (nr_bank == -1)
> +		goto ipi_mask_ex_done;
>  	if (!nr_bank)
>  		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;
>
> @@ -158,6 +160,9 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector)
>
>  	for_each_cpu(cur_cpu, mask) {
>  		vcpu = hv_cpu_number_to_vp_number(cur_cpu);
> +		if (vcpu == -1)
> +			goto ipi_mask_done;
> +

Nit: hv_vp_index is u32 *, it would make sense to use U32_MAX instead of
'-1' everywhere in this patch.

>  		/*
>  		 * This particular version of the IPI hypercall can
>  		 * only target upto 64 CPUs.
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 4c431e1c1eff..04159893702e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -265,7 +265,7 @@ void __init hyperv_init(void)
>  {
>  	u64 guest_id, required_msrs;
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
> -	int cpuhp;
> +	int cpuhp, i;
>
>  	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
>  		return;
> @@ -293,6 +293,9 @@ void __init hyperv_init(void)
>  	if (!hv_vp_index)
>  		return;
>
> +	for (i = 0; i < num_possible_cpus(); i++)
> +		hv_vp_index[i] = -1;
> +
>  	hv_vp_assist_page = kcalloc(num_possible_cpus(),
>  				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
>  	if (!hv_vp_assist_page) {
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 3cd14311edfa..dee3f7347253 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -281,6 +281,8 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
>  	 */
>  	for_each_cpu(cpu, cpus) {
>  		vcpu = hv_cpu_number_to_vp_number(cpu);
> +		if (vcpu == -1)
> +			return -1;
>  		vcpu_bank = vcpu / 64;
>  		vcpu_offset = vcpu % 64;
>  		__set_bit(vcpu_offset, (unsigned long *)

-- 
  Vitaly
