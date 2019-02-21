Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F07DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABA520818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 18:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbfBUS2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 13:28:39 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49244 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfBUS2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 13:28:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F7B780D;
        Thu, 21 Feb 2019 10:28:38 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 852733F5C1;
        Thu, 21 Feb 2019 10:28:36 -0800 (PST)
Subject: Re: [RFC][PATCH 15/16] sched: Trivial forced-newidle balancer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com
References: <20190218165620.383905466@infradead.org>
 <20190218173514.796920915@infradead.org>
 <d7a408c0-b86a-da56-5440-d7cb380708c6@arm.com>
 <20190221164146.GV32494@hirez.programming.kicks-ass.net>
 <20190221164702.GY32534@hirez.programming.kicks-ass.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <49bd4760-53d4-3695-4bcc-aeb9086617ab@arm.com>
Date:   Thu, 21 Feb 2019 18:28:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221164702.GY32534@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2019 16:47, Peter Zijlstra wrote:
[...]
>>> IIUC, we're trying to find/steal tasks matching the core_cookie from other
>>> rqs because dst has been cookie-forced-idle.
>>>
>>> If the p we find isn't running, what's the meaning of core_occupation?
>>> I would have expected it to be 0, but we don't seem to be clearing it when
>>> resetting the state in pick_next_task().
>>
>> Indeed. We preserve the occupation from the last time around; it's not
>> perfect but its better than nothing.
>>
>> Consider there's two groups; and we just happen to run the other group.
>> Then our occopation, being what it was last, is still accurate. When
>> next we run, we'll again get that many siblings together.
>>
>>> If it is running, we prevent the stealing if the core it's on is running
>>> more matching tasks than the core of the pulling rq. It feels to me as if
>>> that's a balancing tweak to try to cram as many matching tasks as possible
>>> in a single core, so to me this reads as "don't steal my tasks if I'm
>>> running more than you are, but I will steal tasks from you if I'm given
>>> the chance". Is that correct?
>>
>> Correct, otherwise an SMT4 with 5 tasks could end up ping-ponging the
>> one task forever.
>>

Wouldn't we want to move some tasks in those cases? If we're going newidle
we're guaranteed to have a thread for that extra task.

So

  if (p->core_occupation == cpumask_weight(cpu_smt_mask(that))

we could want to steal, overriding the occupation comparison
(we already have a (p == src->core_pick) abort before). Kind of feels like
CFS stealing that steals when nr_running > 1.

>> Note that a further condition a little up the callchain from here only
>> does this stealing if the thread was forced-idle -- ie. it had something
>> to run anyway. So under the condition where there simple aren't enough
>> tasks to keep all siblings busy, we'll not compact just cause.
> 
> Better example; it will avoid stealing a task from a full SMT2 core to
> fill another.
> 

Aye, that's the scenario I was thinking of.

Thanks for clearing things up.
