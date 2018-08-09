Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7073EC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA3021EFC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA3021EFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeHIXcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:32:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:43790 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727336AbeHIXcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:32:04 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w79L5PsO037944;
        Fri, 10 Aug 2018 06:05:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Fri, 10 Aug 2018 06:05:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w79L5I0G037934
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 10 Aug 2018 06:05:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: WARNING in try_charge
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Rientjes <rientjes@google.com>,
        syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <0000000000005e979605729c1564@google.com>
 <e2869136-9f59-9ce8-8b9f-f75b157ee31d@I-love.SAKURA.ne.jp>
 <20180809150735.GA15611@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <56c95100-d7f9-b715-bdec-e8bb112e2630@i-love.sakura.ne.jp>
Date:   Fri, 10 Aug 2018 06:05:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809150735.GA15611@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/10 0:07, Michal Hocko wrote:
> On Thu 09-08-18 22:57:43, Tetsuo Handa wrote:
>> >From b1f38168f14397c7af9c122cd8207663d96e02ec Mon Sep 17 00:00:00 2001
>> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> Date: Thu, 9 Aug 2018 22:49:40 +0900
>> Subject: [PATCH] mm, oom: task_will_free_mem(current) should retry until
>>  memory reserve fails
>>
>> Commit 696453e66630ad45 ("mm, oom: task_will_free_mem should skip
>> oom_reaped tasks") changed to select next OOM victim as soon as
>> MMF_OOM_SKIP is set. But we don't need to select next OOM victim as
>> long as ALLOC_OOM allocation can succeed. And syzbot is hitting WARN(1)
>> caused by this race window [1].
> 
> It is not because the syzbot was exercising a completely different code
> path (memcg charge rather than the page allocator).

I know syzbot is hitting memcg charge path.

> 
>> Since memcg OOM case uses forced charge if current thread is killed,
>> out_of_memory() can return true without selecting next OOM victim.
>> Therefore, this patch changes task_will_free_mem(current) to ignore
>> MMF_OOM_SKIP unless ALLOC_OOM allocation failed.
> 
> And the patch is simply wrong for memcg.
> 

Why? I think I should have done

-+	page = __alloc_pages_may_oom(gfp_mask, order, alloc_flags == ALLOC_OOM
-+				     || (gfp_mask & __GFP_NOMEMALLOC), ac,
-+				     &did_some_progress);
++	page = __alloc_pages_may_oom(gfp_mask, order, alloc_flags == ALLOC_OOM,
++				     ac, &did_some_progress);

because nobody will use __GFP_NOMEMALLOC | __GFP_NOFAIL. But for memcg charge
path, task_will_free_mem(current, false) == true and out_of_memory() will return
true, which avoids unnecessary OOM killing.

Of course, this patch cannot avoid unnecessary OOM killing if out_of_memory()
is called by not yet killed process. But to mitigate it, what can we do other
than defer setting MMF_OOM_SKIP using a timeout based mechanism? Making
the OOM reaper unconditionally reclaim all memory is not a valid answer.

