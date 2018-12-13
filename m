Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833DAC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8EE20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8EE20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeLMLJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:09:30 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59314 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbeLMLJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:09:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23A8CA78;
        Thu, 13 Dec 2018 03:09:29 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 544B23F59C;
        Thu, 13 Dec 2018 03:09:27 -0800 (PST)
Subject: Re: [PATCH 4/6] arm64: add sysfs vulnerability show for spectre v2
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de
References: <20181206234408.1287689-1-jeremy.linton@arm.com>
 <20181206234408.1287689-5-jeremy.linton@arm.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <6c572de0-da38-c273-82ed-bafb86bbfa7a@arm.com>
Date:   Thu, 13 Dec 2018 11:09:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206234408.1287689-5-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 23:44, Jeremy Linton wrote:
> Add code to track whether all the cores in the machine are
> vulnerable, and whether all the vulnerable cores have been
> mitigated.
> 
> Once we have that information we can add the sysfs stub and
> provide an accurate view of what is known about the machine.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 72 +++++++++++++++++++++++++++++++---
>  1 file changed, 67 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 559ecdee6fd2..6505c93d507e 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c

[...]

> @@ -766,4 +812,20 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
>  	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
>  }
>  
> +ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	switch (__spectrev2_safe) {
> +	case A64_SV2_SAFE:
> +		return sprintf(buf, "Not affected\n");
> +	case A64_SV2_UNSAFE:
> +		if (__hardenbp_enab == A64_HBP_MIT)
> +			return sprintf(buf,
> +				"Mitigation: Branch predictor hardening\n");
> +		return sprintf(buf, "Vulnerable\n");
> +	default:
> +		return sprintf(buf, "Unknown\n");
> +	}

Again I see that we are going to display "Unknown" when the mitigation
is not built in.

Couldn't we make that CONFIG_GENERIC_CPU_VULNERABILITIES check whether a
CPU is vulnerable or not even if the mitigation is not implemented? It's
just checking the list of MIDRs.

Thanks,

-- 
Julien Thierry
