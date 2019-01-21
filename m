Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7998DC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BACB21726
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYw2FSTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfAUSvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:51:19 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56699 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfAUSvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:51:19 -0500
Received: by mail-pg1-f201.google.com with SMTP id d3so14643693pgv.23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ttDeZKtDPkc6RYeRn0bjQXMJKzEwH+kUuuC5XU8aTs8=;
        b=fYw2FSTizyV/U1RRHYmFSgKk6DYt86c/ushk+JIy6/a82gcn0qUwvUDbSWCrBAbauV
         AKwnK9CcexEy4G4uFSPG4T3rNgyqs2LSgA4lhzIfwPY+p1BvmCevkLtKEbM4U/TP27mX
         fViGckFu+7l3SDn/vugm73AiRsSt5hdhwvzkbyp1AJMLNiyN0x9yd/YX/qc7S196uVuV
         38XJBtDz3wHzyeDqXJGf2OmHJak7cdZozvsXyTHpg7UQkOa4Wp9oxsKL7jEesNHEYO1e
         o5D/+2+Javv0lMm6P2/OlEFRqFdg+r7Shitl5UdxEoizCZe7KI/iEWrOo/5DD3BrOWl9
         lqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ttDeZKtDPkc6RYeRn0bjQXMJKzEwH+kUuuC5XU8aTs8=;
        b=Gmavuo/ewIyVnToHXxuo0zyaJD6HdG2lFx7acXlXAoKZpe63ZBO8GIuxsIdFZETAkN
         ZuRmrhGpcxMyb9/XgBdyRFykv4i0zslTgeyDviDEyCgPlsO9Ry3n4F/81BFHLOs5Cj3u
         YgwF9RlqAUv1zy8oPDaG7Vg6wYu5pIlo6VdNt00RJl+HFoEYz84Oz20fRPGzWNoI7XB5
         DnrKNK0l+VzSzdCsBO7rtORrJEa/x3lvEUbdw+CKpUHv8UmNGgJMRCgO9Qgrywfek/TC
         kONQq3HfV5qjvUCceYzhuVOzgYCFhDycCxdQInHsOJeXu02UKtXNxVLux6IfAHts5UF6
         DEuQ==
X-Gm-Message-State: AJcUukfQocP8aGjYbNg1i6G19qoBKcBXbGivShwukFSSvesfYEaNopsj
        LTyhtalfLsf9Zpvn9bDWUqqox1Kpk372ig==
X-Google-Smtp-Source: ALg8bN7chtpo61mycKV13Mz6uexoGRR3DjFBND6zmTxUVEBBwnmFMapT9sp49lBTdo3i+HcVKfKHSuiYldU19g==
X-Received: by 2002:a17:902:4483:: with SMTP id l3mr10631728pld.16.1548096677859;
 Mon, 21 Jan 2019 10:51:17 -0800 (PST)
Date:   Mon, 21 Jan 2019 10:50:32 -0800
In-Reply-To: <20190121185033.161015-1-shakeelb@google.com>
Message-Id: <20190121185033.161015-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20190121185033.161015-1-shakeelb@google.com>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v2 2/2] mm, oom: remove 'prefer children over parent' heuristic
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>
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
work. Also the heuristic is dangerous because it make fork bomb like
workloads to recover much later because we constantly pick and kill
processes which are not memory hogs. So, let's remove this whole
heuristic.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

---
Changelog since v1:
- Improved commit message based on mhocko's comment.
- Replaced 'p' with 'victim'.
- Removed extra pr_err message.

 mm/oom_kill.c | 62 ++++++++-------------------------------------------
 1 file changed, 9 insertions(+), 53 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1a007dae1e8f..4da73e656c29 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -943,13 +943,8 @@ static int oom_kill_memcg_member(struct task_struct *task, void *unused)
 
 static void oom_kill_process(struct oom_control *oc, const char *message)
 {
-	struct task_struct *p = oc->chosen;
-	unsigned int points = oc->chosen_points;
-	struct task_struct *victim = p;
-	struct task_struct *child;
-	struct task_struct *t;
+	struct task_struct *victim = oc->chosen;
 	struct mem_cgroup *oom_group;
-	unsigned int victim_points = 0;
 	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
 					      DEFAULT_RATELIMIT_BURST);
 
@@ -958,57 +953,18 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 * its children or threads, just give it access to memory reserves
 	 * so it can die quickly
 	 */
-	task_lock(p);
-	if (task_will_free_mem(p)) {
-		mark_oom_victim(p);
-		wake_oom_reaper(p);
-		task_unlock(p);
-		put_task_struct(p);
+	task_lock(victim);
+	if (task_will_free_mem(victim)) {
+		mark_oom_victim(victim);
+		wake_oom_reaper(victim);
+		task_unlock(victim);
+		put_task_struct(victim);
 		return;
 	}
-	task_unlock(p);
+	task_unlock(victim);
 
 	if (__ratelimit(&oom_rs))
-		dump_header(oc, p);
-
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
+		dump_header(oc, victim);
 
 	/*
 	 * Do we need to kill the entire memory cgroup?
-- 
2.20.1.321.g9e740568ce-goog

