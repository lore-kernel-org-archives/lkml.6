Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756549AbeDZPBY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:01:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754847AbeDZPBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:01:23 -0400
Date: Thu, 26 Apr 2018 17:01:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, mhocko@suse.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, ebiederm@xmission.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] exit: Move read_unlock() up in mm_update_next_owner()
Message-ID: <20180426150116.GA14818@redhat.com>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <152474043375.29458.13978538538182642678.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152474043375.29458.13978538538182642678.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26, Kirill Tkhai wrote:
>
> @@ -464,18 +464,15 @@ void mm_update_next_owner(struct mm_struct *mm)
>  	return;
>  
>  assign_new_owner:
> -	BUG_ON(c == p);
>  	get_task_struct(c);
> +	read_unlock(&tasklist_lock);
> +	BUG_ON(c == p);
> +
>  	/*
>  	 * The task_lock protects c->mm from changing.
>  	 * We always want mm->owner->mm == mm
>  	 */
>  	task_lock(c);
> -	/*
> -	 * Delay read_unlock() till we have the task_lock()
> -	 * to ensure that c does not slip away underneath us
> -	 */
> -	read_unlock(&tasklist_lock);

I think this is correct, but...

Firstly, I agree with Michal, it would be nice to kill mm_update_next_owner()
altogether.

If this is not possible I agree, it needs cleanups and we can change it to
avoid tasklist (although your 4/4 looks overcomplicated to me at first glance).

But in this case I think that whatever we do we should start with something like
the patch below. I wrote it 3 years ago but it still applies.

Oleg.

Subject: [PATCH 1/3] memcg: introduce assign_new_owner()

The code under "assign_new_owner" looks very ugly and suboptimal.

We do not really need get_task_struct/put_task_struct(), we can
simply recheck/change mm->owner under tasklist_lock. And we do not
want to restart from the very beginning if ->mm was changed by the
time we take task_lock(), we can simply continue (if we do not drop
tasklist_lock).

Just move this code into the new simple helper, assign_new_owner().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/exit.c |   56 ++++++++++++++++++++++++++------------------------------
 1 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 22fcc05..4d446ab 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -293,6 +293,23 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
 }
 
 #ifdef CONFIG_MEMCG
+static bool assign_new_owner(struct mm_struct *mm, struct task_struct *c)
+{
+	bool ret = false;
+
+	if (c->mm != mm)
+		return ret;
+
+	task_lock(c); /* protects c->mm from changing */
+	if (c->mm == mm) {
+		mm->owner = c;
+		ret = true;
+	}
+	task_unlock(c);
+
+	return ret;
+}
+
 /*
  * A task is exiting.   If it owned this mm, find a new owner for the mm.
  */
@@ -300,7 +317,6 @@ void mm_update_next_owner(struct mm_struct *mm)
 {
 	struct task_struct *c, *g, *p = current;
 
-retry:
 	/*
 	 * If the exiting or execing task is not the owner, it's
 	 * someone else's problem.
@@ -322,16 +338,16 @@ retry:
 	 * Search in the children
 	 */
 	list_for_each_entry(c, &p->children, sibling) {
-		if (c->mm == mm)
-			goto assign_new_owner;
+		if (assign_new_owner(mm, c))
+			goto done;
 	}
 
 	/*
 	 * Search in the siblings
 	 */
 	list_for_each_entry(c, &p->real_parent->children, sibling) {
-		if (c->mm == mm)
-			goto assign_new_owner;
+		if (assign_new_owner(mm, c))
+			goto done;
 	}
 
 	/*
@@ -341,42 +357,22 @@ retry:
 		if (g->flags & PF_KTHREAD)
 			continue;
 		for_each_thread(g, c) {
-			if (c->mm == mm)
-				goto assign_new_owner;
+			if (assign_new_owner(mm, c))
+				goto done;
 			if (c->mm)
 				break;
 		}
 	}
-	read_unlock(&tasklist_lock);
+
 	/*
 	 * We found no owner yet mm_users > 1: this implies that we are
 	 * most likely racing with swapoff (try_to_unuse()) or /proc or
 	 * ptrace or page migration (get_task_mm()).  Mark owner as NULL.
 	 */
 	mm->owner = NULL;
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
+done:
 	read_unlock(&tasklist_lock);
-	if (c->mm != mm) {
-		task_unlock(c);
-		put_task_struct(c);
-		goto retry;
-	}
-	mm->owner = c;
-	task_unlock(c);
-	put_task_struct(c);
+	return;
 }
 #endif /* CONFIG_MEMCG */
 
-- 
1.5.5.1
