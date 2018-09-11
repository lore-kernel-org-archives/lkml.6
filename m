Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDB8C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E7D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 12:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E7D2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIKRzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 13:55:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbeIKRzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 13:55:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3A3D87A78;
        Tue, 11 Sep 2018 12:56:41 +0000 (UTC)
Received: from llong.remote.csb (ovpn-123-172.rdu2.redhat.com [10.10.123.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 191722027EA4;
        Tue, 11 Sep 2018 12:56:41 +0000 (UTC)
Subject: Re: [PATCH] locking/rwsem: Make owner store task pointer of last
 owning reader
To:     Peter Zijlstra <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
References: <1536265114-10842-1-git-send-email-longman@redhat.com>
 <20180910093156.GS24082@hirez.programming.kicks-ass.net>
 <83b333ea-8ef2-84ea-6810-4ab1a67eef88@redhat.com>
 <20180910171550.GA3902@linux-r8p5>
 <20180911081755.GO24106@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <9730a289-dac8-a255-4306-43a676059d73@redhat.com>
Date:   Tue, 11 Sep 2018 08:56:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180911081755.GO24106@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 11 Sep 2018 12:56:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 11 Sep 2018 12:56:41 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 04:17 AM, Peter Zijlstra wrote:
> On Mon, Sep 10, 2018 at 10:15:50AM -0700, Davidlohr Bueso wrote:
>> On Mon, 10 Sep 2018, Waiman Long wrote:
>>
>>> One major issue with a combined count/owner is that we may have to use
>>> cmpxchg for reader lock which will certainly impact reader-heavy
>>> workloads. I have also thought about ways to compress the task pointer
>>> address so that it can use fewer bits and leave the rests for reader
>>> count. It is probably doable on 64-bit systems, but likely not on 32-bit
>>> system given that there are less bits to play around.
>> Yeah we've discussed this before. As a cleanup it would obviously be good,
>> but I fear about raw performance loss when using cmpxchg instead of xadd.
> Does it really matter though? Last time I looked at something similar
> (refcount_t) the "LOCK INCL" vs "LOCK CMPXCHG" was something like 15 vs
> 23 cycles (and that was with the cmpxchg loop actually doing a lot
> more).
>
> Do we really care about the down_read() path _that_ much? I thought that
> with the main pain point, pagefaults, the problem was mostly the line
> bouncing, not a few extra cycles.

It is not simply that cmpxchg needs more cycles to run, it is the fact
that a few retries may be necessary to actually increment the count in
case of contention leading to more RMW cycles than with xadd. I am not
saying that we can't do that, but there is a price we need to pay.

Cheers,
Longman


