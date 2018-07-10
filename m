Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676E2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCE32089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCE32089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeGJJAq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:00:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43162 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751263AbeGJJAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:00:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A364680D;
        Tue, 10 Jul 2018 02:00:44 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 743403F318;
        Tue, 10 Jul 2018 02:00:44 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 2A01E1AE4FBF; Tue, 10 Jul 2018 10:01:26 +0100 (BST)
Date:   Tue, 10 Jul 2018 10:01:26 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Paul Kocialkowski <contact@paulk.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
Message-ID: <20180710090125.GA28924@arm.com>
References: <20180709200956.31158-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709200956.31158-1-labbott@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Laura.

I'll take this as a fix, and add a comment to the Makefile to justify
why we need the linux target.

Will

On Mon, Jul 09, 2018 at 01:09:56PM -0700, Laura Abbott wrote:
> This reverts commit 38fc4248677552ce35efc09902fdcb06b61d7ef9.
> 
> This breaks compilation with Fedora gcc-8 tool chains:
> 
>   CHK     include/generated/compile.h
>   LD [M]  arch/arm64/crypto/sha512-ce.o
> aarch64-linux-gnu-ld: cannot open linker script file ldscripts/aarch64elf.xr: No such file or directory
> make[1]: *** [scripts/Makefile.build:530: arch/arm64/crypto/sha512-ce.o] Error 1
> make: *** [Makefile:1029: arch/arm64/crypto] Error 2
> 
> Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> A bit rushed and I'm still debugging but I wanted to send this out
> before anyone else gets hit since it is -rc4. Seeing this on both native
> and cross compiles.
> ---
>  arch/arm64/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 7976d2d242fa..f476d52ad8d6 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -60,13 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS	+= -mbig-endian
>  CHECKFLAGS	+= -D__AARCH64EB__
>  AS		+= -EB
> -LDFLAGS		+= -EB -maarch64elfb
> +LDFLAGS		+= -EB -maarch64linuxb
>  UTS_MACHINE	:= aarch64_be
>  else
>  KBUILD_CPPFLAGS	+= -mlittle-endian
>  CHECKFLAGS	+= -D__AARCH64EL__
>  AS		+= -EL
> -LDFLAGS		+= -EL -maarch64elf
> +LDFLAGS		+= -EL -maarch64linux
>  UTS_MACHINE	:= aarch64
>  endif
>  
> -- 
> 2.17.1
> 
