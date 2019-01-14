Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8832C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835A3205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfANLcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:32:08 -0500
Received: from foss.arm.com ([217.140.101.70]:59816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfANLcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:32:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B20880D;
        Mon, 14 Jan 2019 03:32:07 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 606D93F5BD;
        Mon, 14 Jan 2019 03:32:05 -0800 (PST)
Subject: Re: [PATCH v3 3/7] arm64: kpti: move check for non-vulnerable CPUs to
 a function
To:     jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        dave.martin@arm.com, shankerd@codeaurora.org,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        julien.thierry@arm.com, mlangsdo@redhat.com, Steven.Price@arm.com,
        stefan.wahren@i2se.com
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-4-jeremy.linton@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <553c4f17-b504-a7a2-51cf-9c0d6c5d7797@arm.com>
Date:   Mon, 14 Jan 2019 11:32:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109235544.2992426-4-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

On 09/01/2019 23:55, Jeremy Linton wrote:
> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> 
> Add is_meltdown_safe() which is a whitelist of known safe cores.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> [Moved location of function]
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   arch/arm64/kernel/cpufeature.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 4f272399de89..ab784d7a0083 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -947,8 +947,7 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
>   #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>   static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
>   
> -static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
> -				int scope)
> +static bool is_cpu_meltdown_safe(void)
>   {
>   	/* List of CPUs that are not vulnerable and don't need KPTI */
>   	static const struct midr_range kpti_safe_list[] = {
> @@ -962,6 +961,15 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>   		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
>   		{ /* sentinel */ }
>   	};
> +	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))

nit: Does it make sense to rename the list to "meltdown_safe_list", to match the
function name ?

Also also, you may do :

	return is_midr_in_range_list(read_cpuid_id(), kpti_safe_list);

Either way

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
