Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeBPS4M (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:56:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:46106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751612AbeBPS4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:56:11 -0500
Date: Fri, 16 Feb 2018 19:56:01 +0100
From: Borislav Petkov <bp@suse.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/microcode: Check microcode revision before updating
 sibling threads
Message-ID: <20180216185601.GB9380@pd.tnic>
References: <1518806808-4074-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518806808-4074-1-git-send-email-ashok.raj@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:46:48AM -0800, Ashok Raj wrote:
> After updating microcode on one of the threads in the core, the
> thread sibling automatically gets the update since the microcode
> resources are shared. Check the ucode revision on the cpu before
> performing a ucode update.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Cc: X86 ML <x86@kernel.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 09b95a7..5802c2f 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -786,11 +786,21 @@ static enum ucode_state apply_microcode_intel(int cpu)
>  
>  	uci = ucode_cpu_info + cpu;
>  	mc = uci->mc;
> +
>  	if (!mc) {
>  		/* Look for a newer patch in our cache: */
>  		mc = find_patch(uci);
>  		if (!mc)
>  			return UCODE_NFOUND;
> +	} else {
> +		rev = intel_get_microcode_revision();
> +		/*
> +		 * Its possible the microcode got udpated
> +		 * because its sibling update was done earlier.
> +		 * Skip the udpate in that case.
> +		 */
> +		if (rev == mc->hdr.rev)
> +			goto done;
>  	}

Make that like the AMD version:

		/*
		 * Its possible the microcode got udpated
		 * because its sibling update was done earlier.
		 * Skip the udpate in that case.
		 */
		rev = intel_get_microcode_revision();
		if (rev >= mc->hdr.rev) {
			uci->cpu_sig.rev = rev;
			c->microcode = rev;

			return UCODE_OK;
		}

and make the subject prefix "x86/microcode/intel:" for your next
submission.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
