Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18630C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C839D20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C839D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406089AbeKWDkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:40:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388150AbeKWDkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:40:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0455361D07;
        Thu, 22 Nov 2018 16:59:58 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-170.ams2.redhat.com [10.36.116.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 172D4103BAB8;
        Thu, 22 Nov 2018 16:59:51 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Rich Felker <dalias@libc.org>, carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v4 1/5] glibc: Perform rseq(2) registration at nptl init and thread creation
References: <20181121183936.8176-1-mathieu.desnoyers@efficios.com>
        <20181122143603.GD23599@brightrain.aerifal.cx>
        <782067422.9852.1542899056778.JavaMail.zimbra@efficios.com>
        <20181122151444.GE23599@brightrain.aerifal.cx>
        <686626451.10113.1542901620250.JavaMail.zimbra@efficios.com>
        <87wop5xeit.fsf@oldenburg.str.redhat.com>
        <1045257294.10291.1542905262086.JavaMail.zimbra@efficios.com>
Date:   Thu, 22 Nov 2018 17:59:44 +0100
In-Reply-To: <1045257294.10291.1542905262086.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 22 Nov 2018 11:47:42 -0500
        (EST)")
Message-ID: <87k1l5xd33.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 22 Nov 2018 16:59:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Nov 22, 2018, at 11:28 AM, Florian Weimer fweimer@redhat.com wrote:
>
>> * Mathieu Desnoyers:
>> 
>>> Here is one scenario: we have 2 early adopter libraries using rseq which
>>> are deployed in an environment with an older glibc (which does not
>>> support rseq).
>>>
>>> Of course, none of those libraries can be dlclose'd unless they somehow
>>> track all registered threads.
>> 
>> Well, you can always make them NODELETE so that dlclose is not an issue.
>> If the library is small enough, that shouldn't be a problem.
>
> That's indeed what I do with lttng-ust, mainly due to use of pthread_key.
>
>> 
>>> But let's focus on how exactly those libraries can handle lazily
>>> registering rseq. They can use pthread_key, and pthread_setspecific on
>>> first use by the thread to setup a destructor function to be invoked
>>> at thread exit. But each early adopter library is unaware of the
>>> other, so if we just use a "is_initialized" flag, the first destructor
>>> to run will unregister rseq while the second library may still be
>>> using it.
>> 
>> I don't think you need unregistering if the memory is initial-exec TLS
>> memory.  Initial-exec TLS memory is tied directly to the TCB and cannot
>> be freed while the thread is running, so it should be safe to put the
>> rseq area there even if glibc knows nothing about it.
>
> Is it true for user-supplied stacks as well ?

I'm not entirely sure because the glibc terminology is confusing, but I
think it places intial-exec TLS into the static TLS area (so that it has
a fixed offset from the TCB).  The static TLS area is placed on the
user-supplied stack.

>> Then you'll only need a mechanism to find the address of the actually
>> active rseq area (which you probably have to store in a TLS variable
>> for performance reasons).  And that part you need whether you have
>> reference counter or not.
>
> I'm not sure I follow your thoughts here. Currently, the __rseq_abi
> TLS symbol identifies a structure registered to the kernel. The
> "currently active" rseq critical section is identified by the field
> "rseq_cs" within the __rseq_abi structure.
>
> So here when you say "actually active rseq area", do you mean the
> currently registered struct rseq (__rseq_abi) or the currently running
> rseq critical section ? (pointed to by __rseq_abi.rseq_cs)

__rseq_abi.

> One issue here is that early adopter libraries cannot always use
> the IE model. I tried using it for other TLS variables in lttng-ust, and
> it ended up hanging our CI tests when tracing a sample application with
> lttng-ust under a Java virtual machine: being dlopen'd in a process that
> possibly already exhausts the number of available backup TLS IE entries
> seems to have odd effects. This is why I'm worried about using the IE model
> within lttng-ust.

You can work around this by preloading the library.  I'm not sure if
this is a compelling reason not to use initial-exec TLS memory.

>>> The same problem arises if we have an application early adopter which
>>> explicitly deal with rseq, with a library early adopter. The issue is
>>> similar, except that the application will explicitly want to unregister
>>> rseq before exiting the thread, which leaves a race window where rseq
>>> is unregistered, but the library may still need to use it.
>>>
>>> The reference counter solves this: only the last rseq user for a thread
>>> performs unregistration.
>> 
>> If you do explicit unregistration, you will run into issues related to
>> destructor ordering.  You should really find a way to avoid that.
>
> The per-thread reference counter is a way to avoid issues that arise from
> lack of destructor ordering. Is it an acceptable approach for you, or
> you have something else in mind ?

Only for the involved libraries.  It will not help if other TLS
destructors run and use these libraries.

Thanks,
Florian
