Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8614C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FC32087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VGR54e64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfAGV3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:29:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfAGV3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uieQqH+rm+7/7n+3FkuRrxe4KYrhKmvhF8kl3osse5c=; b=VGR54e64vZUYgLowu4apKAW1i
        +bME1+qWt2IRfxsinal6Fb9et/zazf0RzQpiP03F5Xw0ClSTMO2bkiKYMrh67nB0yfQdWiHYk3jTo
        z2m4FhHPkwvr/y3TKK8hYdRSLWdrTUQRviPEYhU+vpAyKaTLbrD3nD52vVEzEDwmlfKjqogwo6qjW
        E01LDUf7NSCJ4Z8Pq2VBziIv9j/dftU/b9se4WVuN2gtdC2i8bXJRORad5g5evSNDHeA4L8nedjwW
        PxO4fe4ZifeTnvvFUOC7czwOc/SmhaqhwLMbtkUocYYlFtIDhEtUU3aZ4Hf7UCRNaQvIm8lWkQso+
        atVBE9guA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggcSZ-0005Fz-KS; Mon, 07 Jan 2019 21:29:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00A5E20170508; Mon,  7 Jan 2019 22:29:21 +0100 (CET)
Date:   Mon, 7 Jan 2019 22:29:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        syzbot <syzbot+93d94a001cfbce9e60e1@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux@dominikbrodowski.net, mhocko@suse.com,
        rientjes@google.com, syzkaller-bugs@googlegroups.com,
        xieyisheng1@huawei.com, zhongjiang@huawei.com,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: possible deadlock in __wake_up_common_lock
Message-ID: <20190107212921.GK14122@hirez.programming.kicks-ass.net>
References: <000000000000f67ca2057e75bec3@google.com>
 <1194004c-f176-6253-a5fd-682472dccacc@suse.cz>
 <20190107095217.GB2861@worktop.programming.kicks-ass.net>
 <20190107204627.GA25526@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107204627.GA25526@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 03:46:27PM -0500, Johannes Weiner wrote:
> Hm, so the splat says this:
> 
> wakeups take the pi lock
> pi lock holders take the rq lock
> rq lock holders take the timer base lock (thanks psi)
> timer base lock holders take the zone lock (thanks kasan)
> problem: now a zone lock holder wakes up kswapd
> 
> right? And we can break the chain from the VM or from psi.

Yep. And since PSI it the latest addition to that chain, I figured we
ought maybe not do that. But I've not looked at a computer in 2 weeks,
so what do I know ;-)

> I cannot say one is clearly cleaner than the other, though. With kasan
> allocating from inside the basic timer code, those locks leak out from
> kernel/* and contaminate the VM locking anyway.
> 
> Do you think the rq->lock -> base->lock ordering is likely to cause
> issues elsewhere?

Not sure; we nest the hrtimer base lock under rq->lock (at the time I
fixed hrtimers to not hold it's base lock over the timer function
callback, just like regular timers already did) and that has worked
fine.

So maybe we should look at the kasan thing.. dunno.
