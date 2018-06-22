Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C0AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0FB24045
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hTNDEkrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0FB24045
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeFVKbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:31:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36752 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeFVKbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fvO/2oaDsxi8CG79RQ/53wvy4DjZDbrNCgp1J5QHaBo=; b=hTNDEkrW1rM+jifUxQJ0mjvEa
        4+gB1Sv1oMqJyglLa5rMTnc9iDGxyoGyhaes57Tt7Hr0EHXAfifD+7gcoNgGhUWg2E9dz4VzM7SsX
        VhwVBpAIRoBgKJLAeJwJHFrWcINbwgVjWqE9XXGa9rtG/SM+kC3at98mAKrOreUebXFJBJpahGs+T
        bvR5lIUrGG72wIUJlOYQJB2z02HOYC0omJQkvyC+K0dYBNx2rNFEQLTNrK6QL/pGIu0yEs8l0MD72
        0we1Z1hHNU9DFfArO2xr8JG19AAYK2WH8URPi51PcPst16KvtM6RXowWNoGgzkvgUa8ft6Wf/olZ7
        NHrVYYPaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWJLn-00009c-I6; Fri, 22 Jun 2018 10:31:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E32D2029F1DB; Fri, 22 Jun 2018 12:31:29 +0200 (CEST)
Date:   Fri, 22 Jun 2018 12:31:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20180622103129.GQ2476@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
 <20180622080928.GB7601@arm.com>
 <20180622095547.GE7601@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622095547.GE7601@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 10:55:47AM +0100, Will Deacon wrote:
> On Fri, Jun 22, 2018 at 09:09:28AM +0100, Will Deacon wrote:
> > On Thu, Jun 21, 2018 at 01:27:12PM -0400, Alan Stern wrote:
> > > More than one kernel developer has expressed the opinion that the LKMM
> > > should enforce ordering of writes by release-acquire chains and by
> > > locking.  In other words, given the following code:
> > > 
> > > 	WRITE_ONCE(x, 1);
> > > 	spin_unlock(&s):
> > > 	spin_lock(&s);
> > > 	WRITE_ONCE(y, 1);

So this is the one I'm relying on and really want sorted.

> > > or the following:
> > > 
> > > 	smp_store_release(&x, 1);
> > > 	r1 = smp_load_acquire(&x);	// r1 = 1
> > > 	WRITE_ONCE(y, 1);

Reading back some of the old threads [1], it seems the direct
translation of the first into acquire-release would be:

	WRITE_ONCE(x, 1);
	smp_store_release(&s, 1);
	r1 = smp_load_acquire(&s);
	WRITE_ONCE(y, 1);

Which is I think easier to make happen than the second example you give.

> > > the stores to x and y should be propagated in order to all other CPUs,
> > > even though those other CPUs might not access the lock s or be part of
> > > the release-acquire chain.  In terms of the memory model, this means
> > > that rel-rf-acq-po should be part of the cumul-fence relation.
> > > 
> > > All the architectures supported by the Linux kernel (including RISC-V)
> > > do behave this way, albeit for varying reasons.  Therefore this patch
> > > changes the model in accordance with the developers' wishes.
> > 
> > Interesting...
> > 
> > I think the second example would preclude us using LDAPR for load-acquire,
> > so I'm surprised that RISC-V is ok with this. For example, the first test
> > below is allowed on arm64.
> > 
> > I also think this would break if we used DMB LD to implement load-acquire
> > (second test below).
> > 
> > So I'm not a big fan of this change, and I'm surprised this works on all
> > architectures. What's the justification?
> 
> I also just realised that this prevents Power from using ctrl+isync to
> implement acquire, should they wish to do so.

They in fact do so on chips lacking LWSYNC, see how PPC_ACQUIRE_BARRIER
(as used by atomic_*_acquire) turns into ISYNC (note however that they
do not use PPC_ACQUIRE_BARRIER for smp_load_acquire -- because there's
no CTRL there).


[1] https://lkml.kernel.org/r/20171128095850.rhtnx6e2qxep5npa@hirez.programming.kicks-ass.net
