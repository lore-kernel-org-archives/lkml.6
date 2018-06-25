Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB12DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FD92565E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J+FK7oqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FD92565E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754802AbeFYJHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:07:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754537AbeFYJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4Q95/j64975IV+y3PIEVFy5E+apTPR6EQZ40gLnVXvI=; b=J+FK7oqOs4GzWXGD1lO+LLozw
        +fGC4sTkLsthLUs+ANfBbqam8emQhsqlUjlg3EzTW5+xwLKAkSIACKn7Q59jQyGhmBcdC/DF7RNNr
        EZWe6eYn7xCf3Jgcg1pVoGE3WA6eLlpDsTC95PtqledEYnI1w0vj0LuuNBjsCgbAxXSexUj8O1VGj
        poB4B9JT+MyQiJwnu+b+5Fba1AOwcz8apDIpAf74NhXwWxIrCAgHEbmBalxPWDTFCZX/S0BG3rUlY
        ASaVtKC64lmGouKQ35WogCk3BZ69lgBy5VPfhBnhElX9LSBU2ZSb0Qg2Pf7FvSW5aQfaYEDGqlSv9
        dFsN4XTRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXNSU-0001NA-AT; Mon, 25 Jun 2018 09:06:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62EF42029F1D9; Mon, 25 Jun 2018 11:06:48 +0200 (CEST)
Date:   Mon, 25 Jun 2018 11:06:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180625090648.GU2494@hirez.programming.kicks-ass.net>
References: <20180622080928.GB7601@arm.com>
 <Pine.LNX.4.44L0.1806221337440.1454-100000@iolanthe.rowland.org>
 <20180625073229.GR2494@hirez.programming.kicks-ass.net>
 <20180625082923.GA5808@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625082923.GA5808@andrea>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 10:29:23AM +0200, Andrea Parri wrote:
> On Mon, Jun 25, 2018 at 09:32:29AM +0200, Peter Zijlstra wrote:
> > 
> > I have yet to digest the rest of the discussion, however:
> > 
> > On Fri, Jun 22, 2018 at 02:09:04PM -0400, Alan Stern wrote:
> > > The LKMM uses the same CAT code for acquire/release and lock/unlock.
> > > (In essence, it considers a lock to be an acquire and an unlock to be a
> > > release; everything else follows from that.)  Treating one differently
> > > from the other in these tests would require some significant changes.
> > > It wouldn't be easy.
> > 
> > That is problematic, acquire+release are very much simpler operations
> > than lock+unlock.
> > 
> > At the very least, lock includes a control-dependency, where acquire
> > does not.
> 
> I don't see how this is relevant here; roughly, "if something is guaranteed
> by a control-dependency, that is also guaranteed by an acquire".  Right? ;)

Right, you are, clearly I needs me a wake up drink :-).. So lock does
very fundamentally involve a RmW, and it has the whole wait-until loop
thing in. But yes, now I'm strugging to better express how it's
different from a memory ordering pov.

But still, the lock case will/must disallow the re-ordering (since we rely on
it), whereas the pure acquire/release seems to be struggling.

Personally I prefer a stronger model over a weaker one (as does Linus
IIRC) but clearly people have different opinions on that.
