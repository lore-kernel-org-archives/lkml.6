Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeEVPsp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:48:45 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:52190 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVPso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:48:44 -0400
Date: Tue, 22 May 2018 17:48:42 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoffer Dall <christoffer.dall@arm.com>
Subject: Re: [PATCH 10/14] arm64: ssbd: Add prctl interface for per-thread
 mitigation
Message-ID: <20180522154842.pjml5lagtpyvwwqo@isilmar-4.linta.de>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-11-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522150648.28297-11-marc.zyngier@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, May 22, 2018 at 04:06:44PM +0100, Marc Zyngier wrote:
> If running on a system that performs dynamic SSBD mitigation, allow
> userspace to request the mitigation for itself. This is implemented
> as a prctl call, allowing the mitigation to be enabled or disabled at
> will for this particular thread.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kernel/Makefile |   1 +
>  arch/arm64/kernel/ssbd.c   | 107 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
>  create mode 100644 arch/arm64/kernel/ssbd.c
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index bf825f38d206..0025f8691046 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -54,6 +54,7 @@ arm64-obj-$(CONFIG_ARM64_RELOC_TEST)	+= arm64-reloc-test.o
>  arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
>  arm64-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
>  arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
> +arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
>  
>  obj-y					+= $(arm64-obj-y) vdso/ probes/
>  obj-m					+= $(arm64-obj-m)
> diff --git a/arch/arm64/kernel/ssbd.c b/arch/arm64/kernel/ssbd.c
> new file mode 100644
> index 000000000000..34e3c430176b
> --- /dev/null
> +++ b/arch/arm64/kernel/ssbd.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2018 ARM Ltd, All Rights Reserved.
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/thread_info.h>
> +
> +#include <asm/cpufeature.h>
> +
> +/*
> + * prctl interface for SSBD
> + * FIXME: Drop the below ifdefery once the common interface has been merged.
> + */
> +#ifdef PR_SPEC_STORE_BYPASS

That FIXME wants to be looked at.

Thanks,
	Dominik
