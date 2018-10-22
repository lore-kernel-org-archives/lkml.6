Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24971C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14F020658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14F020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJVQQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 12:16:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:29641 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeJVQQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 12:16:17 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9M7wo4f016895;
        Mon, 22 Oct 2018 16:58:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Mon, 22 Oct 2018 16:58:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9M7woOQ016891;
        Mon, 22 Oct 2018 16:58:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w9M7wojE016890;
        Mon, 22 Oct 2018 16:58:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201810220758.w9M7wojE016890@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [RFC PATCH 1/2] mm, oom: marks all killed tasks as oom victims
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
MIME-Version: 1.0
Date:   Mon, 22 Oct 2018 16:58:50 +0900
References: <20181022071323.9550-1-mhocko@kernel.org> <20181022071323.9550-2-mhocko@kernel.org>
In-Reply-To: <20181022071323.9550-2-mhocko@kernel.org>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko wrote:
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -898,6 +898,7 @@ static void __oom_kill_process(struct task_struct *victim)
>  		if (unlikely(p->flags & PF_KTHREAD))
>  			continue;
>  		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
> +		mark_oom_victim(p);
>  	}
>  	rcu_read_unlock();
>  
> -- 

Wrong. Either

---
 mm/oom_kill.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa53..99b36ff 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -879,6 +879,8 @@ static void __oom_kill_process(struct task_struct *victim)
 	 */
 	rcu_read_lock();
 	for_each_process(p) {
+		struct task_struct *t;
+
 		if (!process_shares_mm(p, mm))
 			continue;
 		if (same_thread_group(p, victim))
@@ -898,6 +900,11 @@ static void __oom_kill_process(struct task_struct *victim)
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
 		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
+		t = find_lock_task_mm(p);
+		if (!t)
+			continue;
+		mark_oom_victim(t);
+		task_unlock(t);
 	}
 	rcu_read_unlock();
 
-- 
1.8.3.1

or

---
 mm/oom_kill.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa53..7fa9b7c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -854,13 +854,6 @@ static void __oom_kill_process(struct task_struct *victim)
 	count_vm_event(OOM_KILL);
 	memcg_memory_event_mm(mm, MEMCG_OOM_KILL);
 
-	/*
-	 * We should send SIGKILL before granting access to memory reserves
-	 * in order to prevent the OOM victim from depleting the memory
-	 * reserves from the user space under its control.
-	 */
-	do_send_sig_info(SIGKILL, SEND_SIG_FORCED, victim, PIDTYPE_TGID);
-	mark_oom_victim(victim);
 	pr_err("Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
 		task_pid_nr(victim), victim->comm, K(victim->mm->total_vm),
 		K(get_mm_counter(victim->mm, MM_ANONPAGES)),
@@ -879,11 +872,23 @@ static void __oom_kill_process(struct task_struct *victim)
 	 */
 	rcu_read_lock();
 	for_each_process(p) {
-		if (!process_shares_mm(p, mm))
+		struct task_struct *t;
+
+		/*
+		 * No use_mm() user needs to read from the userspace so we are
+		 * ok to reap it.
+		 */
+		if (unlikely(p->flags & PF_KTHREAD))
+			continue;
+		t = find_lock_task_mm(p);
+		if (!t)
 			continue;
-		if (same_thread_group(p, victim))
+		if (likely(t->mm != mm)) {
+			task_unlock(t);
 			continue;
+		}
 		if (is_global_init(p)) {
+			task_unlock(t);
 			can_oom_reap = false;
 			set_bit(MMF_OOM_SKIP, &mm->flags);
 			pr_info("oom killer %d (%s) has mm pinned by %d (%s)\n",
@@ -892,12 +897,13 @@ static void __oom_kill_process(struct task_struct *victim)
 			continue;
 		}
 		/*
-		 * No use_mm() user needs to read from the userspace so we are
-		 * ok to reap it.
+		 * We should send SIGKILL before granting access to memory
+		 * reserves in order to prevent the OOM victim from depleting
+		 * the memory reserves from the user space under its control.
 		 */
-		if (unlikely(p->flags & PF_KTHREAD))
-			continue;
 		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
+		mark_oom_victim(t);
+		task_unlock(t);
 	}
 	rcu_read_unlock();
 
-- 
1.8.3.1

will be needed.
