Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0996EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B7420665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AHDkosGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B7420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbeJXCFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:05:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbeJXCFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Uog6eWWZwx7byoO4QTXFhNFrwph/6sU7PgE6Aph2Xh4=; b=AHDkosGoeBQzipN/52F55Iy6f
        R52Kw9Hj8ODg216rwYNcfbxJq+dSYo2gqsTpF7tkkF7sK/uRLXcwu7b2bLCi06x9l6pYF7MSeCX+n
        uKXflitnbhLmV99Se8UxIOcNAPlbbR17RnGFrnIYyLlxNYpcf122ZQqr1nxJF/DKwiSIw1Bh0MPq8
        BT999Z7RTHLYfZGXcBj8LRWEoGlsvhODfIqL2yCVqDYJBrjCN4xc12VMAYa+3qEKpZXot2HcTVeVa
        NjbrEZ3hY3wVdyjz+GoqtGZl92gJXogD+VsXCiZ/WQARbaX99s20vsP4IOa6K944ISd852KbjmX5r
        PCg8jJucQ==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gF0gD-0006ft-FB; Tue, 23 Oct 2018 17:41:21 +0000
Received: by worktop (Postfix, from userid 1000)
        id 61DD36E08B3; Tue, 23 Oct 2018 19:41:15 +0200 (CEST)
Date:   Tue, 23 Oct 2018 19:41:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
Message-ID: <20181023174115.GB3126@worktop.c.hoisthospitality.com>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20181018190710.fcea1c5f9c3b0c15d37ee762@linux-foundation.org>
 <20181023172937.GA21443@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023172937.GA21443@cmpxchg.org>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 01:29:37PM -0400, Johannes Weiner wrote:
> On Thu, Oct 18, 2018 at 07:07:10PM -0700, Andrew Morton wrote:
> > On Tue, 28 Aug 2018 13:22:49 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> > > This version 4 of the PSI series incorporates feedback from Peter and
> > > fixes two races in the lockless aggregator that Suren found in his
> > > testing and which caused the sample calculation to sometimes underflow
> > > and record bogusly large samples; details at the bottom of this email.
> > 
> > We've had very little in the way of review activity for the PSI
> > patchset.  According to the changelog tags, anyway.
> 
> Peter reviewed it quite extensively over all revisions, and acked the
> final version. Peter, can we add your acked-by or reviewed-by tag(s)?

I don't really do reviewed by; but yes, I thought I already did; lemme
find.

> The scheduler part accounts for 99% of the complexity in those
> patches. The mm bits, while somewhat sprawling, are mostly mechanical.

Ah, I now see my mistake;

  https://lkml.kernel.org/r/20180907110407.GQ24106@hirez.programming.kicks-ass.net

I forgot to include an actual tag therein. My bad.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
