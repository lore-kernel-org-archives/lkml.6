Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3899BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C720F223C4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C720F223C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeGDQ37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:29:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40416 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752401AbeGDQ35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:29:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81FE41595;
        Wed,  4 Jul 2018 09:29:57 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 530463F5AD;
        Wed,  4 Jul 2018 09:29:57 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 4E1DC1AE180C; Wed,  4 Jul 2018 17:30:37 +0100 (BST)
Date:   Wed, 4 Jul 2018 17:30:37 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: add endianness option to LDFLAGS instead of LD
Message-ID: <20180704163036.GA8370@arm.com>
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
 <1530580921-23340-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530580921-23340-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:22:00AM +0900, Masahiro Yamada wrote:
> With the recent syntax extension, Kconfig is now able to evaluate the
> compiler / toolchain capability.
> 
> However, accumulating flags to 'LD' is not compatible with the way
> it works; 'LD' must be passed to Kconfig to call $(ld-option,...)
> from Kconfig files.  If you tweak 'LD' in arch Makefile depending on
> CONFIG_CPU_BIG_ENDIAN, this would end up with circular dependency
> between Makefile and Kconfig.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

But note that this will conflict with:

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/587726.html

Catalin -- I'm assuming you're taking both of these and will resolve the
conflict in the arm64 for-next/fixes branch.

Cheers,

Will

>  arch/arm64/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 4527226..8f73da3 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -60,15 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS	+= -mbig-endian
>  CHECKFLAGS	+= -D__AARCH64EB__
>  AS		+= -EB
> -LD		+= -EB
> -LDFLAGS		+= -maarch64linuxb
> +LDFLAGS		+= -EB -maarch64linuxb
>  UTS_MACHINE	:= aarch64_be
>  else
>  KBUILD_CPPFLAGS	+= -mlittle-endian
>  CHECKFLAGS	+= -D__AARCH64EL__
>  AS		+= -EL
> -LD		+= -EL
> -LDFLAGS		+= -maarch64linux
> +LDFLAGS		+= -EL -maarch64linux
>  UTS_MACHINE	:= aarch64
>  endif
>  
> -- 
> 2.7.4
> 
