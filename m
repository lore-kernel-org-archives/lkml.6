Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966251AbeE2Snd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:43:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40741 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965960AbeE2Sn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:43:29 -0400
X-ME-Proxy: <xmx:UJ8NW4eMw6ggslLPKpSj6PY6wlZl8wR_4vQLta-3zWIVugsouEt-zQ>
X-ME-Proxy: <xmx:UJ8NW0dY6cXl1sQZVOggq5LfPAt84fx9FqPPWQ2UfX3SzlBe4326CA>
X-ME-Proxy: <xmx:UJ8NW4cMY9rYvb1TTWs13FnI0-UsTEHN4PM8HnVbkhscu6Ofg5kAHA>
X-ME-Proxy: <xmx:UJ8NW1m-ILaWIBCYLPyDxl5BRhgBmBw3FZh3Rgj1vGPCxNB16J81IQ>
X-ME-Proxy: <xmx:UJ8NWy4Issud1IbWGWK_MjxbKABpzHiVTjiq574u6S73c3H5Tz9OnA>
X-ME-Proxy: <xmx:UJ8NWwSfBHbYfvHFBWicibLcwtYzqxkumI0fkbY7O6hcQbTziVIvEg>
X-ME-Sender: <xms:UJ8NWyomXQ3edwCF6ZB46pMOo4-uzo8XYxJ3yBhq_rCIu3Yoeruv4w>
Date: Tue, 29 May 2018 20:43:08 +0200
From: Greg KH <greg@kroah.com>
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 10/16] x86/split_lock: Add a debugfs interface to
 allow user to enable or disable #AC for split lock during run time
Message-ID: <20180529184308.GC10618@kroah.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-11-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527435965-202085-11-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 08:45:59AM -0700, Fenghua Yu wrote:
> User wants to enable or disable #AC for split lock during run time.
> 
> The interface /sys/kernel/debug/x86/split_lock/enable is added to allow
> user to control #AC for split lock and show current split lock status
> during run time.
> 
> Writing 1 to the file enables #AC for split lock and writing 0 disables
> #AC for split lock.
> 
> Reading the file shows current eanbled/disabled status of #AC for split
> lock:
> 0: disabled and 1: enabled.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  arch/x86/kernel/cpu/test_ctl.c | 92 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/test_ctl.c b/arch/x86/kernel/cpu/test_ctl.c
> index a2f84fcd4da1..e8b3032f3db0 100644
> --- a/arch/x86/kernel/cpu/test_ctl.c
> +++ b/arch/x86/kernel/cpu/test_ctl.c
> @@ -17,6 +17,7 @@
>  #include <linux/mm.h>
>  #include <linux/reboot.h>
>  #include <linux/syscore_ops.h>
> +#include <linux/debugfs.h>
>  #include <asm/msr.h>
>  
>  #define DISABLE_SPLIT_LOCK_AC		0
> @@ -34,6 +35,14 @@ static DEFINE_MUTEX(reexecute_split_lock_mutex);
>  static int split_lock_ac_kernel = DISABLE_SPLIT_LOCK_AC;
>  static int split_lock_ac_firmware = DISABLE_SPLIT_LOCK_AC;
>  
> +static DEFINE_MUTEX(split_lock_mutex);
> +
> +struct debugfs_file {
> +	char				name[32];
> +	int				mode;
> +	const struct file_operations	*fops;
> +};
> +
>  /* Detete feature of #AC for split lock by probing bit 29 in MSR_TEST_CTL. */
>  void detect_split_lock_ac(void)
>  {
> @@ -292,6 +301,85 @@ static struct syscore_ops split_lock_syscore_ops = {
>  	.resume		= split_lock_bsp_resume,
>  };
>  
> +static int enable_show(void *data, u64 *val)
> +{
> +	*val = split_lock_ac_kernel;
> +
> +	return 0;
> +}
> +
> +static int enable_store(void *data, u64 val)
> +{
> +	u64 msr_val;
> +	int cpu;
> +
> +	if (val != DISABLE_SPLIT_LOCK_AC && val != ENABLE_SPLIT_LOCK_AC)
> +		return -EINVAL;
> +
> +	/* No need to update MSR if new setting is the same as old one. */
> +	if (val == split_lock_ac_kernel)
> +		return 0;
> +
> +	mutex_lock(&split_lock_mutex);
> +	mutex_lock(&reexecute_split_lock_mutex);
> +
> +	/*
> +	 * Wait until it's out of any re-executed split lock instruction
> +	 * window.
> +	 */
> +	wait_for_reexecution();
> +
> +	split_lock_ac_kernel = val;
> +	/* Read split lock setting on the current CPU. */
> +	rdmsrl(MSR_TEST_CTL, msr_val);
> +	/* Change the split lock setting. */
> +	if (split_lock_ac_kernel == DISABLE_SPLIT_LOCK_AC)
> +		msr_val &= ~MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
> +	else
> +		msr_val |= MSR_TEST_CTL_ENABLE_AC_SPLIT_LOCK;
> +	/* Update the split lock setting on all online CPUs. */
> +	for_each_online_cpu(cpu)
> +		wrmsrl_on_cpu(cpu, MSR_TEST_CTL, msr_val);
> +
> +	mutex_unlock(&reexecute_split_lock_mutex);
> +	mutex_unlock(&split_lock_mutex);
> +
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(enable_ops, enable_show, enable_store, "%llx\n");
> +
> +static int __init debugfs_setup_split_lock(void)
> +{
> +	struct debugfs_file debugfs_files[] = {
> +		{"enable",      0600, &enable_ops},
> +	};
> +	struct dentry *split_lock_dir, *fd;
> +	int i;
> +
> +	split_lock_dir = debugfs_create_dir("split_lock", arch_debugfs_dir);
> +	if (!split_lock_dir)
> +		goto out;
> +

No need to test this, just keep moving on.  You should never need to
test the result of any debugfs call at all.


> +	/*  Create files under split_lock_dir. */
> +	for (i = 0; i < ARRAY_SIZE(debugfs_files); i++) {
> +		fd = debugfs_create_file(debugfs_files[i].name,
> +					 debugfs_files[i].mode,
> +					 split_lock_dir, NULL,
> +					 debugfs_files[i].fops);
> +		if (!fd)
> +			goto out_cleanup;

Same here, no need to test anything.

> +	}
> +
> +	return 0;

This function can not fail, might as well make it return void :)

thanks,

greg k-h
