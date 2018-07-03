Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7ECC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8190C24687
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qc4vZ4bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8190C24687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934475AbeGCSJ6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:09:58 -0400
Received: from mail.efficios.com ([167.114.142.138]:59268 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934195AbeGCSJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:09:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 35167230DF4;
        Tue,  3 Jul 2018 14:09:54 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id oOsCWIUQumch; Tue,  3 Jul 2018 14:09:53 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A8E4F230DF1;
        Tue,  3 Jul 2018 14:09:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A8E4F230DF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530641393;
        bh=cBwk4tCijKrRObOxksUemWJZTxrqL+QYG7QAcwDXcE0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qc4vZ4biiga7qoZPDx35jUvrWDpvmx7a6tK46ENaXH7NMQdRJglCfmL9cWR7/tlI+
         VgdTj4/WkSV1tuxp56jLXvpXHzig8AB5I+6KtetlU9l2xZ7b6pg4ZjFATb+Pzu81gp
         dtQbi+tiJVyv9amcEPu8Zpcovm8Uzyjt66TeGCcUCW4KIkmWHVojWfQZst/I5OEo9c
         cHaqQ6xCRohemuKZjNcVyptvywWf1OwOfUuxuwzAbGJCINmAFn469K8pAkRjwz0SH0
         N+lUyWCkOwpmUp2HFCOsSXtqdPghuoZXV1EPDHQ+8cMi0RNB9MX99V/Ic9pumi1Fto
         Bzl3s2PgsuCWw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 5B_pyIxbpYNs; Tue,  3 Jul 2018 14:09:53 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 89D59230DEA;
        Tue,  3 Jul 2018 14:09:53 -0400 (EDT)
Date:   Tue, 3 Jul 2018 14:09:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <775833760.11858.1530641393364.JavaMail.zimbra@efficios.com>
In-Reply-To: <CA+55aFxcVbG2DMmmrW-HLTXZE+rcBWc5F48UYoL2heEsEpyO=g@mail.gmail.com>
References: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com> <20180703092113.GV2494@hirez.programming.kicks-ass.net> <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org> <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com> <20180703173451.GX2494@hirez.programming.kicks-ass.net> <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com> <20180703174833.GZ2494@hirez.programming.kicks-ass.net> <CA+55aFxcVbG2DMmmrW-HLTXZE+rcBWc5F48UYoL2heEsEpyO=g@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: 7hOXAcBrxoW70h0Gw8fXbspmhbEFQg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 3, 2018, at 1:59 PM, Linus Torvalds torvalds@linux-foundation.org wrote:

> On Tue, Jul 3, 2018 at 10:49 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> > I can simply document that loads/stores from/to all struct rseq fields
>> > should be thread-local then ?
>>
>> I'm not sure that covers things sufficiently. You really want the
>> userspace load/stores to be single instructions.
> 
> Actually, I think we should try very hard to limit even that to _just_
> the rseq pointer itself.
> 
> Everything else can be filled in ahead of time with non-atomic stores,
> and then the last thing that happens - and the only thing that wants
> that final "one last atomic write" is the rseq pointer write.
> 
> No?

Well a small nit here: the rseq->rseq_cs pointer store is performed
at the _very beginning_ of the rseq critical section. We indeed want
that store to be performed as a single instruction by user-space.

What I think you have in mind as "one last atomic write" is the commit
instruction at the end of the critical section, which does not touch
any field in struct rseq.

> 
> So I'd suggest that the only part we aim to have any "atomic" behavior
> at all is for the individual fields in "struct rseq" itself. So the
> cpu id and the base pointer and the flags. And even they are
> thread-local, so the atomicity is not about the kernel, but about user
> space needing to read and update them in word-sized chunks.
> 
> End result: absolutely nothing is atomic for the kernel.

Yes, +1. If everyone is OK with that I'll go and implement the changes
within the coming day.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
