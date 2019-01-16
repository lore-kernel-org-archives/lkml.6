Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4230C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD012082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733276AbfAPJ5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:57:44 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44098 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbfAPJ5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:57:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AB6280D;
        Wed, 16 Jan 2019 01:57:43 -0800 (PST)
Received: from [10.1.197.45] (e112298-lin.cambridge.arm.com [10.1.197.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 311893F70D;
        Wed, 16 Jan 2019 01:57:41 -0800 (PST)
Subject: Re: [PATCH v6] arm64: implement ftrace with regs
To:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
References: <20190104141053.360F768D93@newverein.lst.de>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <8eb70db4-92a2-95a2-075c-f26690aab3ed@arm.com>
Date:   Wed, 16 Jan 2019 09:57:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190104141053.360F768D93@newverein.lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

On 04/01/2019 14:10, Torsten Duwe wrote:
> Use -fpatchable-function-entry (gcc8) to add 2 NOPs at the beginning
> of each function. Replace the first NOP thus generated with a quick LR
> saver (move it to scratch reg x9), so the 2nd replacement insn, the call
> to ftrace, does not clobber the value. Ftrace will then generate the
> standard stack frames.
> 
> Note that patchable-function-entry in GCC disables IPA-RA, which means
> ABI register calling conventions are obeyed *and* scratch registers
> such as x9 are available.
> 
> Introduce and handle an ftrace_regs_trampoline for module PLTs, right
> after ftrace_trampoline, and double the size of this special section.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 

I wanted to test this patch (and try to benchmark having the "mov x9,
x30" always present in function prelude vs having two nops), but I
cannot get this patch to apply (despite having a version including both
commits below).

Could you provide a git branch from which I could try to rebase the
patch? (Or a new version of the series)

> ---
> 
> This patch applies on 4.20 with the additional changes
> bdb85cd1d20669dfae813555dddb745ad09323ba
> (arm64/module: switch to ADRP/ADD sequences for PLT entries)
> and
> 7dc48bf96aa0fc8aa5b38cc3e5c36ac03171e680
> (arm64: ftrace: always pass instrumented pc in x0)
> along with their respective series, or alternatively on Linus' master,
> which already has these.
> 
> changes since v5:
> 
> * fix mentioned pc in x0 to hold the start address of the call site,
>   not the return address or the branch address.
>   This resolves the problem found by Amit.
> 
> ---
>  arch/arm64/Kconfig                    |    2 
>  arch/arm64/Makefile                   |    4 +
>  arch/arm64/include/asm/assembler.h    |    1 
>  arch/arm64/include/asm/ftrace.h       |   13 +++
>  arch/arm64/include/asm/module.h       |    3 
>  arch/arm64/kernel/Makefile            |    6 -
>  arch/arm64/kernel/entry-ftrace.S      |  131 ++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/ftrace.c            |  125 ++++++++++++++++++++++++--------
>  arch/arm64/kernel/module-plts.c       |    3 
>  arch/arm64/kernel/module.c            |    2 
>  drivers/firmware/efi/libstub/Makefile |    3 
>  include/asm-generic/vmlinux.lds.h     |    1 
>  include/linux/compiler_types.h        |    4 +
>  13 files changed, 262 insertions(+), 36 deletions(-)

[...]

> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S

[...]

> @@ -122,6 +124,7 @@ skip_ftrace_call:			// }
>  ENDPROC(_mcount)
>  
>  #else /* CONFIG_DYNAMIC_FTRACE */
> +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  /*
>   * _mcount() is used to build the kernel with -pg option, but all the branch
>   * instructions to _mcount() are replaced to NOP initially at kernel start up,
> @@ -159,6 +162,124 @@ GLOBAL(ftrace_graph_call)		// ftrace_gra
>  
>  	mcount_exit
>  ENDPROC(ftrace_caller)
> +#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> +
> +/*
> + * Since no -pg or similar compiler flag is used, there should really be
> + * no reference to _mcount; so do not define one. Only some value for
> + * MCOUNT_ADDR is needed for comparison. Let it point here to have some
> + * sort of magic value that can be recognised when debugging.
> + */
> +GLOBAL(_mcount)
> +	ret	/* make it differ from regs caller */

There's something I can't figure out. Since there are no callers to
_mcount, how does the ftrace core builds up its record of patchable
functions?

I don't understand fully the core ftrace code but I've got the
impression that without this record of struct dyn_ftrace, ftrace cannot
patch in calls to tracers in the future.

Am I missing something?

Thanks,

-- 
Julien Thierry
