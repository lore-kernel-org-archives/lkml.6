Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F19C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4F820C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qoo67VBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4F820C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389786AbeGKQk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:40:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388017AbeGKQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BZN3vSzwuk9ehsjZrTfUrc0SUulBrta6AXACSHaNtd0=; b=qoo67VBbHyk6IKDubRCTTNtND
        onuqIFXZDZtDlzAUf8ifCo3AfFkQT3a3CfrtRsEOUlZbfe/T5iqs2C7zRQcILEAySGWpu6769H5o5
        uCvwp+H7xkqE483N7YiGMXMM4ERzmn0f3fYo6LiT9KHFTuZH0DE3ng6Y0bDUPp06+VmwNwVv2ZZZY
        b64/GYterthRw6P+2zdXcikAICpwcWQccf8UaTsKu8BuOwzuHpScpYPGps7E2Aa6lanxnzfZ44n/6
        /R3iG8fuM3JBIBUXlCJtx3U/F1ajJwQQDyh5cvKkLJRvEa1t2WOovzeafC1127rtu6VXH9zDuKrdK
        Mcv8qmCCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdI4x-0005jr-9N; Wed, 11 Jul 2018 16:34:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DC8B20298BAC; Wed, 11 Jul 2018 18:34:56 +0200 (CEST)
Date:   Wed, 11 Jul 2018 18:34:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180711163456.GL2476@hirez.programming.kicks-ass.net>
References: <20180710162555.GV3593@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1807101416390.1449-100000@iolanthe.rowland.org>
 <20180711094344.GE13963@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711094344.GE13963@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:43:45AM +0100, Will Deacon wrote:
> Hi Alan,
> 
> On Tue, Jul 10, 2018 at 02:18:13PM -0400, Alan Stern wrote:
> > More than one kernel developer has expressed the opinion that the LKMM
> > should enforce ordering of writes by locking.  In other words, given
> > the following code:
> > 
> > 	WRITE_ONCE(x, 1);
> > 	spin_unlock(&s):
> > 	spin_lock(&s);
> > 	WRITE_ONCE(y, 1);
> > 
> > the stores to x and y should be propagated in order to all other CPUs,
> > even though those other CPUs might not access the lock s.  In terms of
> > the memory model, this means expanding the cumul-fence relation.
> > 
> > Locks should also provide read-read (and read-write) ordering in a
> > similar way.  Given:
> > 
> > 	READ_ONCE(x);
> > 	spin_unlock(&s);
> > 	spin_lock(&s);
> > 	READ_ONCE(y);		// or WRITE_ONCE(y, 1);
> > 
> > the load of x should be executed before the load of (or store to) y.
> > The LKMM already provides this ordering, but it provides it even in
> > the case where the two accesses are separated by a release/acquire
> > pair of fences rather than unlock/lock.  This would prevent
> > architectures from using weakly ordered implementations of release and
> > acquire, which seems like an unnecessary restriction.  The patch
> > therefore removes the ordering requirement from the LKMM for that
> > case.
> > 
> > All the architectures supported by the Linux kernel (including RISC-V)
> > do provide this ordering for locks, albeit for varying reasons.
> > Therefore this patch changes the model in accordance with the
> > developers' wishes.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Thanks, I'm happy with this version of the patch:
> 
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Me too! Thanks Alan.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
