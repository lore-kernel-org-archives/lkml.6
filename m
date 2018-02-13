Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965565AbeBMRCm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:02:42 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51114 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965057AbeBMRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:02:41 -0500
Date: Tue, 13 Feb 2018 18:02:31 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/intel: Use 64-bit arithmetic instead of
 32-bit
In-Reply-To: <20180213164404.GA11664@embeddedor.com>
Message-ID: <alpine.DEB.2.21.1802131747290.1130@nanos.tec.linutronix.de>
References: <20180213164404.GA11664@embeddedor.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018, Gustavo A. R. Silva wrote:

> Add suffix ULL to constant 1024 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> u64 (64 bits, unsigned).
> 
> The expression c->x86_cache_size * 1024 is currently being evaluated
> using 32-bit arithmetic.
> 
> Addresses-Coverity-ID: 1464429
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index f7c55b0..e5edb92 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -982,7 +982,7 @@ static struct microcode_ops microcode_intel_ops = {
>  
>  static int __init calc_llc_size_per_core(struct cpuinfo_x86 *c)
>  {
> -	u64 llc_size = c->x86_cache_size * 1024;
> +	u64 llc_size = c->x86_cache_size * 1024ULL;

x86_cache_size is 'int', so you really want to cast c->x86_cache_size to
(u64) for correctness sake. 

Aside of that the patch is really purely cosmetic at the moment because the
largest LLC sizes are still below the 3 digit MB range which fits into
32bit quite well. You'd need to have a CPU with >= 2G LLC to create a
problem.

But looking at c->x86_cache_size again. It's int because it's set to -1
initially which is then changed if CPUid or general CPU info gives real
information about the cache size. The only place where that matters is the
/proc/cpuinfo output:

	if (c->x86_cache_size >= 0)
		seq_printf(m, "cache size\t: %d KB\n", c->x86_cache_size);

which is silly, because that really can be done with:

	if (c->x86_cache_size)

as there is no point in printing 'cache size 0KB', which means
x86_cache_size can be made unsigned int, which makes sense because cache
size < 0 does not at all.

So instead of doing this purely mechanical cosmetic change to make a static
checker shut up, I'd like to see a proper cleanup of that thing.

Thanks,

	tglx
