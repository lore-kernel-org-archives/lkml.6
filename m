Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7DFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B0D22565
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Omo621aI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B0D22565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934378AbeGCR0o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:26:44 -0400
Received: from mail.efficios.com ([167.114.142.138]:56414 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934074AbeGCR0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:26:41 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 68007230195;
        Tue,  3 Jul 2018 13:26:40 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id eSPUoTI7tUqO; Tue,  3 Jul 2018 13:26:39 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C1774230192;
        Tue,  3 Jul 2018 13:26:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C1774230192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530638799;
        bh=zgZSJZBAZSDaPGbe9Vl06QB2i7y5d9PRZOyzqbTqMQQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Omo621aIh+jWjrkRsdHweQXhQQC4gUpqadLICJqNok54yyVtzAEGmdUNTgYtfVZTh
         mTwRkyX1+xJYtBOMUt2XCfpYZqZCLkaT6PTjlcInQ4x+KL0hamG0FwO+dw8LuJO+kP
         Pv9tLyfhOgy/Gd+8vtJD/ihviQFnyPcIDnz7orLx6jWMZQvnh8kXc84rlXDNVu8HdT
         1c0klrWCeDonp7sBIfv2KWnrBezU3onGqyM7w9LFGM5jDXX/vPS+dj3PSzLuvSMbfu
         Bk6fwfhBD3nxg7oqcSwr+hSKAGU5/njUkFqyrBuUWh+rK9Y4r3/0URfVek2ZXGf/yw
         FAVESUnXmBnXg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id eBh6q0wSKmR9; Tue,  3 Jul 2018 13:26:39 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id A600023018B;
        Tue,  3 Jul 2018 13:26:39 -0400 (EDT)
Date:   Tue, 3 Jul 2018 13:26:39 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>,
        heiko carstens <heiko.carstens@de.ibm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>, rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        schwidefsky <schwidefsky@de.ibm.com>, gor@linux.ibm.com
Message-ID: <1047204530.11737.1530638799580.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com>
References: <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net> <20180703081449.GT2494@hirez.programming.kicks-ass.net> <20180703082955.GH3704@osiris> <20180703084312.GU2494@hirez.programming.kicks-ass.net> <20180703085546.GJ3704@osiris> <20180703092113.GV2494@hirez.programming.kicks-ass.net> <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org> <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: j66OqF9zbUhN0xBsQ1otYplWTFq6fg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 3, 2018, at 1:10 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Tue, Jul 3, 2018 at 9:40 AM Andi Kleen <andi@firstfloor.org> wrote:
>>
>> So it sounds like architectures that don't have an instruction atomic u64
>> *_user need to disable interrupts during the access, and somehow handle that
>> case when a page fault happens?
> 
> No. It's actually the store by *user* space that is the critical one.
> Not the whole 64-bit value, just the low pointer part.
> 
> The kernel could do it as a byte-by-byte load, really. It's
> per-thread, and once the kernel is running, it's not going to change.
> The kernel never changes the value, it just loads it from user space.
> 
> So all the atomicity worries for the kernel are a red herring. They'd
> arguably be nice to have - but only for an insane case that makes
> absolutely no sense (a different thread trying to change the value).
> 
> Can we please stop the idiocy already? The kernel could read the rseq
> pointer one bit at a time, and do a little dance with "yield()" in
> between, and take interrupts and page faults, and it wouldn't matter
> AT ALL.
> 
> It's not even that we read the value from an interrupt context, it's
> that as we return to user space (which can be the result of an
> interrupt) we can read the value.
> 
> This whole thread has been filled with crazy "what if" things that don't matter.

Sorry to come back in the thread late, looks like I've missed all the
fun.

I agree with Linus: we can simply document that updates to rseq->rseq_cs
should be thread-local in the rseq uapi and be done with it. This would
allow using get_user(u64) even on 32-bit architectures, because we cannot
care less if an architecture chooses to read the u64 byte-wise while
standing on its feet.

With this added requirement, Andy's idea of using a union between __u64
and upper/lower __u32 would fit very nicely.

If everyone is OK with that approach, I can prepare an updated patch.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
