Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbeEVVEI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:04:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54772 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbeEVVEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:04:07 -0400
Subject: Re: [PATCH V4 13/38] x86/intel_rdt: Introduce "bit_usage" to display
 cache allocations details
To: Reinette Chatre <reinette.chatre@intel.com>, tglx@linutronix.de,
        fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1526987654.git.reinette.chatre@intel.com>
 <ce0208727776e5a523657ce5607325fc6c33cf98.1526987654.git.reinette.chatre@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <06e4e2d6-aeb0-21c1-1472-47c14ff37f00@infradead.org>
Date: Tue, 22 May 2018 14:03:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ce0208727776e5a523657ce5607325fc6c33cf98.1526987654.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 04:29 AM, Reinette Chatre wrote:
> With cache regions now explicitly marked as "shareable" or "exclusive"
> we would like to communicate to the user how portions of the cache
> are used.
> 
> Introduce "bit_usage" that indicates for each resource
> how portions of the cache are configured to be used.
> 
> To assist the user to distinguish whether the sharing is from software or
> hardware we add the following annotation:
> 
> 0 - currently unused
> X - currently available for sharing and used by software and hardware
> H - currently used by hardware only but available for software use
> S - currently used and shareable by software only
> E - currently used exclusively by one resource group
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 79 ++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 

Hi,

All occurrences of seq_puts(f, one_char_string); should instead be
seq_putc(f, one_char);

Same for patch 14.

> diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> index 5b78b4aa1a50..d0040f83532d 100644
> --- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> @@ -714,6 +714,78 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +/**
> + * rdt_bit_usage_show - Display current usage of resources
> + *
> + * A domain is a shared resource that can now be allocated differently. Here
> + * we display the current regions of the domain as an annotated bitmask.
> + * For each domain of this resource its allocation bitmask
> + * is annotated as below to indicate the current usage of the corresponding bit:
> + *   0 - currently unused
> + *   X - currently available for sharing and used by software and hardware
> + *   H - currently used by hardware only but available for software use
> + *   S - currently used and shareable by software only
> + *   E - currently used exclusively by one resource group
> + */
> +static int rdt_bit_usage_show(struct kernfs_open_file *of,
> +			      struct seq_file *seq, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	u32 sw_shareable, hw_shareable, exclusive;
> +	struct rdt_domain *dom;
> +	int i, hwb, swb, excl;
> +	enum rdtgrp_mode mode;
> +	bool sep = false;
> +	u32 *ctrl;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +	hw_shareable = r->cache.shareable_bits;
> +	list_for_each_entry(dom, &r->domains, list) {
> +		if (sep)
> +			seq_puts(seq, ";");
> +		ctrl = dom->ctrl_val;
> +		sw_shareable = 0;
> +		exclusive = 0;
> +		seq_printf(seq, "%d=", dom->id);
> +		for (i = 0; i < r->num_closid; i++, ctrl++) {
> +			if (!closid_allocated(i))
> +				continue;
> +			mode = rdtgroup_mode_by_closid(i);
> +			switch (mode) {
> +			case RDT_MODE_SHAREABLE:
> +				sw_shareable |= *ctrl;
> +				break;
> +			case RDT_MODE_EXCLUSIVE:
> +				exclusive |= *ctrl;
> +				break;
> +			case RDT_NUM_MODES:
> +				WARN(1,
> +				     "invalid mode for closid %d\n", i);
> +				break;
> +			}
> +		}
> +		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
> +			hwb = test_bit(i, (unsigned long *)&hw_shareable);
> +			swb = test_bit(i, (unsigned long *)&sw_shareable);
> +			excl = test_bit(i, (unsigned long *)&exclusive);
> +			if (hwb && swb)
> +				seq_puts(seq, "X");
> +			else if (hwb && !swb)
> +				seq_puts(seq, "H");
> +			else if (!hwb && swb)
> +				seq_puts(seq, "S");
> +			else if (excl)
> +				seq_puts(seq, "E");
> +			else /* Unused bits remain */
> +				seq_puts(seq, "0");
> +		}
> +		sep = true;
> +	}
> +	seq_puts(seq, "\n");
> +	mutex_unlock(&rdtgroup_mutex);
> +	return 0;
> +}


-- 
~Randy
