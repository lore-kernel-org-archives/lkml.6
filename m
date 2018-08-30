Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458A4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9012082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9012082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeH3PDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:03:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728180AbeH3PDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:03:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 618F340216E6;
        Thu, 30 Aug 2018 11:01:25 +0000 (UTC)
Received: from flask (unknown [10.40.205.185])
        by smtp.corp.redhat.com (Postfix) with SMTP id C519010FD283;
        Thu, 30 Aug 2018 11:01:22 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 30 Aug 2018 13:01:21 +0200
Date:   Thu, 30 Aug 2018 13:01:21 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] KVM: LAPIC: Fix pv ipis out-of-bounds access
Message-ID: <20180830110121.GB19438@flask>
References: <1535594610-9095-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1535594610-9095-1-git-send-email-wanpengli@tencent.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 30 Aug 2018 11:01:25 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 30 Aug 2018 11:01:25 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-30 10:03+0800, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Dan Carpenter reported that the untrusted data returns from kvm_register_read()
> results in the following static checker warning:
>   arch/x86/kvm/lapic.c:576 kvm_pv_send_ipi()
>   error: buffer underflow 'map->phys_map' 's32min-s32max'
> 
> KVM guest can easily trigger this by executing the following assembly sequence 
> in Ring0:
> 
> mov $10, %rax
> mov $0xFFFFFFFF, %rbx
> mov $0xFFFFFFFF, %rdx
> mov $0, %rsi
> vmcall
> 
> As this will cause KVM to execute the following code-path:
> vmx_handle_exit() -> handle_vmcall() -> kvm_emulate_hypercall() -> kvm_pv_send_ipi()
> which will reach out-of-bounds access.
> 
> This patch fixes it by adding a check to kvm_pv_send_ipi() against map->max_apic_id, 
> ignoring destinations that are not present and delivering the rest. We also check 
> whether or not map->phys_map[min + i] is NULL since the max_apic_id is set to the 
> max apic id, some phys_map maybe NULL when apic id is sparse, especially kvm 
> unconditionally set max_apic_id to 255 to reserve enough space for any xAPIC ID.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Liran Alon <liran.alon@oracle.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * add min > map->max_apic_id check
>  * change min to u32
>  * add min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> @@ -548,7 +548,7 @@ int kvm_apic_set_irq(struct kvm_vcpu *vcpu, struct kvm_lapic_irq *irq,
>  }
>  
>  int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
> -    		    unsigned long ipi_bitmap_high, int min,
> +		    unsigned long ipi_bitmap_high, u32 min,
>  		    unsigned long icr, int op_64_bit)
>  {
>  	int i;
> @@ -571,18 +571,27 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
>  	rcu_read_lock();
>  	map = rcu_dereference(kvm->arch.apic_map);
>  
> +	if (min > map->max_apic_id)
> +		goto out;
>  	/* Bits above cluster_size are masked in the caller.  */
> -	for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
> -		vcpu = map->phys_map[min + i]->vcpu;
> -		count += kvm_apic_set_irq(vcpu, &irq, NULL);
> +	for_each_set_bit(i, &ipi_bitmap_low,
> +		min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))) {
> +		if (map->phys_map[min + i]) {
> +			vcpu = map->phys_map[min + i]->vcpu;
> +			count += kvm_apic_set_irq(vcpu, &irq, NULL);
> +		}
>  	}
>  
>  	min += cluster_size;

We need a second

  if (min > map->max_apic_id)
  	goto out;

here.  I will add it while applying if there are no other change
requests.

> -	for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
> -		vcpu = map->phys_map[min + i]->vcpu;
> -		count += kvm_apic_set_irq(vcpu, &irq, NULL);
> +	for_each_set_bit(i, &ipi_bitmap_high,
> +		min((u32)BITS_PER_LONG, (map->max_apic_id - min + 1))) {
> +		if (map->phys_map[min + i]) {
> +			vcpu = map->phys_map[min + i]->vcpu;
> +			count += kvm_apic_set_irq(vcpu, &irq, NULL);
> +		}
>  	}
>  
> +out:
>  	rcu_read_unlock();
>  	return count;
>  }
> -- 
> 2.7.4
> 
