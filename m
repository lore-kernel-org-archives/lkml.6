Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162377AbeBNSxD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:53:03 -0500
Received: from mail.efficios.com ([167.114.142.141]:38092 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162361AbeBNSwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:52:46 -0500
Date: Wed, 14 Feb 2018 18:53:44 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <254787533.21950.1518634424009.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com>
References: <20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com> <20180214150739.GH2992@arm.com> <20180214165131.o25r3hhrtrjk3ejq@lakrids.cambridge.arm.com>
Subject: Re: arm64/v4.16-rc1: KASAN: use-after-free Read in
 finish_task_switch
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Topic: arm64/v4.16-rc1: KASAN: use-after-free Read in finish_task_switch
Thread-Index: LrbbK6lcoHOuTj035pvxfARcUqWyHQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 14, 2018, at 11:51 AM, Mark Rutland mark.rutland@arm.com wrote:

> On Wed, Feb 14, 2018 at 03:07:41PM +0000, Will Deacon wrote:
>> Hi Mark,
> 
> Hi Will,
> 
>> Cheers for the report. These things tend to be a pain to debug, but I've had
>> a go.
> 
> Thanks for taking a look!
> 
>> On Wed, Feb 14, 2018 at 12:02:54PM +0000, Mark Rutland wrote:
>> The interesting thing here is on the exit path:
>> 
>> > Freed by task 10882:
>> >  save_stack mm/kasan/kasan.c:447 [inline]
>> >  set_track mm/kasan/kasan.c:459 [inline]
>> >  __kasan_slab_free+0x114/0x220 mm/kasan/kasan.c:520
>> >  kasan_slab_free+0x10/0x18 mm/kasan/kasan.c:527
>> >  slab_free_hook mm/slub.c:1393 [inline]
>> >  slab_free_freelist_hook mm/slub.c:1414 [inline]
>> >  slab_free mm/slub.c:2968 [inline]
>> >  kmem_cache_free+0x88/0x270 mm/slub.c:2990
>> >  __mmdrop+0x164/0x248 kernel/fork.c:604
>> 
>> ^^ This should never run, because there's an mmgrab() about 8 lines above
>> the mmput() in exit_mm.
>> 
>> >  mmdrop+0x50/0x60 kernel/fork.c:615
>> >  __mmput kernel/fork.c:981 [inline]
>> >  mmput+0x270/0x338 kernel/fork.c:992
>> >  exit_mm kernel/exit.c:544 [inline]
>> 
>> Looking at exit_mm:
>> 
>>         mmgrab(mm);
>>         BUG_ON(mm != current->active_mm);
>>         /* more a memory barrier than a real lock */
>>         task_lock(current);
>>         current->mm = NULL;
>>         up_read(&mm->mmap_sem);
>>         enter_lazy_tlb(mm, current);
>>         task_unlock(current);
>>         mm_update_next_owner(mm);
>>         mmput(mm);
>> 
>> Then the comment already rings some alarm bells: our spin_lock (as used
>> by task_lock) has ACQUIRE semantics, so the mmgrab (which is unordered
>> due to being an atomic_inc) can be reordered with respect to the assignment
>> of NULL to current->mm.
>> 
>> If the exit()ing task had recently migrated from another CPU, then that
>> CPU could concurrently run context_switch() and take this path:
>> 
>> 	if (!prev->mm) {
>> 		prev->active_mm = NULL;
>> 		rq->prev_mm = oldmm;
>> 	}
> 
> IIUC, on the prior context_switch, next->mm == NULL, so we set
> next->active_mm to prev->mm.
> 
> Then, in this context_switch we set oldmm = prev->active_mm (where prev
> is next from the prior context switch).
> 
> ... right?
> 
>> which then means finish_task_switch will call mmdrop():
>> 
>> 	struct mm_struct *mm = rq->prev_mm;
>> 	[...]
>> 	if (mm) {
>> 		membarrier_mm_sync_core_before_usermode(mm);
>> 		mmdrop(mm);
>> 	}
> 
> ... then here we use what was prev->active_mm in the most recent context
> switch.
> 
> So AFAICT, we're never concurrently accessing a task_struct::mm field
> here, only prev::{mm,active_mm} while prev is current...
> 
> [...]
> 
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index 995453d9fb55..f91e8d56b03f 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -534,8 +534,9 @@ static void exit_mm(void)
>>         }
>>         mmgrab(mm);
>>         BUG_ON(mm != current->active_mm);
>> -       /* more a memory barrier than a real lock */
>>         task_lock(current);
>> +       /* Ensure we've grabbed the mm before setting current->mm to NULL */
>> +       smp_mb__after_spin_lock();
>>         current->mm = NULL;
> 
> ... and thus I don't follow why we would need to order these with
> anything more than a compiler barrier (if we're preemptible here).
> 
> What have I completely misunderstood? ;)

The compiler barrier would not change anything, because task_lock()
already implies a compiler barrier (provided by the arch spin lock
inline asm memory clobber). So compiler-wise, it cannot move the
mmgrab(mm) after the store "current->mm = NULL".

However, given the scenario involves multiples CPUs (one doing exit_mm(),
the other doing context switch), the actual order of perceived load/store
can be shuffled. And AFAIU nothing prevents the CPU from ordering the
atomic_inc() done by mmgrab(mm) _after_ the store to current->mm.

I wonder if we should not simply add a smp_mb__after_atomic() into
mmgrab() instead ? I see that e.g. futex.c does:

static inline void futex_get_mm(union futex_key *key)
{
        mmgrab(key->private.mm);
        /*
         * Ensure futex_get_mm() implies a full barrier such that
         * get_futex_key() implies a full barrier. This is relied upon
         * as smp_mb(); (B), see the ordering comment above.
         */
        smp_mb__after_atomic();
}

It could prevent nasty subtle bugs in other mmgrab() users.

Thoughts ?

Thanks,

Mathieu


> 
> Thanks,
> Mark.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
