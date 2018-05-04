Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeEDR1C (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:27:02 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51255 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeEDR1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:27:01 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
References: <87h8nr2sa3.fsf_-_@xmission.com>
        <20180502084708.GC26305@dhcp22.suse.cz>
        <20180502132026.GB16060@cmpxchg.org> <87lgd1zww0.fsf_-_@xmission.com>
        <20180503133338.GA23401@redhat.com> <87y3h0x0qg.fsf@xmission.com>
        <20180504142056.GA26151@redhat.com> <87r2mrh4is.fsf@xmission.com>
        <20180504145435.GA26573@redhat.com> <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com> <871serfk77.fsf@xmission.com>
        <87tvrncoyc.fsf_-_@xmission.com>
Date: Fri, 04 May 2018 12:26:51 -0500
In-Reply-To: <87tvrncoyc.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 04 May 2018 12:26:03 -0500")
Message-ID: <87lgczcox0.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEeTz-0002iN-IB;;;mid=<87lgczcox0.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19oAP8d0+WTkiVC4VwnD1Lxvo/1+nkler0=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrew Morton <akpm@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 356 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.1 (0.6%), b_tie_ro: 1.35 (0.4%), parse: 0.87 (0.2%),
        extract_message_metadata: 10 (2.9%), get_uri_detail_list: 2.2 (0.6%),
        tests_pri_-1000: 6 (1.6%), tests_pri_-950: 1.08 (0.3%), tests_pri_-900: 0.95
        (0.3%), tests_pri_-400: 30 (8.4%), check_bayes: 29 (8.1%), b_tokenize: 11
        (3.1%), b_tok_get_all: 9 (2.6%), b_comp_prob: 3.0 (0.8%), b_tok_touch_all:
        3.2 (0.9%), b_finish: 0.63 (0.2%), tests_pri_0: 298 (83.9%),
        check_dkim_signature: 0.55 (0.2%), check_dkim_adsp: 3.5 (1.0%),
        tests_pri_500: 4.2 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/2] memcg: Update the mm->memcg maintenance to work when !CONFIG_MMU
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Michal Hocko <mhocko@kernel.org> reported:
> I am getting the following for nommu with MEMCG=y randconfig:
> kernel/fork.o: In function `mm_init':
> fork.c:(.text+0x948): undefined reference to `mm_update_memcg'
> kernel/fork.o: In function `mmput':
> fork.c:(.text+0x119c): undefined reference to `mm_update_memcg'
> make: *** [vmlinux] Error 1

A memory control group that only accounts mm activity on page fault
seems pointless when !MMU.  Still I don't intend to break it so
move the mm->memcg changes out of #ifndef MMU.

Reported-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 mm/memcontrol.c | 109 ++++++++++++++++++++++++++------------------------------
 1 file changed, 51 insertions(+), 58 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a3745ccbd8c0..d74aeba7dfed 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4846,59 +4846,6 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 	return ret;
 }
 
-/**
- * mm_update_memcg - Update the memory cgroup of a mm_struct
- * @mm: mm struct
- * @new: new memory cgroup value
- *
- * Called whenever mm->memcg needs to change.   Consumes a reference
- * to new (unless new is NULL).   The reference to the old memory
- * cgroup is decreased.
- */
-void mm_update_memcg(struct mm_struct *mm, struct mem_cgroup *new)
-{
-	/* This is the only place where mm->memcg is changed */
-	struct mem_cgroup *old;
-
-	old = xchg(&mm->memcg, new);
-	if (old)
-		css_put(&old->css);
-}
-
-static void task_update_memcg(struct task_struct *tsk, struct mem_cgroup *new)
-{
-	struct mm_struct *mm;
-	task_lock(tsk);
-	mm = tsk->mm;
-	if (mm && !(tsk->flags & PF_KTHREAD))
-		mm_update_memcg(mm, new);
-	task_unlock(tsk);
-}
-
-static void mem_cgroup_attach(struct cgroup_taskset *tset)
-{
-	struct cgroup_subsys_state *css;
-	struct task_struct *tsk;
-
-	cgroup_taskset_for_each(tsk, css, tset) {
-		struct mem_cgroup *new = mem_cgroup_from_css(css);
-		css_get(css);
-		task_update_memcg(tsk, new);
-	}
-}
-
-static void mem_cgroup_fork(struct task_struct *tsk)
-{
-	struct cgroup_subsys_state *css;
-
-	rcu_read_lock();
-	css = task_css(tsk, memory_cgrp_id);
-	if (css && css_tryget(css))
-		task_update_memcg(tsk, mem_cgroup_from_css(css));
-	rcu_read_unlock();
-}
-
-
 static void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
 {
 	if (mc.to)
@@ -5067,19 +5014,65 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 {
 	return 0;
 }
-static void mem_cgroup_attach(struct cgroup_taskset *tset)
+static void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
 {
 }
-static void mem_cgroup_fork(struct task_struct *task)
+static void mem_cgroup_move_task(void)
 {
 }
-static void mem_cgroup_cancel_attach(struct cgroup_taskset *tset)
+#endif
+
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
 {
+	/* This is the only place where mm->memcg is changed */
+	struct mem_cgroup *old;
+
+	old = xchg(&mm->memcg, new);
+	if (old)
+		css_put(&old->css);
 }
-static void mem_cgroup_move_task(void)
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
 {
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
 }
-#endif
 
 /*
  * Cgroup retains root cgroups across [un]mount cycles making it necessary
-- 
2.14.1
