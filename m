Date: Tue, 22 May 2018 21:43:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
	vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
	jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 34/38] x86/intel_rdt: Create debugfs files for
 pseudo-locking testing
Message-ID: <20180522194300.GA9656@kroah.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
 <2da8730575c589eb7303c7b18a2721da40c446e2.1526987654.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2da8730575c589eb7303c7b18a2721da40c446e2.1526987654.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 04:29:22AM -0700, Reinette Chatre wrote:
> @@ -149,6 +151,9 @@ struct pseudo_lock_region {
>  	unsigned int		line_size;
>  	unsigned int		size;
>  	void			*kmem;
> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
> +	struct dentry		*debugfs_dir;
> +#endif

Who cares, just always have this here, it's not going to save you
anything to #ifdef the .c code everywhere just for this one pointer.

> @@ -174,6 +180,9 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
>  		plr->d->plr = NULL;
>  	plr->d = NULL;
>  	plr->cbm = 0;
> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
> +	plr->debugfs_dir = NULL;
> +#endif

See?  Ick.

> +	ret = strtobool(buf, &bv);
> +	if (ret == 0 && bv) {
> +		ret = debugfs_file_get(file->f_path.dentry);
> +		if (unlikely(ret))
> +			return ret;

Only ever use unlikely/likely if you can measure the performance
difference.  Hint, you can't do that here, it's not needed at all.

> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
> +	plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
> +					      debugfs_resctrl);
> +	if (IS_ERR(plr->debugfs_dir)) {
> +		ret = PTR_ERR(plr->debugfs_dir);
> +		plr->debugfs_dir = NULL;
> +		goto out_region;

Ick no, you never need to care about the return value of a debugfs call.
You code should never do something different if a debugfs call succeeds
or fails.  And you are checking it wrong, even if you did want to do
this :)

> +	}
> +
> +	entry = debugfs_create_file("pseudo_lock_measure", 0200,
> +				    plr->debugfs_dir, rdtgrp,
> +				    &pseudo_measure_fops);
> +	if (IS_ERR(entry)) {
> +		ret = PTR_ERR(entry);
> +		goto out_debugfs;
> +	}

Again, you don't care, don't do this.

> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
> +	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
> +#endif

Don't put ifdefs in .c files, it's not the Linux way at all.  You can
make this a lot simpler/easier to maintain over time if you do not.

thanks,

greg k-h
