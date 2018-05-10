Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753669AbeEJEDd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 00:03:33 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42302 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753544AbeEJEDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 00:03:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
References: <20180503133338.GA23401@redhat.com> <87y3h0x0qg.fsf@xmission.com>
        <20180504142056.GA26151@redhat.com> <87r2mrh4is.fsf@xmission.com>
        <20180504145435.GA26573@redhat.com> <87y3gzfmjt.fsf@xmission.com>
        <20180504162209.GB26573@redhat.com> <871serfk77.fsf@xmission.com>
        <20180507143358.GA3071@redhat.com> <87vabyvnw0.fsf@xmission.com>
        <20180509144016.GA25742@redhat.com> <87vabwp5p6.fsf@xmission.com>
Date: Wed, 09 May 2018 23:03:23 -0500
In-Reply-To: <87vabwp5p6.fsf@xmission.com> (Eric W. Biederman's message of
        "Wed, 09 May 2018 22:09:25 -0500")
Message-ID: <871sekp378.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fGcnh-00051m-OJ;;;mid=<871sekp378.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.90.247.198;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/mb1mmPHGnnYQkWVVCE01dE+vxBTjSsX0=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 257 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (1.1%), b_tie_ro: 2.1 (0.8%), parse: 0.94 (0.4%),
        extract_message_metadata: 12 (4.5%), get_uri_detail_list: 1.55 (0.6%),
        tests_pri_-1000: 6 (2.3%), tests_pri_-950: 1.16 (0.5%), tests_pri_-900: 0.99
        (0.4%), tests_pri_-400: 23 (8.9%), check_bayes: 22 (8.5%), b_tokenize: 7
        (2.9%), b_tok_get_all: 7 (2.8%), b_comp_prob: 2.1 (0.8%), b_tok_touch_all:
        3.5 (1.4%), b_finish: 0.64 (0.2%), tests_pri_0: 204 (79.2%),
        check_dkim_signature: 0.62 (0.2%), check_dkim_adsp: 2.8 (1.1%),
        tests_pri_500: 4.4 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH] cgroup: Don't mess with tasks in exec
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Semantically exec is supposed to be atomic with no user space visible
intermediate points. Migrating tasks during exec may change that and
lead to all manner of difficult to analyze and maintin corner cases.

So avoid the problems by simply blocking cgroup migration over the
entirety of exec.

Reported-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Unless this leads to some kind of deadlock 
 fs/exec.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 32461a1543fc..54bb01cfc635 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1101,7 +1099,6 @@ static int de_thread(struct task_struct *tsk)
 		struct task_struct *leader = tsk->group_leader;
 
 		for (;;) {
-			cgroup_threadgroup_change_begin(tsk);
 			write_lock_irq(&tasklist_lock);
 			/*
 			 * Do this under tasklist_lock to ensure that
@@ -1112,7 +1109,6 @@ static int de_thread(struct task_struct *tsk)
 				break;
 			__set_current_state(TASK_KILLABLE);
 			write_unlock_irq(&tasklist_lock);
-			cgroup_threadgroup_change_end(tsk);
 			schedule();
 			if (unlikely(__fatal_signal_pending(tsk)))
 				goto killed;
@@ -1750,6 +1746,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 	if (retval)
 		goto out_free;
 
+	cgroup_threadgroup_change_begin(current);
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
 
@@ -1822,6 +1819,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 	/* execve succeeded */
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
+	cgroup_threadgroup_change_end(current);
 	membarrier_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current);
@@ -1841,6 +1839,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 out_unmark:
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
+	cgroup_threadgroup_change_end(current);
 
 out_free:
 	free_bprm(bprm);
-- 
2.14.1
