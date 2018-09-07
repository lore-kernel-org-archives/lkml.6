Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8566CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BB32077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ho1hogiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BB32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbeIGTkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:40:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56968 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbeIGTkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/tt1x5V8vI/gV9w+n7YTsD4Ii6pVEeVAYF8srGCm1Oc=; b=Ho1hogiwokgGgRwrhJZXjxLqe
        oZ+Tk8wKHohXPn1cBsAtN0HbfNBlF5/kl1VCEqqLPTsIGVX9/YqgXck2os+w52wTbaukUfIchAEr7
        18LY7velP9yMnnMGONpht6/Ue5+C6IplKiJVcQZcPktE3JzceITt+yCHPsYEoBzj/8oFDpEBrF2R/
        7RdpufEjYTY088dr4POMSteThdYMHDkmSmvldcTLPAdWEcOt9Kq8IDAPHFKL35JatdeyGsT/t2j9z
        rHOz2cpI74Grds4Egz86OWAP9IYWNJ6ndrmCprt2GjKQUi107hVY2Lwkn0lGXqfRgGxIt/0DhygWo
        +T58MmvsQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyIDs-0006Df-0R; Fri, 07 Sep 2018 14:59:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E9262024E440; Fri,  7 Sep 2018 16:58:58 +0200 (CEST)
Date:   Fri, 7 Sep 2018 16:58:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180907145858.GK24106@hirez.programming.kicks-ass.net>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180828172258.3185-9-hannes@cmpxchg.org>
 <20180907101634.GO24106@hirez.programming.kicks-ass.net>
 <20180907144422.GA11088@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907144422.GA11088@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:44:22AM -0400, Johannes Weiner wrote:

> > This does the whole seqcount thing 6x, which is a bit of a waste.
> 
> [...]
> 
> > It's a bit cumbersome, but that's because of C.
> 
> I was actually debating exactly this with Suren before, but since this
> is a super cold path I went with readability. I was also thinking that
> restarts could happen quite regularly under heavy scheduler load, and
> so keeping the individual retry sections small could be helpful - but
> I didn't instrument this in any way.

I was hoping going over the whole thing once would reduce the time we
need to keep that line in shared mode and reduce traffic. And yes, this
path is cold, but I was thinking about reducing the interference on the
remote CPU.

Alternatively, we memcpy the whole line under the seqlock and then do
everything later.

Also, this only has a single cpu_clock() invocation.
