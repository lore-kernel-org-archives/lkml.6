Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DC0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0C92083D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OvZFwtgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfBZNtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:49:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZNtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T/fctdoKq3Or4EPAr3bz0VE+XinZpxwBtnExFrEtaJ8=; b=OvZFwtgAehkyGtlXo88yEIZsv
        xR+l8YRPvorXguR6N/8NnyqIZSNqdB/vzGu9w/HHm8AMRMumPIt6dyoixnV0YgTggAAteE71fRfDq
        /nUhi/hCqmmIIfR4UPZO3cjaN99CA+LOEthqB96aGfblgPGTL/vd74L5Bg/0E1hDg5HqRht+54dnv
        5+wADrMqcYScd/UfNVmWqjT2qSWoaXLFJ1yZaEDPOsBsPrK9cF6S7s2ChY39QEPQ1i6GhVVigBnow
        DN/Ees21dxluA2WxFe3L59SLOiPvMdSaWKhwHvqGFm2MQ1bNNhp4veJlHm4kwmf+Gbo3ZL2xEunxf
        qs/STg4pA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyd6a-00042V-KV; Tue, 26 Feb 2019 13:49:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D73620269AFA; Tue, 26 Feb 2019 14:49:06 +0100 (CET)
Date:   Tue, 26 Feb 2019 14:49:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190226134906.GG32494@hirez.programming.kicks-ass.net>
References: <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226113813.GA14753@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 12:38:13PM +0100, Borislav Petkov wrote:
> On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
> > When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
> > still broken.
> 
> As requested on IRC:

What I asked was if you could get your GCC developer friends to have a
look at this :-)
