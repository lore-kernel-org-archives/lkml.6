Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98DAC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773072085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RX9RBe8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfAUSvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:51:01 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:50094 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfAUSvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:51:01 -0500
Received: by mail-ot1-f74.google.com with SMTP id o8so8590689otp.16
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2CcbOShHUgtn+dOHqZeV18CYcxhY92wvJ5Li4R9tDvM=;
        b=RX9RBe8vOQ2PLzL7KRnaLrYi2OfGCQJ+ZwGerxIx+sFjxkJVt+77rYuOYpEgspQU9X
         eKMUGL7FY2X+d1tsRkIh4wK2QwIOHTKhaBTGeo297m/Sop7sZfyqxJqr4yXM4tyenpIB
         jMetxxPiiWn5bcn8CWo7UwBhwEXSFGKctucx9gDm+1hwpnor2OxF86otxPpswLuCGQUI
         0+l5SaNoRH/SRJkrgmEIPqSjKeMofxwyx5feVMui9/igZQqjYvykkBGy5mvzlyZxOZvR
         sQ1Ji7AIqTzabPtU9deCshhJNtZ978pWkDM1pPorX4ef1Z95eefbljsh/WmNju7kEXW7
         cmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2CcbOShHUgtn+dOHqZeV18CYcxhY92wvJ5Li4R9tDvM=;
        b=hrxrKj5pKzeBNftocnaA+0gdIYBgzv2pgcYgck3RIRVFAo60ewYG3b4Yv8QXRS5BLv
         ivXFkAiL00388w4F5UBIBu53O35qWJl+ih0jP8mir6NhPt14/hflXJ4cMro8Y6mM8YfV
         mc3XR3PI6Me9ABGZV9l320EPYFlzcrgd2OsyX/Bw1NlquSuPTT+FISSNP6xD3788zcfF
         U7f8TiatCO8bBsKX2MJz+S1Aeg99o34X8WIg2Gbj0FcymCIm6exHzvk3eY0FK4gVsL3A
         KantCYJSxHVuWt2d0UiJWjlzK3tZ9NwjbyN2ZWm8xkIbX15jyLo60rCdmhcRpdBuRNtn
         Q/Ew==
X-Gm-Message-State: AJcUukekVGTfVff4Ol4qGe6u4oncB0AbymyD22UmkyLXOYuOtznEd4rd
        M0g1TrcjNiTdJL+cJuxHHpIV9GKK2CPVUA==
X-Google-Smtp-Source: ALg8bN6hjd5+Fjp9ho1M3errF/qwHqwg76pXGpLhRQw/SVuFpHSGna1TMdBc/maaudun6b837iz9ct2dbWNOOA==
X-Received: by 2002:a9d:7f15:: with SMTP id j21mr21240535otq.71.1548096660274;
 Mon, 21 Jan 2019 10:51:00 -0800 (PST)
Date:   Mon, 21 Jan 2019 10:50:31 -0800
Message-Id: <20190121185033.161015-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
Subject: [PATCH v2 1/2] mm, oom: fix use-after-free in oom_kill_process
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

