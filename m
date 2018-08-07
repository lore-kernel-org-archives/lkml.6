Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D36C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B21215F1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B21215F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeHGWyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:54:54 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57062 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeHGWyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:54:54 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w77Kcfea069550;
        Wed, 8 Aug 2018 05:38:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Wed, 08 Aug 2018 05:38:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w77KcfIq069547
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 8 Aug 2018 05:38:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] memcg, oom: be careful about races when warning about no
 reclaimable task
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        Greg Thelen <gthelen@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
References: <20180807072553.14941-1-mhocko@kernel.org>
 <863d73ce-fae9-c117-e361-12c415c787de@i-love.sakura.ne.jp>
 <20180807201935.GB4251@cmpxchg.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1308e0bd-e194-7b35-484c-fc18f493f8da@i-love.sakura.ne.jp>
Date:   Wed, 8 Aug 2018 05:38:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807201935.GB4251@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/08 5:19, Johannes Weiner wrote:
> On Tue, Aug 07, 2018 at 07:15:11PM +0900, Tetsuo Handa wrote:
>> On 2018/08/07 16:25, Michal Hocko wrote:
>>> @@ -1703,7 +1703,8 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>>>  		return OOM_ASYNC;
>>>  	}
>>>  
>>> -	if (mem_cgroup_out_of_memory(memcg, mask, order))
>>> +	if (mem_cgroup_out_of_memory(memcg, mask, order) ||
>>> +			tsk_is_oom_victim(current))
>>>  		return OOM_SUCCESS;
>>>  
>>>  	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
>>>
>>
>> I don't think this patch is appropriate. This patch only avoids hitting WARN(1).
>> This patch does not address the root cause:
>>
>> The task_will_free_mem(current) test in out_of_memory() is returning false
>> because test_bit(MMF_OOM_SKIP, &mm->flags) test in task_will_free_mem() is
>> returning false because MMF_OOM_SKIP was already set by the OOM reaper. The OOM
>> killer does not need to start selecting next OOM victim until "current thread
>> completes __mmput()" or "it fails to complete __mmput() within reasonable
>> period".
> 
> I don't see why it matters whether the OOM victim exits or not, unless
> you count the memory consumed by struct task_struct.

We are not counting memory consumed by struct task_struct. But David is
counting memory released between set_bit(MMF_OOM_SKIP, &mm->flags) and
completion of exit_mmap().

> 
>> According to https://syzkaller.appspot.com/text?tag=CrashLog&x=15a1c770400000 ,
>> PID=23767 selected PID=23766 as an OOM victim and the OOM reaper set MMF_OOM_SKIP
>> before PID=23766 unnecessarily selects PID=23767 as next OOM victim.
>> At uptime = 366.550949, out_of_memory() should have returned true without selecting
>> next OOM victim because tsk_is_oom_victim(current) == true.
> 
> The code works just fine. We have to kill tasks until we a) free
> enough memory or b) run out of tasks or c) kill current. When one of
> these outcomes is reached, we allow the charge and return.
> 
> The only problem here is a warning in the wrong place.
> 

If forced charge contained a bug, removing this WARN(1) deprives users of chance
to know that something is going wrong.
