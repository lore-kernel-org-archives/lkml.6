Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031141AbeBNPHg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:07:36 -0500
Received: from foss.arm.com ([217.140.101.70]:43726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030731AbeBNPHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:07:35 -0500
Date: Wed, 14 Feb 2018 15:07:41 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com
Subject: Re: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
Message-ID: <20180214150739.GH2992@arm.com>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Cheers for the report. These things tend to be a pain to debug, but I've had
a go.

On Wed, Feb 14, 2018 at 12:02:54PM +0000, Mark Rutland wrote:
> As a heads-up, I hit the splat below when fuzzing v4.16-rc1 on arm64.
> 
> Evidently, we get to finish_task_switch() with rq->prev_mm != NULL,
> despite rq->prev_mm having been freed. KASAN spots the dereference of
> mm->membarrier_state in membarrier_mm_sync_core_before_usermode(mm), but
> AFAICT the underlying issue is independent of the membarrier code, and
> we could get a splat on the subsequent mmdrop(mm).
> 
> I've seen this once in ~2500 CPU hours of fuzzing, so it looks pretty
> difficult to hit, and I have no reproducer so far.
> 
> Syzkaller report below, mirrored with Syzkaller log at [1]. If I hit
> this again, I'll upload new info there.

The interesting thing here is on the exit path:

> Freed by task 10882:
>  save_stack mm/kasan/kasan.c:447 [inline]
>  set_track mm/kasan/kasan.c:459 [inline]
>  __kasan_slab_free+0x114/0x220 mm/kasan/kasan.c:520
>  kasan_slab_free+0x10/0x18 mm/kasan/kasan.c:527
>  slab_free_hook mm/slub.c:1393 [inline]
>  slab_free_freelist_hook mm/slub.c:1414 [inline]
>  slab_free mm/slub.c:2968 [inline]
>  kmem_cache_free+0x88/0x270 mm/slub.c:2990
>  __mmdrop+0x164/0x248 kernel/fork.c:604

^^ This should never run, because there's an mmgrab() about 8 lines above
the mmput() in exit_mm.

>  mmdrop+0x50/0x60 kernel/fork.c:615
>  __mmput kernel/fork.c:981 [inline]
>  mmput+0x270/0x338 kernel/fork.c:992
>  exit_mm kernel/exit.c:544 [inline]

Looking at exit_mm:

        mmgrab(mm);
        BUG_ON(mm != current->active_mm);
        /* more a memory barrier than a real lock */
        task_lock(current);
        current->mm = NULL;
        up_read(&mm->mmap_sem);
        enter_lazy_tlb(mm, current);
        task_unlock(current);
        mm_update_next_owner(mm);
        mmput(mm);

Then the comment already rings some alarm bells: our spin_lock (as used
by task_lock) has ACQUIRE semantics, so the mmgrab (which is unordered
due to being an atomic_inc) can be reordered with respect to the assignment
of NULL to current->mm.

If the exit()ing task had recently migrated from another CPU, then that
CPU could concurrently run context_switch() and take this path:

	if (!prev->mm) {
		prev->active_mm = NULL;
		rq->prev_mm = oldmm;
	}

which then means finish_task_switch will call mmdrop():

	struct mm_struct *mm = rq->prev_mm;
	[...]
	if (mm) {
		membarrier_mm_sync_core_before_usermode(mm);
		mmdrop(mm);
	}

note that KASAN will be ok at this point, but it explains how the exit_mm
path ends up freeing the mm. Then, when the exit()ing CPU calls
context_switch, *it* will explode accessing the freed mm.

Easiest way to fix this is by guaranteeing the barrier semantics in the
exit path. Patch below. I guess we'll have to wait another 2500 hours to
see if it works :)

Will

--->8

diff --git a/kernel/exit.c b/kernel/exit.c
index 995453d9fb55..f91e8d56b03f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -534,8 +534,9 @@ static void exit_mm(void)
        }
        mmgrab(mm);
        BUG_ON(mm != current->active_mm);
-       /* more a memory barrier than a real lock */
        task_lock(current);
+       /* Ensure we've grabbed the mm before setting current->mm to NULL */
+       smp_mb__after_spin_lock();
        current->mm = NULL;
        up_read(&mm->mmap_sem);
        enter_lazy_tlb(mm, current);
