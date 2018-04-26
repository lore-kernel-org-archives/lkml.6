Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756139AbeDZN2q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:28:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:38144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755172AbeDZN2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:28:45 -0400
Date: Thu, 26 Apr 2018 15:28:29 +0200
From: Borislav Petkov <bp@suse.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/smpboot: Don't do mwait_play_dead() on AMD systems
Message-ID: <20180426132829.GK15043@pd.tnic>
References: <20180403140228.58540-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180403140228.58540-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 09:02:28AM -0500, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Recent AMD systems support using MWAIT for C1 state. However, MWAIT will
> not allow deeper cstates than C1 on current systems.
> 
> With play_dead() we expect the OS to use the deepest state available.
> The deepest state available on AMD systems is reached through SystemIO
> or HALT. If MWAIT is available, we use it instead of the other methods,
> so we never reach the deepest state.
> 
> Don't try to use MWAIT to play_dead() on AMD systems. Instead, we'll use
> CPUIDLE to enter the deepest state advertised by firmware. If CPUIDLE is
> not available then we fallback to HALT.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20180402183424.48222-1-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * Drop comment in code.
> 
>  arch/x86/kernel/smpboot.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index ff99e2b6fc54..12599e55e040 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1536,6 +1536,8 @@ static inline void mwait_play_dead(void)
>  	void *mwait_ptr;
>  	int i;
>  
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		return;
>  	if (!this_cpu_has(X86_FEATURE_MWAIT))
>  		return;
>  	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
> -- 

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
