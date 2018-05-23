Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933446AbeEWOz6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:55:58 -0400
Received: from foss.arm.com ([217.140.101.70]:56646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933132AbeEWOz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:55:57 -0400
Date: Wed, 23 May 2018 15:55:53 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180523145552.GN13470@e103592.cambridge.arm.com>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180517181932.GW7753@e103592.cambridge.arm.com>
 <20180523143156.svl7djkm3obrnkvs@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523143156.svl7djkm3obrnkvs@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 04:31:56PM +0200, Sebastian Andrzej Siewior wrote:
> On 2018-05-17 19:19:43 [+0100], Dave Martin wrote:
> > On Thu, May 17, 2018 at 02:40:06PM +0200, Sebastian Andrzej Siewior wrote:
> > > In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
> > > code disables BH and expects that it is not preemptible. On -RT the
> > > task remains preemptible but remains the same CPU. This may corrupt the
> > 
> > Also, watch out for [1] which adds more of this stuff for KVM.  This
> > not merged yet, but likely to land in v4.18.
> 
> yay. I will try to keep this in mind while moving forward.
> 
> > Anyway:
> > 
> > What we're really trying to achieve with the local_bh_disable/enable
> > stuff is exclusive access to the CPU FPSIMD registers and associated
> > metadata that tracks who they belong to.
> 
> I assumed this.

Yup, it's a common pattern cross-arch.

> > > The preempt_disable() + local_bh_enable() combo in kernel_neon_begin()
> > > is not working on -RT. We don't use NEON in kernel mode on RT right now
> > > but this still should be addressed.
> > 
> > I think we effectively have two levels of locking here.
> > 
> > At the outer level, we want exclusive access to the FPSIMD registers.
> > This is what is needed between kernel_neon_begin() and
> > kernel_neon_end(), and maps onto the preempt_disable()/_enable() done
> > by these functions.
> > 
> > In context switch critical code, that's insufficient, and we also
> > need exclusive access to the metadata that tracks which task or context
> > owns the FPSIMD registers.  This is what the local_bh_disable()/
> > _enable() achieves.
> > 
> > 
> > So does it make sense to have two locks (I'm assuming local locks are
> > implicitly percpu ?)
> > 
> > static inline void local_fpsimd_context_lock(void)
> > {
> > 	local_bh_disable();
> > 	local_lock(fpsimd_lock);
> > 	local_lock(fpsimd_context_lock);
> > }
> > 
> > static inline void local_fpsimd_context_unlock(void)
> > {
> > 	local_unlock(fpsimd_context_lock);
> > 	local_unlock(fpsimd_lock);
> > 	local_bh_enable();
> > }
> > 
> > 
> > kernel_neon_begin() could then do
> > 
> > 	local_fpsimd_context_lock();
> > 
> > 	/* ... */
> > 
> > 	preempt_disable();
> > 	local_unlock(fpsimd_context_lock);
> > 
> > ... with the following in kernel_neon_end():
> > 
> > 	local_unlock(fpsimd_lock);
> > 	preempt_enable();
> > 
> > 
> > If kernel-mode NEON was considered harmful to RT due to the context
> > switch overheads, then the above might be overkill.  SVE will be worse
> > in that regard, and also needs thinking about at some point -- I've not
> > looked at if from the RT angle at all.
> > 
> > In either case, I think abstracting the lock/unlock sequences out to
> > make the purpose clearer may be a good idea, even if we just have a
> > single local lock to manage.
> 
> So the two looks you suggested make sense. However I would need to
> replace this preempt_disable() with one such lock. A local_lock() on -RT
> is a per-CPU spin_lock. RT's local_lock gets currently transformed into
> preempt_disable() on !RT configs.

Thinking about this again, I'm guessing it only really makes sense to
have two local locks if there are two independent reasons to inhibit
migration.

There is only one such reason here: preempt_disable() for the purpose
of using the FPSIMD registers, where local_bh_disable() implies this
and also inhibits local softirqs -- which I'm guessing works just
the same with RT.


So maybe there should really be only one local lock as you suggest.

This gives:

static inline void local_fpsimd_context_lock(void)
{
	local_lock(fpsimd_lock);
	local_bh_disable();
}

static inline void local_fpsimd_context_unlock(void)
{
	local_bh_enable();
	local_unlock(fpsimd_lock);
}

kernel_neon_begin(...)
{
	local_lock(fpsimd_lock);
	local_bh_disable();

	/* ... */

	local_bh_enable();
}

kernel_neon_end(...)
{
	/* ... */

	local_unlock(fpsimd_lock);
}

If the local_{,un}lock() gets transmuted to preempt_{dis,en}enable()
for !RT, then this seems to map on to what we currently have.

(Still guessing about how RT works here, so a health warning is
implied.)


If you abstract things this way, can you please split the non-RT changes
into a separate patch and Cc me?  That would be a nice cleanup for
mainline rather than just having the bare local_bh_ and preempt_ stuff
everywhere.

> 
> > There is one place where I mess with the FPSIMD context no lock held
> > because of a need to copy_from_user() straight into the context backing
> > store (we can't copy_from_user() with preemption disabled...)
> > I'm not sure whether RT will have any impact on this, but it probably
> > needs thinking about.
> 
> if no locks are held and the task can be preempted then it also might
> happen on PREEMPT config. But copy_from_user() doesn't sounds like
> something that will go straight to HW.

We're just copying to memory, so I guess so long as program order is
respected when the task is migrated (which is ensured via heavy barriers
somewhere in the scheduler and/or arch context switch code IIRC) then I
think there should be no problem).  This is a prerequisite for
preemptive migration to work at all, not just on RT.  So I suppose
there's no new problem here.

> 
> > One more comment below...
> > 
> > > 
> > > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > ---
> > >  arch/arm64/kernel/fpsimd.c | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > > index e7226c4c7493..3a5cd1908874 100644
> > > --- a/arch/arm64/kernel/fpsimd.c
> > > +++ b/arch/arm64/kernel/fpsimd.c
> > > @@ -38,6 +38,7 @@
> > >  #include <linux/signal.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/sysctl.h>
> > > +#include <linux/locallock.h>
> > >  
> > >  #include <asm/fpsimd.h>
> > >  #include <asm/cputype.h>
> > > @@ -235,7 +236,7 @@ static void sve_user_enable(void)
> > >   *    whether TIF_SVE is clear or set, since these are not vector length
> > >   *    dependent.
> > >   */
> > > -
> > > +static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
> > >  /*
> > >   * Update current's FPSIMD/SVE registers from thread_struct.
> > >   *
> > > @@ -594,6 +595,7 @@ int sve_set_vector_length(struct task_struct *task,
> > >  	 * non-SVE thread.
> > >  	 */
> > >  	if (task == current) {
> > > +		local_lock(fpsimd_lock);
> > >  		local_bh_disable();
> > >  
> > >  		task_fpsimd_save();
> > > @@ -604,8 +606,10 @@ int sve_set_vector_length(struct task_struct *task,
> > >  	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
> > >  		sve_to_fpsimd(task);
> > >  
> > > -	if (task == current)
> > > +	if (task == current) {
> > > +		local_unlock(fpsimd_lock);
> > 
> > Is this misordered against local_bh_enable(), or doesn't it matter?
> 
> It actually is but it does not matter. On RT local_bh_disable() is
> turned into migrate_disable() what in turn disables the migration of the
> task to another CPU (while it is still preemtible). This
> migrate_disable() is also part of local_lock(). Maybe I will add a
> local_lock_bh() and replace this with this local_bh_disable() so it will
> better :)

Fair enough.

Cheers
---Dave

> 
> > >  		local_bh_enable();
> > > +	}
