Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7FEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52BC020892
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BC020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389656AbeKPUSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:18:05 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57657 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeKPUSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:18:05 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAGA6A2Q073720;
        Fri, 16 Nov 2018 19:06:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Fri, 16 Nov 2018 19:06:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAGA64ht073674
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 16 Nov 2018 19:06:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH v2 0/3] oom: rework oom_reaper vs. exit_mmap handoff
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20181025082403.3806-1-mhocko@kernel.org>
 <20181108093224.GS27423@dhcp22.suse.cz>
 <9dfd5c87-ae48-8ffb-fbc6-706d627658ff@i-love.sakura.ne.jp>
 <20181114101604.GM23419@dhcp22.suse.cz>
 <0648083a-3112-97ff-edd7-1444c1be529a@i-love.sakura.ne.jp>
 <20181115113653.GO23831@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <2d7d4cf6-bdd4-741d-764b-beb96d7af296@i-love.sakura.ne.jp>
Date:   Fri, 16 Nov 2018 19:06:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115113653.GO23831@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/15 20:36, Michal Hocko wrote:
> On Thu 15-11-18 18:54:15, Tetsuo Handa wrote:
> > On 2018/11/14 19:16, Michal Hocko wrote:
> > > On Wed 14-11-18 18:46:13, Tetsuo Handa wrote:
> > > [...]
> > > > There is always an invisible lock called "scheduling priority". You can't
> > > > leave the MMF_OOM_SKIP to the exit path. Your approach is not ready for
> > > > handling the worst case.
> > > 
> > > And that problem is all over the memory reclaim. You can get starved
> > > to death and block other resources. And the memory reclaim is not the
> > > only one.
> > 
> > I think that it is a manner for kernel developers that no thread keeps
> > consuming CPU resources forever. In the kernel world, doing
> > 
> >   while (1);
> > 
> > is not permitted. Likewise, doing
> > 
> >   for (i = 0; i < very_large_value; i++)
> >       do_something_which_does_not_yield_CPU_to_others();
> 
> There is nothing like that proposed in this series.
> 
> > has to be avoided, in order to avoid lockup problems. We are required to
> > yield CPU to others when we are waiting for somebody else to make progress.
> > It is the page allocator who is refusing to yield CPU to those who need CPU.
> 
> And we do that in the reclaim path.
> 

No we don't. Please explain why holding oom_lock and not holding oom_lock in a
patch shown below makes difference (i.e. holding oom_lock can avoid lockups while
not holding oom_lock fails to avoid lockups).

----------
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3137,50 +3137,53 @@ void exit_mmap(struct mm_struct *mm)
 	/*
 	 * oom_reaper cannot race with the page tables teardown but we
 	 * want to make sure that the exit path can take over the full
 	 * tear down when it is safe to do so
 	 */
 	if (oom) {
 		extern void my_setpriority(void);
 		down_write(&mm->mmap_sem);
 		__unlink_vmas(vma);
+		mutex_lock(&oom_lock);
 		/*
 		 * the exit path is guaranteed to finish the memory tear down
 		 * without any unbound blocking at this stage so make it clear
 		 * to the oom_reaper
 		 */
 		mm->mmap = NULL;
 		up_write(&mm->mmap_sem);
 		my_setpriority();
 		__free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	} else {
 		free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
 	}
 
 	tlb_finish_mmu(&tlb, 0, -1);
 
 	/*
+	 * Now that the full address space is torn down, make sure the
+	 * OOM killer skips over this task
+	 */
+	if (oom) {
+		set_bit(MMF_OOM_SKIP, &mm->flags);
+		mutex_unlock(&oom_lock);
+	}
+
+	/*
 	 * Walk the list again, actually closing and freeing it,
 	 * with preemption enabled, without holding any MM locks.
 	 */
 	while (vma) {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
 		vma = remove_vma(vma);
 	}
 	vm_unacct_memory(nr_accounted);
