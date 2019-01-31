Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F7AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FEC218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbfAaQUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:20:08 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47186 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731284AbfAaQUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:20:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54929EBD;
        Thu, 31 Jan 2019 08:20:07 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB2943F557;
        Thu, 31 Jan 2019 08:20:05 -0800 (PST)
Subject: Re: [PATCH v5 1/5] arm64: Add utilities to save restore pointer
 authentication keys
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
References: <1548658727-14271-1-git-send-email-amit.kachhap@arm.com>
 <1548658727-14271-2-git-send-email-amit.kachhap@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <88ccd568-f027-6cdf-b4f1-6709d76102c1@arm.com>
Date:   Thu, 31 Jan 2019 16:20:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548658727-14271-2-git-send-email-amit.kachhap@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On 28/01/2019 06:58, Amit Daniel Kachhap wrote:
> The keys can be switched either inside an assembly or such
> functions which do not have pointer authentication checks, so a GCC
> attribute is added to enable it.
> 
> A function ptrauth_keys_store is added which is similar to existing
> function ptrauth_keys_switch but saves the key values in memory.
> This may be useful for save/restore scenarios when CPU changes
> privilege levels, suspend/resume etc.


> diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
> index 15d4951..98441ce 100644
> --- a/arch/arm64/include/asm/pointer_auth.h
> +++ b/arch/arm64/include/asm/pointer_auth.h
> @@ -11,6 +11,13 @@
>  
>  #ifdef CONFIG_ARM64_PTR_AUTH
>  /*
> + * Compile the function without pointer authentication instructions. This
> + * allows pointer authentication to be enabled/disabled within the function
> + * (but leaves the function unprotected by pointer authentication).
> + */
> +#define __no_ptrauth	__attribute__((target("sign-return-address=none")))

The documentation[0] for this says 'none' is the default. Will this only
take-effect once the kernel supports pointer-auth for the host? (Is this just
documentation until then?)

('noptrauth' would fit with 'notrace' slightly better)


Thanks,

James

[0]
https://gcc.gnu.org/onlinedocs/gcc/AArch64-Function-Attributes.html#AArch64-Function-Attributes

