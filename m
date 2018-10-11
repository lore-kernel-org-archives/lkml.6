Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B865C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0287220658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0287220658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbeJKX4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:56:12 -0400
Received: from foss.arm.com ([217.140.101.70]:40806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729368AbeJKX4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:56:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62C04ED1;
        Thu, 11 Oct 2018 09:28:14 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 333EC3F5B3;
        Thu, 11 Oct 2018 09:28:14 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4D2F01AE189D; Thu, 11 Oct 2018 17:28:14 +0100 (BST)
Date:   Thu, 11 Oct 2018 17:28:14 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/17] arm64: add pointer authentication register bits
Message-ID: <20181011162814.GC17000@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-2-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005084754.20950-2-kristina.martsenko@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 09:47:38AM +0100, Kristina Martsenko wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> The ARMv8.3 pointer authentication extension adds:
> 
> * New fields in ID_AA64ISAR1 to report the presence of pointer
>   authentication functionality.
> 
> * New control bits in SCTLR_ELx to enable this functionality.
> 
> * New system registers to hold the keys necessary for this
>   functionality.
> 
> * A new ESR_ELx.EC code used when the new instructions are affected by
>   configurable traps
> 
> This patch adds the relevant definitions to <asm/sysreg.h> and
> <asm/esr.h> for these, to be used by subsequent patches.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/esr.h    |  3 ++-
>  arch/arm64/include/asm/sysreg.h | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index ce70c3ffb993..022785162281 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -30,7 +30,8 @@
>  #define ESR_ELx_EC_CP14_LS	(0x06)
>  #define ESR_ELx_EC_FP_ASIMD	(0x07)
>  #define ESR_ELx_EC_CP10_ID	(0x08)
> -/* Unallocated EC: 0x09 - 0x0B */
> +#define ESR_ELx_EC_PAC		(0x09)

Really minor nit: but shouldn't this be ESR_EL2_EC_PAC, since this trap
can't occur at EL1 afaict?

Rest of the patch looks good:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
