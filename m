Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3802C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D830213A2
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfALKxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 05:53:12 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:14461 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfALKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 05:53:12 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0CAqwja055300;
        Sat, 12 Jan 2019 19:52:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Sat, 12 Jan 2019 19:52:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0CAqnwr055109
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 12 Jan 2019 19:52:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/2] oom, memcg: do not report racy no-eligible OOM
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e55fb27c-f23b-0ac5-acfd-7265c0a3b8dc@i-love.sakura.ne.jp>
 <20190109120212.GT31793@dhcp22.suse.cz>
 <201901102359.x0ANxIbn020225@www262.sakura.ne.jp>
 <fbdfdfeb-5664-ddf3-4d65-c64f9851ac26@i-love.sakura.ne.jp>
 <20190111113354.GD14956@dhcp22.suse.cz>
 <0d67b389-91e2-18ab-b596-39361b895c89@i-love.sakura.ne.jp>
 <20190111133401.GA6997@dhcp22.suse.cz>
 <d9f7b139-d51b-93ae-b5ad-856fd9f2c168@i-love.sakura.ne.jp>
 <20190111150703.GI14956@dhcp22.suse.cz>
 <baa43a5a-6cae-bc4e-5911-13d4bfcd32f2@i-love.sakura.ne.jp>
 <20190111164536.GJ14956@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0aacad13-3e91-646a-90b1-c70993b05701@i-love.sakura.ne.jp>
Date:   Sat, 12 Jan 2019 19:52:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190111164536.GJ14956@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/12 1:45, Michal Hocko wrote:
>>> Anyway, could you update your patch and abstract 
>>> 	if (unlikely(tsk_is_oom_victim(current) ||
>>> 		     fatal_signal_pending(current) ||
>>> 		     current->flags & PF_EXITING))
>>>
>>> in try_charge and reuse it in mem_cgroup_out_of_memory under the
>>> oom_lock with an explanation please?
>>
>> I don't think doing so makes sense, for
>>
>>   tsk_is_oom_victim(current) = T && fatal_signal_pending(current) == F
>>
>> can't happen for mem_cgroup_out_of_memory() under the oom_lock, and
>> current->flags cannot get PF_EXITING when current is inside
>> mem_cgroup_out_of_memory(). fatal_signal_pending(current) alone is
>> appropriate for mem_cgroup_out_of_memory() under the oom_lock because
>>
>>   tsk_is_oom_victim(current) = F && fatal_signal_pending(current) == T
>>
>> can happen there.
> 
> I meant to use the same check consistently. If we can bypass the charge
> under a list of conditions in the charge path we should be surely be
> able to the the same for the oom path. I will not insist but unless
> there is a strong reason I would prefer that.
> 

You mean something like this? I'm not sure this change is safe.

 mm/memcontrol.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 17189da..1733d019 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -248,6 +248,12 @@ enum res_type {
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
+static inline bool can_ignore_limit(void)
+{
+	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
+		(current->flags & PF_EXITING);
+}
+
 /* Some nice accessors for the vmpressure. */
 struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 {
@@ -1395,7 +1401,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * A few threads which were not waiting at mutex_lock_killable() can
 	 * fail to bail out. Therefore, check again after holding oom_lock.
 	 */
-	ret = fatal_signal_pending(current) || out_of_memory(&oc);
+	ret = can_ignore_limit() || out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
 	return ret;
 }
@@ -1724,6 +1730,10 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 
 	mem_cgroup_unmark_under_oom(memcg);
 	if (mem_cgroup_out_of_memory(memcg, mask, order))
+		/*
+		 * Returning OOM_SUCCESS upon can_ignore_limit() is OK, for
+		 * the caller will check can_ignore_limit() again.
+		 */
 		ret = OOM_SUCCESS;
 	else
 		ret = OOM_FAILED;
@@ -1783,6 +1793,11 @@ bool mem_cgroup_oom_synchronize(bool handle)
 		finish_wait(&memcg_oom_waitq, &owait.wait);
 		mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
 					 current->memcg_oom_order);
+		/*
+		 * Returning upon can_ignore_limit() is OK, for the caller is
+		 * already killed... CheckMe: Is this assumption correct?
+		 * Page fault can't happen after getting PF_EXITING?
+		 */
 	} else {
 		schedule();
 		mem_cgroup_unmark_under_oom(memcg);
@@ -2215,9 +2230,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * bypass the last charges so that they can exit quickly and
 	 * free their memory.
 	 */
-	if (unlikely(tsk_is_oom_victim(current) ||
-		     fatal_signal_pending(current) ||
-		     current->flags & PF_EXITING))
+	if (unlikely(can_ignore_limit()))
 		goto force;
 
 	/*
@@ -5527,6 +5540,12 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 		memcg_memory_event(memcg, MEMCG_OOM);
 		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
 			break;
+		/*
+		 * There is no need to check can_ignore_limit() here, for
+		 * signal_pending(current) above will break anyway.
+		 */
+		if (unlikely(can_ignore_limit()))
+			break;
 	}
 
 	memcg_wb_domain_size_changed(memcg);
-- 
1.8.3.1

