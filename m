Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F6FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761192089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761192089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbeJATaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:30:16 -0400
Received: from foss.arm.com ([217.140.101.70]:48304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729204AbeJATaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:30:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DC4D7A9;
        Mon,  1 Oct 2018 05:52:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 485873F5A0;
        Mon,  1 Oct 2018 05:52:31 -0700 (PDT)
Date:   Mon, 1 Oct 2018 13:52:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        prudo@linux.ibm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 07/16] arm64: add image head flag definitions
Message-ID: <20181001125225.7tlfzt5n25sckhyy@lakrids.cambridge.arm.com>
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-8-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928064841.14117-8-takahiro.akashi@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 03:48:32PM +0900, AKASHI Takahiro wrote:
> Those image head's flags will be used later by kexec_file loader.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Acked-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/include/asm/boot.h | 15 +++++++++++++++
>  arch/arm64/kernel/head.S      |  2 +-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/boot.h b/arch/arm64/include/asm/boot.h
> index 355e552a9175..0bab7eed3012 100644
> --- a/arch/arm64/include/asm/boot.h
> +++ b/arch/arm64/include/asm/boot.h
> @@ -5,6 +5,21 @@
>  
>  #include <asm/sizes.h>
>  
> +#define ARM64_MAGIC		"ARM\x64"
> +
> +#define HEAD_FLAG_BE_SHIFT		0
> +#define HEAD_FLAG_PAGE_SIZE_SHIFT	1
> +#define HEAD_FLAG_BE_MASK		0x1
> +#define HEAD_FLAG_PAGE_SIZE_MASK	0x3
> +
> +#define HEAD_FLAG_BE			1

These already exist in some form in arch/arm64/kernel/image.h; can we
please factor those out rather than duplicating them?

I'd be happy if you'd update image.h to use the new HEAD_FLAG_* names,
and removed the old definitions.

> +#define HEAD_FLAG_PAGE_SIZE_4K		1
> +#define HEAD_FLAG_PAGE_SIZE_16K		2
> +#define HEAD_FLAG_PAGE_SIZE_64K		3

I appreciate these are new, since we didn't previously need definitions.

Thanks,
Mark.

> +
> +#define head_flag_field(flags, field) \
> +		(((flags) >> field##_SHIFT) & field##_MASK)
> +
>  /*
>   * arm64 requires the DTB to be 8 byte aligned and
>   * not exceed 2MB in size.
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index b0853069702f..8cbac6232ed1 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -91,7 +91,7 @@ _head:
>  	.quad	0				// reserved
>  	.quad	0				// reserved
>  	.quad	0				// reserved
> -	.ascii	"ARM\x64"			// Magic number
> +	.ascii	ARM64_MAGIC			// Magic number
>  #ifdef CONFIG_EFI
>  	.long	pe_header - _head		// Offset to the PE header.
>  
> -- 
> 2.19.0
> 
