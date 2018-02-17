Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbeBQHu7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 02:50:59 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38151 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeBQHu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 02:50:58 -0500
X-Google-Smtp-Source: AH8x225rZWM6PX+w6UdGe/YNJoVWgeTHOZrOCIi/YdJ25qQ17JRlDtLDbYyhDJAFW0VVN9EGkibu2A==
Date: Sat, 17 Feb 2018 08:50:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: bp@suse.de, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/microcode/intel: Check microcode revision before
 updating sibling threads
Message-ID: <20180217075053.2muugr2ioqvawfxv@gmail.com>
References: <1518809669-3651-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518809669-3651-1-git-send-email-ashok.raj@intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ashok Raj <ashok.raj@intel.com> wrote:

> After updating microcode on one of the threads in the core, the
> thread sibling automatically gets the update since the microcode
> resources are shared. Check the ucode revision on the cpu before
> performing a ucode update.

s/cpu/CPU

> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Cc: X86 ML <x86@kernel.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 09b95a7..036d1db 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -776,7 +776,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
>  {
>  	struct microcode_intel *mc;
>  	struct ucode_cpu_info *uci;
> -	struct cpuinfo_x86 *c;
> +	struct cpuinfo_x86 *c = &cpu_data(cpu);
>  	static int prev_rev;
>  	u32 rev;
>  
> @@ -793,6 +793,18 @@ static enum ucode_state apply_microcode_intel(int cpu)
>  			return UCODE_NFOUND;
>  	}
>  
> +	rev = intel_get_microcode_revision();
> +	/*
> +	 * Its possible the microcode got udpated
> +	 * because its sibling update was done earlier.
> +	 * Skip the udpate in that case.
> +	 */
> +	if (rev >= mc->hdr.rev) {
> +		uci->cpu_sig.rev = rev;
> +		c->microcode = rev;
> +		return UCODE_OK;
> +	}

s/udpate
 /update

Also, more fundamentally, during microcode early testing, isn't it possible for 
internal iterations of the microcode to have the same revision, but be different?

This patch would prevent re-loading it - for a seemingly minimal benefit.

Thanks,

	Ingo
