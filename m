Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C301ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DE020652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DE020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbeGTOPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:15:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:16365 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732136AbeGTOPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:15:43 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6KDRObg093699;
        Fri, 20 Jul 2018 22:27:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Fri, 20 Jul 2018 22:27:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6KDRGvj093639
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 20 Jul 2018 22:27:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] sched/debug: Use terse backtrace for idly sleeping
 threads.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
References: <1532007443-3538-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180719134653.GH2476@hirez.programming.kicks-ass.net>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <54fc7ab8-2995-e864-7f74-c4434d23622c@i-love.sakura.ne.jp>
Date:   Fri, 20 Jul 2018 22:27:17 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719134653.GH2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/19 22:46, Peter Zijlstra wrote:
> On Thu, Jul 19, 2018 at 10:37:23PM +0900, Tetsuo Handa wrote:
>> This patch can be applied before proposing abovementioned changes.
>> Since there are many kernel threads whose backtrace is boring due to idly
>> waiting for an event inside the main loop, this patch introduces a kernel
>> config option (which allows SysRq-t to use one-liner backtrace for threads
>> idly waiting for an event) and simple helpers (which allow current thread
>> to declare that current thread is about to start/end idly waiting).
> 
>> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
>> index f776807..6b8c8bd 100644
>> --- a/drivers/base/devtmpfs.c
>> +++ b/drivers/base/devtmpfs.c
>> @@ -406,7 +406,9 @@ static int devtmpfsd(void *p)
>>  		}
>>  		__set_current_state(TASK_INTERRUPTIBLE);
>>  		spin_unlock(&req_lock);
>> +		start_idle_sleeping();
>>  		schedule();
>> +		end_idle_sleeping();
>>  	}
>>  	return 0;
>>  out:
> 
> So I _really_ hate the idea of sprinking that all around the kernel like
> this.
> 

Does that comment mean the idea of "using one-liner backtrace for threads
idly waiting for an event" itself is OK?

Since there already is schedule_idle() function, introducing idly_schedule()
etc. is very confusing. What I'm trying to do is to tell debug function that
"I'm currently in neutral situation and hence dumping my backtrace will not
give you interesting result". Since such section needs to be carefully
annotated with comments, I think that lockdep-like annotation fits better
than introducing wrapped functions.

