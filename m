Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBEAC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C273F2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C273F2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeJKODH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:03:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:25663 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJKODH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:03:07 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9B6b91H044193;
        Thu, 11 Oct 2018 15:37:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Thu, 11 Oct 2018 15:37:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9B6b9Y0044189;
        Thu, 11 Oct 2018 15:37:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w9B6b9eH044188;
        Thu, 11 Oct 2018 15:37:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201810110637.w9B6b9eH044188@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [RFC PATCH] memcg, oom: throttle =?ISO-2022-JP?B?ZHVtcF9oZWFkZXIgZm9y?=
 =?ISO-2022-JP?B?IG1lbWNnIG9vbXMgd2l0aG91dCBlbGlnaWJsZSB0YXNrcw==?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Michal Hocko <mhocko@suse.com>, guro@fb.com,
        hannes@cmpxchg.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, rientjes@google.com,
        yang.s@alibaba-inc.com
MIME-Version: 1.0
Date:   Thu, 11 Oct 2018 15:37:09 +0900
References: <000000000000dc48d40577d4a587@google.com> <20181010151135.25766-1-mhocko@kernel.org>
In-Reply-To: <20181010151135.25766-1-mhocko@kernel.org>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko wrote:
> Once we are here, make sure that the reason to trigger the OOM is
> printed without ratelimiting because this is really valuable to
> debug what happened.

Here is my version.

From 0c9ab34fd01837d4c85794042ecb9e922c9eed5a Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 11 Oct 2018 15:27:42 +0900
Subject: [PATCH] mm: memcontrol: Don't flood OOM messages with no eligible task.

syzbot is hitting RCU stall at shmem_fault() [1].
This is because memcg-OOM events with no eligible task (current thread
is marked as OOM-unkillable) continued calling dump_header() from
out_of_memory() enabled by commit 3100dab2aa09dc6e ("mm: memcontrol:
print proper OOM header when no eligible victim left.").

Let's make sure that next dump_header() waits for at least 60 seconds from
previous "Out of memory and no killable processes..." message, if current
thread already reported it. This change allows current thread to complete
memory allocation requests for doing recovery operation, and also allows
us to know whether the current thread is doing recovery operation.

[1] https://syzkaller.appspot.com/bug?id=4ae3fff7fcf4c33a47c1192d2d62d2e03efffa64

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
---
 include/linux/sched.h |  1 +
 mm/oom_kill.c         | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57..701cf3c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -723,6 +723,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_MEMCG
 	unsigned			in_user_fault:1;
+	unsigned			memcg_oom_no_eligible_warned:1;
 #ifdef CONFIG_MEMCG_KMEM
 	unsigned			memcg_kmem_skip_account:1;
 #endif
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa53..f954d99 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1106,6 +1106,21 @@ bool out_of_memory(struct oom_control *oc)
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
+#ifdef CONFIG_MEMCG
+		/*
+		 * Don't flood with dump_header() if already reported, in case
+		 * current->signal->oom_score_adj == OOM_SCORE_ADJ_MIN. Maybe
+		 * this variable should be per "struct mem_cgroup". But since
+		 * we can't prove that multiple concurrent memcg OOM without
+		 * eligible task won't cause flooding, choose global variable
+		 * for safety.
+		 */
+		static u64 last_warned;
+
+		if (is_memcg_oom(oc) && current->memcg_oom_no_eligible_warned
+		    && time_before64(get_jiffies_64(), last_warned + 60 * HZ))
+			return false;
+#endif
 		dump_header(oc, NULL);
 		pr_warn("Out of memory and no killable processes...\n");
 		/*
@@ -1115,6 +1130,14 @@ bool out_of_memory(struct oom_control *oc)
 		 */
 		if (!is_sysrq_oom(oc) && !is_memcg_oom(oc))
 			panic("System is deadlocked on memory\n");
+#ifdef CONFIG_MEMCG
+		if (is_memcg_oom(oc)) {
+			last_warned = get_jiffies_64();
+			current->memcg_oom_no_eligible_warned = 1;
+		}
+	} else if (is_memcg_oom(oc)) {
+		current->memcg_oom_no_eligible_warned = 0;
+#endif
 	}
 	if (oc->chosen && oc->chosen != (void *)-1UL)
 		oom_kill_process(oc, !is_memcg_oom(oc) ? "Out of memory" :
-- 
1.8.3.1

