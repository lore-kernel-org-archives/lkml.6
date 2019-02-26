Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC652C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B612173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RMulZanl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfBZJWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:22:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfBZJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HAqDS+0+NT0uQEvK5UDVz2uSLBQrgzEkPgf4DxUtg+0=; b=RMulZanlid7hD9Aa4Aut3fGcd
        Fe1VEnaMmomt46dYSEDzFU+h1bYZAQ74G6E+ZNi6o2Vs5/9AM6HWHzG8o41U61R50QycIPuK3YVOE
        t9uM9oGC8z0hCSDQD9WbiLR9g7DlCC/ScoShD7IbhxKg4Gm2m6WYXfY6np6iv+6QrUxeR2pMQgHnV
        XE+qGU59A9Dm01I+KgJDVGzab88Vbj4rL1ShrL97E4jzAQWCgF+wTV9uP4EDKlbJ3pqUp+uYCkgKM
        qL0STZnb8Lpw8mEDdvBkOoRyfg9nClxlydIx04HPEgQRCaCmmYuSgbsVM/6rOKweM6vPH97lhGCJ3
        YfuQVPyKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyYvp-0006ii-8T; Tue, 26 Feb 2019 09:21:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AAB020269AFC; Tue, 26 Feb 2019 10:21:43 +0100 (CET)
Date:   Tue, 26 Feb 2019 10:21:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
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
Message-ID: <20190226092143.GR32477@hirez.programming.kicks-ass.net>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225175517.GK4072@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 09:55:17AM -0800, Paul E. McKenney wrote:
> Again, if you know of any code in the Linux kernel that would have
> problems with aggressive optimizations based on pointer provenance,
> please let me know!

I've no clue what pointer provenance is to begin with.
