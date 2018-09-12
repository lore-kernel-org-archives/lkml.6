Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D66C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F81120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F81120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbeILRcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:32:53 -0400
Received: from foss.arm.com ([217.140.101.70]:58512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbeILRcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:32:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B95421596;
        Wed, 12 Sep 2018 05:28:34 -0700 (PDT)
Received: from [10.4.12.81] (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C4A83F703;
        Wed, 12 Sep 2018 05:28:32 -0700 (PDT)
Subject: Re: [PATCH v5 04/27] arm64: daifflags: Use irqflags functions for
 daifflags
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
 <1535471497-38854-5-git-send-email-julien.thierry@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <1031e4c9-9123-7a94-a59c-4249cf51adf4@arm.com>
Date:   Wed, 12 Sep 2018 13:28:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535471497-38854-5-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 28/08/18 16:51, Julien Thierry wrote:
> Some of the work done in daifflags save/restore is already provided
> by irqflags functions. Daifflags should always be a superset of irqflags
> (it handles irq status + status of other flags). Modifying behaviour of
> irqflags should alter the behaviour of daifflags.
> 
> Use irqflags_save/restore functions for the corresponding daifflags
> operation.

> diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
> index 22e4c83..8d91f22 100644
> --- a/arch/arm64/include/asm/daifflags.h
> +++ b/arch/arm64/include/asm/daifflags.h
> @@ -36,11 +36,8 @@ static inline unsigned long local_daif_save(void)
>  {
>  	unsigned long flags;
>  
> -	asm volatile(
> -		"mrs	%0, daif		// local_daif_save\n"
> -		: "=r" (flags)
> -		:
> -		: "memory");
> +	flags = arch_local_save_flags();

I clearly should have done this from the beginning!
(I thought there was some header-loop that prevented it, but I can't reproduce
that now!)


>  	local_daif_mask();
>  
>  	return flags;
> @@ -60,11 +57,9 @@ static inline void local_daif_restore(unsigned long flags)
>  {
>  	if (!arch_irqs_disabled_flags(flags))
>  		trace_hardirqs_on();
> -	asm volatile(
> -		"msr	daif, %0		// local_daif_restore"
> -		:
> -		: "r" (flags)
> -		: "memory");
> +
> +	arch_local_irq_restore(flags);

And I thought this only messed with the I bit, which it clearly doesn't.

Thanks for fixing these!

Reviewed-by: James Morse <james.morse@arm.com>
