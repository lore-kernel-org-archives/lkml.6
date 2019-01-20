Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0199BC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB0320861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Po6GX4wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfAUIl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:41:57 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51498 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfAUIl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:41:56 -0500
Received: by mail-pf1-f202.google.com with SMTP id q64so15407136pfa.18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dGeQKrvoHP1mulhRks0X12a//E5VjB8pLY/mCP1JLI4=;
        b=Po6GX4wfAFK03gqLwVzvI8GHpeT139HHpp0P/CVUXBT+j/KH8k7+rCidut/34U/PTK
         UJtQQX5xRhhXlZMJub9c62Kv+i3VEngRcuhOtTOWF70yQ4I+kUpQB3I5suRskWM9B9iN
         6g1dgCayj8EeA+w2uyg8fKi5ZENHsxupyIJKT6L4bOScnfPtU0Cn30w39MhpOgQm/fsQ
         Qhe5DwWJdTV0IeHzk3TpUD1HU35wG/TkF7Bc/yolqromjC1/WWdnbbF6dIyrpStHGWtA
         fuVzv+sL+osGVikgrkMvrUopj2HgAmdUVLaidlJHoJWmiu9K1JJwenlXvz6JFDQYfKs8
         /CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dGeQKrvoHP1mulhRks0X12a//E5VjB8pLY/mCP1JLI4=;
        b=MhanpljXXvHADP3A0DjF4D90sJ61akX4ut0MWZyWZO67yEq9foBguYcu9BIM3asp67
         cHtAU14XOzEIkhX1FCqUz4kikWdNVzXJOIhprenDi+1l+5TwtaOZ+JPcy9cdsGYTnunI
         iL6vaK7UqK56owiotWeb0h8tLd4fjvnmCO3/+SNR5K5T+C1ZYjTHrbdlWYUwcaQ4gRWC
         4ztqIz3nQrK7piunE3MHMy5Jjy3+IfMgnwX50rpgBwZEN7SO4CvBUrm2pH/ZjLA9x2Ut
         iU80/pvW0w1afknVe3cMsHzHoO0Y+KJ3T1dWRPGEOgcJCaerqHtR9UaajP7guPyENVFf
         dncw==
X-Gm-Message-State: AJcUukdHzeVaHxpcIRAT9t6WqZWiyK1oKLj+naC8jf10YrqlSTjCGf0W
        fEMJiWGkxZM+um4E5fvnOZpKQfmT9KE0ww==
X-Google-Smtp-Source: ALg8bN6T2O3E8tAVrCDbIcRTFRXdkMq4qK9xmdx74lJif9rd7s6qpdyYpbRgra1byBueWBfWsWQN5U6X0GI0ow==
X-Received: by 2002:a63:8c07:: with SMTP id m7mr11849200pgd.136.1548021067221;
 Sun, 20 Jan 2019 13:51:07 -0800 (PST)
Date:   Sun, 20 Jan 2019 13:50:59 -0800
Message-Id: <20190120215059.183552-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH] mm, oom: remove 'prefer children over parent' heuristic
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the start of the git history of Linux, the kernel after selecting
the worst process to be oom-killed, prefer to kill its child (if the
child does not share mm with the parent). Later it was changed to prefer
to kill a child who is worst. If the parent is still the worst then the
parent will be killed.

This heuristic assumes that the children did less work than their parent
and by killing one of them, the work lost will be less. However this is
very workload dependent. If there is a workload which can benefit from
this heuristic, can use oom_score_adj to prefer children to be killed
before the parent.

The select_bad_process() has already selected the worst process in the
system/memcg. There is no need to recheck the badness of its children
and hoping to find a worse candidate. That's a lot of unneeded racy
work. So, let's remove this whole heuristic.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/oom_kill.c | 49 ++++---------------------------------------------
 1 file changed, 4 insertions(+), 45 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1a007dae1e8f..6cee185dc147 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -944,12 +944,7 @@ static int oom_kill_memcg_member(struct task_struct *task, void *unused)
 static void oom_kill_process(struct oom_control *oc, const char *message)
 {
 	struct task_struct *p = oc->chosen;
-	unsigned int points = oc->chosen_points;
-	struct task_struct *victim = p;
-	struct task_struct *child;
-	struct task_struct *t;
 	struct mem_cgroup *oom_group;
-	unsigned int victim_points = 0;
 	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
 					      DEFAULT_RATELIMIT_BURST);
 
@@ -971,53 +966,17 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	if (__ratelimit(&oom_rs))
 		dump_header(oc, p);
 
-	pr_err("%s: Kill process %d (%s) score %u or sacrifice child\n",
-		message, task_pid_nr(p), p->comm, points);
-
-	/*
-	 * If any of p's children has a different mm and is eligible for kill,
-	 * the one with the highest oom_badness() score is sacrificed for its
-	 * parent.  This attempts to lose the minimal amount of work done while
-	 * still freeing memory.
-	 */
-	read_lock(&tasklist_lock);
-
-	/*
-	 * The task 'p' might have already exited before reaching here. The
-	 * put_task_struct() will free task_struct 'p' while the loop still try
-	 * to access the field of 'p', so, get an extra reference.
-	 */
-	get_task_struct(p);
-	for_each_thread(p, t) {
-		list_for_each_entry(child, &t->children, sibling) {
-			unsigned int child_points;
-
-			if (process_shares_mm(child, p->mm))
-				continue;
-			/*
-			 * oom_badness() returns 0 if the thread is unkillable
-			 */
-			child_points = oom_badness(child,
-				oc->memcg, oc->nodemask, oc->totalpages);
-			if (child_points > victim_points) {
-				put_task_struct(victim);
-				victim = child;
-				victim_points = child_points;
-				get_task_struct(victim);
-			}
-		}
-	}
-	put_task_struct(p);
-	read_unlock(&tasklist_lock);
+	pr_err("%s: Kill process %d (%s) score %lu or sacrifice child\n",
+		message, task_pid_nr(p), p->comm, oc->chosen_points);
 
 	/*
 	 * Do we need to kill the entire memory cgroup?
 	 * Or even one of the ancestor memory cgroups?
 	 * Check this out before killing the victim task.
 	 */
-	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
+	oom_group = mem_cgroup_get_oom_group(p, oc->memcg);
 
-	__oom_kill_process(victim);
+	__oom_kill_process(p);
 
 	/*
 	 * If necessary, kill all tasks in the selected memory cgroup.
-- 
2.20.1.321.g9e740568ce-goog

