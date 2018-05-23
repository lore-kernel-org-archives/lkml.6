Date: Wed, 23 May 2018 10:05:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
	vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
	jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 34/38] x86/intel_rdt: Create debugfs files for
 pseudo-locking testing
Message-ID: <20180523080501.GA6822@kroah.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
 <2da8730575c589eb7303c7b18a2721da40c446e2.1526987654.git.reinette.chatre@intel.com>
 <20180522194300.GA9656@kroah.com>
 <b32a1e6a-1675-0c96-69d3-75bc97a672b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32a1e6a-1675-0c96-69d3-75bc97a672b4@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 02:02:37PM -0700, Reinette Chatre wrote:
> Hi Greg,
> 
> Thank you very much for taking a look.
> 
> On 5/22/2018 12:43 PM, Greg KH wrote:
> > On Tue, May 22, 2018 at 04:29:22AM -0700, Reinette Chatre wrote:
> >> @@ -149,6 +151,9 @@ struct pseudo_lock_region {
> >>  	unsigned int		line_size;
> >>  	unsigned int		size;
> >>  	void			*kmem;
> >> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
> >> +	struct dentry		*debugfs_dir;
> >> +#endif
> > 
> > Who cares, just always have this here, it's not going to save you
> > anything to #ifdef the .c code everywhere just for this one pointer.
> 
> ok
> 
> > 
> >> @@ -174,6 +180,9 @@ static void pseudo_lock_region_clear(struct pseudo_lock_region *plr)
> >>  		plr->d->plr = NULL;
> >>  	plr->d = NULL;
> >>  	plr->cbm = 0;
> >> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
> >> +	plr->debugfs_dir = NULL;
> >> +#endif
> > 
> > See?  Ick.
> > 
> >> +	ret = strtobool(buf, &bv);
> >> +	if (ret == 0 && bv) {
> >> +		ret = debugfs_file_get(file->f_path.dentry);
> >> +		if (unlikely(ret))
> >> +			return ret;
> > 
> > Only ever use unlikely/likely if you can measure the performance
> > difference.  Hint, you can't do that here, it's not needed at all.
> 
> Here my intention was to follow the current best practices and in the
> kernel source I am working with eight of the ten usages of
> debugfs_file_get() is followed by an unlikely(). My assumption was thus
> that this is a best practice. Thanks for catching this - I'll change it.

Really?  That's some horrible examples, any pointers to them?  I think I
need to do a massive sweep of the kernel tree and fix up all of this
crud so that people don't keep cut/paste the same bad code everywhere.

> >> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
> >> +	plr->debugfs_dir = debugfs_create_dir(rdtgrp->kn->name,
> >> +					      debugfs_resctrl);
> >> +	if (IS_ERR(plr->debugfs_dir)) {
> >> +		ret = PTR_ERR(plr->debugfs_dir);
> >> +		plr->debugfs_dir = NULL;
> >> +		goto out_region;
> > 
> > Ick no, you never need to care about the return value of a debugfs call.
> > You code should never do something different if a debugfs call succeeds
> > or fails.  And you are checking it wrong, even if you did want to do
> > this :)
> 
> Ah - I see I need to be using IS_ERR_OR_NULL() instead of IS_ERR()? If
> this is the case then please note that there seems to be quite a few
> debugfs_create_dir() calls within the kernel that have the same issue.

Again, they are all wrong :)

Just ignore the return value, unless it is a directory, and then just
save it like you are here.  Don't check the value, you can always pass
it into a future debugfs call with no problems.

> >> +	}
> >> +
> >> +	entry = debugfs_create_file("pseudo_lock_measure", 0200,
> >> +				    plr->debugfs_dir, rdtgrp,
> >> +				    &pseudo_measure_fops);
> >> +	if (IS_ERR(entry)) {
> >> +		ret = PTR_ERR(entry);
> >> +		goto out_debugfs;
> >> +	}
> > 
> > Again, you don't care, don't do this.
> > 
> >> +#ifdef CONFIG_INTEL_RDT_DEBUGFS
> >> +	debugfs_remove_recursive(rdtgrp->plr->debugfs_dir);
> >> +#endif
> > 
> > Don't put ifdefs in .c files, it's not the Linux way at all.  You can
> > make this a lot simpler/easier to maintain over time if you do not.
> 
> My mistake - I assumed this would be ok based on my interpretation of
> how CONFIG_GENERIC_IRQ_DEBUGFS is used.
> 
> I could rework the debugfs code to be contained in a new debugfs
> specific .c file that is only compiled if the configuration is set. The
> ifdefs will then be restricted to a .h file that contains the
> declarations of these debugfs functions with empty variants when the
> user did not select the debugfs config option.
> 
> Would that be acceptable to you?

Yes, that is the correct way to do this.

But why would someone _not_ want this option?  Why not always just
include the functionality, that way you don't have to ask someone to
rebuild a kernel if you need that debug information.  And distros will
always enable the option anyway, so it's not like you are keeping things
"smaller", if you disable debugfs, all of that code should just compile
away to almost nothing anyway.

thanks,

greg k-h
