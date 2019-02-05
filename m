Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF37DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF017207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfBENsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:48:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfBENsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:48:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77E2F8830E;
        Tue,  5 Feb 2019 13:48:30 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-91.bos.redhat.com [10.18.17.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 578B571D4F;
        Tue,  5 Feb 2019 13:48:28 +0000 (UTC)
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
To:     Peter Zijlstra <peterz@infradead.org>,
        Alex Kogan <alex.kogan@oracle.com>
Cc:     linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com,
        arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        dave.dice@oracle.com, rahul.x.yadav@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
 <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
 <20190205092256.GN17528@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <16095d28-d3e9-7394-d3c6-1bd24381173d@redhat.com>
Date:   Tue, 5 Feb 2019 08:48:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190205092256.GN17528@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 05 Feb 2019 13:48:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2019 04:22 AM, Peter Zijlstra wrote:
> On Mon, Feb 04, 2019 at 10:35:09PM -0500, Alex Kogan wrote:
>>> On Jan 31, 2019, at 5:00 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
>>>> Choose the next lock holder among spinning threads running on the same
>>>> socket with high probability rather than always. With small probability,
>>>> hand the lock to the first thread in the secondary queue or, if that
>>>> queue is empty, to the immediate successor of the current lock holder
>>>> in the main queue.  Thus, assuming no failures while threads hold the
>>>> lock, every thread would be able to acquire the lock after a bounded
>>>> number of lock transitions, with high probability.
>>>>
>>>> Note that we could make the inter-socket transition deterministic,
>>>> by sticking a counter of intra-socket transitions in the head node
>>>> of the secondary queue. At the handoff time, we could increment
>>>> the counter and check if it is below a threshold. This adds another
>>>> field to queue nodes and nearly-certain local cache miss to read and
>>>> update this counter during the handoff. While still beating stock,
>>>> this variant adds certain overhead over the probabilistic variant.
>>> (also heavily suffers from the socket == node confusion)
>>>
>>> How would you suggest RT 'tunes' this?
>>>
>>> RT relies on FIFO fairness of the basic spinlock primitives; you just
>>> completely wrecked that.
>> This is true that CNA trades some fairness for shorter lock handover
>> latency, much like any other NUMA-aware lock.
>>
>> Can you explain, however, what exactly breaks here?
> Timeliness guarantees. FIFO-fair has well defined time behaviour; you
> know exactly how long you get to wait before you acquire the lock,
> namely however many waiters are in front of you multiplied by the worst
> case wait time.
>
> Doing time analysis on a randomized algorithm isn't my idea of fun.

RT doesn't work well with NUMA qspinlock is another reason why I want it
to be a separate slow path. We will disable it  on a RT kernel where
guaranteed low latency is a must and throughput isn't as important.

Cheers,
Longman
