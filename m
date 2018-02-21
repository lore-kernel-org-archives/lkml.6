Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeBUTGx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:06:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:46867 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbeBUTG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:06:27 -0500
Date: Wed, 21 Feb 2018 20:06:11 +0100
From: Borislav Petkov <bp@suse.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [PATCH 3/3] x86/microcode: Quiesce all threads before a
 microcode update.
Message-ID: <20180221190611.GE16888@pd.tnic>
References: <1519231784-9941-1-git-send-email-ashok.raj@intel.com>
 <1519231784-9941-4-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519231784-9941-4-git-send-email-ashok.raj@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 08:49:44AM -0800, Ashok Raj wrote:
> Microcode updates during OS load always assumed the other hyperthread
> was "quiet", but Linux never really did this. We've recently received
> several issues on this, where things did not go well at scale
> deployments, and the Intel microcode team asked us to make sure the
> system is in a quiet state during these updates. Such updates are
> rare events, so we use stop_machine() to ensure the whole system is
> quiet.

Ewww, where do I begin?!

I really really hoped that we could avoid nasty dancing like that.

> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Cc: X86 ML <x86@kernel.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Andi Kleen <andi.kleen@intel.com>
> Cc: Boris Petkov <bp@suse.de>
> Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
> ---
>  arch/x86/kernel/cpu/microcode/core.c  | 113 +++++++++++++++++++++++++++++-----

This is generic so Tom needs to ack whatever we end up doing for the AMD
side.

>  arch/x86/kernel/cpu/microcode/intel.c |   1 +
>  2 files changed, 98 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index aa1b9a4..af0aeb2 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -31,6 +31,9 @@
>  #include <linux/cpu.h>
>  #include <linux/fs.h>
>  #include <linux/mm.h>
> +#include <linux/nmi.h>
> +#include <linux/stop_machine.h>
> +#include <linux/delay.h>
>  
>  #include <asm/microcode_intel.h>
>  #include <asm/cpu_device_id.h>
> @@ -489,19 +492,82 @@ static void __exit microcode_dev_exit(void)
>  /* fake device for request_firmware */
>  static struct platform_device	*microcode_pdev;
>  
> -static enum ucode_state reload_for_cpu(int cpu)
> +static struct ucode_update_param {
> +	spinlock_t ucode_lock;
> +	atomic_t   count;
> +	atomic_t   errors;
> +	atomic_t   enter;
> +	int	   timeout;
> +} uc_data;
> +
> +static void do_ucode_update(int cpu, struct ucode_update_param *ucd)
>  {
> -	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
> -	enum ucode_state ustate;
> +	enum ucode_state retval = 0;
>  
> -	if (!uci->valid)
> -		return UCODE_OK;
> +	spin_lock(&ucd->ucode_lock);
> +	retval = microcode_ops->apply_microcode(cpu);
> +	spin_unlock(&ucd->ucode_lock);

What's the spinlock protecting against?

We hold the hotplug lock and the microcode mutex. And yet interrupts are
still enabled. So what's up?


> +	if (retval > UCODE_NFOUND) {
> +		atomic_inc(&ucd->errors);

You don't need ->errors. Simply propagate retval from do_ucode_update().
Or compare ucd->count to the number of CPUs. Or something like that.

> +		pr_warn("microcode update to cpu %d failed\n", cpu);
> +	}
> +	atomic_inc(&ucd->count);
> +}
> +
> +/*
> + * Wait for upto 1sec for all cpus
> + * to show up in the rendezvous function
> + */
> +#define MAX_UCODE_RENDEZVOUS	1000000000 /* nanosec */

				1 * NSEC_PER_SEC

> +#define SPINUNIT		100	   /* 100ns */
> +
> +/*
> + * Each cpu waits for 1sec max.
> + */
> +static int ucode_wait_timedout(int *time_out, void *data)
> +{
> +	struct ucode_update_param *ucd = data;
> +	if (*time_out < SPINUNIT) {
> +		pr_err("Not all cpus entered ucode update handler %d cpus missing\n",
> +			(num_online_cpus() - atomic_read(&ucd->enter)));
> +		return 1;
> +	}
> +	*time_out -= SPINUNIT;
> +	touch_nmi_watchdog();
> +	return 0;
> +}
> +
> +/*
> + * All cpus enter here before a ucode load upto 1 sec.
> + * If not all cpus showed up, we abort the ucode update
> + * and return. ucode update is serialized with the spinlock

... and yet you don't check stop_machine()'s retval and issue an error
message that it failed.

> + */
> +static int ucode_load_rendezvous(void *data)

