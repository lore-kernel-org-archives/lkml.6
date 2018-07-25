Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009DCC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF1E2064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF1E2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeGYKCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:02:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34170 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbeGYKCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:02:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95D5680D;
        Wed, 25 Jul 2018 01:51:22 -0700 (PDT)
Received: from [10.37.10.30] (unknown [10.37.10.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE6023F237;
        Wed, 25 Jul 2018 01:51:20 -0700 (PDT)
Subject: Re: [PATCH] arm64: Check for errata before evaluating cpu features
To:     Dirk Mueller <dmueller@suse.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Alex Graf <agraf@suse.de>,
        Dave Martin <Dave.Martin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
References: <20180725083504.25836-1-dmueller@suse.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <aea2daa9-40ef-2066-0da9-0770c3c50dfb@arm.com>
Date:   Wed, 25 Jul 2018 09:51:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180725083504.25836-1-dmueller@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 09:35 AM, Dirk Mueller wrote:
> Since commit d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
> detection to boot-time CPUs") we rely on errata flags being already
> populated during feature enumeration. The order of errata and
> features was flipped as part of commit ed478b3f9e4a ("arm64:
> capabilities: Group handling of features and errata workarounds").
> 
> Return to the orginal order of errata and feature evaluation to
> ensure errata flags are present during feature evaluation.
> 
> Fixes: d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
> detection to boot-time CPUs")
> CC: Suzuki K Poulose <suzuki.poulose@arm.com>
> CC: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Dirk Mueller <dmueller@suse.com>

It would be good to add "Fixes: ed478b3f9e4a" (instead), just to make
sure this gets fixed everywhere the original problem appears.

> ---
>   arch/arm64/kernel/cpufeature.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f24892a40d2c..c6d80743f4ed 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1351,9 +1351,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>   
>   static void update_cpu_capabilities(u16 scope_mask)
>   {
> -	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
>   	__update_cpu_capabilities(arm64_errata, scope_mask,
>   				  "enabling workaround for");
> +	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
>   }
>   
>   static int __enable_cpu_capability(void *arg)
> @@ -1408,8 +1408,8 @@ __enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>   
>   static void __init enable_cpu_capabilities(u16 scope_mask)
>   {
> -	__enable_cpu_capabilities(arm64_features, scope_mask);
>   	__enable_cpu_capabilities(arm64_errata, scope_mask);
> +	__enable_cpu_capabilities(arm64_features, scope_mask);

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

