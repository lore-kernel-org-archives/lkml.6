Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124E1C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B694A21501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B694A21501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbeHBOwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:52:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387454AbeHBOwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:52:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3EBD7A7EE;
        Thu,  2 Aug 2018 13:01:46 +0000 (UTC)
Received: from [10.36.117.197] (ovpn-117-197.ams2.redhat.com [10.36.117.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB62B2026D69;
        Thu,  2 Aug 2018 13:01:45 +0000 (UTC)
Subject: Re: [PATCH v5 3/6] KVM: X86: Fallback to original apic hooks when bad
 happens
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <1532327996-17619-1-git-send-email-wanpengli@tencent.com>
 <1532327996-17619-4-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1059c3b2-3c4a-4218-eee2-d6fc748b99db@redhat.com>
Date:   Thu, 2 Aug 2018 15:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532327996-17619-4-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 13:01:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 02 Aug 2018 13:01:47 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pbonzini@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/2018 08:39, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Fallback to original apic hooks when unlikely kvm fails to add the
> pending IRQ to lapic.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kernel/kvm.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index eed6046..57eb4a2 100644
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
> @@ -454,10 +455,10 @@ static void __init sev_map_percpu_data(void)
>  }
>  
>  #ifdef CONFIG_SMP
> -static void __send_ipi_mask(const struct cpumask *mask, int vector)
> +static int __send_ipi_mask(const struct cpumask *mask, int vector)
>  {
>  	unsigned long flags;
> -	int cpu, apic_id, min = 0, max = 0;
> +	int cpu, apic_id, min = 0, max = 0, ret = 0;
>  #ifdef CONFIG_X86_64
>  	__uint128_t ipi_bitmap = 0;
>  	int cluster_size = 128;
> @@ -467,7 +468,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>  #endif
>  
>  	if (cpumask_empty(mask))
> -		return;
> +		return 0;
>  
>  	local_irq_save(flags);
>  
> @@ -481,7 +482,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>  		} else if (apic_id < min + cluster_size) {
>  			max = apic_id < max ? max : apic_id;
>  		} else {
> -			kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
> +			ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
>  				(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, vector);
>  			min = max = apic_id;
>  			ipi_bitmap = 0;
> @@ -490,11 +491,12 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>  	}
>  
>  	if (ipi_bitmap) {
> -		kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
> +		ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
>  			(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, vector);
>  	}
>  
>  	local_irq_restore(flags);
> +	return ret;
>  }
>  
>  static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
> @@ -511,7 +513,8 @@ static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
>  	cpumask_copy(&new_mask, mask);
>  	cpumask_clear_cpu(this_cpu, &new_mask);
>  	local_mask = &new_mask;
> -	__send_ipi_mask(local_mask, vector);
> +	if (__send_ipi_mask(local_mask, vector))
> +		orig_apic.send_IPI_mask_allbutself(mask, vector);
>  }
>  
>  static void kvm_send_ipi_allbutself(int vector)
> @@ -521,7 +524,8 @@ static void kvm_send_ipi_allbutself(int vector)
>  
>  static void kvm_send_ipi_all(int vector)
>  {
> -	__send_ipi_mask(cpu_online_mask, vector);
> +	if (__send_ipi_mask(cpu_online_mask, vector))
> +		orig_apic.send_IPI_all(vector);
>  }
>  
>  /*
> @@ -529,6 +533,8 @@ static void kvm_send_ipi_all(int vector)
>   */
>  static void kvm_setup_pv_ipi(void)
>  {
> +	orig_apic = *apic;
> +
>  	apic->send_IPI_mask = kvm_send_ipi_mask;
>  	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
>  	apic->send_IPI_allbutself = kvm_send_ipi_allbutself;
> 

Is this actually needed?

Paolo
