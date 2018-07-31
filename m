Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79C2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CBD20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CBD20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbeGaKag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:30:36 -0400
Received: from foss.arm.com ([217.140.101.70]:50260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbeGaKag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:30:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC0851596;
        Tue, 31 Jul 2018 01:51:19 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D01F3F5BA;
        Tue, 31 Jul 2018 01:51:19 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5A2961AE2F57; Tue, 31 Jul 2018 09:51:21 +0100 (BST)
Date:   Tue, 31 Jul 2018 09:51:21 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] efi/libstub: Only disable stackleak plugin for arm64
Message-ID: <20180731085121.GC4680@arm.com>
References: <20180730163722.GD4276@arm.com>
 <20180730183118.25869-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730183118.25869-1-labbott@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:31:18AM -0700, Laura Abbott wrote:
> arm64 uses the full KBUILD_CFLAGS for building libstub as opposed
> to x86 which doesn't. This means that x86 doesn't pick up
> the gcc-plugins. We need to disable the stackleak plugin but
> doing this unconditionally breaks x86 build since it doesn't
> have any plugins. Switch to disabling the stackleak plugin for
> arm64 only.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  drivers/firmware/efi/libstub/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Cheers, Laura, I'll pick this up today. I think we'll need the same thing
for 32-bit ARM if/when they enable support for the plugin.

Will

> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 25dd2a14560d..88c322d7c71e 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -11,7 +11,10 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
>  				   -fPIC -fno-strict-aliasing -mno-red-zone \
>  				   -mno-mmx -mno-sse -fshort-wchar
>  
> -cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie
> +# arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
> +# disable the stackleak plugin
> +cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
> +				   $(DISABLE_STACKLEAK_PLUGIN)
>  cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
>  				   -fno-builtin -fpic -mno-single-pic-base
>  
> @@ -21,7 +24,6 @@ KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>  				   -D__NO_FORTIFY \
>  				   $(call cc-option,-ffreestanding) \
>  				   $(call cc-option,-fno-stack-protector) \
> -				   $(DISABLE_STACKLEAK_PLUGIN)
>  
>  GCOV_PROFILE			:= n
>  KASAN_SANITIZE			:= n
> -- 
> 2.17.1
> 
