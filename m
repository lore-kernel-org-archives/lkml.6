Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B777DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6628E21537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6628E21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbeI0FhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:37:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbeI0FhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:37:10 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2AFA369CE;
        Wed, 26 Sep 2018 23:21:50 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-223.rdu2.redhat.com [10.10.120.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E57A2010D16;
        Wed, 26 Sep 2018 23:21:49 +0000 (UTC)
Subject: Re: [RFC][PATCH 0/3] locking/qspinlock: Improve determinism for x86
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        tglx@linutronix.de
References: <20180926110117.405325143@infradead.org>
 <2c284b6d-99c1-2686-b8c0-fce8987e747f@redhat.com>
 <20180926175112.GA5254@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <5c492b85-365f-e64d-2230-f479903591d8@redhat.com>
Date:   Wed, 26 Sep 2018 19:21:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180926175112.GA5254@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 26 Sep 2018 23:21:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 01:51 PM, Peter Zijlstra wrote:
> On Wed, Sep 26, 2018 at 12:20:09PM -0400, Waiman Long wrote:
>> On 09/26/2018 07:01 AM, Peter Zijlstra wrote:
>>> Back when Will did his qspinlock determinism patches, we were left with one
>>> cmpxchg loop on x86 due to the use of atomic_fetch_or(). Will proposed a nifty
>>> trick:
>>>
>>>   http://lkml.kernel.org/r/20180409145409.GA9661@arm.com
>>>
>>> But at the time we didn't pursue it. This series implements that and argues for
>>> its correctness. In particular it places an smp_mb__after_atomic() in
>>> between the two operations, which forces the load to come after the
>>> store (which is free on x86 anyway).
>>>
>>> In particular this ordering ensures a concurrent unlock cannot trigger
>>> the uncontended handoff. Also it ensures that if the xchg() happens
>>> after a (successful) trylock, we must observe that LOCKED bit.
>> When you said "concurrent unlock cannot trigger the uncontended
>> handoff", are you saying the current code has this uncontended handoff
>> problem or just when comparing to doing a load first followed by xchg()?
> In particular I'm talking about this:
>
> locked:
> 	/*
> 	 * claim the lock:
> 	 *
> 	 * n,0,0 -> 0,0,1 : lock, uncontended
> 	 * *,0,0 -> *,0,1 : lock, contended
> 	 *
> 	 * If the queue head is the only one in the queue (lock value == tail)
> 	 * and nobody is pending, clear the tail code and grab the lock.
> 	 * Otherwise, we only need to grab the lock.
> 	 */
> 	/*
> 	 * In the PV case we might already have _Q_LOCKED_VAL set, because
> 	 * of lock stealing; therefore we must also allow:
> 	 *
> 	 * n,0,1 -> 0,0,1
> 	 *
> 	 * Note: at this point: (val & _Q_PENDING_MASK) == 0, because of the
> 	 *       above wait condition, therefore any concurrent setting of
> 	 *       PENDING will make the uncontended transition fail.
> 	 */
> 	if ((val & _Q_TAIL_MASK) == tail) {
> 		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
> 			goto release; /* No contention */
> 	}
>
>
> Here queue head acquires the lock and we take the "uncontended" path. If
> we set PENDING prior to this, the cmpxchg above will fail, and the later
> load will observe the tail.

Thanks for the clarification. I was wondering if you are talking about a
latent bug in the code. So this is not the case here.

Cheers,
Longman
