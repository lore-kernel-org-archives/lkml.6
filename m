Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C74C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FBD20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u9JWkSw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfBRUk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:40:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35410 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfBRUk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D4KVafrIWO3hRL7wT1pFyqZZqP8UP6+r/2o6A4Cqn30=; b=u9JWkSw32M7Y0PECZWpQl5Rqb
        iF15GJPxMH/cTKJTSQTCyxrIgL1b4XQKjBxSe1KDOU0rVtgF3yJmtXaKBycEXRT8GG3G65CaONGCR
        Mc2HKG7e2XxXPq1Gl8Q+rMc7UBQno0+q4sI4GzxE4OpQthuvEG57xmZbnZXkPPSZ8RDsL5OKRDfYc
        E+bCxyrhsme+gBePf9I9oqacPbnObDKAMYpqYWtSEIqsROQ6tcqQbaMf0gp2xzgUQWO/fSvko6Nbn
        4Ja8sbcrIgFasxD7CZXgNpJ0GqhuZjI+bINVIB8F6ZjO8Fif7HKI90HaqoPtrZHY8nsytRngvEgNZ
        DoZZZ9Myg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gvpiB-0004v8-24; Mon, 18 Feb 2019 20:40:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42F5F201A4F68; Mon, 18 Feb 2019 21:40:20 +0100 (CET)
Date:   Mon, 18 Feb 2019 21:40:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        subhra.mazumdar@oracle.com,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>, kerrnel@google.com
Subject: Re: [RFC][PATCH 00/16] sched: Core scheduling
Message-ID: <20190218204020.GV32494@hirez.programming.kicks-ass.net>
References: <20190218165620.383905466@infradead.org>
 <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh32Zgp+bN7G1KH7SuCiY1YSJ41Y-_eWpfWubGjqq2_dw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 09:49:10AM -0800, Linus Torvalds wrote:
> On Mon, Feb 18, 2019 at 9:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > However; whichever way around you turn this cookie; it is expensive and nasty.
> 
> Do you (or anybody else) have numbers for real loads?
> 
> Because performance is all that matters. If performance is bad, then
> it's pointless, since just turning off SMT is the answer.

Not for these patches; they stopped crashing only yesterday and I
cleaned them up and send them out.

The previous version; which was more horrible; but L1TF complete, was
between OK-ish and horrible depending on the number of VMEXITs a
workload had.

If there were close to no VMEXITs, it beat smt=off, if there were lots
of VMEXITs it was far far worse. Supposedly hosting people try their
very bestest to have no VMEXITs so it mostly works for them (with the
obvious exception of single VCPU guests).

It's just that people have been bugging me for this crap; and I figure
I'd post it now that it's not exploding anymore and let others have at.


