Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8C9C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4F32477D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4F32477D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934290AbeFVSwo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:52:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934079AbeFVSwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:52:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E1AF8D753;
        Fri, 22 Jun 2018 18:52:41 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2B3E62156889;
        Fri, 22 Jun 2018 18:52:39 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 22 Jun 2018 20:52:38 +0200
Date:   Fri, 22 Jun 2018 20:52:38 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     KVM <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] x86/kvm: Implement MSR_HWCR support
Message-ID: <20180622185237.GC5549@flask>
References: <20180622095101.32587-1-bp@alien8.de>
 <20180622095101.32587-3-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622095101.32587-3-bp@alien8.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 22 Jun 2018 18:52:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 22 Jun 2018 18:52:41 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-06-22 11:51+0200, Borislav Petkov:
> From: Borislav Petkov <bp@suse.de>
> 
> The hardware configuration register has some useful bits which can be
> used by guests. Implement McStatusWrEn which can be used by guests when
> injecting MCEs with the in-kernel mce-inject module.
> 
> For that, we need to set bit 18 - McStatusWrEn - first, before writing
> the MCi_STATUS registers (otherwise we #GP).
> 
> Add the required machinery to do so.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> @@ -2146,6 +2146,30 @@ static void kvmclock_sync_fn(struct work_struct *work)
>  					KVMCLOCK_SYNC_PERIOD);
>  }
>  
> +/*
> + * On AMD, HWCR[McStatusWrEn] controls whether setting MCi_STATUS results in #GP.
> + */
> +static bool __set_mci_status(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> +{
> +	if (guest_cpuid_is_amd(vcpu)) {
> +		struct msr_data tmp;
> +
> +		tmp.index = MSR_K7_HWCR;
> +
> +		if (kvm_x86_ops->get_msr(vcpu, &tmp))
> +			return false;
> +
> +		/* McStatusWrEn enabled? */
> +		if (tmp.data & BIT_ULL(18))
> +			return true;
> +	}
> +
> +	if (!msr_info->host_initiated && msr_info->data != 0)
> +		return false;

msr_info->host_initiated is always going to return true, so it would be
better to put it outside of __set_mci_status.

Maybe we could just write the whole logic inline, otherwise I'd call it
something like mci_status_is_writeable.

>  static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  {
>  	u64 mcg_cap = vcpu->arch.mcg_cap;
> @@ -2176,9 +2200,13 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			if ((offset & 0x3) == 0 &&
>  			    data != 0 && (data | (1 << 10)) != ~(u64)0)
>  				return -1;
> -			if (!msr_info->host_initiated &&
> -				(offset & 0x3) == 1 && data != 0)
> -				return -1;
> +
> +			/* MCi_STATUS */
> +			if ((offset & 0x3) == 1) {
> +				if (!__set_mci_status(vcpu, msr_info))
> +					return -1;
> +			}

			if (!msr_info->host_initiated &&
			    (offset & 0x3) == 1 && data != 0) {
				struct msr_data tmp = {.index = MSR_K7_HWCR};

				if (!guest_cpuid_is_amd(vcpu) ||
				    !kvm_x86_ops->get_msr(vcpu, &tmp) ||
				    !(tmp.data & BIT_ULL(18)))
					return -1;
			}

> +
>  			vcpu->arch.mce_banks[offset] = data;
>  			break;
>  		}
> -- 
> 2.17.0.582.gccdcbd54c
> 
