Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971597AbeEXVQj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:16:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967358AbeEXVQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:16:37 -0400
Date: Thu, 24 May 2018 14:16:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/2] mm->owner to mm->memcg fixes
Message-Id: <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
In-Reply-To: <20180524111002.GB20441@dhcp22.suse.cz>
References: <20180504142056.GA26151@redhat.com>
        <87r2mrh4is.fsf@xmission.com>
        <20180504145435.GA26573@redhat.com>
        <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com>
        <871serfk77.fsf@xmission.com>
        <87tvrncoyc.fsf_-_@xmission.com>
        <20180510121418.GD5325@dhcp22.suse.cz>
        <20180522125757.GL20020@dhcp22.suse.cz>
        <87wovu889o.fsf@xmission.com>
        <20180524111002.GB20441@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018 13:10:02 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> I would really prefer and appreciate a repost with all the fixes folded
> in.

[1/2]

From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: memcg: replace mm->owner with mm->memcg

Recently it was reported that mm_update_next_owner could get into cases
where it was executing its fallback for_each_process part of the loop and
thus taking up a lot of time.

To deal with this replace mm->owner with mm->memcg.  This just reduces the
complexity of everything.  As much as possible I have maintained the
current semantics.  There are two siginificant exceptions.  During fork
the memcg of the process calling fork is charged rather than init_css_set.
During memory cgroup migration the charges are migrated not if the
process is the owner of the mm, but if the process being migrated has the
same memory cgroup as the mm.

I believe it was a bug if init_css_set is charged for memory activity
during fork, and the old behavior was simply a consequence of the new task
not having tsk->cgroup not initialized to it's proper cgroup.

During cgroup migration only thread group leaders are allowed to migrate. 
Which means in practice there should only be one.  Linux tasks created
with CLONE_VM are the only exception, but the common cases are already
ruled out.  Processes created with vfork have a suspended parent and can
do nothing but call exec so they should never show up.  Threads of the
same cgroup are not the thread group leader so also should not show up. 
That leaves the old LinuxThreads library which is probably out of use by
now, and someone doing something very creative with cgroups, and rolling
their own threads with CLONE_VM.  So in practice I don't think the
difference charge migration will affect anyone.

To ensure that mm->memcg is updated appropriately I have implemented
cgroup "attach" and "fork" methods.  This ensures that at those points the
mm pointed to the task has the appropriate memory cgroup.

For simplicity instead of introducing a new mm lock I simply use exchange
on the pointer where the mm->memcg is updated to get atomic updates.

Looking at the history effectively this change is a revert.  The reason
given for adding mm->owner is so that multiple cgroups can be attached to
the same mm.  In the last 8 years a second user of mm->owner has not
appeared.  A feature that has never used, makes the code more complicated
and has horrible worst case performance should go.

[ebiederm@xmission.com: update to work when !CONFIG_MMU]
  Link: http://lkml.kernel.org/r/87lgczcox0.fsf_-_@xmission.com
[ebiederm@xmission.com: close race between migration and installing bprm->mm as mm]
  Link: http://lkml.kernel.org/r/87fu37cow4.fsf_-_@xmission.com
Link: http://lkml.kernel.org/r/87lgd1zww0.fsf_-_@xmission.com
Fixes: cf475ad28ac3 ("cgroups: add an owner to the mm_struct")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Reported-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/exec.c                  |    3 -
 include/linux/memcontrol.h |   16 +++++-
 include/linux/mm_types.h   |   12 ----
 include/linux/sched/mm.h   |    8 ---
 kernel/exit.c              |   89 -----------------------------------
 kernel/fork.c              |   17 +++++-
 mm/debug.c                 |    4 -
 mm/memcontrol.c            |   81 +++++++++++++++++++++++--------
 8 files changed, 93 insertions(+), 137 deletions(-)

