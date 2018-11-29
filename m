Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F46C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD7820834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uv5EWYxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD7820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeK3CyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:54:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeK3CyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WJfKPk62iR8HjrIDfrOhj1agMZ8cEXyVLMFpR5knzCA=; b=uv5EWYxgH6Ho1XiYHKl5HZfoH
        IpbUhztiIPNSIUVuWRlFHiIGQ/WCFunkW+RVxG/O3LspwIPzpSlMzAnj9IOC0sUZe2oveDfDeG6K9
        8lRGsVUjl4OXcToTRpx7evs4OrcNOie9kgjN+4VTrvvSKEs6L7uAlTYtvP4FlJYr3FMqCGyHxLuUI
        NgIn5zW2c2YotLeZZvjT7kRxITx3q1nooqegTWPSPDCj4GiuY+204B7vw+uzxjVgk++Hqm3x6t7el
        44ZWlDut51iqOZ2UXRecwirUtOX4if0ovlxI9tUOEzb4EroIZ4f7/aUVY3EQqhHQxbSLkZ44LYFYB
        89/2Z68lA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSOXy-0004jv-56; Thu, 29 Nov 2018 15:48:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4E572029FD58; Thu, 29 Nov 2018 16:48:08 +0100 (CET)
Date:   Thu, 29 Nov 2018 16:48:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch V2 08/28] sched/smt: Make sched_smt_present track topology
Message-ID: <20181129154808.GT2131@hirez.programming.kicks-ass.net>
References: <20181125183328.318175777@linutronix.de>
 <20181125185004.246110444@linutronix.de>
 <20181129144256.GI32259@char.us.oracle.com>
 <20181129145013.GA32648@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129145013.GA32648@char.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:50:13AM -0500, Konrad Rzeszutek Wilk wrote:
> On Thu, Nov 29, 2018 at 09:42:56AM -0500, Konrad Rzeszutek Wilk wrote:
> > On Sun, Nov 25, 2018 at 07:33:36PM +0100, Thomas Gleixner wrote:
> > > Currently the 'sched_smt_present' static key is enabled when at CPU bringup
> > > SMT topology is observed, but it is never disabled. However there is demand
> > > to also disable the key when the topology changes such that there is no SMT
> > > present anymore.
> > > 
> > > Implement this by making the key count the number of cores that have SMT
> > > enabled.
> > > 
> > > In particular, the SMT topology bits are set before interrrupts are enabled
> > > and similarly, are cleared after interrupts are disabled for the last time
> > > and the CPU dies.
> > 
> > I see that the number you used is '2', but I thought that there are some
> > CPUs out there (Knights Landing?) that could have four threads?

This code is generic, Sparc, Power and I think MIPS all have parts with
SMT8.

> > Would it be better to have a generic function that would provide the
> > amount of threads the platform does expose - and use that instead
> > of a constant value? 
> 
> Nevermind - this would work even with 4 threads as we would hit the
> number '2' before '4' and the key would be turned on/off properly.

Indeed so, 2 is the point where we either have more than 1 sibling, or
will go back to 1.
