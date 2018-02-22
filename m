Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeBVLod (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:44:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:40403 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753665AbeBVLoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:44:32 -0500
Date: Thu, 22 Feb 2018 12:44:13 +0100
From: Borislav Petkov <bp@suse.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [v2 3/3] x86/microcode: Quiesce all threads before a microcode
 update.
Message-ID: <20180222114413.GB27489@pd.tnic>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
 <1519281205-58951-4-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519281205-58951-4-git-send-email-ashok.raj@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 10:33:25PM -0800, Ashok Raj wrote:
> Microcode updates during OS load always assumed the other hyper-thread
> was "quiet", but Linux never really did this. We've recently received
> several issues on this, where things did not go well at scale
> deployments, and the Intel microcode team asked us to make sure the
> system is in a quiet state during these updates. Such updates are
> rare events, so we use stop_machine() to ensure the whole system is
> quiet.
> 
> The most robust solution is to have all the CPUs wait in
> stop_machine() rendezvous before ucode update, and ensure we stay there
> until all the CPUs have completed the microcode load. stop_machine ensures
> that interrupts are disabled while waiting, and a spin_lock serializes
> that only 1 cpu can perform the update.
> 
> Remember microcode resources are shared between the HT siblings of the same
> core. So updating microcode on one thread automatically is good enough for the
> sibling thread. Microcode update ensures that the version being updated is
> greater than what is reported by the CPU. This ensures we do not perform a
> redundant load on the HT sibling when one isn't necessary.
> 
> During early boot, we bring up one CPU at a time. Hence we only end up
> loading for one of the sibling thread and subsequent sibling would already have
> the latest copy of the microcode.
> 
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
> 
> Changes from V1:
> - Check for return code of stop_machine
> - When microcode file load fails, stop on first error.
> - If any of the present CPUs are offline, then stop reload.
> - Added more comments in commitlog and inline in file.
> - split some functionality from reload_store() per Boris's comments.
> 
> What's not done from review: TBD:
> - Load microcode file only once.
> - Removing ucd->errors. (Gives a count of failed loads)
> ---
>  arch/x86/kernel/cpu/microcode/core.c  | 207 ++++++++++++++++++++++++++++++----
>  arch/x86/kernel/cpu/microcode/intel.c |   1 +
>  2 files changed, 183 insertions(+), 25 deletions(-)

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index aa1b9a4..20d2cbb 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -31,6 +31,10 @@
>  #include <linux/cpu.h>
>  #include <linux/fs.h>
>  #include <linux/mm.h>
> +#include <linux/nmi.h>
> +#include <linux/stop_machine.h>
> +#include <linux/delay.h>
> +#include <linux/topology.h>
>  
>  #include <asm/microcode_intel.h>
>  #include <asm/cpu_device_id.h>
> @@ -489,30 +493,185 @@ static void __exit microcode_dev_exit(void)
>  /* fake device for request_firmware */
>  static struct platform_device	*microcode_pdev;
>  
> -static enum ucode_state reload_for_cpu(int cpu)
> +static struct ucode_update_param {
> +	spinlock_t ucode_lock;	/* Serialize microcode updates */
> +	atomic_t   count;  	/* # of CPUs that attempt to load ucode */
> +	atomic_t   errors; 	/* # of CPUs ucode load failed */
> +	atomic_t   enter;  	/* ucode rendezvous count */
> +	int	   timeout;	/* Timeout to wait for all cpus to enter */
> +} uc_data;
> +
> +static int do_ucode_update(int cpu, struct ucode_update_param *ucd)
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
> +	if (retval > UCODE_NFOUND) {
> +		atomic_inc(&ucd->errors);
> +		pr_warn("microcode update to CPU %d failed\n", cpu);
> +	}
> +	atomic_inc(&ucd->count);
> +
> +	return retval;
> +}
> +
> +/*
> + * Wait for upto 1sec for all CPUs
> + * to show up in the rendezvous function
> + */
> +#define MAX_UCODE_RENDEZVOUS	1000000000 /* nanosec */

Please incorporate all review comments before sending the next version.
I already commented here:

	                                1 * NSEC_PER_SEC

I don't want to be pointing out the same issues twice.

> +#define SPINUNIT		100	   /* 100ns */
> +
> +/*
> + * Each cpu waits for 1sec max.
> + */
> +static int microcode_wait_timedout(int *time_out, void *data)
> +{
> +	struct ucode_update_param *ucd = data;
> +	if (*time_out < SPINUNIT) {
> +		pr_err("Not all CPUs entered ucode update handler %d CPUs missed rendezvous\n",
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

Ok, I think Ingo and I already pointed out that the proper spelling
is "CPU" not "cpu" or "cpu's" as I see it somewhere else *still* in
this patch. And I asked you already yesterday to go over everything and
correct that. But you're still sending me half-baked stuff. Are you
trying to make me ignore your patches?

...


> +/*
> + * loads microcode files for all cpus.
> + * TBD: We load for each cpu which is useful
> + * if we support hetero cores. We really don't yet
> + * support hetero, so we could optimize this in future to load

Let's just forget the heterogeneous cores. That's just nuts.

> + * just for 1 cpu and reuse the same image for other cpus.
> + */
> +static int reload_microcode_files(void)
> +{
> +	int cpu, ret = 0;
> +
> +	/*
> +	 * First load the microcode file for all cpu's
> +	 */
> +	for_each_online_cpu(cpu) {
> +		ret = microcode_ops->request_microcode_fw(cpu,
> +				&microcode_pdev->dev, true);

So looking at this more:

->request_microcode_fw() calls generic_load_microcode() which ends up saving the
microcode patch for early loading: save_mc_for_early() -> save_microcode_patch()
so the new patch is in the microcode cache.

Now, apply_microcode_intel() looks for a newer patch in the cache so you
should be able to do ->request_microcode_fw() only once on CPU 0 and
then the patch is there.

So I *think* you don't need that reload_microcode_files() dance but
you'll have to try it.

> +		if (ret > UCODE_NFOUND) {
> +			pr_warn("Error reloading microcode file for CPU %d\n", cpu);
> +
> +			/*
> +			 * set retval for the first encountered reload error
> +			 * stop further processing of ucode loads.
> +			 */
> +			if (!ret)
> +				ret = -EINVAL;
> +			break;
> +		}
> +	}
> +	return ret;

Also, I'd like you to split this patch as it is becoming too big and
unwieldy to review. Split it in logical steps which contain one logical
change and commit message explains clearly what it is.

Thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
