Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeEBT3F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 15:29:05 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55643 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBT3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 15:29:00 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
        <20180426130700.GP17484@dhcp22.suse.cz> <87efj2q6sq.fsf@xmission.com>
        <20180426192818.GX17484@dhcp22.suse.cz>
        <20180427070848.GA17484@dhcp22.suse.cz> <87r2n01q58.fsf@xmission.com>
        <87o9hz2sw3.fsf@xmission.com> <87h8nr2sa3.fsf_-_@xmission.com>
        <20180502084708.GC26305@dhcp22.suse.cz>
        <20180502132026.GB16060@cmpxchg.org>
Date: Wed, 02 May 2018 14:21:35 -0500
In-Reply-To: <20180502132026.GB16060@cmpxchg.org> (Johannes Weiner's message
        of "Wed, 2 May 2018 09:20:26 -0400")
Message-ID: <87lgd1zww0.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fDxLm-0008JI-Pr;;;mid=<87lgd1zww0.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cFuHiegGgrpRITElMNOAP4T7J64O5A5Q=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Johannes Weiner <hannes@cmpxchg.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 895 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.6 (0.3%), b_tie_ro: 1.68 (0.2%), parse: 1.33 (0.1%),
        extract_message_metadata: 21 (2.3%), get_uri_detail_list: 7 (0.8%),
        tests_pri_-1000: 10 (1.1%), tests_pri_-950: 1.83 (0.2%), tests_pri_-900: 1.60
        (0.2%), tests_pri_-400: 83 (9.3%), check_bayes: 82 (9.1%), b_tokenize: 45
        (5.1%), b_tok_get_all: 22 (2.4%), b_comp_prob: 6 (0.6%), b_tok_touch_all: 6
        (0.7%), b_finish: 0.61 (0.1%), tests_pri_0: 766 (85.6%),
        check_dkim_signature: 0.93 (0.1%), check_dkim_adsp: 2.6 (0.3%),
        tests_pri_500: 3.9 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] memcg: Replace mm->owner with mm->memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently it was reported that mm_update_next_owner could get into
cases where it was executing it's fallback for_each_process part of
the loop and thus taking up a lot of time.

To deal with this replace mm->owner with mm->memcg.  This just reduces
the complexity of everything.  As much as possible I have maintained
the current semantics.  There are two siginificant exceptions.  During
fork the memcg of the process calling fork is charged rather than
init_css_set.  During memory cgroup migration the charges are migrated
not if the process is the owner of the mm, but if the process being
migrated has the same memory cgroup as the mm.

I believe it was a bug if init_css_set is charged for memory activity
during fork, and the old behavior was simply a consequence of the new
task not having tsk->cgroup not initialized to it's proper cgroup.

Durhing cgroup migration only thread group leaders are allowed to
migrate.  Which means in practice there should only be one.  Linux
tasks created with CLONE_VM are the only exception, but the common
cases are already ruled out.  Processes created with vfork have a
suspended parent and can do nothing but call exec so they should never
show up.  Threads of the same cgroup are not the thread group leader
so also should not show up.  That leaves the old LinuxThreads library
which is probably out of use by now, and someone doing something very
creative with cgroups, and rolling their own threads with CLONE_VM.
So in practice I don't think the difference charge migration will
affect anyone.

To ensure that mm->memcg is updated appropriately I have implemented
cgroup "attach" and "fork" methods.  This ensures that at those
points the mm pointed to the task has the appropriate memory cgroup.

For simplicity instead of introducing a new mm lock I simply use
exchange on the pointer where the mm->memcg is updated to get
atomic updates.

Looking at the history effectively this change is a revert.  The
reason given for adding mm->owner is so that multiple cgroups can be
attached to the same mm.  In the last 8 years a second user of
mm->owner has not appeared.  A feature that has never used, makes the
code more complicated and has horrible worst case performance should
go.

Fixes: cf475ad28ac3 ("cgroups: add an owner to the mm_struct")
Reported-by:  Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Fingers crossed that this is the final version of this patch.

 fs/exec.c                  |  1 -
 include/linux/memcontrol.h | 11 ++++--
 include/linux/mm_types.h   | 12 +------
 include/linux/sched/mm.h   |  8 -----
 kernel/exit.c              | 89 ----------------------------------------------
 kernel/fork.c              | 17 +++++++--
 mm/debug.c                 |  4 +--
 mm/memcontrol.c            | 88 ++++++++++++++++++++++++++++++++++-----------
 8 files changed, 93 insertions(+), 137 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 183059c427b9..a8be9318d1a8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1040,7 +1040,6 @@ static int exec_mmap(struct mm_struct *mm)
 		up_read(&old_mm->mmap_sem);
 		BUG_ON(active_mm != old_mm);
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
-		mm_update_next_owner(old_mm);
 		mmput(old_mm);
 		return 0;
 	}
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d99b71bc2c66..147e04bfcaee 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -341,7 +341,6 @@ static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
 struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
 
 bool task_in_mem_cgroup(struct task_struct *task, struct mem_cgroup *memcg);
-struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
@@ -402,6 +401,8 @@ static inline bool mem_cgroup_is_descendant(struct mem_cgroup *memcg,
 	return cgroup_is_descendant(memcg->css.cgroup, root->css.cgroup);
 }
 
+void mm_update_memcg(struct mm_struct *mm, struct mem_cgroup *new);
+
 static inline bool mm_match_cgroup(struct mm_struct *mm,
 				   struct mem_cgroup *memcg)
 {
@@ -409,7 +410,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	bool match = false;
 
 	rcu_read_lock();
-	task_memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
+	task_memcg = rcu_dereference(mm->memcg);
 	if (task_memcg)
 		match = mem_cgroup_is_descendant(task_memcg, memcg);
 	rcu_read_unlock();
@@ -693,7 +694,7 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
 		return;
 
 	rcu_read_lock();
-	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
+	memcg = rcu_dereference(mm->memcg);
 	if (likely(memcg)) {
 		count_memcg_events(memcg, idx, 1);
 		if (idx == OOM_KILL)
@@ -781,6 +782,10 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
 	return &pgdat->lruvec;
 }
 
+static inline void mm_update_memcg(struct mm_struct *mm, struct mem_cgroup *new)
+{
+}
+
 static inline bool mm_match_cgroup(struct mm_struct *mm,
 		struct mem_cgroup *memcg)
 {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 21612347d311..ea5efd40a5d1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -443,17 +443,7 @@ struct mm_struct {
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
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2c570cd934af..cc8e68d36fc2 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -95,14 +95,6 @@ extern struct mm_struct *mm_access(struct task_struct *task, unsigned int mode);
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
diff --git a/kernel/exit.c b/kernel/exit.c
index c3c7ac560114..be967d2da0ce 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -399,94 +399,6 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
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
diff --git a/kernel/fork.c b/kernel/fork.c
index a5d21c42acfc..f284acf22aad 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -868,10 +868,19 @@ static void mm_init_aio(struct mm_struct *mm)
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
 
@@ -901,7 +910,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	spin_lock_init(&mm->page_table_lock);
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
-	mm_init_owner(mm, p);
+	mm_init_memcg(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_mm_init(mm);
 	hmm_mm_init(mm);
@@ -931,6 +940,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 fail_nocontext:
 	mm_free_pgd(mm);
 fail_nopgd:
+	mm_update_memcg(mm, NULL);
 	free_mm(mm);
 	return NULL;
 }
@@ -968,6 +978,7 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+	mm_update_memcg(mm, NULL);
 	mmdrop(mm);
 }
 
diff --git a/mm/debug.c b/mm/debug.c
index 56e2d9125ea5..3aed6102b8d0 100644
--- a/mm/debug.c
+++ b/mm/debug.c
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
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2bd3df3d101a..a3745ccbd8c0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -664,20 +664,6 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
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
 static struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 {
 	struct mem_cgroup *memcg = NULL;
@@ -692,7 +678,7 @@ static struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 		if (unlikely(!mm))
 			memcg = root_mem_cgroup;
 		else {
-			memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
+			memcg = rcu_dereference(mm->memcg);
 			if (unlikely(!memcg))
 				memcg = root_mem_cgroup;
 		}
@@ -1011,7 +997,7 @@ bool task_in_mem_cgroup(struct task_struct *task, struct mem_cgroup *memcg)
 		 * killed to prevent needlessly killing additional tasks.
 		 */
 		rcu_read_lock();
-		task_memcg = mem_cgroup_from_task(task);
+		task_memcg = mem_cgroup_from_css(task_css(task, memory_cgrp_id));
 		css_get(&task_memcg->css);
 		rcu_read_unlock();
 	}
@@ -4827,15 +4813,16 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
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
@@ -4859,6 +4846,59 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 	return ret;
 }
 
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
+static void mem_cgroup_fork(struct task_struct *tsk)
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
+
 static void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
 {
 	if (mc.to)
@@ -5027,6 +5067,12 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 {
 	return 0;
 }
+static void mem_cgroup_attach(struct cgroup_taskset *tset)
+{
+}
+static void mem_cgroup_fork(struct task_struct *task)
+{
+}
 static void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
 {
 }
@@ -5335,8 +5381,10 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_free = mem_cgroup_css_free,
 	.css_reset = mem_cgroup_css_reset,
 	.can_attach = mem_cgroup_can_attach,
+	.attach = mem_cgroup_attach,
 	.cancel_attach = mem_cgroup_cancel_attach,
 	.post_attach = mem_cgroup_move_task,
+	.fork = mem_cgroup_fork,
 	.bind = mem_cgroup_bind,
 	.dfl_cftypes = memory_files,
 	.legacy_cftypes = mem_cgroup_legacy_files,
@@ -5769,7 +5817,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 	}
 
 	rcu_read_lock();
-	memcg = mem_cgroup_from_task(current);
+	memcg = mem_cgroup_from_css(task_css(current, memory_cgrp_id));
 	if (memcg == root_mem_cgroup)
 		goto out;
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
-- 
2.14.1
