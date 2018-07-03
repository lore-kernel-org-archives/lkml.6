Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFF3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280242083C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="We5U+lEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280242083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934322AbeGCRjC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:39:02 -0400
Received: from mail.efficios.com ([167.114.142.138]:57094 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933063AbeGCRjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:39:01 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9AF032305A4;
        Tue,  3 Jul 2018 13:39:00 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id NP_DPV-yewK8; Tue,  3 Jul 2018 13:39:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E629A2305A0;
        Tue,  3 Jul 2018 13:38:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E629A2305A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1530639539;
        bh=Z+6XUbJW3XsQ3K4R6g/oDi3s1GKmuJoAdXwHAySA55w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=We5U+lEcmE8SlTieV6/xEBtM8Q+o5KNbG5Zk8RLA/hgDYn/9wVNzYnJ1J10Ha7lMq
         yhJ2la1s5LJqlEbix3yUdj9mSGqwYVVCUAt0blpZDIdAsIv/9WewbJicD8qsLeV88O
         4DqHgjFomWPVKCqAkvD+d8PDCAaCvvHU/rTbxdbOcT0QDf8AfFhRJynoOVxqfJCNSE
         J6wFUpzCX6601Brb8guXUbXcGX5oWzEijpVpwCsDiLbKowDIKhfjcKfbjB5+UueB8O
         yUHLXo0SnJTWyUm7TbgwnrUmnuTUzo8gSBVhiEinCoqQYr8sEyz+8SqiyNaurJOQf0
         8BdkY4B+5DKDA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Z65sK-yiY4Q4; Tue,  3 Jul 2018 13:38:59 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C398C23059A;
        Tue,  3 Jul 2018 13:38:59 -0400 (EDT)
Date:   Tue, 3 Jul 2018 13:38:59 -0400 (EDT)
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
Message-ID: <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180703173451.GX2494@hirez.programming.kicks-ass.net>
References: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com> <20180703082955.GH3704@osiris> <20180703084312.GU2494@hirez.programming.kicks-ass.net> <20180703085546.GJ3704@osiris> <20180703092113.GV2494@hirez.programming.kicks-ass.net> <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org> <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com> <20180703173451.GX2494@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq: use __u64 for rseq_cs fields, validate user inputs
Thread-Index: jY49ZLr6KS8Cu4ynVzBYdM/e7Jj2VA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 3, 2018, at 1:34 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Jul 03, 2018 at 10:10:37AM -0700, Linus Torvalds wrote:
>> On Tue, Jul 3, 2018 at 9:40 AM Andi Kleen <andi@firstfloor.org> wrote:
>> >
>> > So it sounds like architectures that don't have an instruction atomic u64
>> > *_user need to disable interrupts during the access, and somehow handle that
>> > case when a page fault happens?
>> 
>> No. It's actually the store by *user* space that is the critical one.
>> Not the whole 64-bit value, just the low pointer part.
>> 
>> The kernel could do it as a byte-by-byte load, really. It's
>> per-thread, and once the kernel is running, it's not going to change.
>> The kernel never changes the value, it just loads it from user space.
> 
> The kernel doesn't change _this_ value, but the kernel does change other
> values, like for instance rseq->cpu_id. But even there, it could use
> byte stores and it is again the userspace load of that field that is
> critical again and needs to be a single op.

I can simply document that loads/stores from/to all struct rseq fields
should be thread-local then ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
