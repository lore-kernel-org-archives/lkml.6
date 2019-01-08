Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354C6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 037AE20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfAHOVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:21:39 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:15158 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfAHOVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:21:39 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x08ELVPf097884;
        Tue, 8 Jan 2019 23:21:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Tue, 08 Jan 2019 23:21:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x08ELPLx097838
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 8 Jan 2019 23:21:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH 3/2] memcg: Facilitate termination of memcg OOM victims.
To:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190107143802.16847-1-mhocko@kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a49e2b45-10b2-715c-7dcb-2eb7ec5d2cf2@i-love.sakura.ne.jp>
Date:   Tue, 8 Jan 2019 23:21:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107143802.16847-1-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

If memcg OOM events in different domains are pending, already OOM-killed
threads needlessly wait for pending memcg OOM events in different domains.
An out_of_memory() call is slow because it involves printk(). With slow
serial consoles, out_of_memory() might take more than a second. Therefore,
allowing killed processes to quickly call mmput() from exit_mm() from
do_exit() will help calling __mmput() (which can reclaim more memory than
the OOM reaper can reclaim) quickly.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 mm/memcontrol.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 90eb2e2..a7d3ba9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1389,14 +1389,19 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	};
 	bool ret = true;
 
-	mutex_lock(&oom_lock);
-
 	/*
-	 * multi-threaded tasks might race with oom_reaper and gain
-	 * MMF_OOM_SKIP before reaching out_of_memory which can lead
-	 * to out_of_memory failure if the task is the last one in
-	 * memcg which would be a false possitive failure reported
+	 * Multi-threaded tasks might race with oom_reaper() and gain
+	 * MMF_OOM_SKIP before reaching out_of_memory(). But if current
+	 * thread was already killed or is ready to terminate, there is
+	 * no need to call out_of_memory() nor wait for oom_reaoer() to
+	 * set MMF_OOM_SKIP. These three checks minimize possibility of
+	 * needlessly calling out_of_memory() and try to call exit_mm()
+	 * as soon as possible.
 	 */
+	if (mutex_lock_killable(&oom_lock))
+		return true;
+	if (fatal_signal_pending(current))
+		goto unlock;
 	if (tsk_is_oom_victim(current))
 		goto unlock;
 
-- 
1.8.3.1


