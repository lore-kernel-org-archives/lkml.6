Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DDDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABDC2229E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfBKRdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:33:03 -0500
Received: from foss.arm.com ([217.140.101.70]:54640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbfBKRdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:33:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF954EBD;
        Mon, 11 Feb 2019 09:33:01 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19D9A3F675;
        Mon, 11 Feb 2019 09:32:58 -0800 (PST)
Date:   Mon, 11 Feb 2019 17:32:56 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, Matthew Wilcox <willy@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Laight <David.Laight@aculab.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH RFC LKMM 5/7] docs/memory-barriers.txt: Enforce heavy
 ordering for port I/O accesses
Message-ID: <20190211173256.GB2994@fuggles.cambridge.arm.com>
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109210748.29074-5-paulmck@linux.ibm.com>
 <20190211153043.GC32385@fuggles.cambridge.arm.com>
 <CAK8P3a3bkQoVfkV-+pNniirLN5Z_Wv3eG2TXW35kdJixCOH9_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3bkQoVfkV-+pNniirLN5Z_Wv3eG2TXW35kdJixCOH9_Q@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Feb 11, 2019 at 06:11:48PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 11, 2019 at 4:30 PM Will Deacon <will.deacon@arm.com> wrote:
> 
> > Given the lack of Intel response here, I went away to do some digging.
> > As evidenced by the commit message, there is certainly an understanding
> > amongst some developers that inX/outX() are strongly ordered on x86 and
> > this was re-enforced by Linus in March last year:
> >
> > https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg131212.html
> >
> > It was this information on which I based my patch. The Intel SDM is not
> > quite as assertive in its claims.
> >
> > However, it has also occurred to me that this patch is actually missing
> > the point. memory-barriers.txt should be documenting the *Linux* memory
> > model, not the x86 one, and so the port accessors should be defined to
> > have the same ordering semantics as the MMIO accessors. If this wasn't
> > the case, then macros such as ioreadX() and iowriteX() would be unusable
> > in portable driver code.
> 
> My interpretation of the ioreadX() and iowriteX() semantics is that they
> only guarantee readl()/writel() barrier semantics, even though they
> may in fact provide stronger barriers for PIO on architectures that use
> CONFIG_GENERIC_IOMAP (which falls back to inX()/outX()).
> 
> > The inX/outX implementation in asm-generic would
> > also be bogus, despite being widely used.
> 
> They likely are. The asm-generic files tend to provide a generic
> abstraction as much as that is possible, but without having access
> to the architecture specific semantics, they raditionally don't know
> what should be done here. We now have __io_pbw()/__io_paw()/
> __io_pbr()/__io_par() to let architectures get it right, but that is
> a fairly recent addition, so nothing other than riscv defines them
> today.
> To make things worse, a lot of machines are unable to provide
> __io_paw(), e.g. when all bus writes are posted.

So I've just sent an RFC (you're on cc) that attempts to rewrite this part
of memory-barriers.txt to reflect reality. Hopefully that can act as a
starting point for discussion if we decide we want to change the documented
behaviour and/or implementation.

Will
