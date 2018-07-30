Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76418FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5B820890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5B820890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeG3RAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:00:39 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:42592 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeG3RAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:00:39 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6UFP949000877;
        Tue, 31 Jul 2018 00:25:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Tue, 31 Jul 2018 00:25:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6UFP8jW000868
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 31 Jul 2018 00:25:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
To:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <ca3da8b8-1bb5-c302-b190-fa6cebab58ca@I-love.SAKURA.ne.jp>
 <20180726113958.GE28386@dhcp22.suse.cz>
 <55c9da7f-e448-964a-5b50-47f89a24235b@i-love.sakura.ne.jp>
 <20180730093257.GG24267@dhcp22.suse.cz>
 <9158a23e-7793-7735-e35c-acd540ca59bf@i-love.sakura.ne.jp>
 <20180730144647.GX24267@dhcp22.suse.cz>
 <20180730145425.GE1206094@devbig004.ftw2.facebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0018ac3b-94ee-5f09-e4e0-df53d2cbc925@i-love.sakura.ne.jp>
Date:   Tue, 31 Jul 2018 00:25:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730145425.GE1206094@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/30 23:54, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jul 30, 2018 at 04:46:47PM +0200, Michal Hocko wrote:
>> On Mon 30-07-18 23:34:23, Tetsuo Handa wrote:
>>> On 2018/07/30 18:32, Michal Hocko wrote:
>> [...]
>>>> This one is waiting for draining and we are in mm_percpu_wq WQ context
>>>> which has its rescuer so no other activity can block us for ever. So
>>>> this certainly shouldn't deadlock. It can be dead slow but well, this is
>>>> what you will get when your shoot your system to death.
>>>
>>> We need schedule_timeout_*() to allow such WQ_MEM_RECLAIM workqueues to wake up. (Tejun,
>>> is my understanding correct?) Lack of schedule_timeout_*() does block WQ_MEM_RECLAIM
>>> workqueues forever.
>>
>> Hmm. This doesn't match my understanding of what WQ_MEM_RECLAIM actually
>> guarantees. If you are right then the whole thing sounds quite fragile
>> to me TBH.
> 
> Workqueue doesn't think the cpu is stalled as long as one of the
> per-cpu kworkers is running.  The assumption is that kernel threads
> are not supposed to be busy-looping indefinitely (and they really
> shouldn't).

WQ_MEM_RECLAIM guarantees that "struct task_struct" is preallocated. But
WQ_MEM_RECLAIM does not guarantee that the pending work is started as soon
as an item was queued. Same rule applies to both WQ_MEM_RECLAIM workqueues 
and !WQ_MEM_RECLAIM workqueues regarding when to start a pending work (i.e.
when schedule_timeout_*() is called).

Is this correct?

>              We can add timeout mechanism to workqueue so that it
> kicks off other kworkers if one of them is in running state for too
> long, but idk, if there's an indefinite busy loop condition in kernel
> threads, we really should get rid of them and hung task watchdog is
> pretty effective at finding these cases (at least with preemption
> disabled).

Currently the page allocator has a path which can loop forever with
only cond_resched().

> 
> Thanks.
> 

