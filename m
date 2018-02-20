Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753299AbeBTRPd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 12:15:33 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:33516 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753159AbeBTRPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 12:15:32 -0500
Date: Tue, 20 Feb 2018 18:15:30 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Reinette Chatre <reinette.chatre@intel.com>
cc: fenghua.yu@intel.com, tony.luck@intel.com, gavin.hindman@intel.com,
        vikas.shivappa@linux.intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 13/22] x86/intel_rdt: Support schemata write -
 pseudo-locking core
In-Reply-To: <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1802200059240.1853@nanos.tec.linutronix.de>
References: <cover.1518443616.git.reinette.chatre@intel.com> <dbf01ddf087e4597f86a85c1c91c1fc942e70269.1518443616.git.reinette.chatre@intel.com>
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
>  static void __pseudo_lock_region_release(struct pseudo_lock_region *plr)
>  {
>  	bool is_new_plr = (plr == new_plr);
> @@ -93,6 +175,23 @@ static void __pseudo_lock_region_release(struct pseudo_lock_region *plr)
>  	if (!plr->deleted)
>  		return;
>  
> +	if (plr->locked) {
> +		plr->d->plr = NULL;
> +		/*
> +		 * Resource groups come and go. Simply returning this
> +		 * pseudo-locked region's bits to the default CLOS may
> +		 * result in default CLOS to become fragmented, causing
> +		 * the setting of its bitmask to fail. Ensure it is valid
> +		 * first. If this check does fail we cannot return the bits
> +		 * to the default CLOS and userspace intervention would be
> +		 * required to ensure portions of the cache do not go
> +		 * unused.
> +		 */
> +		if (cbm_validate_val(plr->d->ctrl_val[0] | plr->cbm, plr->r))
> +			pseudo_lock_clos_set(plr, 0,
> +					     plr->d->ctrl_val[0] | plr->cbm);
> +		pseudo_lock_region_clear(plr);
> +	}
>  	kfree(plr);
>  	if (is_new_plr)
>  		new_plr = NULL;

Are you really sure that the life time rules of plr are correct vs. an
application which still has the locked memory mapped? i.e. the following
operation:

1# create_pseudo_lock_region()

					2# start_app()
					   fd = open(/dev/.../lock);
					   ptr = mmap(fd, .....); <- takes a ref on fd
					   close(fd);
					   do_stuff(ptr);

1# rmdir .../lock

					   unmap(ptr);	<- releases fd

I can't see how that is protected. You already have a kref in the PLR, but
it's in no way connected to the file descriptor lifetime.  So the refcount
logic here must be:

create_lock_region()
	plr = alloc_plr();
	take_ref(plr);
	if (!init_plr(plr)) {
		drop_ref(plr);
		...
	}

lockdev_open(filp)
	take_ref(plr);
	filp->private = plr;

rmdir_lock_region()
	...
	drop_ref(plr);

lockdev_relese(filp)
	filp->private = NULL;
	drop_ref(plr);

>  /*
> + * Only one pseudo-locked region can be set up at a time and that is
> + * enforced by taking the rdt_pseudo_lock_mutex when the user writes the
> + * requested schemata to the resctrl file and releasing the mutex on
> + * completion. The thread locking the kernel memory into the cache starts
> + * and completes during this time so we can be sure that only one thread
> + * can run at any time.
> + * The functions starting the pseudo-locking thread needs to wait for its
> + * completion and since there can only be one we have a global workqueue
> + * and variable to support this.
> + */
> +static DECLARE_WAIT_QUEUE_HEAD(wq);
> +static int thread_done;

Eew. For one, you really couldn't come up with more generic and less
relatable variable names, right?

That aside, its just wrong to build code based on current hardware
limitations. The waitqueue and the result code belong into PLR.

> +/**
> + * pseudo_lock_fn - Load kernel memory into cache
> + *
> + * This is the core pseudo-locking function.
> + *
> + * First we ensure that the kernel memory cannot be found in the cache.
> + * Then, while taking care that there will be as little interference as
> + * possible, each cache line of the memory to be loaded is touched while
> + * core is running with class of service set to the bitmask of the
> + * pseudo-locked region. After this is complete no future CAT allocations
> + * will be allowed to overlap with this bitmask.
> + *
> + * Local register variables are utilized to ensure that the memory region
> + * to be locked is the only memory access made during the critical locking
> + * loop.
> + */
> +static int pseudo_lock_fn(void *_plr)
> +{
> +	struct pseudo_lock_region *plr = _plr;
> +	u32 rmid_p, closid_p;
> +	unsigned long flags;
> +	u64 i;
> +#ifdef CONFIG_KASAN
> +	/*
> +	 * The registers used for local register variables are also used
> +	 * when KASAN is active. When KASAN is active we use a regular
> +	 * variable to ensure we always use a valid pointer, but the cost
> +	 * is that this variable will enter the cache through evicting the
> +	 * memory we are trying to lock into the cache. Thus expect lower
> +	 * pseudo-locking success rate when KASAN is active.
> +	 */

I'm not a real fan of this mess. But well, 

> +	unsigned int line_size;
> +	unsigned int size;
> +	void *mem_r;
> +#else
> +	register unsigned int line_size asm("esi");
> +	register unsigned int size asm("edi");
> +#ifdef CONFIG_X86_64
> +	register void *mem_r asm("rbx");
> +#else
> +	register void *mem_r asm("ebx");
> +#endif /* CONFIG_X86_64 */
> +#endif /* CONFIG_KASAN */
> +
> +	/*
> +	 * Make sure none of the allocated memory is cached. If it is we
> +	 * will get a cache hit in below loop from outside of pseudo-locked
> +	 * region.
> +	 * wbinvd (as opposed to clflush/clflushopt) is required to
> +	 * increase likelihood that allocated cache portion will be filled
> +	 * with associated memory

Sigh.

> +	 */
> +	wbinvd();
> +
> +	preempt_disable();
> +	local_irq_save(flags);

preempt_disable() is pointless when you disable interrupts.  And this
really should be local_irq_disable(). This code is always called with
interrupts enabled....

> +	/*
> +	 * Call wrmsr and rdmsr as directly as possible to avoid tracing
> +	 * clobbering local register variables or affecting cache accesses.
> +	 */

You probably want to make sure that the code below is in L1 cache already
before the CLOSID is set to the allocation. To do this you want to put the
preload mechanics into a separate ASM function.

Then you run it with size = 1 on some other temporary memory buffer with
the default CLOSID, which has the CBM bits of the lock region excluded,
Then switch to the real CLOSID and run the loop with the real buffer and
the real size.

> +	__wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);

This wants an explanation why the prefetcher needs to be disabled.

> +static int pseudo_lock_doit(struct pseudo_lock_region *plr,
> +			    struct rdt_resource *r,
> +			    struct rdt_domain *d)
> +{
> +	struct task_struct *thread;
> +	int closid;
> +	int ret, i;
> +
> +	/*
> +	 * With the usage of wbinvd we can only support one pseudo-locked
> +	 * region per domain at this time.

This really sucks.

> +	 */
> +	if (d->plr) {
> +		rdt_last_cmd_puts("pseudo-locked region exists on cache\n");
> +		return -ENOSPC;

This check is not sufficient for a CPU which has both L2 and L3 allocation
capability. If there is already a L3 locked region and the current call
sets up a L2 locked region then this will not catch it and the following
wbinvd will wipe the L3 locked region ....

> +	}
> +
> +	ret = pseudo_lock_region_init(plr, r, d);
> +	if (ret < 0)
> +		return ret;
> +
> +	closid = closid_alloc();
> +	if (closid < 0) {
> +		ret = closid;
> +		rdt_last_cmd_puts("unable to obtain free closid\n");
> +		goto out_region;
> +	}
> +
> +	/*
> +	 * Ensure we end with a valid default CLOS. If a pseudo-locked
> +	 * region in middle of possible bitmasks is selected it will split
> +	 * up default CLOS which would be a fault and for which handling
> +	 * is unclear so we fail back to userspace. Validation will also
> +	 * ensure that default CLOS is not zero, keeping some cache
> +	 * available to rest of system.
> +	 */
> +	if (!cbm_validate_val(d->ctrl_val[0] & ~plr->cbm, r)) {
> +		ret = -EINVAL;
> +		rdt_last_cmd_printf("bm 0x%x causes invalid clos 0 bm 0x%x\n",
> +				    plr->cbm, d->ctrl_val[0] & ~plr->cbm);
> +		goto out_closid;
> +	}
> +
> +	ret = pseudo_lock_clos_set(plr, 0, d->ctrl_val[0] & ~plr->cbm);

Fiddling with the default CBM is wrong. The lock operation should only
succeed when the bits in that domain are not used by _ANY_ control group
including the default one. This is a reasonable constraint.

> +	if (ret < 0) {
> +		rdt_last_cmd_printf("unable to set clos 0 bitmask to 0x%x\n",
> +				    d->ctrl_val[0] & ~plr->cbm);
> +		goto out_closid;
> +	}
> +
> +	ret = pseudo_lock_clos_set(plr, closid, plr->cbm);
> +	if (ret < 0) {
> +		rdt_last_cmd_printf("unable to set closid %d bitmask to 0x%x\n",
> +				    closid, plr->cbm);
> +		goto out_clos_def;
> +	}
> +
> +	plr->closid = closid;
> +
> +	thread_done = 0;
> +
> +	thread = kthread_create_on_node(pseudo_lock_fn, plr,
> +					cpu_to_node(plr->cpu),
> +					"pseudo_lock/%u", plr->cpu);
> +	if (IS_ERR(thread)) {
> +		ret = PTR_ERR(thread);
> +		rdt_last_cmd_printf("locking thread returned error %d\n", ret);
> +		/*
> +		 * We do not return CBM to newly allocated CLOS here on
> +		 * error path since that will result in a CBM of all
> +		 * zeroes which is an illegal MSR write.

I'm not sure what you are trying to explain here.

If you remove a ctrl group then the CBM bits are not added to anything
either. It's up to the operator to handle that. Why would this be any
different for the pseudo-locking stuff?

> +		 */
> +		goto out_clos_def;
> +	}
> +
> +	kthread_bind(thread, plr->cpu);
> +	wake_up_process(thread);
> +
> +	ret = wait_event_interruptible(wq, thread_done == 1);
> +	if (ret < 0) {
> +		rdt_last_cmd_puts("locking thread interrupted\n");
> +		goto out_clos_def;

This is broken. If the thread does not get on the CPU for whatever reason
and the process which sets up the region is interrupted then this will
leave the thread in runnable state and once it gets on the CPU it will
happily derefence the freed plr struct and fiddle with the freed memory.

You need to make sure that the thread holds a reference on the plr struct,
which prevents freeing. That includes the CLOSID .....

> +	}
> +
> +	/*
> +	 * closid will be released soon but its CBM as well as CBM of not
> +	 * yet allocated CLOS as stored in the array will remain. Ensure
> +	 * that CBM will be what is currently the default CLOS, which
> +	 * excludes pseudo-locked region.
> +	 */
> +	for (i = 1; i < r->num_closid; i++) {
> +		if (i == closid || !closid_allocated(i))
> +			pseudo_lock_clos_set(plr, i, d->ctrl_val[0]);
> +	}

This is all magical duct tape. The overall design of this is sideways and
not really well integrated into the existing infrastructure which creates
these kinds of magic warts and lots of duplicated code.

The deeper I read into the patch series the less I like that interface and
the implementation.

Let's look at the existing crtl/mon groups which are each represented by a
directory already.

 - Adding a 'size' file to the ctrl groups would be a natural extension
   which makes sense for regular cache allocations as well.

 - Adding a 'exclusive' flag would be an interesting feature even for the
   normal use case. Marking a group as exclusive prevents other groups to
   request CBM bits which are held by a exclusive allocation.

   I'd suggest to have a file 'mode' for controlling this. The valid values
   would be something like 'shareable' and 'exclusive'.

   When trying to set a group to exclusive mode then the schemata has to be
   checked for overlaps with the other schematas and in case of conflict
   the write fails. Once enabled subsequent writes to the schemata file
   need to be checked for conflicts as well.

   If the exclusive setting is enabled then the CBM bits of that group
   are excluded from being used in other control groups.

Aside of that a file in the info directory which shows the (un)used CBM
bits of all groups is really helpful for controlling all of that (even w/o
pseudo locking). You have this in the 'avail' file, but there is no reason
why this should only be available for pseudo locking enabled systems.

Now for the pseudo locking part.

What you need on top of the above is a new 'mode': 'locked'. That mode
utilizes the 'exclusive' mode rules vs. conflict checking and the
protection against allocating the associated CBM bits in other control
groups.

The setup would be like this:

    mkdir group
    echo '$CONFIG' >group/schemata
    echo 'locked' >group/mode

Setting mode to locked locks down the schemata file along with the
task/cpus/cpus_list files. The task/cpu files need to be empty when
entering locked mode, otherwise the operation fails. I'd even would not
bother handing back the CLOSID. For simplicity the CLOSID should just stay
associated with the control group until it is destroyed as any other
control group.

Now the remaining thing is the memory allocation and the mmap itself. I
really dislike the preallocation of memory right at setup time. Ideally
that should be an allocation of the application itself, but the horrid
wbinvd stuff kinda prevents that. With that restriction we are more or less
bound to immediate allocation and population.

Thanks,

	tglx
