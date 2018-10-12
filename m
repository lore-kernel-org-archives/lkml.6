Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769EEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4EB2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4EB2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeJLSTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:19:07 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:17360 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:19:06 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9CAl9Oj014651;
        Fri, 12 Oct 2018 19:47:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Fri, 12 Oct 2018 19:47:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9CAl3GV014603
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 12 Oct 2018 19:47:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] memcg, oom: throttle dump_header for memcg ooms
 without eligible tasks
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Michal Hocko <mhocko@kernel.org>, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Michal Hocko <mhocko@suse.com>, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com
References: <000000000000dc48d40577d4a587@google.com>
 <20181010151135.25766-1-mhocko@kernel.org>
 <201810110637.w9B6b9eH044188@www262.sakura.ne.jp>
Message-ID: <7bb967ec-81ae-2c07-7e58-9ad23167bb66@i-love.sakura.ne.jp>
Date:   Fri, 12 Oct 2018 19:47:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201810110637.w9B6b9eH044188@www262.sakura.ne.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/11 15:37, Tetsuo Handa wrote:
> Michal Hocko wrote:
>> Once we are here, make sure that the reason to trigger the OOM is
>> printed without ratelimiting because this is really valuable to
>> debug what happened.
> 
> Here is my version.
> 

Hmm, per mem_cgroup flag would be better than per task_struct flag.

From 5e80805e4988f23372a3b352fd4185e6bad53f58 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Fri, 12 Oct 2018 16:24:49 +0900
Subject: [PATCH v2] mm: memcontrol: Don't flood OOM messages with no eligible task.

syzbot is hitting RCU stall at shmem_fault() [1].
This is because memcg-OOM events with no eligible task (current thread
is marked as OOM-unkillable) continued calling dump_header() from
out_of_memory() enabled by commit 3100dab2aa09dc6e ("mm: memcontrol:
print proper OOM header when no eligible victim left.").

Let's make sure that next dump_header() waits for at least 60 seconds from
previous "Out of memory and no killable processes..." message, if requested
memcg already reported it. This change allows threads in requested memcg to
complete memory allocation requests for doing recovery operation, and also
allows us to know whether threads in requested memcg is doing recovery
operation.

[1] https://syzkaller.appspot.com/bug?id=4ae3fff7fcf4c33a47c1192d2d62d2e03efffa64

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
---
 include/linux/memcontrol.h |  3 +++
 mm/oom_kill.c              | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 652f602..8da2340 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -230,6 +230,9 @@ struct mem_cgroup {
 	 */
 	bool oom_group;
 
+	/* Previous OOM-kill request failed due to no eligible task? */
+	bool oom_no_eligible_warned;
+
 	/* protected by memcg_oom_lock */
 	bool		oom_lock;
 	int		under_oom;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa53..52a8319 100644
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
+		if (is_memcg_oom(oc) && oc->memcg->oom_no_eligible_warned &&
+		    time_before64(get_jiffies_64(), last_warned + 60 * HZ))
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
+			oc->memcg->oom_no_eligible_warned = true;
+			last_warned = get_jiffies_64();
+		}
+	} else if (is_memcg_oom(oc)) {
+		oc->memcg->oom_no_eligible_warned = false;
+#endif
 	}
 	if (oc->chosen && oc->chosen != (void *)-1UL)
 		oom_kill_process(oc, !is_memcg_oom(oc) ? "Out of memory" :
-- 
1.8.3.1
