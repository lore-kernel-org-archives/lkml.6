Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 491ACC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0428B208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0428B208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755363AbeFNQnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:43:33 -0400
Received: from foss.arm.com ([217.140.101.70]:34016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755071AbeFNQnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:43:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E86D80D;
        Thu, 14 Jun 2018 09:43:32 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E3D333F59D;
        Thu, 14 Jun 2018 09:43:31 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 2D0191AE519B; Thu, 14 Jun 2018 17:44:06 +0100 (BST)
Date:   Thu, 14 Jun 2018 17:44:06 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, James Morse <james.morse@arm.com>
Subject: Re: [PATCHv2 02/19] arm64: move SCTLR_EL{1,2} assertions to
 <asm/sysreg.h>
Message-ID: <20180614164405.GE26471@arm.com>
References: <20180601112441.37810-1-mark.rutland@arm.com>
 <20180601112441.37810-3-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601112441.37810-3-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 12:24:24PM +0100, Mark Rutland wrote:
> Currently we assert that the SCTLR_EL{1,2}_{SET,CLEAR} bits are
> self-consistent with an assertion in config_sctlr_el1(). This is a bit
> unusual, since config_sctlr_el1() doesn't make use of these definitions,
> and is far away from the definitions themselves.
> 
> We can use the CPP #error directive to have equivalent assertions in
> <asm/sysreg.h>, next to the definitions of the set/clear bits, which is
> a bit clearer and simpler.
> 
> The preprocessor handles literals differently than regular C, e.g. ~0 is
> equivalent to ~(intmax_t)0 rather than ~(int)0. Therefore, instead of ~0
> we use 0xffffffff, which is unambiguous.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Dave Martin <dave.martin@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 6171178075dc..bd1d1194a5e7 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -452,9 +452,9 @@
>  			 SCTLR_ELx_SA     | SCTLR_ELx_I    | SCTLR_ELx_WXN | \
>  			 ENDIAN_CLEAR_EL2 | SCTLR_EL2_RES0)
>  
> -/* Check all the bits are accounted for */
> -#define SCTLR_EL2_BUILD_BUG_ON_MISSING_BITS	BUILD_BUG_ON((SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != ~0)
> -
> +#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffff
> +#error "Inconsistent SCTLR_EL2 set/clear bits"
> +#endif

Please can you extend this check to be 64-bit, since SCTLR is growing fields
up there and we'll want to check them too?

Thanks,

Will
