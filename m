Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932269AbeBSVBj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 16:01:39 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60241 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbeBSVBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 16:01:38 -0500
Date: Mon, 19 Feb 2018 22:01:41 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 08/22] x86/intel_rdt: Introduce pseudo-locking
 resctrl files
In-Reply-To: <fadd2bd34f8cff46ecaf1071d2ff93340c683ed1.1518443616.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1802192158210.1853@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <fadd2bd34f8cff46ecaf1071d2ff93340c683ed1.1518443616.git.reinette.chatre@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2018, Reinette Chatre wrote:
> diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
> index 7a22e367b82f..94bd1b4fbfee 100644
> --- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
> @@ -40,6 +40,7 @@ static DEFINE_MUTEX(rdt_pseudo_lock_mutex);
>   * @kn:			kernfs node representing this region in the resctrl
>   *			filesystem
>   * @cbm:		bitmask of the pseudo-locked region
> + * @size:		size of pseudo-locked region in bytes
>   * @cpu:		core associated with the cache on which the setup code
>   *			will be run
>   * @minor:		minor number of character device associated with this
> @@ -52,6 +53,7 @@ static DEFINE_MUTEX(rdt_pseudo_lock_mutex);
>  struct pseudo_lock_region {
>  	struct kernfs_node	*kn;
>  	u32			cbm;
> +	unsigned int		size;
>  	int			cpu;
>  	unsigned int		minor;
>  	bool			locked;
> @@ -227,6 +229,49 @@ static struct kernfs_ops pseudo_lock_avail_ops = {
>  	.seq_show		= pseudo_lock_avail_show,
>  };
>  
> +int pseudo_lock_schemata_show(struct kernfs_open_file *of,
> +			      struct seq_file *seq, void *v)
> +{
> +	struct pseudo_lock_region *plr;
> +	struct rdt_resource *r;
> +	int ret = 0;
> +
> +	plr = pseudo_lock_region_kn_lock(of->kn);
> +	if (!plr) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	if (!plr->locked) {
> +		for_each_alloc_enabled_rdt_resource(r) {
> +			seq_printf(seq, "%s:uninitialized\n", r->name);
> +		}

Surplus braces around the for_...()

Thanks,

	tglx
