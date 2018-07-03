Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75FCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9167021A14
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LwCtF40f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9167021A14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933626AbeGCJWm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:22:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35426 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932388AbeGCJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FZMlQBMhh07DmOBi2DGoVVI03OLIvxkX/Fpl6PeiGfg=; b=LwCtF40fucB4YUNqiOmCD+V35
        WOR3wc1m3RC4x7Kc+q7tjATzgAUZ1tQstTzAnGd0n615wRL7uTVHKLq++F/iSBiNPoWQqj4QgscKY
        Fd13LqUQPAD/pG9yTSTgdrY/dRUqmI6K2hngGXwKhHn06rS4ONoBAkODnNcezTvMowaj14LLfVpAg
        kVdvbmVi2bSZYcf+WbV+KkJA1D3VBoamwVpLEJQ3UZluvasbNEcOk49AOcT18RlxVJeLgHK+FFUoW
        Hy/3tlc87BPO6EaTNLlu5SAPkfx6A64TKnuSjs5lEmli1JJdVv1wUiW+7ZzHgKXq3KXSTOICnh4I8
        jO2xPxuHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faHUq-0005UI-IE; Tue, 03 Jul 2018 09:21:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3CDF2029F1DB; Tue,  3 Jul 2018 11:21:13 +0200 (CEST)
Date:   Tue, 3 Jul 2018 11:21:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, michal.simek@xilinx.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields,
 validate user inputs
Message-ID: <20180703092113.GV2494@hirez.programming.kicks-ass.net>
References: <1959930320.10843.1530573742647.JavaMail.zimbra@efficios.com>
 <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net>
 <459661281.10865.1530580742205.JavaMail.zimbra@efficios.com>
 <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <CA+55aFxWMjwx-4TGBHt0H6bh6FXC3NKMsjp=eKGw5cgA4wMBUA@mail.gmail.com>
 <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com>
 <20180703081449.GT2494@hirez.programming.kicks-ass.net>
 <20180703082955.GH3704@osiris>
 <20180703084312.GU2494@hirez.programming.kicks-ass.net>
 <20180703085546.GJ3704@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703085546.GJ3704@osiris>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:55:46AM +0200, Heiko Carstens wrote:
> > 
> > The problem is interrupts; we need interrupts on the CPU doing the store
> > to observe either the old or the new value, not a mix.
> > 
> > If mvcos does not guarantee that, we're having problems. Is there a
> > reason get_user() cannot use a 'regular' load?
> 
> Well, that's single instruction semantics. This is something we actually
> can guarantee, since the mvcos instruction itself won't be interrupted and
> copies all 1/2/4/8 bytes in a row.
> 
> So we are talking about that single instructions are required and not
> atomic accesses?

rseq is strictly task local. So from that pov single-copy atomic and
single instruction semantics end up being very similar.

The most complicated scenario would be where we interrupt the task,
schedule it out, migrate it and resume execution on another CPU. In that
case the second CPU also needs to observe a 'whole' value.

But note that in that example there's a fair bit of ordering provided by
the scheduler to ensure all the state from the old CPU is observed by
the new CPU (on s390 just the rq->lock fiddling would imply a bunch of
general memory barriers).

So I think you're good... But yes, you raise an interresting point.
