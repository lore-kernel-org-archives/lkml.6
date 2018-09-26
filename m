Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F3DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8781221530
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8781221530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeIZWoU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:44:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49464 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbeIZWoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:44:20 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72AB5CD4D1;
        Wed, 26 Sep 2018 16:30:36 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0DB860C60;
        Wed, 26 Sep 2018 16:30:35 +0000 (UTC)
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
To:     Peter Zijlstra <peterz@infradead.org>, will.deacon@arm.com,
        mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com,
        tglx@linutronix.de
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <396f7363-0f28-0fdb-7a48-ae16b0c8e82f@redhat.com>
Date:   Wed, 26 Sep 2018 12:30:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180926111307.513429499@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 26 Sep 2018 16:30:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 07:01 AM, Peter Zijlstra wrote:
> On x86 we cannot do fetch_or with a single instruction and end up
> using a cmpxchg loop, this reduces determinism. Replace the fetch_or
> with a very tricky composite xchg8 + load.
>
> The basic idea is that we use xchg8 to test-and-set the pending bit
> (when it is a byte) and then a load to fetch the whole word. Using
> two instructions of course opens a window we previously did not have.
> In particular the ordering between pending and tail is of interrest,
> because that is where the split happens.
>
> The claim is that if we order them, it all works out just fine. There
> are two specific cases where the pending,tail state changes:
>
>  - when the 3rd lock(er) comes in and finds pending set, it'll queue
>    and set tail; since we set tail while pending is set, the ordering
>    is split is not important (and not fundamentally different form
>    fetch_or). [*]

The split can cause some changes in behavior. The 3rd locker observes
the pending bit and set tail. The split load of the 2nd locker may make
it observe the tail and backout of the pending loop. As a result, the
2nd locker will acquire the lock after the third locker in this case.
That won't happen with the original code.

I am not saying this is a problem. It is just something we should take
note on.

Cheers,
Longman

