Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083BAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F5320660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rlkAF1Mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733056AbfAHUF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:05:56 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:41382 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbfAHUFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:05:53 -0500
Received: by mail-it1-f201.google.com with SMTP id 123so4807293itv.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 12:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=txNiwTr9zOR1HjVOP3bo2qaITo/vW1+4t71PfijPP4c=;
        b=rlkAF1MjC29sfFIQEKpxF+0AV8L6qXF+nhZkPIbME243C8Jwuvj/1e3xhDjqtHVE59
         0mGycnvWR4daAKkMgxLrA0v6A/yIqABPwr4rXJFrczjy+fy8/dUJhDlLOdXWguHugkBV
         18G0CBHsGd6SSb7Ou2aE7ZATlNwGbwmiJvAYv8wxgcL2Cu5TdZUFF7NWcKlK+EpGeBy4
         Le24umrAwRk7E58WuRH0ZdLHihGcAFfp3mjLPj2x5YaLCD3FbvYPqjIcIXQou3GVpMth
         J5C1QwAXBOp7qtlHNFGRbKfZUDmkIJAqtIV3aPZsqXblElgsQmIsJefKLeks2sxKZV/X
         K3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=txNiwTr9zOR1HjVOP3bo2qaITo/vW1+4t71PfijPP4c=;
        b=qt3klK8YLBKpjDYPRMJ3rRClJuOuE8Zzz8i0Hk3LTKCXARpC/0Yoqqt+/hIZTUkA+9
         chscFUvsjcsNGFoGqMi9JcqZqa+vHMLvPXZl0zjmQ/jD2LGO7clhx3RIIPttgoL7ZZxt
         sfEEw+wVC0syE4Kz6RtaKFg8JoiWqjSofQylbh7Zk/a+6GHEtm+CBp0K//MZhy466OaQ
         +IvUcNE95DfqN7+X99fYSpcrLdsq03uKrTdy2tyW/P9WnqYCD80TbirhJ0XBInxLSFG1
         OgrdvzfUiN6iK13STZ+o7kbB9+UDrA7Q/HV6BgFve/hW1v5Nyb+eoXMlgqDDI0HFB0nU
         IyVw==
X-Gm-Message-State: AJcUukcFYKhc/t0cw2PDcOo+4BW00cAbFp03ISWC8cvAisxiviAL6rax
        FaIM6It5UKrNge7QKdHuV2wfOlmRHecWRg==
X-Google-Smtp-Source: ALg8bN4CvWVUPVnD74x3rMa3McPsCj5IBNGdgmPr7bgHkGszws1zhUP4HnQrEnbheeYFeQcp9NcbBfz1bvsWww==
X-Received: by 2002:a24:1c87:: with SMTP id c129mr2340547itc.11.1546977952601;
 Tue, 08 Jan 2019 12:05:52 -0800 (PST)
Date:   Tue,  8 Jan 2019 12:05:38 -0800
Message-Id: <20190108200538.80371-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v2] memcg: schedule high reclaim for remote memcgs on high_work
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a memcg is over high limit, memory reclaim is scheduled to run on
return-to-userland. However it is assumed that the memcg is the current
process's memcg. With remote memcg charging for kmem or swapping in a
page charged to remote memcg, current process can trigger reclaim on
remote memcg. So, schduling reclaim on return-to-userland for remote
memcgs will ignore the high reclaim altogether. So, record the memcg
needing high reclaim and trigger high reclaim for that memcg on
return-to-userland. However if the memcg is already recorded for high
reclaim and the recorded memcg is not the descendant of the the memcg
needing high reclaim, punt the high reclaim to the work queue.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changelog since v1:
- Punt high reclaim of a memcg to work queue only if the recorded memcg
  is not its descendant.

 include/linux/sched.h |  3 +++
 kernel/fork.c         |  1 +
 mm/memcontrol.c       | 18 +++++++++++++-----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a95d1a9574e7..9a46243e6585 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1168,6 +1168,9 @@ struct task_struct {
 
 	/* Used by memcontrol for targeted memcg charge: */
 	struct mem_cgroup		*active_memcg;
+
+	/* Used by memcontrol for high relcaim: */
+	struct mem_cgroup		*memcg_high_reclaim;
 #endif
 
 #ifdef CONFIG_BLK_CGROUP
diff --git a/kernel/fork.c b/kernel/fork.c
index 68e0a0c0b2d3..98c9963ac8d5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -916,6 +916,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
+	tsk->memcg_high_reclaim = NULL;
 #endif
 	return tsk;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e9db1160ccbc..81fada6b4a32 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2145,7 +2145,8 @@ void mem_cgroup_handle_over_high(void)
 	if (likely(!nr_pages))
 		return;
 
-	memcg = get_mem_cgroup_from_mm(current->mm);
+	memcg = current->memcg_high_reclaim;
+	current->memcg_high_reclaim = NULL;
 	reclaim_high(memcg, nr_pages, GFP_KERNEL);
 	css_put(&memcg->css);
 	current->memcg_nr_pages_over_high = 0;
@@ -2301,10 +2302,10 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * If the hierarchy is above the normal consumption range, schedule
 	 * reclaim on returning to userland.  We can perform reclaim here
 	 * if __GFP_RECLAIM but let's always punt for simplicity and so that
-	 * GFP_KERNEL can consistently be used during reclaim.  @memcg is
-	 * not recorded as it most likely matches current's and won't
-	 * change in the meantime.  As high limit is checked again before
-	 * reclaim, the cost of mismatch is negligible.
+	 * GFP_KERNEL can consistently be used during reclaim. Record the memcg
+	 * for the return-to-userland high reclaim. If the memcg is already
+	 * recorded and the recorded memcg is not the descendant of the memcg
+	 * needing high reclaim, punt the high reclaim to the work queue.
 	 */
 	do {
 		if (page_counter_read(&memcg->memory) > memcg->high) {
@@ -2312,6 +2313,13 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			if (in_interrupt()) {
 				schedule_work(&memcg->high_work);
 				break;
+			} else if (!current->memcg_high_reclaim) {
+				css_get(&memcg->css);
+				current->memcg_high_reclaim = memcg;
+			} else if (!mem_cgroup_is_descendant(
+					current->memcg_high_reclaim, memcg)) {
+				schedule_work(&memcg->high_work);
+				break;
 			}
 			current->memcg_nr_pages_over_high += batch;
 			set_notify_resume(current);
-- 
2.20.1.97.g81188d93c3-goog

