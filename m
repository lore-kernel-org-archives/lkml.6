Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8690CECDE46
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 01:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C16207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 01:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C16207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeJ0Jtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 05:49:42 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:21294 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJ0Jtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 05:49:42 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9R1ADKa061478;
        Sat, 27 Oct 2018 10:10:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Sat, 27 Oct 2018 10:10:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9R1A8fQ061445
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 27 Oct 2018 10:10:13 +0900 (JST)
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <dfafc626-2233-db9b-49fa-9d4bae16d4aa@i-love.sakura.ne.jp>
Date:   Sat, 27 Oct 2018 10:10:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026193304.GD18839@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/27 4:25, Michal Hocko wrote:
>> out_of_memory() bails on task_will_free_mem(current), which
>> specifically *excludes* already reaped tasks. Why are we then adding a
>> separate check before that to bail on already reaped victims?
> 
> 696453e66630a has introduced the bail out.
> 
>> Do we want to bail if current is a reaped victim or not?
>>
>> I don't see how we could skip it safely in general: the current task
>> might have been killed and reaped and gotten access to the memory
>> reserve and still fail to allocate on its way out. It needs to kill
>> the next task if there is one, or warn if there isn't another
>> one. Because we're genuinely oom without reclaimable tasks.
> 
> Yes, this would be the case for the global case which is a real OOM
> situation. Memcg oom is somehow more relaxed because the oom is local.

We can handle possibility of genuinely OOM without reclaimable tasks.
Only __GFP_NOFAIL OOM has to select next OOM victim. There is no need to
select next OOM victim unless __GFP_NOFAIL. Commit 696453e66630ad45
("mm, oom: task_will_free_mem should skip oom_reaped tasks") was too simple.

On 2018/10/27 4:33, Michal Hocko wrote:
> On Fri 26-10-18 21:25:51, Michal Hocko wrote:
>> On Fri 26-10-18 10:25:31, Johannes Weiner wrote:
> [...]
>>> There is of course the scenario brought forward in this thread, where
>>> multiple threads of a process race and the second one enters oom even
>>> though it doesn't need to anymore. What the global case does to catch
>>> this is to grab the oom lock and do one last alloc attempt. Should
>>> memcg lock the oom_lock and try one more time to charge the memcg?
>>
>> That would be another option. I agree that making it more towards the
>> global case makes it more attractive. My tsk_is_oom_victim is more
>> towards "plug this particular case".
> 
> Nevertheless let me emphasise that tsk_is_oom_victim will close the race
> completely, while mem_cgroup_margin will always be racy. So the question
> is whether we want to close the race because it is just too easy for
> userspace to hit it or keep the global and memcg oom handling as close
> as possible.
> 

Yes, adding tsk_is_oom_victim(current) before calling out_of_memory() from
both global OOM and memcg OOM paths can close the race completely. (But
note that tsk_is_oom_victim(current) for global OOM path needs to check for
__GFP_NOFAIL in order to handle genuinely OOM case.)
