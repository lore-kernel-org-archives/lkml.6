Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeFAB5M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:57:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:39738 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeFAB5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:57:11 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
References: <20180504145435.GA26573@redhat.com> <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com> <871serfk77.fsf@xmission.com>
        <87tvrncoyc.fsf_-_@xmission.com>
        <20180510121418.GD5325@dhcp22.suse.cz>
        <20180522125757.GL20020@dhcp22.suse.cz> <87wovu889o.fsf@xmission.com>
        <20180524111002.GB20441@dhcp22.suse.cz>
        <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
        <20180530121721.GD27180@dhcp22.suse.cz> <87wovjacrh.fsf@xmission.com>
Date: Thu, 31 May 2018 20:57:02 -0500
In-Reply-To: <87wovjacrh.fsf@xmission.com> (Eric W. Biederman's message of
        "Thu, 31 May 2018 13:41:38 -0500")
Message-ID: <87wovj8e1d.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fOZJU-00009V-Kl;;;mid=<87wovj8e1d.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+QlRxU84OVoOZ2qijK+RERRupOvNyQiLY=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 981 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.7 (0.3%), b_tie_ro: 1.94 (0.2%), parse: 1.53 (0.2%),
        extract_message_metadata: 20 (2.1%), get_uri_detail_list: 9 (0.9%),
        tests_pri_-1000: 7 (0.7%), tests_pri_-950: 1.23 (0.1%), tests_pri_-900: 1.04
        (0.1%), tests_pri_-400: 64 (6.5%), check_bayes: 62 (6.4%), b_tokenize: 29
        (2.9%), b_tok_get_all: 19 (2.0%), b_comp_prob: 5 (0.5%), b_tok_touch_all: 6
        (0.7%), b_finish: 0.63 (0.1%), tests_pri_0: 874 (89.1%),
        check_dkim_signature: 0.83 (0.1%), check_dkim_adsp: 2.5 (0.3%),
        tests_pri_500: 6 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] memcg: Replace mm->owner with mm->memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently Kiril Tkhai reported that mm_update_next_ownerwas executing
it's expensive for_each_process fallback.  Reading the code reveals
that all that is needed to trigger this is a multi-threaded process
where the thread group leader exits.  AKA something anyone can easily
trigger an any time.

Walking all of the processes in the system is quite expensive so
the current mm_update_next_owner needs to be killed.

To deal with this replace mm->owner with mm->memcg.  This removes
an unnecessary hop when dealing with mm and the memory control group.
As much as possible I have maintained the current semantics.  There
are two siginificant exceptions.  During fork the memcg of
the process calling fork is charged rather than init_css_set.  During
memory cgroup migration the charges are migrated not if the process
is the owner of the mm, but of the process being migrated has
the same memory cgroup as the mm.

I believe it was a bug if init_css_set is charged for memory activity
during fork, and the old behavior was simply a consequence of the new
task not having tsk->cgroup not initialized to it's proper cgroup.

On a previous reading of mem_cgroup_can_attach I thought it limited
task migration between memory cgroups, but the only limit it applies
is are if the target memory cgroup can not be precharged with the
charges of the mm being moved.  Which means that today the memory
cgroup code is supporting processes that share an mm with CLONE_VM
being in different memory cgroups as well as threads of a
multi-threaded process being in different memory cgroups.

There is a minor difference with charge migration.  Instead of moving
the charges exactly when the mm->owner is moved, charges are now moved
when any thread group leader that uses the mm and shares the mm memcg
is moved.  It requires playing games with vfork or CLONE_VM to setup a
situation with multiple thread group leaders sharing the same mm.  As
vfork only lasts a moment and the old LinuxThreads library appears out
of use, I do not expect there to be many occasions for there even to
be a chance for the difference in charge migration to be visible.

To ensure that the mm->memcg is updated appropriate I have implemented
the cgroup "attach" and "fork" methods and a special
mm_sync_memcg_from_task function.  These methods and the new function
ensure that at task migration, after fork, and after exec the task
has the appropriate memory cgroup.

The need to call something in exec is unfortunate and likely indicates
a defect in the way control groups and exec interact.  As migration
during exec is expected to be rare this interaction can wait to be
improved.

