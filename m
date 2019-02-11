Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65604C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9FE218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfBKMAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:00:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46492 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfBKMAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:00:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 578D480D;
        Mon, 11 Feb 2019 03:59:59 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDC373F557;
        Mon, 11 Feb 2019 03:59:56 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:59:54 +0000
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
        live-patching@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v8 2/5] arm64: replace -pg with CC_FLAGS_FTRACE in efi
 Makefiles
Message-ID: <20190211115953.GD10501@lakrids.cambridge.arm.com>
References: <20190208150826.44EBC68DD2@newverein.lst.de>
 <20190208151011.0807668DD3@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208151011.0807668DD3@newverein.lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 04:10:11PM +0100, Torsten Duwe wrote:
>   In preparation for arm64 supporting ftrace built on other compiler
>   options, let's have makefiles remove the $(CC_FLAGS_FTRACE)
>   flags, whatever these may be, rather than assuming '-pg'.
>   While at it, fix arm32 as well.
> 
>   There should be no functional change as a result of this patch.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>

With the indentation removed from the commit text:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> ---
>  drivers/firmware/efi/libstub/Makefile |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -16,9 +16,9 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__K
>  
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
> -cflags-$(CONFIG_ARM64)		:= $(subst -pg,,$(KBUILD_CFLAGS)) -fpie \
> -				   $(DISABLE_STACKLEAK_PLUGIN)
> -cflags-$(CONFIG_ARM)		:= $(subst -pg,,$(KBUILD_CFLAGS)) \
> +cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
> +				   -fpie $(DISABLE_STACKLEAK_PLUGIN)
> +cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  				   -fno-builtin -fpic \
>  				   $(call cc-option,-mno-single-pic-base)
>  
