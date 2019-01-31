Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D59C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABFC218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfAaVAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:00:08 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:24663 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfAaVAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:00:08 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0VL06kl083929;
        Fri, 1 Feb 2019 06:00:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Fri, 01 Feb 2019 06:00:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0VKxx1L083877
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 1 Feb 2019 06:00:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] mm, oom: Tolerate processes sharing mm with different
 view of oom_score_adj.
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Yong-Taek Lee <ytk.lee@samsung.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1547636121-9229-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190116110937.GI24149@dhcp22.suse.cz>
 <88e10029-f3d9-5bb5-be46-a3547c54de28@I-love.SAKURA.ne.jp>
 <20190116121915.GJ24149@dhcp22.suse.cz>
 <6118fa8a-7344-b4b2-36ce-d77d495fba69@i-love.sakura.ne.jp>
 <20190116134131.GP24149@dhcp22.suse.cz>
 <20190117155159.GA4087@dhcp22.suse.cz>
 <edad66e0-1947-eb42-f4db-7f826d3157d7@i-love.sakura.ne.jp>
 <20190131071130.GM18811@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5fd73d87-3e4b-f793-1976-b937955663e3@i-love.sakura.ne.jp>
Date:   Fri, 1 Feb 2019 05:59:55 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190131071130.GM18811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/31 16:11, Michal Hocko wrote:
> On Thu 31-01-19 07:49:35, Tetsuo Handa wrote:
>> This patch reverts both commit 44a70adec910d692 ("mm, oom_adj: make sure
>> processes sharing mm have same view of oom_score_adj") and commit
>> 97fd49c2355ffded ("mm, oom: kill all tasks sharing the mm") in order to
>> close a race and reduce the latency at __set_oom_adj(), and reduces the
>> warning at __oom_kill_process() in order to minimize the latency.
>>
>> Commit 36324a990cf578b5 ("oom: clear TIF_MEMDIE after oom_reaper managed
>> to unmap the address space") introduced the worst case mentioned in
>> 44a70adec910d692. But since the OOM killer skips mm with MMF_OOM_SKIP set,
>> only administrators can trigger the worst case.
>>
>> Since 44a70adec910d692 did not take latency into account, we can "hold RCU
>> for minutes and trigger RCU stall warnings" by calling printk() on many
>> thousands of thread groups. Also, current code becomes a DoS attack vector
>> which will allow "stalling for more than one month in unkillable state"
>> simply printk()ing same messages when many thousands of thread groups
>> tried to iterate __set_oom_adj() on each other.
>>
>> I also noticed that 44a70adec910d692 is racy [1], and trying to fix the
>> race will require a global lock which is too costly for rare events. And
>> Michal Hocko is thinking to change the oom_score_adj implementation to per
>> mm_struct (with shadowed score stored in per task_struct in order to
>> support vfork() => __set_oom_adj() => execve() sequence) so that we don't
>> need the global lock.
>>
>> If the worst case in 44a70adec910d692 happened, it is an administrator's
>> request. Therefore, before changing the oom_score_adj implementation,
>> let's eliminate the DoS attack vector first.
> 
> This is really ridiculous. I have already nacked the previous version
> and provided two ways around. The simplest one is to drop the printk.
> The second one is to move oom_score_adj to the mm struct. Could you
> explain why do you still push for this?

Dropping printk() does not close the race.
You must propose an alternative patch if you dislike this patch.

> 
>> [1] https://lkml.kernel.org/r/20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p8
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Reported-by: Yong-Taek Lee <ytk.lee@samsung.com>
>> Nacked-by: Michal Hocko <mhocko@suse.com>
>> ---
>>  fs/proc/base.c     | 46 ----------------------------------------------
>>  include/linux/mm.h |  2 --
>>  mm/oom_kill.c      | 10 ++++++----
>>  3 files changed, 6 insertions(+), 52 deletions(-)
>>
