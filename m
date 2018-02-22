Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753621AbeBVLBV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:01:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:37343 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753588AbeBVLBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:01:18 -0500
Date: Thu, 22 Feb 2018 12:00:57 +0100
From: Borislav Petkov <bp@suse.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [v2 1/3] x86/microcode/intel: Check microcode revision before
 updating sibling threads
Message-ID: <20180222110056.GA27489@pd.tnic>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
 <1519281205-58951-2-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519281205-58951-2-git-send-email-ashok.raj@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 10:33:23PM -0800, Ashok Raj wrote:
> After updating microcode on one of the threads in the core, the
> thread sibling automatically gets the update since the microcode
> resources are shared. Check the ucode revision on the CPU before
> performing a ucode update.
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
> 
> Updates:
> v2: Address Boris's to cleanup apply_microcode_intel
> v3: Fixups per Ingo: Spell Checks

That changelog...

> ---

... comes under this line so that it can be ignored by tools.

>  arch/x86/kernel/cpu/microcode/intel.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 09b95a7..137c9f5 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -589,6 +589,18 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
>  	if (!mc)
>  		return 0;
>  
> +	rev = intel_get_microcode_revision();

Ok, so I'm still wondering what this patch is trying to achieve.

intel_get_microcode_revision() does already *two* MSR reads and a CPUID.
So it is not speed improvements - it actually makes loading slower due to that
checking.

So why are we doing this again?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
