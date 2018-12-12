Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AE3C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EA72084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41EA72084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeLLKX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:23:59 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:13428 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbeLLKX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:23:58 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBCANfdM020393;
        Wed, 12 Dec 2018 19:23:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Wed, 12 Dec 2018 19:23:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBCANaHE020370
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 12 Dec 2018 19:23:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20181022071323.9550-1-mhocko@kernel.org>
 <20181022071323.9550-3-mhocko@kernel.org>
 <20181026142531.GA27370@cmpxchg.org> <20181026192551.GC18839@dhcp22.suse.cz>
 <20181026193304.GD18839@dhcp22.suse.cz>
 <dfafc626-2233-db9b-49fa-9d4bae16d4aa@i-love.sakura.ne.jp>
 <c38e352a-dd23-a5e4-ac50-75b557506479@i-love.sakura.ne.jp>
 <20181106124224.GM27423@dhcp22.suse.cz>
 <8725e3b3-3752-fa7f-a88f-5ff4f5b6eace@i-love.sakura.ne.jp>
 <20181107100810.GA27423@dhcp22.suse.cz>
 <8a71ecd8-e7bc-25de-184f-dfda511ee0d1@i-love.sakura.ne.jp>
Message-ID: <38568dbe-f45b-8c55-84e4-d4dcbdbef545@i-love.sakura.ne.jp>
Date:   Wed, 12 Dec 2018 19:23:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <8a71ecd8-e7bc-25de-184f-dfda511ee0d1@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/07 21:43, Tetsuo Handa wrote:
> No response for one month. When can we get to an RCU stall problem syzbot reported?

Why not to apply this patch and then think how to address
https://lore.kernel.org/lkml/201810100012.w9A0Cjtn047782@www262.sakura.ne.jp/ ?

From 0fb58415770a83d6c40d471e1840f8bc4a35ca83 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 12 Dec 2018 19:15:51 +0900
Subject: [PATCH] memcg: killed threads should not invoke memcg OOM killer

It is possible that a single process group memcg easily swamps the log
with no-eligible OOM victim messages after current thread was OOM-killed,
due to race between the memcg charge and the OOM reaper [1].

Thread-1                 Thread-2                       OOM reaper
try_charge()
  mem_cgroup_out_of_memory()
    mutex_lock(oom_lock)
                        try_charge()
                          mem_cgroup_out_of_memory()
                            mutex_lock(oom_lock)
    out_of_memory()
      select_bad_process()
      oom_kill_process(current)
      wake_oom_reaper()
                                                        oom_reap_task()
                                                        # sets MMF_OOM_SKIP
    mutex_unlock(oom_lock)
                            out_of_memory()
                              select_bad_process() # no task
                            mutex_unlock(oom_lock)

We don't need to invoke the memcg OOM killer if current thread was killed
when waiting for oom_lock, for mem_cgroup_oom_synchronize(true) and
memory_max_write() can bail out upon SIGKILL, and try_charge() allows
already killed/exiting threads to make forward progress.

Michal has a plan to use tsk_is_oom_victim() by calling mark_oom_victim()
on all thread groups sharing victim's mm. But fatal_signal_pending() in
this patch helps regardless of Michal's plan because it will avoid
needlessly calling out_of_memory() when current thread is already
terminating (e.g. got SIGINT after passing fatal_signal_pending() check
in try_charge() and mutex_lock_killable() did not block).

[1] https://lkml.kernel.org/r/ea637f9a-5dd0-f927-d26d-d0b4fd8ccb6f@i-love.sakura.ne.jp

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 mm/memcontrol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b860dd4f7..b0d3bf3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1389,8 +1389,13 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	};
 	bool ret;
 
-	mutex_lock(&oom_lock);
-	ret = out_of_memory(&oc);
+	if (mutex_lock_killable(&oom_lock))
+		return true;
+	/*
+	 * A few threads which were not waiting at mutex_lock_killable() can
+	 * fail to bail out. Therefore, check again after holding oom_lock.
+	 */
+	ret = fatal_signal_pending(current) || out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
 	return ret;
 }
-- 
1.8.3.1
