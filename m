Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeEQSTs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:19:48 -0400
Received: from foss.arm.com ([217.140.101.70]:39788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbeEQSTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:19:47 -0400
Date: Thu, 17 May 2018 19:19:43 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180517181932.GW7753@e103592.cambridge.arm.com>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 02:40:06PM +0200, Sebastian Andrzej Siewior wrote:
> In v4.16-RT I noticed a number of warnings from task_fpsimd_load(). The
> code disables BH and expects that it is not preemptible. On -RT the
> task remains preemptible but remains the same CPU. This may corrupt the

Also, watch out for [1] which adds more of this stuff for KVM.  This
not merged yet, but likely to land in v4.18.

> content of the SIMD registers if the task is preempted during
> saving/restoring those registers.
> Add a locallock around next to the local_bh_disable(). This fulfill the
> requirement that the code is not invoked again in different context on
> the same CPU while it remains preemptible.

Thanks for this.

*WARNING*: My RT-fu is weak to nonexistent, so don't assume that
anything I suggest below is correct without thinking carefully about
it :)

Anyway:

What we're really trying to achieve with the local_bh_disable/enable
stuff is exclusive access to the CPU FPSIMD registers and associated
metadata that tracks who they belong to.

> The preempt_disable() + local_bh_enable() combo in kernel_neon_begin()
> is not working on -RT. We don't use NEON in kernel mode on RT right now
> but this still should be addressed.

I think we effectively have two levels of locking here.

At the outer level, we want exclusive access to the FPSIMD registers.
This is what is needed between kernel_neon_begin() and
kernel_neon_end(), and maps onto the preempt_disable()/_enable() done
by these functions.

In context switch critical code, that's insufficient, and we also
need exclusive access to the metadata that tracks which task or context
owns the FPSIMD registers.  This is what the local_bh_disable()/
_enable() achieves.


So does it make sense to have two locks (I'm assuming local locks are
implicitly percpu ?)

static inline void local_fpsimd_context_lock(void)
{
	local_bh_disable();
	local_lock(fpsimd_lock);
	local_lock(fpsimd_context_lock);
}

static inline void local_fpsimd_context_unlock(void)
{
	local_unlock(fpsimd_context_lock);
	local_unlock(fpsimd_lock);
	local_bh_enable();
}


kernel_neon_begin() could then do

	local_fpsimd_context_lock();

	/* ... */

	preempt_disable();
	local_unlock(fpsimd_context_lock);

... with the following in kernel_neon_end():

	local_unlock(fpsimd_lock);
	preempt_enable();


If kernel-mode NEON was considered harmful to RT due to the context
switch overheads, then the above might be overkill.  SVE will be worse
in that regard, and also needs thinking about at some point -- I've not
looked at if from the RT angle at all.

In either case, I think abstracting the lock/unlock sequences out to
make the purpose clearer may be a good idea, even if we just have a
single local lock to manage.


There is one place where I mess with the FPSIMD context no lock held
because of a need to copy_from_user() straight into the context backing
store (we can't copy_from_user() with preemption disabled...)
I'm not sure whether RT will have any impact on this, but it probably
needs thinking about.

One more comment below...

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm64/kernel/fpsimd.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index e7226c4c7493..3a5cd1908874 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -38,6 +38,7 @@
>  #include <linux/signal.h>
>  #include <linux/slab.h>
>  #include <linux/sysctl.h>
> +#include <linux/locallock.h>
>  
>  #include <asm/fpsimd.h>
>  #include <asm/cputype.h>
> @@ -235,7 +236,7 @@ static void sve_user_enable(void)
>   *    whether TIF_SVE is clear or set, since these are not vector length
>   *    dependent.
>   */
> -
> +static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
>  /*
>   * Update current's FPSIMD/SVE registers from thread_struct.
>   *
> @@ -594,6 +595,7 @@ int sve_set_vector_length(struct task_struct *task,
>  	 * non-SVE thread.
>  	 */
>  	if (task == current) {
> +		local_lock(fpsimd_lock);
>  		local_bh_disable();
>  
>  		task_fpsimd_save();
> @@ -604,8 +606,10 @@ int sve_set_vector_length(struct task_struct *task,
>  	if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
>  		sve_to_fpsimd(task);
>  
> -	if (task == current)
> +	if (task == current) {
> +		local_unlock(fpsimd_lock);

Is this misordered against local_bh_enable(), or doesn't it matter?

>  		local_bh_enable();
> +	}
>  
>  	/*
>  	 * Force reallocation of task SVE state to the correct size
> @@ -838,6 +842,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
>  	sve_alloc(current);
>  
>  	local_bh_disable();
> +	local_lock(fpsimd_lock);
>  
>  	task_fpsimd_save();
>  	fpsimd_to_sve(current);
> @@ -849,6 +854,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
>  	if (test_and_set_thread_flag(TIF_SVE))
>  		WARN_ON(1); /* SVE access shouldn't have trapped */
>  
> +	local_unlock(fpsimd_lock);
>  	local_bh_enable();
>  }
>  
> @@ -926,6 +932,7 @@ void fpsimd_flush_thread(void)
>  		return;
>  
>  	local_bh_disable();
> +	local_lock(fpsimd_lock);
>  
>  	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
>  	fpsimd_flush_task_state(current);
> @@ -967,6 +974,7 @@ void fpsimd_flush_thread(void)
>  
>  	set_thread_flag(TIF_FOREIGN_FPSTATE);
>  
> +	local_unlock(fpsimd_lock);
>  	local_bh_enable();
>  }
>  
> @@ -980,7 +988,9 @@ void fpsimd_preserve_current_state(void)
>  		return;
>  
>  	local_bh_disable();
> +	local_lock(fpsimd_lock);
>  	task_fpsimd_save();
> +	local_unlock(fpsimd_lock);
>  	local_bh_enable();
>  }
>  
> @@ -1022,12 +1032,14 @@ void fpsimd_restore_current_state(void)
>  		return;
>  
>  	local_bh_disable();
> +	local_lock(fpsimd_lock);
>  
>  	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
>  		task_fpsimd_load();
>  		fpsimd_bind_to_cpu();
>  	}
>  
> +	local_unlock(fpsimd_lock);
>  	local_bh_enable();
>  }
>  
> @@ -1042,6 +1054,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
>  		return;
>  
>  	local_bh_disable();
> +	local_lock(fpsimd_lock);
>  
>  	current->thread.fpsimd_state.user_fpsimd = *state;
>  	if (system_supports_sve() && test_thread_flag(TIF_SVE))
> @@ -1052,6 +1065,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
>  	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE))
>  		fpsimd_bind_to_cpu();
>  
> +	local_unlock(fpsimd_lock);
>  	local_bh_enable();
>  }
>  
> @@ -1116,6 +1130,7 @@ void kernel_neon_begin(void)
>  	BUG_ON(!may_use_simd());
>  
>  	local_bh_disable();
> +	local_lock(fpsimd_lock);
>  
>  	__this_cpu_write(kernel_neon_busy, true);
>  
> @@ -1128,6 +1143,7 @@ void kernel_neon_begin(void)
>  	/* Invalidate any task state remaining in the fpsimd regs: */
>  	fpsimd_flush_cpu_state();
>  
> +	local_unlock(fpsimd_lock);
>  	preempt_disable();
>  
>  	local_bh_enable();

The general approach looks reasonable, based on my guesswork about what
the local_lock/_unlocks are doing here.

Cheers
---Dave

[...]

[1] [PATCH v7 00/16] KVM: arm64: Optimise FPSIMD context switching
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-May/576595.html