-
-	/*
-	 * Now that the full address space is torn down, make sure the
-	 * OOM killer skips over this task
-	 */
-	if (oom)
-		set_bit(MMF_OOM_SKIP, &mm->flags);
 }
 
 /* Insert vm structure into process list sorted by address
  * and into the inode's i_mmap tree.  If vm_file is non-NULL
  * then i_mmap_rwsem is taken here.
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;

----------

> > Since the OOM reaper kernel thread "has normal priority" and "can run on any
> > CPU", the possibility of failing to run is lower than an OOM victim thread
> > which "has idle priority" and "can run on only limited CPU". You are trying
> > to add a dependency on such thread, and I'm saying that adding a dependency
> > on such thread increases possibility of lockup.
> 
> Sigh. No, this is not the case. All this patch series does is that we
> hand over to the exiting task once it doesn't block on any locks
> anymore. If the thread is low priority then it is quite likely that the
> oom reaper is done by the time the victim even reaches the exit path.

Not true. A thread executing exit_mmap() can change its priority at any moment.

Also, the OOM reaper kernel thread can fail to complete OOM reaping before
exit_mmap() does mm->mmap = NULL due to e.g. down_read_trylock(&mm->mmap_sem)
failure, doing OOM reaping on other OOM victims in different OOM domains, being
preempted by scheduling priority. You will notice it by trying both

----------
 	 */
 	if (mm->mmap)
 		set_bit(MMF_OOM_SKIP, &mm->flags);
+	else
+		pr_info("Handed over %u to exit path.\n", task_pid_nr(tsk));
 
 	/* Drop a reference taken by wake_oom_reaper */
 	put_task_struct(tsk);
----------

and

----------
 	 */
 	if (mm->mmap)
 		set_bit(MMF_OOM_SKIP, &mm->flags);
+	else if (!test_bit(MMF_OOM_SKIP, &mm->flags))
+		pr_info("Handed over %u to exit path.\n", task_pid_nr(tsk));
 
 	/* Drop a reference taken by wake_oom_reaper */
 	put_task_struct(tsk);
----------

and checking the frequency of printing "Handed over " messages.

> 
> > Yes, even the OOM reaper kernel thread might fail to run if all CPUs were
> > busy with realtime threads waiting for the OOM reaper kernel thread to make
> > progress. In that case, we had better stop relying on asynchronous memory
> > reclaim, and switch to direct OOM reaping by allocating threads.
> > 
> > But what I demonstrated is that
> > 
> >         /*
> >          * the exit path is guaranteed to finish the memory tear down
> >          * without any unbound blocking at this stage so make it clear
> >          * to the oom_reaper
> >          */
> > 
> > becomes a lie even when only one CPU was busy with realtime threads waiting
> > for an idle thread to make progress. If the page allocator stops telling a
> > lie that "an OOM victim is making progress on behalf of me", we can avoid
> > the lockup.
> 
> OK, I stopped reading right here. This discussion is pointless. Once you
> busy loop all CPUs you are screwed.

Look at the log files. I made only 1 CPU (out of 8 CPUs) busy.

>                                     Are you going to blame a filesystem
> that no progress can be made if a code path holding an important lock
> is preemempted by high priority stuff a no further progress can be
> made?

I don't blame that case because it is doing something which is not a kernel bug.

>       This is just ridiculous. What you are arguing here is not fixable
> with the current upstream kernel.

I do blame memory allocation case because it is doing something which is a
kernel bug which can be avoided if we stop telling a lie. No future kernel
is fixable as long as we keep telling a lie.

>                                   Even your so beloved timeout based
> solution doesn't cope with that because oom reaper can be preempted for
> unbound amount of time.

Yes, that's the reason I suggest direct OOM reaping.

>                         Your argument just doens't make much sense in
> the context of the current kernel. Full stop.

Won't full stop at all. What I'm saying is "don't rely on busy polling loop".
The reclaim path becomes a no-op for a thread executing __free_pgtables()
when memcg OOM is waiting for that thread to complete __free_pgtables() and
set MMF_OOM_SKIP.
