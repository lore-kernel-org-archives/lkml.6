Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8914ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD1E2084A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 11:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD1E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeGUMYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 08:24:09 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61705 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbeGUMYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 08:24:08 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6LBVgNV011042;
        Sat, 21 Jul 2018 20:31:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Sat, 21 Jul 2018 20:31:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6LBVY55011007
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 21 Jul 2018 20:31:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] sched/debug: Use terse backtrace for idly sleeping
 threads.
To:     David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1532007443-3538-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180719134653.GH2476@hirez.programming.kicks-ass.net>
 <54fc7ab8-2995-e864-7f74-c4434d23622c@i-love.sakura.ne.jp>
 <2802327e499a43cf832d84237436959c@AcuMS.aculab.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <374c247a-ebe1-7f31-a52f-69d7f2db21be@i-love.sakura.ne.jp>
Date:   Sat, 21 Jul 2018 20:31:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2802327e499a43cf832d84237436959c@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/20 23:04, David Laight wrote:
> From: Tetsuo Handa
>> Sent: 20 July 2018 14:27
>>
>> On 2018/07/19 22:46, Peter Zijlstra wrote:
>>> On Thu, Jul 19, 2018 at 10:37:23PM +0900, Tetsuo Handa wrote:
>>>> This patch can be applied before proposing abovementioned changes.
>>>> Since there are many kernel threads whose backtrace is boring due to idly
>>>> waiting for an event inside the main loop, this patch introduces a kernel
>>>> config option (which allows SysRq-t to use one-liner backtrace for threads
>>>> idly waiting for an event) and simple helpers (which allow current thread
>>>> to declare that current thread is about to start/end idly waiting).
> 
> A kernel config option isn't the right place to select this.
> Distros will build kernels with the 'wrong' value.

What do you mean? Distros can build their kernels with that config option disabled.
Are you suggesting runtime switching like /proc/sys/ or sysfs or debugfs ?

I'm using a syzbot specific kernel config option for testing under syzbot
(e.g. https://lore.kernel.org/lkml/9b9fcdda-c347-53ee-fdbb-8a7d11cf430e@I-love.SAKURA.ne.jp/T/#u ).
But I don't think that "using one-liner backtrace for threads idly waiting for
an event" has to be syzbot specific.

> 
> In any case it is usually easier to read /proc/nnn/stack of the process
> you are interested it rather than write all of them to the kernel message
> buffer and find that it is far too small.

Reading /proc/$pid/stack is not an option for automated testing by syzbot.

syzbot currently has 65 hung task reports. Calling SysRq-l when khungtaskd
fired is still insufficient, and also analyzing vmcore is still impossible.
For syzbot, calling SysRq-t when khungtaskd fired will be helpful.

> 
>>>> diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
>>>> index f776807..6b8c8bd 100644
>>>> --- a/drivers/base/devtmpfs.c
>>>> +++ b/drivers/base/devtmpfs.c
>>>> @@ -406,7 +406,9 @@ static int devtmpfsd(void *p)
>>>>  		}
>>>>  		__set_current_state(TASK_INTERRUPTIBLE);
>>>>  		spin_unlock(&req_lock);
>>>> +		start_idle_sleeping();
>>>>  		schedule();
>>>> +		end_idle_sleeping();
>>>>  	}
>>>>  	return 0;
>>>>  out:
>>>
>>> So I _really_ hate the idea of sprinking that all around the kernel like
>>> this.
>>>
>>
>> Does that comment mean the idea of "using one-liner backtrace for threads
>> idly waiting for an event" itself is OK?
> 
> Aren't such stack traces likely to be short ones anyway?
> Either that or you actually want to know where it is really waiting.

Even if each stack is small, since size of console log needs to be limited,
I want to save lines where possible.

> 
>> Since there already is schedule_idle() function, introducing idly_schedule()
>> etc. is very confusing. What I'm trying to do is to tell debug function that
>> "I'm currently in neutral situation and hence dumping my backtrace will not
>> give you interesting result". Since such section needs to be carefully
>> annotated with comments, I think that lockdep-like annotation fits better
>> than introducing wrapped functions.
> 
> Or use extra bits of current->state set by set_current_state().

I didn't catch how we can use it. I worry that there is a risk of
unexpectedly overwritten because I don't think that the statement which
follows set_current_state() is always schedule*()/wait_event*() etc.

