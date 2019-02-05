Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96F9C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947162083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfBESeH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:34:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35695 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbfBESeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:34:06 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7AD41811DB;
        Tue,  5 Feb 2019 18:34:06 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5438560BE8;
        Tue,  5 Feb 2019 18:34:05 +0000 (UTC)
Date:   Tue, 5 Feb 2019 11:34:04 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "jsteckli@amazon.de" <jsteckli@amazon.de>,
        "sironi@amazon.de" <sironi@amazon.de>,
        "wawei@amazon.de" <wawei@amazon.de>
Subject: Re: [RFC PATCH 8/8] svm: Allow AVIC with in-kernel irqchip mode
Message-ID: <20190205113404.5c5382e6@w520.home>
In-Reply-To: <20190204144128.9489-9-suravee.suthikulpanit@amd.com>
References: <20190204144128.9489-1-suravee.suthikulpanit@amd.com>
        <20190204144128.9489-9-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 05 Feb 2019 18:34:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 14:42:32 +0000
"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com> wrote:

> Once the IRQ ack notifier for in-kernel PIT is no longer required
> and run-time AVIC activate/deactivate is supported, we can remove
> the kernel irqchip split mode requirement for AVIC.
> 
> Hence, remove the check for irqchip split mode when enabling AVIC.

Yay!  Could we also at this point make avic enabled by default or are
there remaining incompatibilities?  Thanks,

Alex


> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/svm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 580ab40ba207..24dfa6a93711 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5157,7 +5157,7 @@ static void svm_set_virtual_apic_mode(struct kvm_vcpu *vcpu)
>  
>  static bool svm_get_enable_apicv(struct kvm_vcpu *vcpu)
>  {
> -	return avic && irqchip_split(vcpu->kvm);
> +	return avic;
>  }
>  
>  static void svm_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr)

