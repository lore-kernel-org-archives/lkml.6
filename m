Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971609AbeEXVRK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:17:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46208 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967358AbeEXVRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:17:09 -0400
Date: Thu, 24 May 2018 14:17:06 -0700
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
Message-Id: <20180524141706.049f1baa9eba1afd041b4820@linux-foundation.org>
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

[2/2]

From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm/memcontrol.c: add mem_cgroup_from_task() as a local helper

Factor out some commonly-occurring code.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memcontrol.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff -puN mm/memcontrol.c~mm-memcontrolc-add-mem_cgroup_from_task-as-a-local-helper mm/memcontrol.c
--- a/mm/memcontrol.c~mm-memcontrolc-add-mem_cgroup_from_task-as-a-local-helper
+++ a/mm/memcontrol.c
@@ -664,6 +664,11 @@ static void memcg_check_events(struct me
 	}
 }
 
+static inline struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
+{
+	return mem_cgroup_from_css(task_css(p, memory_cgrp_id));
+}
+
 struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 {
 	struct mem_cgroup *memcg = NULL;
@@ -1011,7 +1016,7 @@ bool task_in_mem_cgroup(struct task_stru
 		 * killed to prevent needlessly killing additional tasks.
 		 */
 		rcu_read_lock();
-		task_memcg = mem_cgroup_from_css(task_css(task, memory_cgrp_id));
+		task_memcg = mem_cgroup_from_task(task);
 		css_get(&task_memcg->css);
 		rcu_read_unlock();
 	}
@@ -4836,7 +4841,7 @@ static int mem_cgroup_can_attach(struct
 	if (!move_flags)
 		return 0;
 
-	from = mem_cgroup_from_css(task_css(p, memory_cgrp_id));
+	from = mem_cgroup_from_task(p);
 
 	VM_BUG_ON(from == memcg);
 
@@ -5887,7 +5892,7 @@ void mem_cgroup_sk_alloc(struct sock *sk
 	}
 
 	rcu_read_lock();
-	memcg = mem_cgroup_from_css(task_css(current, memory_cgrp_id));
+	memcg = mem_cgroup_from_task(current);
 	if (memcg == root_mem_cgroup)
 		goto out;
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && !memcg->tcpmem_active)
_
