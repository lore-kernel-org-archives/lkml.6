Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752903AbeC1KJj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:09:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39082 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbeC1KJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:09:38 -0400
Date: Wed, 28 Mar 2018 12:08:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Eric Dumazet <edumazet@google.com>
Cc: x86 <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] x86, msr: fix rdmsrl_safe_on_cpu()
Message-ID: <20180328100844.GA20533@pd.tnic>
References: <20180328032233.153055-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180328032233.153055-1-edumazet@google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 08:22:33PM -0700, Eric Dumazet wrote:
> When changing rdmsr_safe_on_cpu() to schedule, I missed that
> __rdmsr_safe_on_cpu() was also used by rdmsrl_safe_on_cpu()
> 
> Lets make rdmsrl_safe_on_cpu() a wrapper instead of copy/pasting
> the code I added for the completion handling.
> 
> Fixes: 07cde313b2d2 ("x86/msr: Allow rdmsr_safe_on_cpu() to schedule")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> ---
>  arch/x86/lib/msr-smp.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
> index 761ba062afdaf7f7d0603ed94ed6cc3e46b37f76..fee8b9c0520c9954e3cf9093332e1a9b53009b8b 100644
> --- a/arch/x86/lib/msr-smp.c
> +++ b/arch/x86/lib/msr-smp.c
> @@ -225,16 +225,13 @@ EXPORT_SYMBOL(wrmsrl_safe_on_cpu);
>  
>  int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
>  {
> +	u32 low, high;
>  	int err;
> -	struct msr_info rv;
>  
> -	memset(&rv, 0, sizeof(rv));
> +	err = rdmsr_safe_on_cpu(cpu, msr_no, &low, &high);
> +	*q = (u64)high << 32 | low;
>  
> -	rv.msr_no = msr_no;
> -	err = smp_call_function_single(cpu, __rdmsr_safe_on_cpu, &rv, 1);
> -	*q = rv.reg.q;
> -
> -	return err ? err : rv.err;
> +	return err;
>  }
>  EXPORT_SYMBOL(rdmsrl_safe_on_cpu);
>  
> -- 

I guess now that the rdmsr* side does this, you probably should convert
the wrmsr* side as well.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
