Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BFCC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0417D20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0417D20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388882AbeGYAEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:04:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:47700 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388587AbeGYAEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:04:48 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6OMtumR005166;
        Wed, 25 Jul 2018 07:55:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Wed, 25 Jul 2018 07:55:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6OMtuUK005163
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 25 Jul 2018 07:55:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch v4] mm, oom: fix unnecessary killing of additional
 processes
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com>
 <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807181317540.49359@chino.kir.corp.google.com>
 <a78fb992-ad59-0cdb-3c38-8284b2245f21@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807200133310.119737@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807201314230.231119@chino.kir.corp.google.com>
 <ca34b123-5c81-569f-85ea-4851bc569962@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807201505550.38399@chino.kir.corp.google.com>
 <f8d24892-b05e-73a8-36d5-4fe278f84c44@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807241444370.206335@chino.kir.corp.google.com>
 <05dbc69a-1c26-adec-15c6-f7192f8d2ae0@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807241549420.215249@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f2e09fbf-700c-19d6-7dd8-42683507b5d1@i-love.sakura.ne.jp>
Date:   Wed, 25 Jul 2018 07:55:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807241549420.215249@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/25 7:51, David Rientjes wrote:
> On Wed, 25 Jul 2018, Tetsuo Handa wrote:
> 
>>>> You might worry about situations where __oom_reap_task_mm() is a no-op.
>>>> But that is not always true. There is no point with emitting
>>>>
>>>>   pr_info("oom_reaper: unable to reap pid:%d (%s)\n", ...);
>>>>   debug_show_all_locks();
>>>>
>>>> noise and doing
>>>>
>>>>   set_bit(MMF_OOM_SKIP, &mm->flags);
>>>>
>>>> because exit_mmap() will not release oom_lock until __oom_reap_task_mm()
>>>> completes. That is, except extra noise, there is no difference with
>>>> current behavior which sets set_bit(MMF_OOM_SKIP, &mm->flags) after
>>>> returning from __oom_reap_task_mm().
>>>>
>>>
>>> v5 has restructured how exit_mmap() serializes its unmapping with the oom 
>>> reaper.  It sets MMF_OOM_SKIP while holding mm->mmap_sem.
>>>
>>
>> I think that v5 is still wrong. exit_mmap() keeps mmap_sem held for write does
>> not prevent oom_reap_task() from emitting the noise and setting MMF_OOM_SKIP
>> after timeout. Since your purpose is to wait for release of memory which could
>> not be reclaimed by __oom_reap_task_mm(), what if __oom_reap_task_mm() was no-op and
>> exit_mmap() was preempted immediately after returning from __oom_reap_task_mm() ?
>>
> 
> If exit_mmap() gets preempted indefinitely before it can free any memory, 
> we are better off oom killing another process.  The purpose of the timeout 
> is to give an oom victim an amount of time to free its memory and exit 
> before selecting another victim.
> 

There is no point with emitting the noise.
