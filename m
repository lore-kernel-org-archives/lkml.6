Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122B8C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73A9208B1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kc5W/hj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73A9208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934372AbeGCRtu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:49:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47164 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934187AbeGCRts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xnUtUyUdlgEeaCkjd4iQHwYvQFix1UZqe+IlFrzhsz8=; b=Kc5W/hj+vQZfKPX/Y1ewqZWV0
        vEUQkrXN1o6d/4kUOzBMWVS8ZKd8hB7IMc3wV7f0Tnrdewufn0ukUmt4UKuyHts0Q1LePnIjFLvWJ
        lrRvNj/jM7hVby3BGPSQMlZGMogb2USzgCGV2f7OCMqNy8KAthKKonrI5XyJtUE/w4EnR6QvBUors
        HKTiKQtYZCl8GJgvQ6C2BH1AQPfb5SdYR7CR0hkfnrtt9u4ZR91uMHkFwktWln3+nErWMZjRu1myA
        rB2gnUPvZcEXDhMpTUc3mEUIXrOrn4z3XqcSiI+iSck+QmNdUT3gETwUNBRhLhberaMSkgQ0M8O2Z
        ygXa6rs+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faPPn-0004Bb-1L; Tue, 03 Jul 2018 17:48:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5C352029764D; Tue,  3 Jul 2018 19:48:33 +0200 (CEST)
Date:   Tue, 3 Jul 2018 19:48:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
Message-ID: <20180703174833.GZ2494@hirez.programming.kicks-ass.net>
References: <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <20180703082955.GH3704@osiris>
 <20180703084312.GU2494@hirez.programming.kicks-ass.net>
 <20180703085546.GJ3704@osiris>
 <20180703092113.GV2494@hirez.programming.kicks-ass.net>
 <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org>
 <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com>
 <20180703173451.GX2494@hirez.programming.kicks-ass.net>
 <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <399697782.11820.1530639539750.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:38:59PM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 3, 2018, at 1:34 PM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Tue, Jul 03, 2018 at 10:10:37AM -0700, Linus Torvalds wrote:
> >> On Tue, Jul 3, 2018 at 9:40 AM Andi Kleen <andi@firstfloor.org> wrote:
> >> >
> >> > So it sounds like architectures that don't have an instruction atomic u64
> >> > *_user need to disable interrupts during the access, and somehow handle that
> >> > case when a page fault happens?
> >> 
> >> No. It's actually the store by *user* space that is the critical one.
> >> Not the whole 64-bit value, just the low pointer part.
> >> 
> >> The kernel could do it as a byte-by-byte load, really. It's
> >> per-thread, and once the kernel is running, it's not going to change.
> >> The kernel never changes the value, it just loads it from user space.
> > 
> > The kernel doesn't change _this_ value, but the kernel does change other
> > values, like for instance rseq->cpu_id. But even there, it could use
> > byte stores and it is again the userspace load of that field that is
> > critical again and needs to be a single op.
> 
> I can simply document that loads/stores from/to all struct rseq fields
> should be thread-local then ?

I'm not sure that covers things sufficiently. You really want the
userspace load/stores to be single instructions.

Also, I think it was rseq_update_cpu_id() where we wanted to use a
single u64 store if possible but you worried about the stores.
