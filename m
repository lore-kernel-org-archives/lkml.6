Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186EFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5F321905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389563AbeLTUGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:06:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387436AbeLTUGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:06:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D9E83F731;
        Thu, 20 Dec 2018 20:06:36 +0000 (UTC)
Received: from flask (unknown [10.43.2.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id 98CAD5C1B2;
        Thu, 20 Dec 2018 20:06:31 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Thu, 20 Dec 2018 21:06:30 +0100
Date:   Thu, 20 Dec 2018 21:06:30 +0100
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org
Subject: Re: [PATCH] KVM: x86: svm: report MSR_IA32_MCG_EXT_CTL as unsupported
Message-ID: <20181220200630.GC25497@flask>
References: <20181219110613.24459-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219110613.24459-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 20 Dec 2018 20:06:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-12-19 12:06+0100, Vitaly Kuznetsov:
> AMD doesn't seem to implement MSR_IA32_MCG_EXT_CTL and svm code in kvm
> knows nothing about it, however, this MSR is among emulated_msrs and
> thus returned with KVM_GET_MSR_INDEX_LIST. The consequent KVM_GET_MSRS,
> of course, fails.
> 
> Report the MSR as unsupported to not confuse userspace.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/svm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 2acb42b74a51..dfdf7d0b7f88 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5845,6 +5845,13 @@ static bool svm_cpu_has_accelerated_tpr(void)
>  
>  static bool svm_has_emulated_msr(int index)
>  {
> +	switch (index) {
> +	case MSR_IA32_MCG_EXT_CTL:
> +		return false;
> +	default:
> +		break;

Queued, thanks.

Btw, I would prefer this without the

  default: break;

as I don't think we'll ever add something there.