The correct prefix is "microcode_"

> +{
> +	int cpu = smp_processor_id();
> +	struct ucode_update_param *ucd = data;
> +	int timeout = MAX_UCODE_RENDEZVOUS;
> +	int total_cpus = num_online_cpus();
>  
> -	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, true);
> -	if (ustate != UCODE_OK)
> -		return ustate;
> +	/*
> +	 * Wait for all cpu's to arrive
> +	 */
> +	atomic_dec(&ucd->enter);
> +	while(atomic_read(&ucd->enter)) {
> +		if (ucode_wait_timedout(&timeout, ucd))
> +			return 1;
> +		ndelay(SPINUNIT);
> +	}
> +
> +	do_ucode_update(cpu, ucd);
>  
> -	return apply_microcode_on_target(cpu);
> +	/*
> +	 * Wait for all cpu's to complete
> +	 * ucode update
> +	 */
> +	while (atomic_read(&ucd->count) != total_cpus)
> +		cpu_relax();
> +	return 0;
>  }
>  
>  static ssize_t reload_store(struct device *dev,
> @@ -509,7 +575,6 @@ static ssize_t reload_store(struct device *dev,
>  			    const char *buf, size_t size)
>  {
>  	enum ucode_state tmp_ret = UCODE_OK;
> -	bool do_callback = false;
>  	unsigned long val;
>  	ssize_t ret = 0;
>  	int cpu;
> @@ -523,21 +588,37 @@ static ssize_t reload_store(struct device *dev,
>  
>  	get_online_cpus();
>  	mutex_lock(&microcode_mutex);
> +	/*
> +	 * First load the microcode file for all cpu's
> +	 */

It is always "CPU" or "CPUs". Fix all misspelled places.

>  	for_each_online_cpu(cpu) {

You need to fail loading and not even try when not all cores are online.
And issue an error message.

> -		tmp_ret = reload_for_cpu(cpu);
> +		tmp_ret = microcode_ops->request_microcode_fw(cpu,
> +				&microcode_pdev->dev, true);

This needs to happen only once - not per CPU. Let's simply forget
heterogeneous microcode revisions.

>  		if (tmp_ret > UCODE_NFOUND) {
> -			pr_warn("Error reloading microcode on CPU %d\n", cpu);
> +			pr_warn("Error reloading microcode file for CPU %d\n", cpu);
>  
>  			/* set retval for the first encountered reload error */
>  			if (!ret)
>  				ret = -EINVAL;

You can't continue loading here if you've encountered an error.

>  		}
> -
> -		if (tmp_ret == UCODE_UPDATED)
> -			do_callback = true;
>  	}
> +	pr_debug("Done loading microcode file for all cpus\n");
>  
> -	if (!ret && do_callback)
> +	memset(&uc_data, 0, sizeof(struct ucode_update_param));
> +	spin_lock_init(&uc_data.ucode_lock);
> +	atomic_set(&uc_data.enter, num_online_cpus());
> +	/*
> +	 * Wait for a 1 sec
> +	 */
> +	uc_data.timeout = USEC_PER_SEC;
> +	stop_machine(ucode_load_rendezvous, &uc_data, cpu_online_mask);
> +
> +	pr_debug("Total CPUS = %d uperrors = %d\n",
> +		atomic_read(&uc_data.count), atomic_read(&uc_data.errors));
> +
> +	if (atomic_read(&uc_data.errors))
> +		pr_warn("Update failed for %d cpus\n", atomic_read(&uc_data.errors));
> +	else
>  		microcode_check();

This whole jumping through hoops needs to be extracted away in a
separate function.

Ok, that should be enough review for now. More with v2.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
