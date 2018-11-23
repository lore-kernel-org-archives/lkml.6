Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA5BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E114220685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E114220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439727AbeKWXyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:54:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394696AbeKWXyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:54:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BDC3F6EB85;
        Fri, 23 Nov 2018 13:10:28 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-155.ams2.redhat.com [10.36.117.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4DCC19741;
        Fri, 23 Nov 2018 13:10:22 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Rich Felker <dalias@libc.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        carlos <carlos@redhat.com>,
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
        <87k1l5xd33.fsf@oldenburg.str.redhat.com>
        <20181122171010.GH23599@brightrain.aerifal.cx>
Date:   Fri, 23 Nov 2018 14:10:14 +0100
In-Reply-To: <20181122171010.GH23599@brightrain.aerifal.cx> (Rich Felker's
        message of "Thu, 22 Nov 2018 12:10:10 -0500")
Message-ID: <871s7cvt1l.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 23 Nov 2018 13:10:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rich Felker:

>> I'm not entirely sure because the glibc terminology is confusing, but I
>> think it places intial-exec TLS into the static TLS area (so that it has
>> a fixed offset from the TCB).  The static TLS area is placed on the
>> user-supplied stack.
>
> This is an implementation detail that should not leak to applications,
> and I believe it's still considered a bug, in that, with large static
> TLS, it could overflow or leave unusably little space left on an
> otherwise-plenty-large application-provided stack.

Sure, but that does not matter in this context because right now, there
is no fix for this bug, and when we fix it, we can take backwards
compatibility into account.

Any library that ends up using rseq will need to coordinate with the
toolchain.  I think that's unavoidable given the kernel interface.

>> > One issue here is that early adopter libraries cannot always use
>> > the IE model. I tried using it for other TLS variables in lttng-ust, and
>> > it ended up hanging our CI tests when tracing a sample application with
>> > lttng-ust under a Java virtual machine: being dlopen'd in a process that
>> > possibly already exhausts the number of available backup TLS IE entries
>> > seems to have odd effects. This is why I'm worried about using the IE model
>> > within lttng-ust.
>> 
>> You can work around this by preloading the library.  I'm not sure if
>> this is a compelling reason not to use initial-exec TLS memory.
>
> Use of IE model from a .so file (except possibly libc.so or something
> else that inherently needs to be present at program startup for other
> reasons) should be a considered a bug and unsupported usage.
> Encouraging libraries to perpetuate this behavior is going backwards
> on progress that's being made to end it.

Why?  Just because glibc's TCB allocation strategy is problematic?
We can fix that, even with dlopen.

If you are only concerned about the interactions with dlopen, then why
do you think initial-exec TLS is the problem, and not dlopen?

>> > The per-thread reference counter is a way to avoid issues that arise from
>> > lack of destructor ordering. Is it an acceptable approach for you, or
>> > you have something else in mind ?
>> 
>> Only for the involved libraries.  It will not help if other TLS
>> destructors run and use these libraries.
>
> Presumably they should have registered their need for rseq too,
> thereby incrementing the reference count. I'm not sure this is a good
> idea, but I think I understand it now.

They may have to increase the reference count from 0 to 1, though, so
they have to re-register the rseq area.  This tends to get rather messy.

I still I think implicit destruction of the rseq area is preferable over
this complexity.

Thanks,
Florian
