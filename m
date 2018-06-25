Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8F3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADFD25530
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aA0SUllj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADFD25530
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeFYHc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:32:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45214 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeFYHcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PBoGhVkgWYUIk3bBP0fqjg5MBz1BZqi9g6zFYvCLoS0=; b=aA0SUlljz1mn9p8MP55/Xajx9
        5tIhpLjgqK9jDn7lcV2Dm90lp7W0Q7xrt2XN5dZwqPm1MWYgJqfjIxEK+yG6Ej0vHXxqkBJbHaiEa
        oEun85AE+dqaDFdBV/f1gE1wVlLP4pNwBPGo4xuE6yf+Sq9t667dvDq4f1IR2vakYWcbsqWAGBD0G
        ClCWl9jEw966mwEOHiFAiN7YtOFW8jrH/vswZVnZ/zpby4SmRdbMHzqGbZ1++R+v+sFgnLtJTVAqD
        PFsKqrWVnQHMz+Hl1dka+fZSz2wzFDvU8loMKjxrtSeIOn+X704vipDm4s/zUcazFNXbMWqrYd57Z
        A53pwZXww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXLzE-00065s-U4; Mon, 25 Jun 2018 07:32:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8ED402029FA0A; Mon, 25 Jun 2018 09:32:29 +0200 (CEST)
Date:   Mon, 25 Jun 2018 09:32:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will.deacon@arm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180625073229.GR2494@hirez.programming.kicks-ass.net>
References: <20180622080928.GB7601@arm.com>
 <Pine.LNX.4.44L0.1806221337440.1454-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1806221337440.1454-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have yet to digest the rest of the discussion, however:

On Fri, Jun 22, 2018 at 02:09:04PM -0400, Alan Stern wrote:
> The LKMM uses the same CAT code for acquire/release and lock/unlock.
> (In essence, it considers a lock to be an acquire and an unlock to be a
> release; everything else follows from that.)  Treating one differently
> from the other in these tests would require some significant changes.
> It wouldn't be easy.

That is problematic, acquire+release are very much simpler operations
than lock+unlock.

At the very least, lock includes a control-dependency, where acquire
does not.

