Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2644C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C9A20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C9A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLGMne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:43:34 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:47446 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeLGMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:43:34 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wB7ChEO7026052;
        Fri, 7 Dec 2018 21:43:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Fri, 07 Dec 2018 21:43:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wB7Ch81o025973
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 7 Dec 2018 21:43:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181022071323.9550-1-mhocko@kernel.org>
 <20181022071323.9550-3-mhocko@kernel.org>
 <20181026142531.GA27370@cmpxchg.org> <20181026192551.GC18839@dhcp22.suse.cz>
 <20181026193304.GD18839@dhcp22.suse.cz>
 <dfafc626-2233-db9b-49fa-9d4bae16d4aa@i-love.sakura.ne.jp>
 <c38e352a-dd23-a5e4-ac50-75b557506479@i-love.sakura.ne.jp>
 <20181106124224.GM27423@dhcp22.suse.cz>
 <8725e3b3-3752-fa7f-a88f-5ff4f5b6eace@i-love.sakura.ne.jp>
 <20181107100810.GA27423@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <8a71ecd8-e7bc-25de-184f-dfda511ee0d1@i-love.sakura.ne.jp>
Date:   Fri, 7 Dec 2018 21:43:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181107100810.GA27423@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/07 19:08, Michal Hocko wrote:
> On Wed 07-11-18 18:45:27, Tetsuo Handa wrote:
>> On 2018/11/06 21:42, Michal Hocko wrote:
>>> On Tue 06-11-18 18:44:43, Tetsuo Handa wrote:
>>> [...]
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index 6e1469b..a97648a 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -1382,8 +1382,13 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>>>>  	};
>>>>  	bool ret;
>>>>  
>>>> -	mutex_lock(&oom_lock);
>>>> -	ret = out_of_memory(&oc);
>>>> +	if (mutex_lock_killable(&oom_lock))
>>>> +		return true;
>>>> +	/*
>>>> +	 * A few threads which were not waiting at mutex_lock_killable() can
>>>> +	 * fail to bail out. Therefore, check again after holding oom_lock.
>>>> +	 */
>>>> +	ret = fatal_signal_pending(current) || out_of_memory(&oc);
>>>>  	mutex_unlock(&oom_lock);
>>>>  	return ret;
>>>>  }
>>>
>>> If we are goging with a memcg specific thingy then I really prefer
>>> tsk_is_oom_victim approach. Or is there any reason why this is not
>>> suitable?
>>>
>>
>> Why need to wait for mark_oom_victim() called after slow printk() messages?
>>
>> If current thread got Ctrl-C and thus current thread can terminate, what is
>> nice with waiting for the OOM killer? If there are several OOM events in
>> multiple memcg domains waiting for completion of printk() messages? I don't
>> see points with waiting for oom_lock, for try_charge() already allows current
>> thread to terminate due to fatal_signal_pending() test.
> 
> mutex_lock_killable would take care of exiting task already. I would
> then still prefer to check for mark_oom_victim because that is not racy
> with the exit path clearing signals. I can update my patch to use
> _killable lock variant if we are really going with the memcg specific
> fix.
> 
> Johaness?
> 

No response for one month. When can we get to an RCU stall problem syzbot reported?
