Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755387AbeEaNzs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:55:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:54692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755261AbeEaNzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:55:45 -0400
Date: Thu, 31 May 2018 15:55:42 +0200
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        alek.du@intel.com
Subject: Re: [RFC 2/2] x86, tsc: Enable clock for ealry printk timestamp
Message-ID: <20180531135542.4j7w7bxsw43ydx3j@pathway.suse.cz>
References: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
 <1527672059-6225-2-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527672059-6225-2-git-send-email-feng.tang@intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-05-30 17:20:59, Feng Tang wrote:
> To show time info in kernel log earlier and help optimizing kernel
> boot time, printk adds a debug hook "boot_printk_clock_fn()"  for
> capable platform which has accurate clock in early boot phase.
> 
> This patch will add early param setup option, so that user can
> chose to provide a tsc based early printk clock simply by adding
> in command line: "boot_tsc=xxxxM" (xxxxM is the stable TSC freq).
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  arch/x86/kernel/tsc.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 74392d9..d99eb70 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -281,6 +281,57 @@ static int __init tsc_setup(char *str)
>  
>  __setup("tsc=", tsc_setup);
>  
> +
> +/*
> + * This is to provide a not-so-accurate clock for printk timestamp in
> + * early boot phase (before sched_clock is setup).It could be used for
> + * analyzing/optimising kernel boot time and tools like bootchart.
> + *
> + * User can use it by simply append something like
> + *	"boot_tsc=1881M"
> + * to cmdline for a platform with a stable 1881MHz TSC.
> + */
> +static u64 boot_tsc_mhz;
> +static u64 boot_tsc_offset;
> +
> +static u64 boot_tsc_clock(void)
> +{
> +	u64 cur_tsc, cur_ns;
> +
> +	cur_tsc	= rdtsc();
> +	cur_tsc -= boot_tsc_offset;
> +
> +	/* return value in ns */
> +	cur_ns = div64_u64(cur_tsc * 1000, boot_tsc_mhz);
> +	return cur_ns;
> +}
> +
> +static int __init boot_tsc_setup(char *p)
> +{
> +	u64 tsc_hz;
> +
> +	if (!p)
> +		return -EINVAL;
> +
> +	boot_tsc_offset = rdtsc();
> +
> +	tsc_hz = memparse(p, &p);
> +	boot_tsc_mhz = div64_u64(tsc_hz, 1024 * 1024);
> +	if (boot_tsc_mhz == 0)
> +		return -EINVAL;
> +
> +	pr_info("TSC has run for %lld us\n",
> +		div64_u64(boot_tsc_offset, boot_tsc_mhz));
> +
> +	/* Setup the early printk clock */
> +	boot_printk_clock_fn = boot_tsc_clock;

I wonder if we could get some cleaner integration into the timer and
printk code.

I wonder if we could hide this under the existing timer interface.
For example, local_clock() could provide values from this non-accurate
timer and then transparently continue with the proper counting.
The proper counting will not start from zero but from the offset
reached by boot_tsc().

Best Regards,
Petr


> +	pr_info("TSC: Setup early printk timestamp with %lldM TSC.",
> +		boot_tsc_mhz);
> +
> +	return 0;
> +}
> +early_param("boot_tsc", boot_tsc_setup);
> +
>  #define MAX_RETRIES     5
>  #define SMI_TRESHOLD    50000
>  
> -- 
> 2.7.4
> 