For simplicity instead of introducing a new mm lock I simply use
exchange on the pointer where the mm->memcg is updated to get atomic
updates.

The way the memory cgroup of an mm is reassigned has changed
significantly.  Instead of mm_update_next_owner assiging a new owner
and potential changing the memcg of the mm when a task exits, the
memcg of an mm remains the same unless a task using the memcg migrates
or the memcg is brought offline.  If the memcg is brought offline (AKA
rmdir on the memory cgroups directory in cgroupfs) then the next call
of mm_cgroup_from_mm will reassign mm->memcg to the first ancestor
memory cgroup that is still online, and then return that memory cgroup.

By walking returning the first ancestor memory cgroup that is online
this ensures a process that has been delegated a memory cgroup subtree
can not escape from the delegation point.  As every living thread of a
process will remain in some memory cgroup at or below the delegation
point, it is guaranteed at least the delegation point will remain
online if the mm is in use.  Thus this does not provide a memory
cgroup escape.

Looking at the history effectively this change is a revert.  The
reason given for adding mm->owner is so that multiple cgroups can be
attached to the same mm.  In the last 8 years a second user of
mm->owner has not appeared.  A feature that has never used, makes the
code more complicated and has horrible worst case performance should
go.

Fixes: cf475ad28ac3 ("cgroups: add an owner to the mm_struct")
Reported-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

I believe this is a correct patch but folks please look it over and see
if I am missing something.

 fs/exec.c                  |   3 +-
 include/linux/memcontrol.h |  16 ++++--
 include/linux/mm_types.h   |  12 +----
 include/linux/sched/mm.h   |   8 ---
 kernel/exit.c              |  89 -------------------------------
 kernel/fork.c              |  14 +++--
 mm/debug.c                 |   4 +-
 mm/memcontrol.c            | 130 +++++++++++++++++++++++++++++++++------------
 8 files changed, 126 insertions(+), 150 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 183059c427b9..32461a1543fc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1040,11 +1040,12 @@ static int exec_mmap(struct mm_struct *mm)
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
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d99b71bc2c66..9b68d9f2740e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -341,7 +341,6 @@ static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
 struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
 
 bool task_in_mem_cgroup(struct task_struct *task, struct mem_cgroup *memcg);
-struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
@@ -402,6 +401,9 @@ static inline bool mem_cgroup_is_descendant(struct mem_cgroup *memcg,
 	return cgroup_is_descendant(memcg->css.cgroup, root->css.cgroup);
 }
 
+void mm_update_memcg(struct mm_struct *mm, struct mem_cgroup *new);
+void mm_sync_memcg_from_task(struct task_struct *tsk);
+
 static inline bool mm_match_cgroup(struct mm_struct *mm,
 				   struct mem_cgroup *memcg)
 {
@@ -409,7 +411,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	bool match = false;
 
 	rcu_read_lock();
-	task_memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
+	task_memcg = rcu_dereference(mm->memcg);
 	if (task_memcg)
 		match = mem_cgroup_is_descendant(task_memcg, memcg);
 	rcu_read_unlock();
@@ -693,7 +695,7 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
 		return;
 
 	rcu_read_lock();
-	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
+	memcg = rcu_dereference(mm->memcg);
 	if (likely(memcg)) {
 		count_memcg_events(memcg, idx, 1);
 		if (idx == OOM_KILL)
@@ -781,6 +783,14 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
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
index a5d21c42acfc..8d558678e038 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -868,10 +868,16 @@ static void mm_init_aio(struct mm_struct *mm)
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
+	css = task_get_css(current, memory_cgrp_id);
+	mm_update_memcg(mm, mem_cgroup_from_css(css));
 #endif
 }
 
@@ -901,7 +907,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	spin_lock_init(&mm->page_table_lock);
 	mm_init_cpumask(mm);
 	mm_init_aio(mm);
-	mm_init_owner(mm, p);
+	mm_init_memcg(mm);
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_mm_init(mm);
 	hmm_mm_init(mm);
@@ -931,6 +937,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 fail_nocontext:
 	mm_free_pgd(mm);
 fail_nopgd:
+	mm_update_memcg(mm, NULL);
 	free_mm(mm);
 	return NULL;
 }
