Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1434C3713C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764E32089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m35vyTXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfAUV7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:59:09 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56797 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfAUV7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:59:09 -0500
Received: by mail-pg1-f201.google.com with SMTP id d3so14927126pgv.23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 13:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RlgORdSvQwmPD09FJcJanUSE+TSIllkya483gUwhvMQ=;
        b=m35vyTXE9TDQpgRreAMYh/veSAIurRfYe8Bx8eX5y3nxbIjgXVC3iQTm/J1m1IL3+u
         lqXjy3vj3ni2Ghsk58JOw53FA37LHILcBVNC4b38vXlkO8gSjucX7cXL0Nd5yIJYcNol
         5WNwO3RuKXDcGYS75QPBUaeV7Vxs2BJOuKsKoMdfMW4olGU/+xohrWlXpja2g8vEALby
         YBkRwYPhBZZOueZIBr16rR63K7DxTmuyP5cVrX2+qFYnm6aL74ib+pBbsu94Hh2x1G+3
         ba8ZewRr9AGFmM184y5QHmhszaZY5Ourukk3O0+aL4yZCWv8qFI109cTOCcexqZnEFNN
         vFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RlgORdSvQwmPD09FJcJanUSE+TSIllkya483gUwhvMQ=;
        b=ZK+gE85lAsY8UBmreObFS1KWhJF929VhqN8anirVYCS1L7T2dsDcC0SSdqlzO5cYsq
         N8Ngx1KYEWhcmMti0xSx/x+udlkV+7NBY8NgllKWxKkBKyaP5BcSbEtlZaSlNiB0qAFK
         Xz1mAyE5V0uY34K+Ky/6IN0ut5nwrVmFO3Eyk9JBpYeHG0TjW+kApKCUx4NNXV1gCzBy
         369HODJ0d3/hj29vKqmHcq7CUjyR49+QnGOvjx0I42jYVex5qLRox3oimALVTJPZdOWq
         g2fn5SkS9R7UE7mccOz4+gQ5D/9cZDPVci/vqZdjkhKcDeT0CGs/GsBuip0+dzM6R4jq
         rdYg==
X-Gm-Message-State: AJcUukcEOYGUcHqLnhjbZmUHje/Wdn6nH1r4jJz2ADqZ3lmJD7AjZX83
        WnGiTIgOCGjKoEYMr/RIzTV5EyfoXUrnjQ==
X-Google-Smtp-Source: ALg8bN68WIK9c/pAcXEgDa8n8yHYP2NPutnrTG1GYcQlEemJMHFiXYZLkLc01oAUr1BNPYOKaW2x2fUGvE5MeA==
X-Received: by 2002:a63:7a07:: with SMTP id v7mr13906561pgc.149.1548107948485;
 Mon, 21 Jan 2019 13:59:08 -0800 (PST)
Date:   Mon, 21 Jan 2019 13:58:49 -0800
Message-Id: <20190121215850.221745-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v3 1/2] mm, oom: fix use-after-free in oom_kill_process
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
        syzbot+7fbbfa368521945f0e3d@syzkaller.appspotmail.com,
        Michal Hocko <mhocko@suse.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot instance running on upstream kernel found a use-after-free bug
in oom_kill_process. On further inspection it seems like the process
selected to be oom-killed has exited even before reaching
read_lock(&tasklist_lock) in oom_kill_process(). More specifically the
tsk->usage is 1 which is due to get_task_struct() in oom_evaluate_task()
and the put_task_struct within for_each_thread() frees the tsk and
for_each_thread() tries to access the tsk. The easiest fix is to do
get/put across the for_each_thread() on the selected task.

Now the next question is should we continue with the oom-kill as the
previously selected task has exited? However before adding more
complexity and heuristics, let's answer why we even look at the
children of oom-kill selected task? The select_bad_process() has already
selected the worst process in the system/memcg. Due to race, the
selected process might not be the worst at the kill time but does that
matter? The userspace can use the oom_score_adj interface to prefer
children to be killed before the parent. I looked at the history but it
seems like this is there before git history.

Reported-by: syzbot+7fbbfa368521945f0e3d@syzkaller.appspotmail.com
Fixes: 6b0c81b3be11 ("mm, oom: reduce dependency on tasklist_lock")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: stable@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

---
Changelog since v2:
- N/A

Changelog since v1:
- Improved the commit message and added the Reported-by and Fixes tags.

 mm/oom_kill.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 0930b4365be7..1a007dae1e8f 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -981,6 +981,13 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	 * still freeing memory.
 	 */
 	read_lock(&tasklist_lock);
+
+	/*
+	 * The task 'p' might have already exited before reaching here. The
+	 * put_task_struct() will free task_struct 'p' while the loop still try
+	 * to access the field of 'p', so, get an extra reference.
+	 */
+	get_task_struct(p);
 	for_each_thread(p, t) {
 		list_for_each_entry(child, &t->children, sibling) {
 			unsigned int child_points;
@@ -1000,6 +1007,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 			}
 		}
 	}
+	put_task_struct(p);
 	read_unlock(&tasklist_lock);
 
 	/*
-- 
2.20.1.321.g9e740568ce-goog

