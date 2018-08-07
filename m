Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C2EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A459E21779
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A459E21779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbeHGM24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:28:56 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:23235 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbeHGM24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:28:56 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w77AFH0b063913;
        Tue, 7 Aug 2018 19:15:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Tue, 07 Aug 2018 19:15:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w77AFDWx063896
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 7 Aug 2018 19:15:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] memcg, oom: be careful about races when warning about no
 reclaimable task
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        Greg Thelen <gthelen@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
References: <20180807072553.14941-1-mhocko@kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <863d73ce-fae9-c117-e361-12c415c787de@i-love.sakura.ne.jp>
Date:   Tue, 7 Aug 2018 19:15:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807072553.14941-1-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/07 16:25, Michal Hocko wrote:
> @@ -1703,7 +1703,8 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>  		return OOM_ASYNC;
>  	}
>  
> -	if (mem_cgroup_out_of_memory(memcg, mask, order))
> +	if (mem_cgroup_out_of_memory(memcg, mask, order) ||
> +			tsk_is_oom_victim(current))
>  		return OOM_SUCCESS;
>  
>  	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
> 

I don't think this patch is appropriate. This patch only avoids hitting WARN(1).
This patch does not address the root cause:

The task_will_free_mem(current) test in out_of_memory() is returning false
because test_bit(MMF_OOM_SKIP, &mm->flags) test in task_will_free_mem() is
returning false because MMF_OOM_SKIP was already set by the OOM reaper. The OOM
killer does not need to start selecting next OOM victim until "current thread
completes __mmput()" or "it fails to complete __mmput() within reasonable
period".

According to https://syzkaller.appspot.com/text?tag=CrashLog&x=15a1c770400000 ,
PID=23767 selected PID=23766 as an OOM victim and the OOM reaper set MMF_OOM_SKIP
before PID=23766 unnecessarily selects PID=23767 as next OOM victim.
At uptime = 366.550949, out_of_memory() should have returned true without selecting
next OOM victim because tsk_is_oom_victim(current) == true.

[  365.869417] syz-executor2 invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), order=0, oom_score_adj=0
[  365.878899] CPU: 0 PID: 23767 Comm: syz-executor2 Not tainted 4.18.0-rc6-next-20180725+ #18
(...snipped...)
[  366.487490] Tasks state (memory values in pages):
[  366.492349] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[  366.501237] [  23766]     0 23766    17620     8221   126976        0             0 syz-executor3
[  366.510367] [  23767]     0 23767    17618     8218   126976        0             0 syz-executor2
[  366.519409] Memory cgroup out of memory: Kill process 23766 (syz-executor3) score 8252000 or sacrifice child
[  366.529422] Killed process 23766 (syz-executor3) total-vm:70480kB, anon-rss:116kB, file-rss:32768kB, shmem-rss:0kB
[  366.540456] oom_reaper: reaped process 23766 (syz-executor3), now anon-rss:0kB, file-rss:32000kB, shmem-rss:0kB
[  366.550949] syz-executor3 invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), order=0, oom_score_adj=0
[  366.560374] CPU: 1 PID: 23766 Comm: syz-executor3 Not tainted 4.18.0-rc6-next-20180725+ #18
(...snipped...)
[  367.138136] Tasks state (memory values in pages):
[  367.142986] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
[  367.151889] [  23766]     0 23766    17620     8002   126976        0             0 syz-executor3
[  367.160946] [  23767]     0 23767    17618     8218   126976        0             0 syz-executor2
[  367.169994] Memory cgroup out of memory: Kill process 23767 (syz-executor2) score 8249000 or sacrifice child
[  367.180119] Killed process 23767 (syz-executor2) total-vm:70472kB, anon-rss:104kB, file-rss:32768kB, shmem-rss:0kB
[  367.192101] oom_reaper: reaped process 23767 (syz-executor2), now anon-rss:0kB, file-rss:32000kB, shmem-rss:0kB
[  367.202986] ------------[ cut here ]------------
[  367.207845] Memory cgroup charge failed because of no reclaimable memory! This looks like a misconfiguration or a kernel bug.
[  367.207965] WARNING: CPU: 1 PID: 23767 at mm/memcontrol.c:1710 try_charge+0x734/0x1680
[  367.227540] Kernel panic - not syncing: panic_on_warn set ...

Of course, if the hard limit is 0, all processes will be killed after all. But
Michal is ignoring the fact that if the hard limit were not 0, there is a chance
of saving next process from needlessly killed if we waited until "mm of PID=23766
completed __mmput()" or "mm of PID=23766 failed to complete __mmput() within
reasonable period". 

We can make efforts not to return false at

	/*
	 * This task has already been drained by the oom reaper so there are
	 * only small chances it will free some more
	 */
	if (test_bit(MMF_OOM_SKIP, &mm->flags))
		return false;

(I admit that ignoring MMF_OOM_SKIP for once might not be sufficient for memcg
case), and we can use feedback based backoff like
"[PATCH 4/4] mm, oom: Fix unnecessary killing of additional processes." *UNTIL*
we come to the point where the OOM reaper can always reclaim all memory.

