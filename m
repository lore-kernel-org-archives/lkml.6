Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C89C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DCB20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfARRZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:25:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35284 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfARRZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:25:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E78980D;
        Fri, 18 Jan 2019 09:25:01 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A744D3F7BE;
        Fri, 18 Jan 2019 09:24:58 -0800 (PST)
Date:   Fri, 18 Jan 2019 17:24:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v7 1/3] arm64: replace -pg with CC_FLAGS_FTRACE in
 Makefiles
Message-ID: <20190118172455.GF12256@lakrids.cambridge.arm.com>
References: <20190118163736.6A99268CEB@newverein.lst.de>
 <20190118163904.CD7BA68CEB@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118163904.CD7BA68CEB@newverein.lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

On Fri, Jan 18, 2019 at 05:39:04PM +0100, Torsten Duwe wrote:
> Ftrace instrumentation might also be introduced by
> -fpatchable-function-entry, not only -pg. Ensure the Makefiles are
> flexible to filter out the respective flags in "notrace" directories.

I think this is a cleanup regardless of whether we use
-fpatchable-function-entry.

Can we please give this a more complete description, e.g.

| Currently arm64 makefiles assume that ftrace will use '-pg', and remove
| this flag specifically, rather than the contents of $(CC_FLAGS_FTRACE).
| 
| In preparation for arm64 supporting ftrace built on other compiler
| options, let's have the arm64 makefiles remove the $(CC_FLAGS_FTRACE)
| flags, whatever these may be, rather than assuming '-pg'. 
|
| There should be no functional change as a result of this patch.

> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> ---
>  arch/arm64/kernel/Makefile            |    6 +++---
>  drivers/firmware/efi/libstub/Makefile |    3 ++-

This misses arch/arm64/lib/Makefile and mm/kasan/makefile.

Could we please split this into three patches, addressing:

* arm64
* efistub
* kasan

... since those have distinct maintainers. All those patches can be part
of this series, but having them as separate patches is a bit nicer for
review.

>  2 files changed, 5 insertions(+), 4 deletions(-)
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -7,9 +7,9 @@ CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(
>  AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
>  CFLAGS_armv8_deprecated.o := -I$(src)
>  
> -CFLAGS_REMOVE_ftrace.o = -pg
> -CFLAGS_REMOVE_insn.o = -pg
> -CFLAGS_REMOVE_return_address.o = -pg
> +CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_insn.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
>  
>  # Object file lists.
>  obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -16,7 +16,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__K
>  
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
> -cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
> +cflags-$(CONFIG_ARM64)		:= $(filter-out $(CC_FLAGS_FTRACE)\
> +				  ,$(KBUILD_CFLAGS)) -fpie \
>  				   $(DISABLE_STACKLEAK_PLUGIN)

Why do we need to swtich to using filter-out. AFAICT, subst works just fine.

To keepthis legible, it would be nicer to split it like:

cflags-$(CONFIG_ARM64)			:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
					   -fpie $(DISABLE_STACKLEAK_PLUGIN)

>  cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
>  				   -fno-builtin -fpic \

Please clean up this instance too, at least for consistency.

Thanks,
Mark.
