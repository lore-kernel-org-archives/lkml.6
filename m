Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeFAOxx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:53:53 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41746 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeFAOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:53:50 -0400
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
Date: Fri, 01 Jun 2018 09:53:44 -0500
In-Reply-To: <87y3fywodn.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 01 Jun 2018 09:52:04 -0500")
Message-ID: <87muwewoav.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fOlR6-0003Xb-Ou;;;mid=<87muwewoav.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18qBH05hqpv6NvyPgTAxcfOyMN16WuoCYQ=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Michal Hocko <mhocko@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 261 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 5 (2.0%), b_tie_ro: 4.0 (1.5%), parse: 1.28 (0.5%),
        extract_message_metadata: 10 (3.9%), get_uri_detail_list: 1.47 (0.6%),
        tests_pri_-1000: 5 (1.9%), tests_pri_-950: 1.14 (0.4%), tests_pri_-900: 0.96
        (0.4%), tests_pri_-400: 35 (13.4%), check_bayes: 34 (13.0%), b_tokenize: 8
        (3.0%), b_tok_get_all: 9 (3.3%), b_comp_prob: 2.0 (0.8%), b_tok_touch_all: 10
        (3.8%), b_finish: 2.4 (0.9%), tests_pri_0: 195 (74.6%), check_dkim_signature:
        0.44 (0.2%), check_dkim_adsp: 3.2 (1.2%), tests_pri_500: 4.0 (1.5%),
        rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH 2/2] memcgl: Remove dead code now that all tasks of an mm share a memcg
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


get_mem_cgroup_from_mm no longer needs to deal with offline memory cgroups.

mem_cgroup_can_attach no longer needs to worry about cgroup leaders
as all tasks of an mm will migrate together.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 mm/memcontrol.c | 43 +++++++++----------------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 078ef562bb90..a05c1253ad87 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -666,7 +666,7 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
 
 static struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 {
-	struct mem_cgroup *memcg, *omemcg;
+	struct mem_cgroup *memcg;
 
 	rcu_read_lock();
 	/*
@@ -677,37 +677,18 @@ static struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 	if (unlikely(!mm))
 		goto root_memcg;
 
-	/* Loop trying to get a reference while mm->memcg is changing */
-	for (omemcg = NULL;; omemcg = memcg) {
+	do {
 		memcg = rcu_dereference(mm->memcg);
 		if (unlikely(!memcg))
 			goto root_memcg;
-		if (likely(css_tryget_online(&memcg->css)))
-			goto found;
-		if ((memcg == omemcg) && css_tryget(&omemcg->css))
-			break;
-	}
+	} while (!css_tryget_online(&memcg->css));
+	rcu_read_unlock();
+	return memcg;
 
-	/* Walk up and find a live memory cgroup */
-	while (memcg != root_mem_cgroup) {
-		memcg = mem_cgroup_from_css(memcg->css.parent);
-		if (css_tryget_online(&memcg->css))
-			goto found_parent;
-	}
-	css_put(&omemcg->css);
 root_memcg:
 	css_get(&root_mem_cgroup->css);
 	rcu_read_unlock();
 	return root_mem_cgroup;
-
-found_parent:
-	css_get(&memcg->css);
-	mm_update_memcg(mm, memcg);
-	css_put(&omemcg->css);
-found:
-	rcu_read_unlock();
-	return memcg;
-
 }
 
 /**
@@ -4847,7 +4828,7 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg = NULL; /* unneeded init to make gcc happy */
 	struct mem_cgroup *from;
-	struct task_struct *leader, *p;
+	struct task_struct *p;
 	struct mm_struct *mm;
 	unsigned long move_flags;
 	int ret;
@@ -4863,18 +4844,12 @@ static int mem_cgroup_can_attach(struct cgroup_taskset *tset)
 
 	/*
 	 * Multi-process migrations only happen on the default hierarchy
-	 * where charge immigration is not used.  Perform charge
-	 * immigration if @tset contains a leader and whine if there are
-	 * multiple.
+	 * where charge immigration is not used.
 	 */
-	p = NULL;
-	cgroup_taskset_for_each_leader(leader, css, tset) {
-		WARN_ON_ONCE(p);
-		p = leader;
-		memcg = mem_cgroup_from_css(css);
-	}
+	p = cgroup_taskset_first(tset, &css);
 	if (!p)
 		return 0;
+	memcg = mem_cgroup_from_css(css);
 
 	/*
 	 * We are now commited to this value whatever it is. Changes in this
-- 
2.14.1
