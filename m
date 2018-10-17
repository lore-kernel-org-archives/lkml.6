Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB67ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830F12150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830F12150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeJQVfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:35:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:42932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbeJQVfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:35:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1930FAFC1;
        Wed, 17 Oct 2018 13:39:33 +0000 (UTC)
Date:   Wed, 17 Oct 2018 15:39:31 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Torsten Duwe <duwe@lst.de>
cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, jeyu@kernel.org
Subject: Re: [PATCH v3 3/4] arm64: implement live patching
In-Reply-To: <20181001141652.5478C68BE1@newverein.lst.de>
Message-ID: <alpine.LSU.2.21.1810171051560.21847@pobox.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141652.5478C68BE1@newverein.lst.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2018, Torsten Duwe wrote:

> Based on ftrace with regs, do the usual thing. Also allocate a
> task flag for whatever consistency handling will be used.
> Watch out for interactions with the graph tracer.

Similar to what Mark wrote about 2/4, I'd appreciate a better commit log. 
Could you explain traditional "what/why/how", please?
 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -119,6 +119,7 @@ config ARM64
>  	select HAVE_GENERIC_DMA_COHERENT
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>  	select HAVE_IRQ_TIME_ACCOUNTING
> +	select HAVE_LIVEPATCH
>  	select HAVE_MEMBLOCK
>  	select HAVE_MEMBLOCK_NODE_MAP if NUMA
>  	select HAVE_NMI
> @@ -1349,4 +1350,6 @@ if CRYPTO
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

Could you add a note to the changelog what this means? My ability to read 
arm64 entry.S is very limited, but I can see that _TIF_WORK_MASK is 
process in a syscall exit and irq return paths. That's good. It is also 
called (via "b ret_to_user") in a couple of different places (el0_* 
labels). I guess those are returns from exception handling. A comment 
about it in the changelog would be appreciated.
  
>  #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>  				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
> --- /dev/null
> +++ b/arch/arm64/include/asm/livepatch.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * livepatch.h - arm64-specific Kernel Live Patching Core
> + *
> + * Copyright (C) 2016,2018 SUSE
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
> +#ifndef _ASM_ARM64_LIVEPATCH_H
> +#define _ASM_ARM64_LIVEPATCH_H
> +
> +#include <linux/module.h>
> +#include <linux/ftrace.h>

I think that only

#include <asm/ptrace.h>

is in fact needed, because of "struct pt_regs".


Ad relocations. I checked that everything in struct mod_arch_specific 
stays after the module is load. Both core and init get SHF_ALLOC set 
(mod->arch.core.plt->sh_flags in module_frob_arch_sections(). It is 
important because apply_relocate_add() may use those sections 
through module_emit_plt_entry() call.

ftrace_trampoline section gets SHF_ALLOC as well. Btw, don't you want to 
do something similar for new ftrace_regs_trampoline in 
module_frob_arch_sections()? Perhaps even edit 
arch/arm64/kernel/module.lds? I'm completely clueless here, so it may be 
ok. And it applies to 2/4 patch.

The last thing is count_plts() function called from 
module_frob_arch_sections(). It needed to be changed in 2016 as well. See 
Jessica's patch 
(20160713001113.GA30925@packer-debian-8-amd64.digitalocean.com). The logic 
in the function has changed since then. If I am not mistaken, 
count_plts() is fine as it is right now. It does not consider SHN_UNDEF 
anymore, it looks at the destination section (where a symbol should 
resolved to) only.

Jessica, could you doublecheck, please?

Torsten, please doublecheck all this as well and add a comment about all 
this to the changelog, so we don't have to analyze it from the beginning 
again in the future.

Thanks,
Miroslav
