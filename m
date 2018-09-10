Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC86C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEAF20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEAF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeIJOe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:34:56 -0400
Received: from foss.arm.com ([217.140.101.70]:53938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbeIJOe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:34:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABF8518A;
        Mon, 10 Sep 2018 02:41:45 -0700 (PDT)
Received: from [10.1.214.36] (unknown [10.1.214.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD6A03F557;
        Mon, 10 Sep 2018 02:41:44 -0700 (PDT)
Subject: Re: [PATCH AUTOSEL 4.18 074/131] ARM: 8783/1: NOMMU: Extend check for
 VBAR support
To:     Sasha Levin <Alexander.Levin@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
 <20180902064601.183036-74-alexander.levin@microsoft.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <bb9d354b-6a8f-529e-3e62-0d250b967b1a@arm.com>
Date:   Mon, 10 Sep 2018 10:41:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180902064601.183036-74-alexander.levin@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/18 14:04, Sasha Levin wrote:
> From: Vladimir Murzin <vladimir.murzin@arm.com>
> 
> [ Upstream commit c803ce3f18bd93b3b4a15d1da0c5b5ebc60e0b85 ]
> 
> ARMv8R adds support for VBAR and updates ID_PFR1 with the new filed
> Sec_frac (bits [23:20]):
> 
> Security fractional field. When the Security field is 0000, determines
> the support for features from the ARMv7 Security Extensions. Permitted
> values are:
> 
> 0000 No features from the ARMv7 Security Extensions are implemented.
>      This value is not supported in ARMv8 if ID_PFR1 bits [7:4] are zero.
> 
> 0001 The implementation includes the VBAR, and the TCR.PD0 and TCR.PD1
>      bits.
> 
> 0010 As for 0001, plus the ability to access Secure or Non-secure
>      physical memory is supported.
> 
> All other values are reserved.
> 
> This field is only valid when ID_PFR1[7:4] == 0, otherwise it holds
> the value 0000.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  arch/arm/mm/nommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> index 5dd6c58d653b..7d67c70bbded 100644
> --- a/arch/arm/mm/nommu.c
> +++ b/arch/arm/mm/nommu.c
> @@ -53,7 +53,8 @@ static inline bool security_extensions_enabled(void)
>  {
>  	/* Check CPUID Identification Scheme before ID_PFR1 read */
>  	if ((read_cpuid_id() & 0x000f0000) == 0x000f0000)
> -		return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
> +		return cpuid_feature_extract(CPUID_EXT_PFR1, 4) ||
> +			cpuid_feature_extract(CPUID_EXT_PFR1, 20);
>  	return 0;
>  }
>  
> 

NAK - it is not stable material.

Thanks
Vladimir
