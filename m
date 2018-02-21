Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeBUS0L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:26:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:44118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751890AbeBUS0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:26:09 -0500
Date: Wed, 21 Feb 2018 19:25:53 +0100
From: Borislav Petkov <bp@suse.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [PATCH 2/3] x86/microcode/intel: Perform a cache flush before
 ucode update.
Message-ID: <20180221182553.GD16888@pd.tnic>
References: <1519231784-9941-1-git-send-email-ashok.raj@intel.com>
 <1519231784-9941-3-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519231784-9941-3-git-send-email-ashok.raj@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 08:49:43AM -0800, Ashok Raj wrote:
> Microcode updates can be safer if the caches are clean.
> Some of the issues around in certain Broadwell parts
> can be addressed by doing a full cache flush.

Take that text...

> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Cc: X86 ML <x86@kernel.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Andi Kleen <andi.kleen@intel.com>
> Cc: Boris Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index eff80df..5d32724 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -589,6 +589,7 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
>  	if (!mc)
>  		return 0;
>  

... and put it here as a comment.

> +	wbinvd();

This definitely needs to be native_wbinvd(). Early mode don't love pvops.

>  	/* write microcode via MSR 0x79 */
>  	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
>  
> @@ -805,6 +806,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
>  		return UCODE_OK;
>  	}


Ditto.

> +	wbinvd();
>  	/* write microcode via MSR 0x79 */
>  	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
>  
> -- 
> 2.7.4
> 

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
