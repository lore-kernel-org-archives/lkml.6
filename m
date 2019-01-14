Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F3EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCDB2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfANNXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:23:55 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61565 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfANNXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:23:54 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0EDNIM0027326;
        Mon, 14 Jan 2019 22:23:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Mon, 14 Jan 2019 22:23:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0EDND0F027267
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 14 Jan 2019 22:23:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] locking/lockdep: Add debug_locks check in
 __lock_downgrade()
To:     Dmitry Vyukov <dvyukov@google.com>,
        Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1547093005-26085-1-git-send-email-longman@redhat.com>
 <CACT4Y+YJYSo5GtSvMSqh4y_w7jWC1S-RYu+exuR3DU9NyrpJqA@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b6469b3a-0c92-8281-ed7a-5364c5de0615@i-love.sakura.ne.jp>
Date:   Mon, 14 Jan 2019 22:23:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YJYSo5GtSvMSqh4y_w7jWC1S-RYu+exuR3DU9NyrpJqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/10 19:21, Dmitry Vyukov wrote:
>> @@ -3535,6 +3535,9 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
>>         unsigned int depth;
>>         int i;
>>
>> +       if (unlikely(!debug_locks))
>> +               return 0;
>> +
> 
> Are we sure this resolves the problem rather than makes the
> inconsistency window smaller?

As far as I know, this should resolve the problem.

> I don't understand all surrounding code, but looking just at this
> function it looks like it may just pepper over the problem. Say, we
> pass this check when lockdep was still turned on. Then this thread is
> preempted for some time (e.g. a virtual CPU), then another thread
> started reporting a warning, turned lockdep off, some information
> wasn't collected, and this this task resumes and reports a false
> warning.

What this function checks is whether current thread is holding rw_semaphore
for write. Since the information of held locks are per "struct task_struct"
record, if lockdep is still enabled as of entry of this function, there must
be a lockdep record that current thread is holding rw_semaphore for write
if current thread is actually holding rw_semaphore for write. Therefore,
preemption/interrupts can't erase the lockdep record that current thread is
holding rw_semaphore, even if lockdep is turned off after passing this check.

> Or we are holding the mutex here, and the fact that we are holding it
> ensures that no other task will take it and no information will be
> lost?
> Quite a tricky moment, perhaps deserves a comment.

I think many other functions check debug_locks upon entry of functions.

> 
>>         depth = curr->lockdep_depth;
>>         /*
>>          * This function is about (re)setting the class of a held lock,

