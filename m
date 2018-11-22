Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5938C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892592081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d2whUuXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892592081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436991AbeKWAWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:22:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46528 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436977AbeKWAWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1QTzSVO94g0wnOGs1CIZXYdIPuLak3HQX26kKCg76A4=; b=d2whUuXIMoLDUf39ff7wMcgUp
        zcpi789mE0MNUWbDLkFSUqplnMxoaYWaz9Q9BGHXjSsoJqicNoLgW+y92qxJWMZzwfFTPtqBJkY1a
        SMDKenxESupZorZdEb3rEjs/VbLTlHMIGSpZHq26d2A0XYRS/WjTfRPFAH7sJpZw/41ibqeXYWHzX
        nHvQXy9E9eqb1g2mI0bWdWkp5JbkdWlGyPY238HbfDFKk243wHp13ByBCqz53mUOKd1pJG8E4JNsQ
        qqJdShXqPVLGN1KU2DHurVVwsIJnvuOFX3R1536leZVEB4LYAbufcV7WrKJtbr9EIEmE+JA+qMoxO
        RR74Mw9OA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpFl-0000fw-E5; Thu, 22 Nov 2018 13:42:45 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1F662029FD58; Thu, 22 Nov 2018 14:42:38 +0100 (CET)
Date:   Thu, 22 Nov 2018 14:42:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC][PATCH 00/14] function_graph: Rewrite to allow multiple
 users
Message-ID: <20181122134238.GU2131@hirez.programming.kicks-ass.net>
References: <20181122012708.491151844@goodmis.org>
 <20181122100812.GO2131@hirez.programming.kicks-ass.net>
 <20181122074605.063a7525@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122074605.063a7525@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 07:46:05AM -0500, Steven Rostedt wrote:
> On Thu, 22 Nov 2018 11:08:12 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Nov 21, 2018 at 08:27:08PM -0500, Steven Rostedt wrote:
> > > Well the fuction graph tracer is arguably the strongest of the tracers.
> > > It shows both the entrance and exit of a function, can give the timings
> > > of a function, and shows the execution of the code quite nicely.
> > > 
> > > But it has one major flaw.
> > > 
> > > It can't let more than one user access it at a time.  
> > 
> > The reason I 'never' use it is performance, it _sucks_.. I've never ran
> > into the multi-user issue.
> 
> And performance is also something to fix (it has improved lately, you
> probably haven't noticed).

Indeed, I've not recently used it.

> > So while I don't think the rewrite is bad, this argument here is.
> 
> Except that we plan on merging kretprobe with function graph tracing.
> This also solves the issue that Mark Rutland has with ret protection.
> He has a solution for function graph tracing, but not with kretprobes.

Sure. But you didn't make that argument.

> And yes, there's also the case of being able to trace to different
> buffers where you can have a full function graph tracing enabled and
> also trace a subset that you want to have.
> 
> Just because you don't need it, doesn't mean it's not needed by others.

Not saying that; just saying the argument doesn't hold. It is not the
_one_ flaw.
