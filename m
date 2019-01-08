Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03AAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70EE20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfAHKkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:40:11 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:37348 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfAHKkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:40:11 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x08Ae0He083683;
        Tue, 8 Jan 2019 19:40:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Tue, 08 Jan 2019 19:40:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x08Adxxk083662
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 8 Jan 2019 19:39:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190107143802.16847-1-mhocko@kernel.org>
 <20190107143802.16847-3-mhocko@kernel.org>
 <fa8892d1-4a38-dccd-9597-923924aa0a66@i-love.sakura.ne.jp>
 <20190108081441.GO31793@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3b105bba-3542-1d00-c6e2-52f6d125eff2@i-love.sakura.ne.jp>
Date:   Tue, 8 Jan 2019 19:39:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108081441.GO31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/08 17:14, Michal Hocko wrote:
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index af7f18b32389..90eb2e2093e7 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -1387,10 +1387,22 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>>>  		.gfp_mask = gfp_mask,
>>>  		.order = order,
>>>  	};
>>> -	bool ret;
>>> +	bool ret = true;
>>>  
>>>  	mutex_lock(&oom_lock);
>>
>> And because of "[PATCH 1/2] mm, oom: marks all killed tasks as oom
>> victims", mark_oom_victim() will be called on current thread even if
>> we used mutex_lock_killable(&oom_lock) here, like you said
>>
>>   mutex_lock_killable would take care of exiting task already. I would
>>   then still prefer to check for mark_oom_victim because that is not racy
>>   with the exit path clearing signals. I can update my patch to use
>>   _killable lock variant if we are really going with the memcg specific
>>   fix.
>>
>> . If current thread is not yet killed by the OOM killer but can terminate
>> without invoking the OOM killer, using mutex_lock_killable(&oom_lock) here
>> saves some processes. What is the race you are referring by "racy with the
>> exit path clearing signals" ?
> 
> This is unrelated to the patch.

Ultimately related! This is the reasoning why your patch should be preferred
over my patch.

For example, if memcg OOM events in different domains are pending, already
OOM-killed threads needlessly wait for pending memcg OOM events in different
domains. An out_of_memory() call is slow because it involves printk(). With
slow serial consoles, out_of_memory() might take more than a second. I consider
that allowing killed processes to call mmput() from exit_mm() from do_exit()
quickly (instead of waiting for pending memcg OOM events in different domains
at mem_cgroup_out_of_memory()) helps calling __mmput() (which can reclaim more
memory than the OOM reaper can reclaim) quickly. Unless what you call "racy" is
problematic, I don't see reasons not to apply my patch. So, please please answer
what you are referring to with "racy".