@@ -968,6 +975,7 @@ static inline void __mmput(struct mm_struct *mm)
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
index 2bd3df3d101a..21c13f4768eb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -664,41 +664,50 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 	}
 }
 
-struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
+static struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 {
+	struct mem_cgroup *memcg, *omemcg;
+
+	rcu_read_lock();
 	/*
-	 * mm_update_next_owner() may clear mm->owner to NULL
-	 * if it races with swapoff, page migration, etc.
-	 * So this can be called with p == NULL.
+	 * Page cache insertions can happen without an
+	 * actual mm context, e.g. during disk probing
+	 * on boot, loopback IO, acct() writes etc.
 	 */
-	if (unlikely(!p))
-		return NULL;
-
-	return mem_cgroup_from_css(task_css(p, memory_cgrp_id));
-}
-EXPORT_SYMBOL(mem_cgroup_from_task);
+	if (unlikely(!mm))
+		goto root_memcg;
+
+	/* Loop trying to get a reference while mm->memcg is changing */
+	for (omemcg = NULL;; omemcg = memcg) {
+		memcg = rcu_dereference(mm->memcg);
+		if (unlikely(!memcg))
+			goto root_memcg;
+		if (likely(css_tryget_online(&memcg->css)))
+			goto found;
+		if ((memcg == omemcg) && css_tryget(&omemcg->css))
+			break;
+	}
 
-static struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
-{
-	struct mem_cgroup *memcg = NULL;
+	/* Walk up and find a live memory cgroup */
+	while (memcg != root_mem_cgroup) {
+		memcg = mem_cgroup_from_css(memcg->css.parent);
+		if (css_tryget_online(&memcg->css))
+			goto found_parent;
+	}
+	css_put(&omemcg->css);
+root_memcg:
+	css_get(&root_mem_cgroup->css);
+	rcu_read_unlock();
+	return root_mem_cgroup;
 
-	rcu_read_lock();
-	do {
-		/*
-		 * Page cache insertions can happen withou an
-		 * actual mm context, e.g. during disk probing
-		 * on boot, loopback IO, acct() writes etc.
-		 */
-		if (unlikely(!mm))
-			memcg = root_mem_cgroup;
-		else {
-			memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
-			if (unlikely(!memcg))
-				memcg = root_mem_cgroup;
-		}
-	} while (!css_tryget_online(&memcg->css));
+found_parent:
+	css_get(&memcg->css);
+	mm_update_memcg(mm, memcg);
+	css_put(&omemcg->css);
+found:
 	rcu_read_unlock();
 	return memcg;
+
 }
 
 /**
@@ -1011,7 +1020,7 @@ bool task_in_mem_cgroup(struct task_struct *task, struct mem_cgroup *memcg)
 		 * killed to prevent needlessly killing additional tasks.
 		 */
 		rcu_read_lock();
-		task_memcg = mem_cgroup_from_task(task);
+		task_memcg = mem_cgroup_from_css(task_css(task, memory_cgrp_id));
 		css_get(&task_memcg->css);
 		rcu_read_unlock();
 	}
@@ -4827,15 +4836,19 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
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
+	/*
+	 * Charges are moved only when moving a leader in the same
+	 * memcg as the mm.
+	 */
+	if (mm->memcg == from) {
 		VM_BUG_ON(mc.from);
 		VM_BUG_ON(mc.to);
 		VM_BUG_ON(mc.precharge);
@@ -5035,6 +5048,55 @@ static void mem_cgroup_move_task(void)
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
+	css = task_get_css(tsk, memory_cgrp_id);
+	task_update_memcg(tsk, mem_cgroup_from_css(css));
+}
+
 /*
  * Cgroup retains root cgroups across [un]mount cycles making it necessary
  * to verify whether we're attached to the default hierarchy on each mount
@@ -5335,8 +5397,10 @@ struct cgroup_subsys memory_cgrp_subsys = {
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
@@ -5769,7 +5833,7 @@ void mem_cgroup_sk_alloc(struct sock *sk)
 	}
 
 	rcu_read_lock();
-	memcg = mem_cgroup_from_task(current);
+	memcg = mem_cgroup_from_css(task_css(current, memory_cgrp_id));
 	if (memcg == root_mem_cgroup)
 		goto out;
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
-- 
2.14.1
