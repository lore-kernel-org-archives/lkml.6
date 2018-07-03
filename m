Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFDFC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACB620837
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e4Pokch6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACB620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934015AbeGCRDK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:03:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932440AbeGCRDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WEOT40Y3+KHK/X862bVgkMG8/dkmFvOWi5Deulb3sL8=; b=e4Pokch6cr+aYAWgJODB8mg/u
        lBqHneE/zH5irG1jAjh07E2T+YiAPUB0HUyrWShstb2/H6nvXVt4K535DZLrE1ktZDo6ROH/N6uOu
        8hfZTot2hpFwpjGEuJlr5ZBceJGELqWg7hImDYWKt5qqptvWOKGjlgdJJ61J8oDHiAPcunhpgdDGw
        Sr0qkwS9woUjjRO2gEoN3fCNJ/wOGOR8T8/9CY7UYsEs1hjQj6O0lhRsrb6StRqBONtTwP5+Em0Yq
        AT3RXkkR+aX9XelAoVeQbCLd4QFu29L3usMHKpfkK9pmcmJDf2FQkxc/W2uQSHKQGcaLAJqo/JzD+
        QHTvywYog==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faOhE-0001Xz-Mf; Tue, 03 Jul 2018 17:02:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0E222029764D; Tue,  3 Jul 2018 19:02:30 +0200 (CEST)
Date:   Tue, 3 Jul 2018 19:02:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Joel Fernandes <joelaf@google.com>, michal.simek@xilinx.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
Message-ID: <20180703170230.GI2458@hirez.programming.kicks-ass.net>
References: <459661281.10865.1530580742205.JavaMail.zimbra@efficios.com>
 <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <CA+55aFxWMjwx-4TGBHt0H6bh6FXC3NKMsjp=eKGw5cgA4wMBUA@mail.gmail.com>
 <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com>
 <20180703081449.GT2494@hirez.programming.kicks-ass.net>
 <20180703082955.GH3704@osiris>
 <20180703084312.GU2494@hirez.programming.kicks-ass.net>
 <20180703085546.GJ3704@osiris>
 <20180703092113.GV2494@hirez.programming.kicks-ass.net>
 <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 09:40:48AM -0700, Andi Kleen wrote:
> > 
> > So I think you're good... But yes, you raise an interresting point.
> 
> So it sounds like architectures that don't have an instruction atomic u64
> *_user need to disable interrupts during the access, and somehow handle that
> case when a page fault happens?

So for 32bit, as Linus already said, a split store is _fine_, because
the top word is always going to be 0 anyway.

So all we really need is native word sized loads / stores. s390 is just
a little weird here (it wouldn't be s390 if it wasn't I suppose) for not
actually using regular loads / stores because of the split address space
stuff.

