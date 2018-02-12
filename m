Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933839AbeBLKWS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:22:18 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43377 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932868AbeBLKWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:22:16 -0500
X-Google-Smtp-Source: AH8x224neNJB9kl9xzRvzprJ3vhaUBEWIgocTkmiJGY+W9oImSRy3vMmLm8bL/g0C2h6mfCjPA6Gpg==
Date: Mon, 12 Feb 2018 11:22:11 +0100
From: Ingo Molnar <mingo@kernel.org>
To: hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk, peterz@infradead.org
Cc: linux-tip-commits@vger.kernel.org, Dave Hansen <dave@sr71.net>,
        Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>
Subject: Re: [tip:x86/pti] x86/speculation: Use IBRS if available before
 calling into firmware
Message-ID: <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot for David Woodhouse <tipbot@zytor.com> wrote:

> Commit-ID:  670c3e8da87fa4046a55077b1409cf250865a203
> Gitweb:     https://git.kernel.org/tip/670c3e8da87fa4046a55077b1409cf250865a203
> Author:     David Woodhouse <dwmw@amazon.co.uk>
> AuthorDate: Sun, 11 Feb 2018 15:19:19 +0000
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Sun, 11 Feb 2018 19:44:46 +0100
> 
> x86/speculation: Use IBRS if available before calling into firmware
> 
> Retpoline means the kernel is safe because it has no indirect branches.
> But firmware isn't, so use IBRS for firmware calls if it's available.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Link: http://lkml.kernel.org/r/1518362359-1005-1-git-send-email-dwmw@amazon.co.uk
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/include/asm/apm.h           |  6 ++++++
>  arch/x86/include/asm/cpufeatures.h   |  1 +
>  arch/x86/include/asm/efi.h           | 17 +++++++++++++++--
>  arch/x86/include/asm/nospec-branch.h | 37 +++++++++++++++++++++++++++---------
>  arch/x86/kernel/cpu/bugs.c           | 12 +++++++++++-
>  drivers/watchdog/hpwdt.c             |  3 +++
>  6 files changed, 64 insertions(+), 12 deletions(-)

> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h

> +/*
> + * With retpoline, we must use IBRS to restrict branch prediction
> + * before calling into firmware.
> + */
> +static inline void firmware_restrict_branch_speculation_start(void)
> +{
> +	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,
> +			      X86_FEATURE_USE_IBRS_FW);
> +}
> +
> +static inline void firmware_restrict_branch_speculation_end(void)
> +{
> +	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,
> +			      X86_FEATURE_USE_IBRS_FW);

BTW., there's a detail that only occurred to me today, this enabling/disabling 
sequence is not NMI safe, and it might be called from NMI context:

> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -38,6 +38,7 @@
>  #endif /* CONFIG_HPWDT_NMI_DECODING */
>  #include <asm/nmi.h>
>  #include <asm/frame.h>
> +#include <asm/nospec-branch.h>
>  
>  #define HPWDT_VERSION			"1.4.0"
>  #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
> @@ -486,11 +487,13 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>  	if (!hpwdt_nmi_decoding)
>  		return NMI_DONE;
>  
> +	firmware_restrict_branch_speculation_start();
>  	spin_lock_irqsave(&rom_lock, rom_pl);
>  	if (!die_nmi_called && !is_icru && !is_uefi)
>  		asminline_call(&cmn_regs, cru_rom_addr);
>  	die_nmi_called = 1;
>  	spin_unlock_irqrestore(&rom_lock, rom_pl);
> +	firmware_restrict_branch_speculation_end();
>  
>  	if (allow_kdump)
>  		hpwdt_stop();

But ... this is a (comparatively rare) hardware-watchdog tick function, and the 
chance of racing with say an EFI call seems minuscule. The race will result in an 
EFI call being performed with speculation enabled, sporadically.

Is this something we should worry about?

Thanks,

	Ingo
