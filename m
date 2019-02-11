Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89170C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7D5222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897917;
	bh=MaazP+ObdzU1i8xkn4/z5S/6e+AQpzbJRS/haPVpXm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R8UL18vNYdPlVCzfhrxMmJDRxNXs8Dmqmg0XkWcbzWZ1UiBhupw4Vx4D+vOagU1m/
	 zs1rE2OzvfMYwCQWFSYlFUzOUYiDXmjI4LZN4OFwQC7K+86A06R4WDKr4etBS4B33X
	 H8tjDxrORTeQzp2sGfgFmsEesg5rGnVo+nnHMbrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391524AbfBKPLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:11:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403973AbfBKPKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:10:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7719B222A7;
        Mon, 11 Feb 2019 15:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897844;
        bh=MaazP+ObdzU1i8xkn4/z5S/6e+AQpzbJRS/haPVpXm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZlnw+IeDOpWpTAGCZwHs+vGxOy2oxS4+Gpw2GBOO+MV84lD92anI9a+MCr2JBk4M
         +euKzGgBUTW7DSLXaYYKs8nn7H4oIbYoXWZjBBILSXp1JECHR/w8GQnEmsyjSNKlXz
         yjBw+DFtIkQSF3CK6lD2jU5zSQFgJ0kvTdCWAWiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Arkadiusz Miskiewicz <arekm@maven.pl>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, Aleksa Sarai <asarai@suse.de>,
        Jay Kamat <jgkamat@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 134/137] oom, oom_reaper: do not enqueue same task twice
Date:   Mon, 11 Feb 2019 15:20:15 +0100
Message-Id: <20190211141824.547690140@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 9bcdeb51bd7d2ae9fe65ea4d60643d2aeef5bfe3 upstream.

Arkadiusz reported that enabling memcg's group oom killing causes
strange memcg statistics where there is no task in a memcg despite the
number of tasks in that memcg is not 0.  It turned out that there is a
bug in wake_oom_reaper() which allows enqueuing same task twice which
makes impossible to decrease the number of tasks in that memcg due to a
refcount leak.

This bug existed since the OOM reaper became invokable from
task_will_free_mem(current) path in out_of_memory() in Linux 4.7,

  T1@P1     |T2@P1     |T3@P1     |OOM reaper
  ----------+----------+----------+------------
                                   # Processing an OOM victim in a different memcg domain.
                        try_charge()
                          mem_cgroup_out_of_memory()
                            mutex_lock(&oom_lock)
             try_charge()
               mem_cgroup_out_of_memory()
                 mutex_lock(&oom_lock)
  try_charge()
    mem_cgroup_out_of_memory()
      mutex_lock(&oom_lock)
                            out_of_memory()
                              oom_kill_process(P1)
                                do_send_sig_info(SIGKILL, @P1)
                                mark_oom_victim(T1@P1)
                                wake_oom_reaper(T1@P1) # T1@P1 is enqueued.
                            mutex_unlock(&oom_lock)
                 out_of_memory()
                   mark_oom_victim(T2@P1)
                   wake_oom_reaper(T2@P1) # T2@P1 is enqueued.
                 mutex_unlock(&oom_lock)
      out_of_memory()
        mark_oom_victim(T1@P1)
        wake_oom_reaper(T1@P1) # T1@P1 is enqueued again due to oom_reaper_list == T2@P1 && T1@P1->oom_reaper_list == NULL.
      mutex_unlock(&oom_lock)
                                   # Completed processing an OOM victim in a different memcg domain.
                                   spin_lock(&oom_reaper_lock)
                                   # T1P1 is dequeued.
                                   spin_unlock(&oom_reaper_lock)

but memcg's group oom killing made it easier to trigger this bug by
calling wake_oom_reaper() on the same task from one out_of_memory()
request.

Fix this bug using an approach used by commit 855b018325737f76 ("oom,
oom_reaper: disable oom_reaper for oom_kill_allocating_task").  As a
side effect of this patch, this patch also avoids enqueuing multiple
threads sharing memory via task_will_free_mem(current) path.

Link: http://lkml.kernel.org/r/e865a044-2c10-9858-f4ef-254bc71d6cc2@i-love.sakura.ne.jp
Link: http://lkml.kernel.org/r/5ee34fc6-1485-34f8-8790-903ddabaa809@i-love.sakura.ne.jp
Fixes: af8e15cc85a25315 ("oom, oom_reaper: do not enqueue task if it is on the oom_reaper_list head")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: Arkadiusz Miskiewicz <arekm@maven.pl>
Tested-by: Arkadiusz Miskiewicz <arekm@maven.pl>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Aleksa Sarai <asarai@suse.de>
Cc: Jay Kamat <jgkamat@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/sched.h |    1 +
 mm/oom_kill.c         |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -527,6 +527,7 @@ static inline int get_dumpable(struct mm
 #define MMF_OOM_SKIP		21	/* mm is of no interest for the OOM killer */
 #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
 #define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
+#define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
 
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK)
 
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -626,8 +626,8 @@ static void wake_oom_reaper(struct task_
 	if (!oom_reaper_th)
 		return;
 
-	/* tsk is already queued? */
-	if (tsk == oom_reaper_list || tsk->oom_reaper_list)
+	/* mm is already queued? */
+	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
 		return;
 
 	get_task_struct(tsk);


