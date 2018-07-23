Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF482ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9496E20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9496E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbeGWOmS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:42:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387956AbeGWOmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:42:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4A6A40241D7;
        Mon, 23 Jul 2018 13:40:58 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DDE72166BA0;
        Mon, 23 Jul 2018 13:40:58 +0000 (UTC)
Subject: Re: [PATCH v2] locking/rwsem: Take read lock immediate if queue empty
 with no writer
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Mark Ray <mark.ray@hpe.com>,
        Joe Mario <jmario@redhat.com>,
        Scott Norton <scott.norton@hpe.com>
References: <1531506653-5244-1-git-send-email-longman@redhat.com>
 <20180718161639.GT2494@hirez.programming.kicks-ass.net>
 <d9a125b2-3421-9c11-ff30-78812e42edc5@redhat.com>
 <20180723040423.hntq6dzzzf3sagfb@linux-r8p5>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9722ffd0-9adb-9ad1-a05b-25869c0b2e60@redhat.com>
Date:   Mon, 23 Jul 2018 09:40:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180723040423.hntq6dzzzf3sagfb@linux-r8p5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 23 Jul 2018 13:40:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 23 Jul 2018 13:40:58 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 12:04 AM, Davidlohr Bueso wrote:
> On Wed, 18 Jul 2018, Waiman Long wrote:
>
>> The key here is that we don't want other incoming readers to observe
>> that there are waiters in the wait queue and hence have to go into the
>> slowpath until the single waiter in the queue is sure that it probably
>> will need to go to sleep if there is writer.
>>
>> With a constant stream of incoming readers, a major portion of them will
>> observe the a negative count and be serialized to enter the slowpath.
>> There are certainly other readers that do not observe the negative count
>> in the in between period after one reader clear the count in the unlock
>> path and a waiter set the count to negative again. Those readers can go
>> ahead and do the read in parallel. But it is the serialized readers that
>> cause the performance loss and the observation of spinlock contention in
>> the perf output.
>
> This makes sense and seems feasible in that the optimization is done with
> the wait_lock held.
>
>>
>> It is the constant stream of incoming readers that sustain the spinlock
>> queue and the repeated clearing and negative setting of the count.
>
> This would not affect optimistic spinners that haven't yet arrived at the
> waitqueue phase because the lock is anonymously owned, so they won't spin
> in the first place, right?

The reader fastpath would have incremented the active count before
entering the slowpath. The spinning writer, seeing a non-zero active
count, will not attempt to steal the lock until the reader decrement the
count and set the waiting bias in one atomic op. Nothing will happen
before that.

-Longman

