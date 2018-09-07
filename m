Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE71C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6522083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SlVzZSkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6522083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbeIGSo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:44:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56674 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbeIGSo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=P7DuxNQQPTu96m4uqUwyVAzS7ZTrBmsqkedx+n73/84=; b=SlVzZSkZNMm5S7TQkod2fxjYM
        4BvAKer9C7QLqV82tJ77DVEpOkSHRpS3iJ64O/F1ZJPV0hirB0DtsKuSw+tvml50zZ3CyyQGq3u+C
        XXasqwwX0nGyBsRozcyRU6iv0Rll+E2s/7k+jZ2pCSB1m3OX81MsPNEtPZLQQ5VE1CarxgjkBCJXx
        Um/MOeiDAxz+4hTBofxZo26kj3fzUmyA8HdWz5h/wLuaaj+CWnEkxVYTvKFEQ3eQAyJ5oU+b+gRY1
        GRvVYBZJlfcnGig8iQyL85N24QWSFPKNjbgRm4P6pnDeyfuK+csT/TxeyRr3XBmM868DEzD2DREtg
        ULORLDBXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyHMN-0005wu-FI; Fri, 07 Sep 2018 14:03:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10EAD2024DB7A; Fri,  7 Sep 2018 16:03:42 +0200 (CEST)
Date:   Fri, 7 Sep 2018 16:03:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] printk/tracing: Do not trace printk_nmi_enter()
Message-ID: <20180907140342.GH24106@hirez.programming.kicks-ass.net>
References: <20180905213334.03375777@vmware.local.home>
 <20180907073448.GL24106@hirez.programming.kicks-ass.net>
 <20180907094148.2444acc6@gandalf.local.home>
 <20180907134532.GD24106@hirez.programming.kicks-ass.net>
 <20180907095533.5b5febc2@gandalf.local.home>
 <20180907100128.64e08130@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907100128.64e08130@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:01:28AM -0400, Steven Rostedt wrote:
> On Fri, 7 Sep 2018 09:55:33 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 7 Sep 2018 15:45:32 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Yes really, we should not muck with the IRQ state from NMI context.  
> > 
> > Right, and we didn't. Your patch didn't change anything, but allow for
> > printk_nmi_enter/exit() to be traced by ftrace, but that's wrong to
> > begin with because it ftrace_nmi_enter() hasn't been called yet.
> > 
> 
> I would even argue that placing printk_nmi_enter() between
> lockdep_off() and ftrace_nmi_enter() is wrong because if in the future
> printk_nmi_enter() were to do any ftrace tracing, it wont be caught, as
> it was by having it before lockdep_off().
> 
> printk_nmi_enter() should not muck with IRQ state, nor should it do any
> ftrace tracing. Since ftrace mucks with IRQ state when it gets enabled
> or disabled, it will screw up lockdep, and lockdep will complain. That
> way we can use lockdep not being off to catch this bug.

The very bestest solution is to rm -rf printk ;-)
