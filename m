Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F25C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2E524169
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Gvi5aTna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2E524169
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934389AbeGCR6l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:58:41 -0400
Received: from mail.efficios.com ([167.114.142.138]:57994 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934194AbeGCR6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:58:39 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id AE3A7230B57;
        Tue,  3 Jul 2018 13:58:38 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id mHMxNb1nyohs; Tue,  3 Jul 2018 13:58:38 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 21B28230B54;
        Tue,  3 Jul 2018 13:58:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 21B28230B54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530640718;
        bh=QcS7yCbkT8TT4SKz7LTEzJemkpNiJcXtHzR2En3GBzY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Gvi5aTna2aYoJLMgXX/WLgt9GhJA7CEePLT/Ef1vLurY0TTsO5P+JtcBbkAKzMmoi
         TVKLa4PK8ln94NeOsFu+yNEilQFeDux/9mT8iHN5qQoZK/Z3oJP00HrPpYhmpoqWD+
         M+LwoJdhdMggMcMGXee9rUKVECWHo75nq3MwsHQOKLvNvnJCXba+jUT5pGrzvm6aG7
         n68Lah6YqZd8c9A9+mP8Ym5ZzQ9+qZWskH6jDc5n1GBvO8c2E6yEaE857WWzgPInOn
         QKncDraQmqsx+Njpo3MlO+nFHM9eH+k89Ht0mV+sX51fOT8rywI9o3q9IqirDHtvKg
         B8Dt9ac79uHYg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id KhcRl4Z08dv3; Tue,  3 Jul 2018 13:58:38 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 03B2C230B4D;
        Tue,  3 Jul 2018 13:58:38 -0400 (EDT)
Date:   Tue, 3 Jul 2018 13:58:37 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
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
        schwidefsky <schwidefsky@de.ibm.com>, gor <gor@linux.ibm.com>
Message-ID: <1048940999.11846.1530640717837.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180703174833.GZ2494@hirez.programming.kicks-ass.net>
References: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com> <20180703085546.GJ3704@osiris> <20180703092113.GV2494@hirez.programming.kicks-ass.net> <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org> <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com> <20180703173451.GX2494@hirez.programming.kicks-ass.net> <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com> <20180703174833.GZ2494@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: iuuWVjAu2z6iRXS9/u0IY59Kxde0hw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 3, 2018, at 1:48 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Jul 03, 2018 at 01:38:59PM -0400, Mathieu Desnoyers wrote:
>> ----- On Jul 3, 2018, at 1:34 PM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Tue, Jul 03, 2018 at 10:10:37AM -0700, Linus Torvalds wrote:
>> >> On Tue, Jul 3, 2018 at 9:40 AM Andi Kleen <andi@firstfloor.org> wrote:
>> >> >
>> >> > So it sounds like architectures that don't have an instruction atomic u64
>> >> > *_user need to disable interrupts during the access, and somehow handle that
>> >> > case when a page fault happens?
>> >> 
>> >> No. It's actually the store by *user* space that is the critical one.
>> >> Not the whole 64-bit value, just the low pointer part.
>> >> 
>> >> The kernel could do it as a byte-by-byte load, really. It's
>> >> per-thread, and once the kernel is running, it's not going to change.
>> >> The kernel never changes the value, it just loads it from user space.
>> > 
>> > The kernel doesn't change _this_ value, but the kernel does change other
>> > values, like for instance rseq->cpu_id. But even there, it could use
>> > byte stores and it is again the userspace load of that field that is
>> > critical again and needs to be a single op.
>> 
>> I can simply document that loads/stores from/to all struct rseq fields
>> should be thread-local then ?
> 
> I'm not sure that covers things sufficiently. You really want the
> userspace load/stores to be single instructions.

Yes, of course. More specifically, I would document that those need to
be single-copy atomicity load/store performed by the local thread.

> Also, I think it was rseq_update_cpu_id() where we wanted to use a
> single u64 store if possible but you worried about the stores.

With this added bit of restriction on thread-local loads, indeed we
can then update them without caring about atomicity at kernel level.

I can modify the ABI to put the cpu_id_start and cpu_id fields inside
a union, and update it with a single store.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
