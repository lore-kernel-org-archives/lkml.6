Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbeEDR1e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:27:34 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51453 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbeEDR1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:27:32 -0400
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
Date: Fri, 04 May 2018 12:27:23 -0500
In-Reply-To: <87tvrncoyc.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 04 May 2018 12:26:03 -0500")
Message-ID: <87fu37cow4.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fEeUV-0002uE-BF;;;mid=<87fu37cow4.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+uQc9uwtjFXF5wj9rqYKYy3MaxnBKKQDA=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.0 XMSlimDrugH Weight loss drug headers
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Andrew Morton <akpm@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 280 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.9%), b_tie_ro: 1.70 (0.6%), parse: 0.82 (0.3%),
        extract_message_metadata: 10 (3.5%), get_uri_detail_list: 1.46 (0.5%),
        tests_pri_-1000: 6 (2.1%), tests_pri_-950: 1.20 (0.4%), tests_pri_-900: 1.01
        (0.4%), tests_pri_-400: 29 (10.4%), check_bayes: 28 (10.0%), b_tokenize: 11
        (4.1%), b_tok_get_all: 9 (3.2%), b_comp_prob: 2.1 (0.7%), b_tok_touch_all:
        3.6 (1.3%), b_finish: 0.53 (0.2%), tests_pri_0: 223 (79.5%),
        check_dkim_signature: 0.67 (0.2%), check_dkim_adsp: 2.3 (0.8%),
        tests_pri_500: 4.5 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/2] memcg: Close the race between migration and installing bprm->mm as mm
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Oleg pointed out that there is a race at exec time between when
bprm->mm is initialized and the exec'ing task being migrated to a
different memory control group.

Ractor the code in memcontrol so exec_mmap can use the same code as as
fork to ensure that task->memcg == task->mm->memcg.

Reported-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c                  | 2 ++
 include/linux/memcontrol.h | 5 +++++
 mm/memcontrol.c            | 4 ++--
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a8be9318d1a8..32461a1543fc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1044,6 +1044,8 @@ static int exec_mmap(struct mm_struct *mm)
 		return 0;
 	}
 	mmdrop(active_mm);
+	/* The tsk may have migrated before the new mm was attached */
+	mm_sync_memcg_from_task(tsk);
 	return 0;
 }
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 147e04bfcaee..9b68d9f2740e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -402,6 +402,7 @@ static inline bool mem_cgroup_is_descendant(struct mem_cgroup *memcg,
 }
 
 void mm_update_memcg(struct mm_struct *mm, struct mem_cgroup *new);
+void mm_sync_memcg_from_task(struct task_struct *tsk);
 
 static inline bool mm_match_cgroup(struct mm_struct *mm,
 				   struct mem_cgroup *memcg)
@@ -786,6 +787,10 @@ static inline void mm_update_memcg(struct mm_struct *mm, struct mem_cgroup *new)
 {
 }
 
+static inline void mm_sync_memcg_from_task(struct task_struct *tsk)
+{
+}
+
 static inline bool mm_match_cgroup(struct mm_struct *mm,
 		struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d74aeba7dfed..552657613c0b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5063,7 +5063,7 @@ static void mem_cgroup_attach(struct cgroup_taskset *tset)
 	}
 }
 
-static void mem_cgroup_fork(struct task_struct *tsk)
+void mm_sync_memcg_from_task(struct task_struct *tsk)
 {
 	struct cgroup_subsys_state *css;
 
@@ -5377,7 +5377,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.attach = mem_cgroup_attach,
 	.cancel_attach = mem_cgroup_cancel_attach,
 	.post_attach = mem_cgroup_move_task,
-	.fork = mem_cgroup_fork,
+	.fork = mm_sync_memcg_from_task,
 	.bind = mem_cgroup_bind,
 	.dfl_cftypes = memory_files,
 	.legacy_cftypes = mem_cgroup_legacy_files,
-- 
2.14.1
