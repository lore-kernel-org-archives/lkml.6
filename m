Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5857AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3155C20866
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404050AbeLUO5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:57:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53062 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404038AbeLUO5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:57:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FD6C1596;
        Fri, 21 Dec 2018 06:57:18 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9DBD3F59C;
        Fri, 21 Dec 2018 06:57:16 -0800 (PST)
Subject: Re: [PATCH v2 2/2] arm64: uaccess: Implement unsafe accessors
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, hpa@zytor.com
References: <1543845318-24543-1-git-send-email-julien.thierry@arm.com>
 <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f933b06a-0f4a-3bdb-86ef-644ac0a16163@arm.com>
Date:   Fri, 21 Dec 2018 14:57:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1543845318-24543-3-git-send-email-julien.thierry@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 03/12/2018 13:55, Julien Thierry wrote:
> Current implementation of get/put_user_unsafe default to get/put_user
> which toggle PAN before each access, despite having been told by the caller
> that multiple accesses to user memory were about to happen.
> 
> Provide implementations for user_access_begin/end to turn PAN off/on and
> implement unsafe accessors that assume PAN was already turned off.

> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 842fb95..4e6477b 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -108,6 +108,8 @@
>  #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
>  #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
>  
> +#define SYS_PSTATE_PAN			sys_reg(3, 0, 4, 2, 3)

Nit: Could we keep this list in encoding order please.
(it makes conflicts easier to resolve in the future)

>  #define SYS_OSDTRRX_EL1			sys_reg(2, 0, 0, 0, 2)
>  #define SYS_MDCCINT_EL1			sys_reg(2, 0, 0, 2, 0)
>  #define SYS_MDSCR_EL1			sys_reg(2, 0, 0, 2, 2)
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 07c3408..cabfcae 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -233,6 +233,23 @@ static inline void uaccess_enable_not_uao(void)
>  	__uaccess_enable(ARM64_ALT_PAN_NOT_UAO);
>  }
>  
> +#define unsafe_user_region_active	uaccess_region_active
> +static inline bool uaccess_region_active(void)
> +{
> +	if (system_uses_ttbr0_pan()) {
> +		u64 ttbr;
> +
> +		ttbr = read_sysreg(ttbr1_el1);
> +		return ttbr & TTBR_ASID_MASK;
> +	} else if (cpus_have_const_cap(ARM64_ALT_PAN_NOT_UAO)) {
> +		return (read_sysreg(sctlr_el1) & SCTLR_EL1_SPAN) ?
> +				false :
> +				!read_sysreg_s(SYS_PSTATE_PAN);
> +	}
> +
> +	return false;
> +}

(Reading the SCTLR bit is a bit of a heavy-hammer, as suggested elsewhere on the
thread, can we use alternatives_applied here?)

It may be worth splitting this into three patches, so the 'unsafe' bits can be
merged without the debug option.


Either way, for the unsafe parts:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks!

James
