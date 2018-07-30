Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31541C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7086720892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EuYaYTJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7086720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbeG3VKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:10:51 -0400
Received: from mail.efficios.com ([167.114.142.138]:59490 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbeG3VKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:10:50 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CF2132333D1;
        Mon, 30 Jul 2018 15:34:19 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id OxwMgVWFqh6U; Mon, 30 Jul 2018 15:34:19 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 211A02333CE;
        Mon, 30 Jul 2018 15:34:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 211A02333CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1532979259;
        bh=GcakN0uZnNXruo+2bLESEXU5oj7fxrWXu1ftKzUbhI4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EuYaYTJ3p4uI1zCSutKjMDb76GmPLcWFEjArxiEYkR90j8FogrZC1cXPocTl5z5DQ
         3XlU4NglJsULFMIsPheMbWqomXt5xIE6GgjuQeJWsn9WiN1i07WeEg+RpUcFbivM/2
         +vIcyRyaFK3z+Txp3RQvrr93Mwu+xgfZhvF1vqCYO2fvt3Oggw3IZv+Jf62Uhd9WYC
         xoX1w2qI2B+xKzH9Vv8swq8rVW+Atrm6q2TIb3qBJUkVT1v/rhMCFncIsY/1ArqB+q
         MLnV0ymKiQRBQkFSWvS3qtS0z2bv26ippY7775xmRNDQOHB4LSu7bud+Ijr6WJQ5bB
         FLQJti8vKrvxA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id FsiX0cjfLLgF; Mon, 30 Jul 2018 15:34:19 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 03F652333BC;
        Mon, 30 Jul 2018 15:34:19 -0400 (EDT)
Date:   Mon, 30 Jul 2018 15:34:18 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Message-ID: <1259134501.7268.1532979258894.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180730190715.GA29926@amd>
References: <20180602124408.8430-1-mathieu.desnoyers@efficios.com> <20180727220115.GA18879@amd> <1210024721.6363.1532785744879.JavaMail.zimbra@efficios.com> <20180728141314.GA25264@amd> <1005916991.7038.1532976120931.JavaMail.zimbra@efficios.com> <20180730190715.GA29926@amd>
Subject: Re: [RFC PATCH for 4.18 00/16] Restartable Sequences
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_2055 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_2055)
Thread-Topic: Restartable Sequences
Thread-Index: ZTX5gUIPaEC9HmtKDh5ztvgT4rOqQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 30, 2018, at 3:07 PM, Pavel Machek pavel@ucw.cz wrote:

> Hi!
> 
>> > Thanks for pointer.
>> > 
>> > +Restartable sequences are atomic with respect to preemption (making
>> > it
>> > +atomic with respect to other threads running on the same CPU), as
>> > well
>> > +as signal delivery (user-space execution contexts nested over the
>> > same
>> > +thread).
>> > 
>> > So the threads are protected against sigkill when running the
>> > restartable sequence?
>> 
>> In that scenario, SIGKILL _will_ be delivered, hence execution of the
>> rseq critical section will never reach the commit instruction. This
>> follows the guarantee provided that the rseq c.s. either executes
>> completely "atomically" wrt preemption/signal delivery, *or* gets
>> aborted. In this case, sigkill will reap the entire process, so
> 
> The text above does not mention abort -- so I was just making
> sure. Maybe mentioning it would be good idea?

How about this ?

Restartable sequences are atomic with respect to preemption (making it
atomic with respect to other threads running on the same CPU), as well
as signal delivery (user-space execution contexts nested over the same
thread). They either complete atomically with respect to preemption on
the current CPU and signal delivery, or they are aborted.

[...]

> 
>> > +Optimistic cache of the CPU number on which the current thread is
>> > +running. Its value is guaranteed to always be a possible CPU number,
>> > +even when rseq is not initialized. The value it contains should
>> > always
>> > +be confirmed by reading the cpu_id field.
>> > 
>> > I'm not sure what "optimistic cache" is...
>> 
>> Perhaps we can find a better wording.
>> 
>> It's "optimistic" in the sense that it's always guaranteed to hold a
>> valid CPU number within the range [ 0 .. nr_possible_cpus - 1 ]. It can
>> therefore be loaded by user-space and then used as an offset, without
>> having to check whether it is within valid bounds compared to the number
>> of possible CPUs in the system.
>> 
>> This works even if the kernel on which the application runs on does not
>> support rseq at all: the __rseq_abi->cpu_id_start field stays initialized at
>> 0, which is indeed a valid CPU number. It's therefore valid to use it as an
>> offset in per-cpu data structures, and only validate whether it's actually the
>> current CPU number by comparing it with the __rseq_abi->cpu_id field
>> within the rseq critical section. If rseq is not available in the kernel,
>> that cpu_id field stays initialized at -1, so the comparison always fails,
>> as intended.
>> 
>> It's then up to user-space to use a fall-back mechanism, considering that
>> rseq is not available.
>> 
>> Advice on improved wording would be welcome.
> 
> Ok, that makes sense, but I'd not understand it from the man
> page. Perhaps your text should be put there?

How about this ?

.TP
.in +4n
.I cpu_id_start
Optimistic cache of the CPU number on which the current thread is
running. Its value is guaranteed to always be a possible CPU number,
even when rseq is not initialized. The value it contains should always
be confirmed by reading the cpu_id field.

This field is an optimistic cache in the sense that it is always
guaranteed to hold a valid CPU number in the range [ 0 ..
nr_possible_cpus - 1 ]. It can therefore be loaded by user-space and
used as an offset in per-cpu data structures without having to
check whether its value is within the valid bounds compared to the
number of possible CPUs in the system.

For user-space applications executed on a kernel without rseq support,
the cpu_id_start field stays initialized at 0, which is indeed a valid
CPU number. It is therefore valid to use it as an offset in per-cpu data
structures, and only validate whether it's actually the current CPU
number by comparing it with the cpu_id field within the rseq critical
section. If the kernel does not provide rseq support, that cpu_id field
stays initialized at -1, so the comparison always fails, as intended.

It is then up to user-space to use a fall-back mechanism, considering
that rseq is not available.

[...]

> 
>> > (Will not
>> > this need to be bigger on machines with bigger cache sizes?)
>> > 
>> > above it says:
>> > 
>> > +.B Structure size
>> > +This structure is extensible. Its size is passed as parameter to the
>> > +rseq system call.
>> > 
>> > I'm reading source, so maybe it refers to different structure.
>> 
>> It can be aligned on a larger multiple. This requirement of 32 bytes
>> is a minimum. Therefore, if we ever extend struct rseq, or if an
>> architecture shows benefit from aligning struct rseq on larger boundaries,
>> it is free to do so. It will still respect the requirement of alignment on
>> 32 bytes boundaries.
> 
> Well, elsewhere it said "This structure has a fixed size of 32 bytes."
> Now it says structure size is passed with every syscalls. Now I'm
> confused (but maybe that's caused by reading source, not formatted
> document).

This is the layout for struct rseq_cs version 0.

The variable-sized structure is struct rseq.

struct rseq is typically in a TLS, and contains a "rseq_cs" field
which is a pointer to the struct rseq_cs descriptor describing the
currently active rseq critical section.

Hoping this clears up the confusion.

Thanks for the review!

Mathieu


> 
> Best regards,
>									Pavel
> 
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
