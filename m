Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED96AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A758920867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A758920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeH2Pdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:33:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:43974 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728423AbeH2Pdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:33:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 898F7AE31;
        Wed, 29 Aug 2018 11:37:02 +0000 (UTC)
Date:   Wed, 29 Aug 2018 13:37:00 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Torsten Duwe <duwe@lst.de>
cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: implement live patching
In-Reply-To: <20180810160306.2954D68C76@newverein.lst.de>
Message-ID: <alpine.LSU.2.21.1808291313170.30704@pobox.suse.cz>
References: <20180810160043.9E45568C76@newverein.lst.de> <20180810160306.2954D68C76@newverein.lst.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2018, Torsten Duwe wrote:

> Based on ftrace with regs, do the usual thing. Also allocate a
> task flag for whatever consistency handling is implemented.
> Watch out for interactions with the graph tracer.
> This code has been compile-tested, but has not yet seen any
> heavy livepatching.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>

There is one thing missing. Livepatch is able to automatically resolve 
relocations pointing to SHN_LIVEPATCH symbols. Arch-specific 
apply_relocate_add() is called for the purpose. It needs all 
arch-specific info preserved because of that. Usually it means to keep 
at least mod_arch_specific struct also after a module is loaded. It 
depends on its content. See f31e0960f395 ("module: s390: keep 
mod_arch_specific for livepatch modules") for example.

We discussed the issue in 2016 when you submitted the arm64 support 
originally. It was more or less ok back then. Jessica only proposed to 
update count_plts(). However, a lot has changed since then and the code 
must be inspected again. If everything is ok, there should be at least a 
note in the changelog.
 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 28c8c03..31df287 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -117,6 +117,7 @@ config ARM64
>  	select HAVE_GENERIC_DMA_COHERENT
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>  	select HAVE_IRQ_TIME_ACCOUNTING
> +	select HAVE_LIVEPATCH
>  	select HAVE_MEMBLOCK
>  	select HAVE_MEMBLOCK_NODE_MAP if NUMA
>  	select HAVE_NMI
> @@ -1343,4 +1344,6 @@ if CRYPTO
>  source "arch/arm64/crypto/Kconfig"
>  endif
>  
> +source "kernel/livepatch/Kconfig"
> +
>  source "lib/Kconfig"
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -76,6 +76,7 @@ void arch_release_task_struct(struct tas
>  #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
>  #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
>  #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
> +#define TIF_PATCH_PENDING	6
>  #define TIF_NOHZ		7
>  #define TIF_SYSCALL_TRACE	8
>  #define TIF_SYSCALL_AUDIT	9
> @@ -94,6 +95,7 @@ void arch_release_task_struct(struct tas
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
>  #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
> +#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
>  #define _TIF_NOHZ		(1 << TIF_NOHZ)
>  #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
>  #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
> @@ -106,7 +108,8 @@ void arch_release_task_struct(struct tas
>  
>  #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
>  				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
> -				 _TIF_UPROBE | _TIF_FSCHECK)
> +				 _TIF_UPROBE | _TIF_FSCHECK | \
> +				 _TIF_PATCH_PENDING)

We're ok if _TIF_WORK_MASK is processed in the syscall return path and in 
irq return to user space. It looks like it is the case, but I'd welcome a 
confirmation.

Anyway, one piece is still missing. _TIF_PATCH_PENDING must be cleared 
somewhere. I think something like

                        if (thread_flags & _TIF_PATCH_PENDING)
				klp_update_patch_state(current);

in do_notify_resume() (arch/arm64/kernel/signal.c) before 
_TIF_SIGPENDING processing should do the trick.
  
>  #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>  				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
> diff --git a/arch/arm64/include/asm/livepatch.h b/arch/arm64/include/asm/livepatch.h
> new file mode 100644
> index 0000000..6b9a3d1
> --- /dev/null
> +++ b/arch/arm64/include/asm/livepatch.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * livepatch.h - arm64-specific Kernel Live Patching Core
> + *
> + * Copyright (C) 2016 SUSE
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

Someone could argue that GPL boilerplate is superfluous thanks to SPDX 
identifier. I don't, so thanks for putting it there.

> +#ifndef _ASM_ARM64_LIVEPATCH_H
> +#define _ASM_ARM64_LIVEPATCH_H
> +
> +#include <linux/module.h>
> +#include <linux/ftrace.h>
> +
> +#ifdef CONFIG_LIVEPATCH

The guard is unnecessary, I think. The header file is included from 
include/linux/livepatch.h only. Right after the guard there.

> +static inline int klp_check_compiler_support(void)
> +{
> +	return 0;
> +}
> +
> +static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
> +{
> +	regs->pc = ip;
> +}
> +#endif /* CONFIG_LIVEPATCH */
> +
> +#endif /* _ASM_ARM64_LIVEPATCH_H */

Regards,
Miroslav
