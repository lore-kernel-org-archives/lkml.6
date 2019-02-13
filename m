Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA39C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468B52190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389611AbfBMKaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:30:17 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50998 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732488AbfBMKaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:30:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2725A78;
        Wed, 13 Feb 2019 02:30:16 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 795B53F575;
        Wed, 13 Feb 2019 02:30:14 -0800 (PST)
Subject: Re: [PATCH v8 4/5] arm64: implement ftrace with regs
To:     Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
References: <20190208150826.44EBC68DD2@newverein.lst.de>
 <20190208151019.9E7A968DDD@newverein.lst.de>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <c6a24572-84d5-bf0f-f70c-8580a83834a1@arm.com>
Date:   Wed, 13 Feb 2019 10:30:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190208151019.9E7A968DDD@newverein.lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

On 08/02/2019 15:10, Torsten Duwe wrote:
> Implement ftrace with regs, based on the new gcc flag
> -fpatchable-function-entry (=2)
> 
> Now that gcc8 added 2 NOPs at the beginning of each function, replace
> the first NOP thus generated with a quick LR saver (move it to scratch
> reg x9), so the 2nd replacement insn, the call to ftrace, does not
> clobber the value. Ftrace will then generate the standard stack
> frames.
> 
> Note that patchable-function-entry in GCC disables IPA-RA, which means
> ABI register calling conventions are obeyed and scratch registers such
> as x9 are available.
> 
> Introduce and handle an ftrace_regs_trampoline for module PLTs, right
> after ftrace_trampoline in an ftrace_trampolines[2] array, and double
> the size of the corresponding special section.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> ---
>  arch/arm64/include/asm/ftrace.h  |   16 ++++
>  arch/arm64/include/asm/module.h  |    3 
>  arch/arm64/kernel/entry-ftrace.S |  125 +++++++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/ftrace.c       |  117 ++++++++++++++++++++++++++++--------
>  arch/arm64/kernel/module-plts.c  |    3 
>  arch/arm64/kernel/module.c       |    2 
>  6 files changed, 231 insertions(+), 35 deletions(-)

[...]

> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -32,7 +32,8 @@ struct mod_arch_specific {
>  	struct mod_plt_sec	init;
>  
>  	/* for CONFIG_DYNAMIC_FTRACE */
> -	struct plt_entry 	*ftrace_trampoline;
> +	struct plt_entry	*ftrace_trampolines;
> +#define MOD_ARCH_NR_FTRACE_TRAMPOLINES	2

Nit: I'd define this outside of the struct, just below
MODULE_ARCH_VERMAGIC, and use the prefix "MODULE_ARCH" instead of
"MOD_ARCH" as this seem to be already in use for a few other defines.

Otherwise things look good to me:

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

Cheers,

-- 
Julien Thierry
