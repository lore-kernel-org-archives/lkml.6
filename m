Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22462C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CDA2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CDA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbeIYQGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:06:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbeIYQG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 12:06:29 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 804DF3082138;
        Tue, 25 Sep 2018 09:59:43 +0000 (UTC)
Received: from [10.36.117.173] (ovpn-117-173.ams2.redhat.com [10.36.117.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28C2E19487;
        Tue, 25 Sep 2018 09:59:38 +0000 (UTC)
Subject: Re: [PATCH v5 15/18] kvm: arm64: Add 52bit support for PAR to HPFAR
 conversoin
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, dave.martin@arm.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-16-suzuki.poulose@arm.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <b6929b5d-e797-6922-a5d2-3a1ded517e1a@redhat.com>
Date:   Tue, 25 Sep 2018 11:59:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180917104144.19188-16-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 25 Sep 2018 09:59:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 9/17/18 12:41 PM, Suzuki K Poulose wrote:
> Add support for handling 52bit addresses in PAR to HPFAR
> conversion. Instead of hardcoding the address limits, we
> now use PHYS_MASK_SHIFT.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  arch/arm64/include/asm/kvm_arm.h | 7 +++++++
>  arch/arm64/kvm/hyp/switch.c      | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 0a37c0513ede..241d1622fa19 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -308,6 +308,13 @@
>  
>  /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
>  #define HPFAR_MASK	(~UL(0xf))
> +/*
> + * We have
> + *	PAR	[PA_Shift - 1	: 12] = PA	[PA_Shift - 1 : 12]
> + *	HPFAR	[PA_Shift - 9	: 4]  = FIPA	[PA_Shift - 1 : 12]
> + */
> +#define PAR_TO_HPFAR(par)		\
> +	(((par) & GENMASK_ULL(PHYS_MASK_SHIFT - 1, 12)) >> 8)
>  
>  #define kvm_arm_exception_type	\
>  	{0, "IRQ" }, 		\
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 9d5ce1a3039a..7cc175c88a37 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -263,7 +263,7 @@ static bool __hyp_text __translate_far_to_hpfar(u64 far, u64 *hpfar)
>  		return false; /* Translation failed, back to guest */
>  
>  	/* Convert PAR to HPFAR format */
> -	*hpfar = ((tmp >> 12) & ((1UL << 36) - 1)) << 4;
> +	*hpfar = PAR_TO_HPFAR(tmp);
>  	return true;
>  }
>  
> 
