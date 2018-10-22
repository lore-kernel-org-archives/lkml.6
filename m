Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DF1C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C49E20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 08:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C49E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeJVRGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:06:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:33126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727388AbeJVRGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:06:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 418E4AE10;
        Mon, 22 Oct 2018 08:48:43 +0000 (UTC)
Date:   Mon, 22 Oct 2018 10:48:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] mm, oom: marks all killed tasks as oom victims
Message-ID: <20181022084842.GW18839@dhcp22.suse.cz>
References: <20181022071323.9550-1-mhocko@kernel.org>
 <20181022071323.9550-2-mhocko@kernel.org>
 <201810220758.w9M7wojE016890@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810220758.w9M7wojE016890@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-10-18 16:58:50, Tetsuo Handa wrote:
> Michal Hocko wrote:
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -898,6 +898,7 @@ static void __oom_kill_process(struct task_struct *victim)
> >  		if (unlikely(p->flags & PF_KTHREAD))
> >  			continue;
> >  		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
> > +		mark_oom_victim(p);
> >  	}
> >  	rcu_read_unlock();
> >  
> > -- 
> 
> Wrong. Either

You are right. The mm might go away between process_shares_mm and here.
While your find_lock_task_mm would be correct I believe we can do better
by using the existing mm that we already have. I will make it a separate
patch to clarity.

Thanks for pointing this out.

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 188ae490cf3e..4c205061ed67 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -663,6 +663,7 @@ static inline void wake_oom_reaper(struct task_struct *tsk)
 /**
  * mark_oom_victim - mark the given task as OOM victim
  * @tsk: task to mark
+ * @mm: mm associated with the task
  *
  * Has to be called with oom_lock held and never after
  * oom has been disabled already.
@@ -670,10 +671,8 @@ static inline void wake_oom_reaper(struct task_struct *tsk)
  * tsk->mm has to be non NULL and caller has to guarantee it is stable (either
  * under task_lock or operate on the current).
  */
-static void mark_oom_victim(struct task_struct *tsk)
+static void mark_oom_victim(struct task_struct *tsk, struct mm_struct *mm)
 {
-	struct mm_struct *mm = tsk->mm;
-
 	WARN_ON(oom_killer_disabled);
 	/* OOM killer might race with memcg OOM */
 	if (test_and_set_tsk_thread_flag(tsk, TIF_MEMDIE))
@@ -860,7 +859,7 @@ static void __oom_kill_process(struct task_struct *victim)
 	 * reserves from the user space under its control.
 	 */
 	do_send_sig_info(SIGKILL, SEND_SIG_FORCED, victim, PIDTYPE_TGID);
-	mark_oom_victim(victim);
+	mark_oom_victim(victim, mm);
 	pr_err("Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 		task_pid_nr(victim), victim->comm, K(victim->mm->total_vm),
 		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
@@ -898,7 +897,7 @@ static void __oom_kill_process(struct task_struct *victim)
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
 		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
-		mark_oom_victim(p);
+		mark_oom_victim(p, mm);
 	}
 	rcu_read_unlock();
 
@@ -942,7 +941,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 */
 	task_lock(p);
 	if (task_will_free_mem(p)) {
-		mark_oom_victim(p);
+		mark_oom_victim(p, p->mm);
 		wake_oom_reaper(p);
 		task_unlock(p);
 		put_task_struct(p);
@@ -1072,7 +1071,7 @@ bool out_of_memory(struct oom_control *oc)
 	 * quickly exit and free its memory.
 	 */
 	if (task_will_free_mem(current)) {
-		mark_oom_victim(current);
+		mark_oom_victim(current, current->mm);
 		wake_oom_reaper(current);
 		return true;
 	}
-- 
Michal Hocko
SUSE Labs
