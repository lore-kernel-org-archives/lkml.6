Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48461C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08683204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08683204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbeGSRPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:15:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731661AbeGSRPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:15:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0811840252ED;
        Thu, 19 Jul 2018 16:31:42 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 156FC111DCE5;
        Thu, 19 Jul 2018 16:31:39 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 19 Jul 2018 18:31:39 +0200
Date:   Thu, 19 Jul 2018 18:31:39 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 5/6] KVM: X86: Add NMI support to PV IPIs
Message-ID: <20180719163138.GC11749@flask>
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-6-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1530598891-21370-6-git-send-email-wanpengli@tencent.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 19 Jul 2018 16:31:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 19 Jul 2018 16:31:42 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-03 14:21+0800, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> The NMI delivery mode of ICR is used to deliver an NMI to the processor, 
> and the vector information is ignored.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> @@ -479,7 +479,16 @@ static int __send_ipi_mask(const struct cpumask *mask, int vector)
>  		}
>  	}
>  
> -	ret = kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, vector);
> +	switch (vector) {
> +	default:
> +		icr = APIC_DM_FIXED | vector;
> +		break;
> +	case NMI_VECTOR:
> +		icr = APIC_DM_NMI;

I think it would be better to say that KVM interprets NMI_VECTOR and
sends the interrupt as APIC_DM_NMI.

> +		break;
> +	}
> +
> +	ret = kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, icr);
>  
