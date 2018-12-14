Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4745C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDA020879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDA020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbeLNKef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:34:35 -0500
Received: from foss.arm.com ([217.140.101.70]:48610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNKef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:34:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A99DA78;
        Fri, 14 Dec 2018 02:34:34 -0800 (PST)
Received: from [10.1.196.55] (e112269-lin.cambridge.arm.com [10.1.196.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAE133F614;
        Fri, 14 Dec 2018 02:34:32 -0800 (PST)
Subject: Re: [PATCH 5/6] arm64: add sysfs vulnerability show for speculative
 store bypass
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de, dave.martin@arm.com,
        shankerd@codeaurora.org
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-6-jeremy.linton@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <901bdfff-df83-846f-1695-a89e8bbfa787@arm.com>
Date:   Fri, 14 Dec 2018 10:34:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181206234408.1287689-6-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 23:44, Jeremy Linton wrote:
> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> 
> Return status based no ssbd_state and the arm64 SSBS feature.
                      ^^ on

> Return string "Unknown" in case CONFIG_ARM64_SSBD is
> disabled or arch workaround2 is not available
> in the firmware.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> [Added SSBS logic]
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 6505c93d507e..8aeb5ca38db8 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -423,6 +423,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>  		ssbd_state = ARM64_SSBD_UNKNOWN;
>  		return false;
>  
> +	/* machines with mixed mitigation requirements must not return this */
>  	case SMCCC_RET_NOT_REQUIRED:
>  		pr_info_once("%s mitigation not required\n", entry->desc);
>  		ssbd_state = ARM64_SSBD_MITIGATED;
> @@ -828,4 +829,31 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
>  	}
>  }
>  
> +ssize_t cpu_show_spec_store_bypass(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 *  Two assumptions: First, get_ssbd_state() reflects the worse case
> +	 *  for hetrogenous machines, and that if SSBS is supported its
                                                  ^^^^ SSBD
> +	 *  supported by all cores.
> +	 */
> +	switch (arm64_get_ssbd_state()) {
> +	case ARM64_SSBD_MITIGATED:
> +		return sprintf(buf, "Not affected\n");
> +
> +	case ARM64_SSBD_KERNEL:
> +	case ARM64_SSBD_FORCE_ENABLE:
> +		if (cpus_have_cap(ARM64_SSBS))
> +			return sprintf(buf, "Not affected\n");
> +		return sprintf(buf,
> +			"Mitigation: Speculative Store Bypass disabled\n");

NIT: To me this reads as the mitigation is disabled. Can we call it
"Speculative Store Bypass Disable" (with a capital 'D' and without the
'd at the end)?

Steve

> +
> +	case ARM64_SSBD_FORCE_DISABLE:
> +		return sprintf(buf, "Vulnerable\n");
> +
> +	default: /* ARM64_SSBD_UNKNOWN*/
> +		return sprintf(buf, "Unknown\n");
> +	}
> +}
> +
>  #endif
> 

