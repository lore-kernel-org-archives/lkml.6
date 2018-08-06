Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14293C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76FB21A50
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:13:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76FB21A50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387645AbeHFUX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:23:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:40346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726279AbeHFUX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:23:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08451ACE1;
        Mon,  6 Aug 2018 18:13:39 +0000 (UTC)
Date:   Mon, 6 Aug 2018 20:13:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>
Cc:     cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penguin-kernel@I-love.SAKURA.ne.jp,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
Subject: Re: WARNING in try_charge
Message-ID: <20180806181339.GD10003@dhcp22.suse.cz>
References: <fc6e173e-8bda-269f-d44f-1c5f5215beac@I-love.SAKURA.ne.jp>
 <0000000000006350880572c61e62@google.com>
 <20180806174410.GB10003@dhcp22.suse.cz>
 <20180806175627.GC10003@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806175627.GC10003@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I simply do not see how this is possible. Let's try with the following
extended debugging patch.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 116b181bb646afedd770985de20a68721bdb2648

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4603ad75c9a9..e2dfdf4361ba 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1388,6 +1388,8 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool ret;
 
 	mutex_lock(&oom_lock);
+	pr_info("task=%s pid=%d invoked memcg oom killer. oom_victim=%d\n",
+			current->comm, current->pid, tsk_is_oom_victim(current));
 	ret = out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
 	return ret;
@@ -2108,6 +2110,9 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	if (mem_cgroup_is_root(memcg))
 		return 0;
+	if (tsk_is_oom_victim(current))
+		pr_info("task=%s pid=%d charge for nr_pages=%d\n",
+			current->comm, current->pid, nr_pages);
 retry:
 	if (consume_stock(memcg, nr_pages))
 		return 0;
@@ -2137,8 +2142,11 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 */
 	if (unlikely(tsk_is_oom_victim(current) ||
 		     fatal_signal_pending(current) ||
-		     current->flags & PF_EXITING))
+		     current->flags & PF_EXITING)) {
+		pr_info("task=%s pid=%d charge bypass\n",
+			current->comm, current->pid);
 		goto force;
+	}
 
 	/*
 	 * Prevent unbounded recursion when reclaim operations need to
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 104ef4a01a55..7d9adcde8cf6 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -692,6 +692,8 @@ static void mark_oom_victim(struct task_struct *tsk)
 	__thaw_task(tsk);
 	atomic_inc(&oom_victims);
 	trace_mark_victim(tsk->pid);
+	pr_info("task=%s pid=%d is oom victim now\n",
+			current->comm, current->pid);
 }
 
 /**
-- 
Michal Hocko
SUSE Labs