diff -puN fs/exec.c~memcg-replace-mm-owner-with-mm-memcg fs/exec.c
--- a/fs/exec.c~memcg-replace-mm-owner-with-mm-memcg
+++ a/fs/exec.c
@@ -1040,11 +1040,12 @@ static int exec_mmap(struct mm_struct *m
 		up_read(&old_mm->mmap_sem);
 		BUG_ON(active_mm != old_mm);
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
-		mm_update_next_owner(old_mm);
 		mmput(old_mm);
 		return 0;
 	}
 	mmdrop(active_mm);
+	/* The tsk may have migrated before the new mm was attached */
+	mm_sync_memcg_from_task(tsk);
 	return 0;
 }
 
diff -puN include/linux/memcontrol.h~memcg-replace-mm-owner-with-mm-memcg include/linux/memcontrol.h
--- a/include/linux/memcontrol.h~memcg-replace-mm-owner-with-mm-memcg
+++ a/include/linux/memcontrol.h
@@ -345,7 +345,6 @@ out:
 struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
 
 bool task_in_mem_cgroup(struct task_struct *task, struct mem_cgroup *memcg);
-struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
@@ -408,6 +407,9 @@ static inline bool mem_cgroup_is_descend
 	return cgroup_is_descendant(memcg->css.cgroup, root->css.cgroup);
 }
 
