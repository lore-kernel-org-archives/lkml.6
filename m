Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060D8C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68F620880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfAUPzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:55:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbfAUPzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:55:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BD4FC0669B9;
        Mon, 21 Jan 2019 15:55:49 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 220E45D971;
        Mon, 21 Jan 2019 15:55:47 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        x86@kernel.org
Subject: Re: [PATCH] KVM: nSVM: clear events pending from svm_complete_interrupts() when exiting to L1
In-Reply-To: <20190107184451.17749-1-vkuznets@redhat.com>
References: <20190107184451.17749-1-vkuznets@redhat.com>
Date:   Mon, 21 Jan 2019 16:55:46 +0100
Message-ID: <87d0oq2ef1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 21 Jan 2019 15:55:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> kvm-unit-tests' eventinj "NMI failing on IDT" test results in NMI being
> delivered to the host (L1) when it's running nested. The problem seems to
> be: svm_complete_interrupts() raises 'nmi_injected' flag but later we
> decide to reflect EXIT_NPF to L1. The flag remains pending and we do NMI
> injection upon entry so it got delivered to L1 instead of L2.
>
> It seems that VMX code solves the same issue in prepare_vmcs12(), this was
> introduced with code refactoring in commit 5f3d5799974b ("KVM: nVMX: Rework
> event injection and recovery").
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/svm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 33d4ed6e78a5..db842dafccf0 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -3419,6 +3419,14 @@ static int nested_svm_vmexit(struct vcpu_svm *svm)
>  	kvm_mmu_reset_context(&svm->vcpu);
>  	kvm_mmu_load(&svm->vcpu);
>  
> +	/*
> +	 * Drop what we picked up for L2 via svm_complete_interrupts() so it
> +	 * doesn't end up in L1.
> +	 */
> +	svm->vcpu.arch.nmi_injected = false;
> +	kvm_clear_exception_queue(&svm->vcpu);
> +	kvm_clear_interrupt_queue(&svm->vcpu);
> +
>  	return 0;
>  }

Ping?

-- 
Vitaly
