Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeDQKQJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:16:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55493 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbeDQKQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:16:08 -0400
Date: Tue, 17 Apr 2018 12:15:56 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Wang <davidwang@zhaoxin.com>
cc: mingo@redhat.com, hpa@zytor.com, mingo@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, brucechang@via-alliance.com,
        cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com,
        lukelin@viacpu.com, timguo@zhaoxin.com
Subject: Re: [PATCH] x86/centaur: report correct CPU/cache topology
In-Reply-To: <1522835579-22893-1-git-send-email-davidwang@zhaoxin.com>
Message-ID: <alpine.DEB.2.21.1804171202040.1694@nanos.tec.linutronix.de>
References: <1522835579-22893-1-git-send-email-davidwang@zhaoxin.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2018, David Wang wrote:

> This patch is used to support multi-core Centaur CPU. After using this
> patch, we can get correct CPU topology and correct cache topology.

David. This changelog is pretty useless. First of all, please do not use
'This patch ..'. We all know already that this is a patch.
Documentation/process/submitting-patches.rst has a good explanation about
writing changelogs.

The changelog should explain why it does something. Let me give you an
example:

  Centaur CPUs enumerate the cache topology in the same way as Intel CPUs,
  but the functionality is unused so far. The Centaur init code also misses
  to initialize x86_cpuinfo::max_cores so the CPU topology cannot be
  desribed correctly,

  Initialize x86_cpuinfo::max_cores and invoke init_intel_cacheinfo() to
  make CPU and cache topology information available and correct.

See? I'm neither using 'this patch' nor 'We/I' as I'm not impersonatimg the
code. It's all factual instead.
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/centaur.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
> index e5ec0f1..713e4db 100644
> --- a/arch/x86/kernel/cpu/centaur.c
> +++ b/arch/x86/kernel/cpu/centaur.c
> @@ -112,6 +112,19 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
>  	}
>  }
>  
> +static int centaur_num_cpu_cores(struct cpuinfo_x86 *c)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	if (c->cpuid_level < 4)
> +		return 1;
> +	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
> +	if (eax & 0x1f)
> +		return (eax >> 26) + 1;
> +	else
> +		return 1;

This is a bad copy of intel_num_cpu_cores(). See for the subtle
difference. Please rename the intel function and move it to common.c

>  static void init_centaur(struct cpuinfo_x86 *c)
>  {
>  #ifdef CONFIG_X86_32
> @@ -128,6 +141,13 @@ static void init_centaur(struct cpuinfo_x86 *c)
>  	clear_cpu_cap(c, 0*32+31);
>  #endif
>  	early_init_centaur(c);
> +
> +	init_intel_cacheinfo(c);
> +	c->x86_max_cores = centaur_num_cpu_cores(c);
> +#ifdef CONFIG_X86_32
> +	detect_ht(c);
> +#endif

Can you please create a stub inline of detect_ht() for the !32bit case and
get rid of these #ifdefs in the code. That wants to be a separate patch
which also cleans up the existing call sites.

Thanks,

	tglx