+void mm_update_memcg(struct mm_struct *mm, struct mem_cgroup *new);
+void mm_sync_memcg_from_task(struct task_struct *tsk);
+
 static inline bool mm_match_cgroup(struct mm_struct *mm,
 				   struct mem_cgroup *memcg)
 {
@@ -415,7 +417,7 @@ static inline bool mm_match_cgroup(struc
 	bool match = false;
 
 	rcu_read_lock();
-	task_memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
+	task_memcg = rcu_dereference(mm->memcg);
 	if (task_memcg)
 		match = mem_cgroup_is_descendant(task_memcg, memcg);
 	rcu_read_unlock();
@@ -699,7 +701,7 @@ static inline void count_memcg_event_mm(
 		return;
 
 	rcu_read_lock();
-	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
+	memcg = rcu_dereference(mm->memcg);
 	if (likely(memcg)) {
 		count_memcg_events(memcg, idx, 1);
 		if (idx == OOM_KILL)
@@ -787,6 +789,14 @@ static inline struct lruvec *mem_cgroup_
 	return &pgdat->lruvec;
 }
 
+static inline void mm_update_memcg(struct mm_struct *mm, struct mem_cgroup *new)
+{
+}
+
+static inline void mm_sync_memcg_from_task(struct task_struct *tsk)
+{
+}
+
 static inline bool mm_match_cgroup(struct mm_struct *mm,
 		struct mem_cgroup *memcg)
 {
diff -puN include/linux/mm_types.h~memcg-replace-mm-owner-with-mm-memcg include/linux/mm_types.h
--- a/include/linux/mm_types.h~memcg-replace-mm-owner-with-mm-memcg
+++ a/include/linux/mm_types.h
@@ -445,17 +445,7 @@ struct mm_struct {
 	struct kioctx_table __rcu	*ioctx_table;
 #endif
 #ifdef CONFIG_MEMCG
-	/*
-	 * "owner" points to a task that is regarded as the canonical
-	 * user/owner of this mm. All of the following must be true in
-	 * order for it to be changed:
-	 *
-	 * current == mm->owner
-	 * current->mm != mm
-	 * new_owner->mm == mm
-	 * new_owner->alloc_lock is held
-	 */
-	struct task_struct __rcu *owner;
+	struct mem_cgroup __rcu	*memcg;
 #endif
 	struct user_namespace *user_ns;
 
diff -puN include/linux/sched/mm.h~memcg-replace-mm-owner-with-mm-memcg include/linux/sched/mm.h
--- a/include/linux/sched/mm.h~memcg-replace-mm-owner-with-mm-memcg
+++ a/include/linux/sched/mm.h
@@ -95,14 +95,6 @@ extern struct mm_struct *mm_access(struc
 /* Remove the current tasks stale references to the old mm_struct */
 extern void mm_release(struct task_struct *, struct mm_struct *);
 
-#ifdef CONFIG_MEMCG
-extern void mm_update_next_owner(struct mm_struct *mm);
-#else
-static inline void mm_update_next_owner(struct mm_struct *mm)
-{
-}
-#endif /* CONFIG_MEMCG */
-
 #ifdef CONFIG_MMU
 extern void arch_pick_mmap_layout(struct mm_struct *mm,
 				  struct rlimit *rlim_stack);
diff -puN kernel/exit.c~memcg-replace-mm-owner-with-mm-memcg kernel/exit.c
--- a/kernel/exit.c~memcg-replace-mm-owner-with-mm-memcg
+++ a/kernel/exit.c
@@ -399,94 +399,6 @@ kill_orphaned_pgrp(struct task_struct *t
 	}
 }
 
-#ifdef CONFIG_MEMCG
-/*
- * A task is exiting.   If it owned this mm, find a new owner for the mm.
- */
-void mm_update_next_owner(struct mm_struct *mm)
-{
-	struct task_struct *c, *g, *p = current;
-
-retry:
-	/*
-	 * If the exiting or execing task is not the owner, it's
-	 * someone else's problem.
-	 */
-	if (mm->owner != p)
-		return;
-	/*
-	 * The current owner is exiting/execing and there are no other
-	 * candidates.  Do not leave the mm pointing to a possibly
-	 * freed task structure.
-	 */
-	if (atomic_read(&mm->mm_users) <= 1) {
-		mm->owner = NULL;
-		return;
-	}
-
-	read_lock(&tasklist_lock);
-	/*
-	 * Search in the children
-	 */
-	list_for_each_entry(c, &p->children, sibling) {
-		if (c->mm == mm)
-			goto assign_new_owner;
-	}
-
-	/*
-	 * Search in the siblings
-	 */
-	list_for_each_entry(c, &p->real_parent->children, sibling) {
-		if (c->mm == mm)
-			goto assign_new_owner;
-	}
-
-	/*
-	 * Search through everything else, we should not get here often.
-	 */
-	for_each_process(g) {
-		if (g->flags & PF_KTHREAD)
-			continue;
-		for_each_thread(g, c) {
-			if (c->mm == mm)
-				goto assign_new_owner;
-			if (c->mm)
-				break;
-		}
-	}
-	read_unlock(&tasklist_lock);
-	/*
-	 * We found no owner yet mm_users > 1: this implies that we are
-	 * most likely racing with swapoff (try_to_unuse()) or /proc or
-	 * ptrace or page migration (get_task_mm()).  Mark owner as NULL.
-	 */
-	mm->owner = NULL;
-	return;
-
-assign_new_owner:
-	BUG_ON(c == p);
-	get_task_struct(c);
-	/*
-	 * The task_lock protects c->mm from changing.
-	 * We always want mm->owner->mm == mm
-	 */
-	task_lock(c);
-	/*
-	 * Delay read_unlock() till we have the task_lock()
-	 * to ensure that c does not slip away underneath us
-	 */
-	read_unlock(&tasklist_lock);
-	if (c->mm != mm) {
-		task_unlock(c);
-		put_task_struct(c);
-		goto retry;
-	}
-	mm->owner = c;
-	task_unlock(c);
-	put_task_struct(c);
-}
-#endif /* CONFIG_MEMCG */
-
 /*
  * Turn us into a lazy TLB process if we
  * aren't already..
@@ -540,7 +452,6 @@ static void exit_mm(void)
 	up_read(&mm->mmap_sem);
 	enter_lazy_tlb(mm, current);
 	task_unlock(current);
-	mm_update_next_owner(mm);
 	mmput(mm);
 	if (test_thread_flag(TIF_MEMDIE))
 		exit_oom_victim();
diff -puN kernel/fork.c~memcg-replace-mm-owner-with-mm-memcg kernel/fork.c
--- a/kernel/fork.c~memcg-replace-mm-owner-with-mm-memcg
+++ a/kernel/fork.c
@@ -878,10 +878,19 @@ static void mm_init_aio(struct mm_struct
 #endif
 }
 
-static void mm_init_owner(struct mm_struct *mm, struct task_struct *p)
+static void mm_init_memcg(struct mm_struct *mm)
 {
 #ifdef CONFIG_MEMCG
-	mm->owner = p;
+	struct cgroup_subsys_state *css;
+
+	/* Ensure mm->memcg is initialized */
+	mm->memcg = NULL;
+
+	rcu_read_lock();
+	css = task_css(current, memory_cgrp_id);
+	if (css && css_tryget(css))
+		mm_update_memcg(mm, mem_cgroup_from_css(css));
+	rcu_read_unlock();
 #endif
 }
 
@@ -912,7 +921,7 @@ static struct mm_struct *mm_init(struct
 	spin_lock_init(&mm->arg_lock);
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
-	mm_init_owner(mm, p);
+	mm_init_memcg(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_mm_init(mm);
 	hmm_mm_init(mm);
@@ -942,6 +951,7 @@ static struct mm_struct *mm_init(struct
 fail_nocontext:
 	mm_free_pgd(mm);
 fail_nopgd:
+	mm_update_memcg(mm, NULL);
 	free_mm(mm);
 	return NULL;
 }
@@ -979,6 +989,7 @@ static inline void __mmput(struct mm_str
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+	mm_update_memcg(mm, NULL);
 	mmdrop(mm);
 }
 
diff -puN mm/debug.c~memcg-replace-mm-owner-with-mm-memcg mm/debug.c
--- a/mm/debug.c~memcg-replace-mm-owner-with-mm-memcg
+++ a/mm/debug.c
@@ -116,7 +116,7 @@ void dump_mm(const struct mm_struct *mm)
 		"ioctx_table %px\n"
 #endif
 #ifdef CONFIG_MEMCG
-		"owner %px "
+		"memcg %px "
 #endif
 		"exe_file %px\n"
 #ifdef CONFIG_MMU_NOTIFIER
@@ -147,7 +147,7 @@ void dump_mm(const struct mm_struct *mm)
 		mm->ioctx_table,
 #endif
 #ifdef CONFIG_MEMCG
-		mm->owner,
+		mm->memcg,
 #endif
 		mm->exe_file,
 #ifdef CONFIG_MMU_NOTIFIER
diff -puN mm/memcontrol.c~memcg-replace-mm-owner-with-mm-memcg mm/memcontrol.c
--- a/mm/memcontrol.c~memcg-replace-mm-owner-with-mm-memcg
+++ a/mm/memcontrol.c
@@ -664,20 +664,6 @@ static void memcg_check_events(struct me
 	}
 }
 
-struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
-{
-	/*
-	 * mm_update_next_owner() may clear mm->owner to NULL
-	 * if it races with swapoff, page migration, etc.
-	 * So this can be called with p == NULL.
-	 */
-	if (unlikely(!p))
-		return NULL;
-
-	return mem_cgroup_from_css(task_css(p, memory_cgrp_id));
-}
-EXPORT_SYMBOL(mem_cgroup_from_task);
-
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 {
 	struct mem_cgroup *memcg = NULL;
@@ -692,7 +678,7 @@ struct mem_cgroup *get_mem_cgroup_from_m
 		if (unlikely(!mm))
 			memcg = root_mem_cgroup;
 		else {
-			memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
+			memcg = rcu_dereference(mm->memcg);
 			if (unlikely(!memcg))
 				memcg = root_mem_cgroup;
 		}
@@ -1025,7 +1011,7 @@ bool task_in_mem_cgroup(struct task_stru
 		 * killed to prevent needlessly killing additional tasks.
 		 */
 		rcu_read_lock();
-		task_memcg = mem_cgroup_from_task(task);
+		task_memcg = mem_cgroup_from_css(task_css(task, memory_cgrp_id));
 		css_get(&task_memcg->css);
 		rcu_read_unlock();
 	}
@@ -4850,15 +4836,16 @@ static int mem_cgroup_can_attach(struct
 	if (!move_flags)
 		return 0;
 
-	from = mem_cgroup_from_task(p);
+	from = mem_cgroup_from_css(task_css(p, memory_cgrp_id));
 
 	VM_BUG_ON(from == memcg);
 
 	mm = get_task_mm(p);
 	if (!mm)
 		return 0;
-	/* We move charges only when we move a owner of the mm */
-	if (mm->owner == p) {
+
+	/* We move charges except for creative uses of CLONE_VM */
+	if (mm->memcg == from) {
 		VM_BUG_ON(mc.from);
 		VM_BUG_ON(mc.to);
 		VM_BUG_ON(mc.precharge);
@@ -5058,6 +5045,58 @@ static void mem_cgroup_move_task(void)
 }
 #endif
 
+/**
+ * mm_update_memcg - Update the memory cgroup of a mm_struct
+ * @mm: mm struct
+ * @new: new memory cgroup value
+ *
+ * Called whenever mm->memcg needs to change.   Consumes a reference
+ * to new (unless new is NULL).   The reference to the old memory
+ * cgroup is decreased.
+ */
+void mm_update_memcg(struct mm_struct *mm, struct mem_cgroup *new)
+{
+	/* This is the only place where mm->memcg is changed */
+	struct mem_cgroup *old;
+
+	old = xchg(&mm->memcg, new);
+	if (old)
+		css_put(&old->css);
+}
+
+static void task_update_memcg(struct task_struct *tsk, struct mem_cgroup *new)
+{
+	struct mm_struct *mm;
+	task_lock(tsk);
+	mm = tsk->mm;
+	if (mm && !(tsk->flags & PF_KTHREAD))
+		mm_update_memcg(mm, new);
+	task_unlock(tsk);
+}
+
+static void mem_cgroup_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *css;
+	struct task_struct *tsk;
+
+	cgroup_taskset_for_each(tsk, css, tset) {
+		struct mem_cgroup *new = mem_cgroup_from_css(css);
+		css_get(css);
+		task_update_memcg(tsk, new);
+	}
+}
+
+void mm_sync_memcg_from_task(struct task_struct *tsk)
+{
+	struct cgroup_subsys_state *css;
+
+	rcu_read_lock();
+	css = task_css(tsk, memory_cgrp_id);
+	if (css && css_tryget(css))
+		task_update_memcg(tsk, mem_cgroup_from_css(css));
+	rcu_read_unlock();
+}
+
 /*
  * Cgroup retains root cgroups across [un]mount cycles making it necessary
  * to verify whether we're attached to the default hierarchy on each mount
@@ -5358,8 +5397,10 @@ struct cgroup_subsys memory_cgrp_subsys
 	.css_free = mem_cgroup_css_free,
 	.css_reset = mem_cgroup_css_reset,
 	.can_attach = mem_cgroup_can_attach,
+	.attach = mem_cgroup_attach,
 	.cancel_attach = mem_cgroup_cancel_attach,
 	.post_attach = mem_cgroup_move_task,
+	.fork = mm_sync_memcg_from_task,
 	.bind = mem_cgroup_bind,
 	.dfl_cftypes = memory_files,
 	.legacy_cftypes = mem_cgroup_legacy_files,
@@ -5846,7 +5887,7 @@ void mem_cgroup_sk_alloc(struct sock *sk
 	}
 
 	rcu_read_lock();
-	memcg = mem_cgroup_from_task(current);
+	memcg = mem_cgroup_from_css(task_css(current, memory_cgrp_id));
 	if (memcg == root_mem_cgroup)
 		goto out;
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
_
