Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeFAOxS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:53:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60737 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbeFAOxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:53:16 -0400
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
        <87wovj8e1d.fsf_-_@xmission.com> <87y3fywodn.fsf_-_@xmission.com>
Date: Fri, 01 Jun 2018 09:53:09 -0500
In-Reply-To: <87y3fywodn.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 01 Jun 2018 09:52:04 -0500")
Message-ID: <87sh66wobu.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fOlQY-0000L0-0k;;;mid=<87sh66wobu.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+R+hx0VH/cHOO9Tc5PuTJL8tqFJXpOMVQ=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1006 ms - load_scoreonly_sql: 0.28 (0.0%),
        signal_user_changed: 6 (0.6%), b_tie_ro: 3.3 (0.3%), parse: 2.5 (0.3%),
        extract_message_metadata: 34 (3.4%), get_uri_detail_list: 4.0 (0.4%),
        tests_pri_-1000: 15 (1.5%), tests_pri_-950: 2.9 (0.3%), tests_pri_-900: 2.2
        (0.2%), tests_pri_-400: 44 (4.3%), check_bayes: 41 (4.1%), b_tokenize: 18
        (1.7%), b_tok_get_all: 10 (1.0%), b_comp_prob: 5 (0.5%), b_tok_touch_all: 3.6
        (0.4%), b_finish: 0.98 (0.1%), tests_pri_0: 879 (87.4%),
        check_dkim_signature: 1.35 (0.1%), check_dkim_adsp: 6 (0.5%), tests_pri_500:
        12 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH 1/2] memcg: Ensure every task that uses an mm is in the same memory cgroup
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>From a userspace perspective the cgroup of a mm is determined by which
the cgroup the task belongs too.  As practically an mm can only belong to
a single memory cgroup having multiple tasks with the same mm in different
memory cgroups is not well defined.

Avoid the difficulties of dealing with crazy semantics and restrict all
tasks that share a single mm to the same memory cgroup.

This is accomplished by adding a new function mem_cgroup_mm_can_attach
that checks this condition with a straight forward algorithm.  In the worst
case it is O(N^2).  In the common case it should be O(N) in the number of
tasks being migrated.  As typically only a single process and thus a single
process is being migrated and it is optimized for that case.

There are users of mmget such as proc that can create references to an
mm this function can not find.  This results in an unnecessary
migration failure.  It does not break the invariant that every task of
an mm stays in the same memory cgroup.  So this condition is annoying
but harmelss.

This requires multi-threaded mm's to be migrated using the procs file.

This effectively forbids process with mm's shared processes being migrated.
Although enabling the control file might work.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 mm/memcontrol.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 21c13f4768eb..078ef562bb90 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4798,6 +4798,50 @@ static void mem_cgroup_clear_mc(void)
 	mmput(mm);
 }
 
+static int mem_cgroup_mm_can_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *css, *tcss;
+	struct task_struct *p, *t;
+	struct mm_struct *mm = NULL;
+	int ret = -EINVAL;
+
+	/*
+	 * Ensure all references for every mm can be accounted for by
+	 * tasks that are being migrated.
+	 */
+	rcu_read_lock();
+	cgroup_taskset_for_each(p, css, tset) {
+		int mm_users, mm_count;
+
+		/* Does this task have an mm that has not been visited? */
+		if (!p->mm || (p->flags & PF_KTHREAD) || (p->mm == mm))
+			continue;
+
+		mm = p->mm;
+		mm_users = atomic_read(&mm->mm_users);
+		if (mm_users == 1)
+			continue;
+
+		mm_count = 0;
+		cgroup_taskset_for_each(t, tcss, tset) {
+			if (t->mm != mm)
+				continue;
+			mm_count++;
+		}
+		/*
+		 * If there are no non-task references mm_users will
+		 * be stable as holding cgroup_thread_rwsem for write
+		 * blocks fork and exit.
+		 */
+		if (mm_count != mm_users)
+			goto out;
+	}
+	ret = 0;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
 static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
@@ -4806,7 +4850,12 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 	struct task_struct *leader, *p;
 	struct mm_struct *mm;
 	unsigned long move_flags;
-	int ret = 0;
+	int ret;
+
+	/* Is every task of every mm in tset being moved? */
+	ret = mem_cgroup_mm_can_attach(tset);
+	if (ret)
+		return ret;
 
 	/* charge immigration isn't supported on the default hierarchy */
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
-- 
2.14.1
