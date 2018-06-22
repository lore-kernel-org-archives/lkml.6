Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDC8C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AB524715
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AB524715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934069AbeFVSQJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:16:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933585AbeFVSQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:16:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF04987AAC;
        Fri, 22 Jun 2018 18:16:07 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1F12E2026D6C;
        Fri, 22 Jun 2018 18:16:04 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 22 Jun 2018 20:16:04 +0200
Date:   Fri, 22 Jun 2018 20:16:04 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     KVM <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] x86/kvm: Handle all MCA banks
Message-ID: <20180622181603.GB5549@flask>
References: <20180622095101.32587-1-bp@alien8.de>
 <20180622095101.32587-4-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622095101.32587-4-bp@alien8.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 22 Jun 2018 18:16:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 22 Jun 2018 18:16:07 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-22 11:51+0200, Borislav Petkov:
> From: Borislav Petkov <bp@suse.de>
> 
> Extend the range of MCA banks which get passed to set/get_msr_mce() to
> include all the MSRs of the last bank too.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kvm/x86.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 80452b0f0e8c..a7d344823356 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2466,7 +2466,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  
>  	case MSR_IA32_MCG_CTL:
>  	case MSR_IA32_MCG_STATUS:
> -	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_CTL(KVM_MAX_MCE_BANKS) - 1:
> +	case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_MISC(KVM_MAX_MCE_BANKS) - 1:

It was correct before.  We have 32 banks (KVM_MAX_MCE_BANKS), so the
last useable has index 31 and the "- 1" is going to roll over from first
MSR of bank 32 to the last MSR of the last bank.

Another way of writing it would be:

 case MSR_IA32_MC0_CTL ... MSR_IA32_MCx_MISC(KVM_MAX_MCE_BANKS - 1):

>  		return set_msr_mce(vcpu, msr_info);
>  
>  	case MSR_K7_PERFCTR0 ... MSR_K7_PERFCTR3:
> @@ -2588,9 +2588,10 @@ static int get_msr_mce(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata)
>  	case MSR_IA32_MCG_STATUS:
>  		data = vcpu->arch.mcg_status;
>  		break;
> +
>  	default:
>  		if (msr >= MSR_IA32_MC0_CTL &&
> -		    msr < MSR_IA32_MCx_CTL(bank_num)) {
> +		    msr < MSR_IA32_MCx_MISC(bank_num)) {

Similar logic here.

I think it would be best just to keep the current code,

thanks.
