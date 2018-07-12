Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E011BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E67720C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zn5xlX0H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E67720C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbeGLJi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:38:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeGLJiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NdR6VUThs2RqCqKV0PY7nHtFykaa+P3LuZg6Ym7Gy1I=; b=Zn5xlX0HgYtaTnt1UGILdtBj8
        +EotlMx0kvmP0AwbR50sbu2sWzO/FMNYA0G/XyNeNm9Qd2YJwfp72EnIlrEfhwG+7jpxS3+inQcqN
        aevoeP1FiX4nV5AFN1U8WmWAW2nuab0Cg9ncnPw36RNbOCQk6dbzHYfgPiy4XOrpgb4HTQI/rfrIZ
        w3W515j7nvB0beo0YWZdRuZTKolUXCMkNjKy0ljCc6P4seA1XPDcPYnmCSRximc+iS4RYe7hpM9Wi
        l7e3UyeGFPwMC+hwN6K89ngJaSjs20y1gMsNGpz68asMX/fYye4IuhCyLuuTPA4CqIz0PWTaZajXQ
        z7Q4m+g8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdXui-0002ZK-LX; Thu, 12 Jul 2018 09:29:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CCA620291063; Thu, 12 Jul 2018 11:29:26 +0200 (CEST)
Date:   Thu, 12 Jul 2018 11:29:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Lustig <dlustig@nvidia.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712092926.GR2494@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
 <20180711155751.GC18477@arm.com>
 <20180711170053.GM2476@hirez.programming.kicks-ass.net>
 <e5148058-c551-ca65-eef3-4259badecf57@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5148058-c551-ca65-eef3-4259badecf57@nvidia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:50:56AM -0700, Daniel Lustig wrote:
> On 7/11/2018 10:00 AM, Peter Zijlstra wrote:
> > On Wed, Jul 11, 2018 at 04:57:51PM +0100, Will Deacon wrote:
> > 
> >> It might be simple to model, but I worry this weakens our locking
> >> implementations to a point where they will not be understood by the average
> >> kernel developer. As I've said before, I would prefer "full" RCsc locking,
> > 
> > Another vote for RCsc locks. The (in)famous hold-out is of course
> > PowerPC, but it now looks like RISC-V is following where they I really
> > rather wish they didn't.
> 
> That's not entirely fair.  We came in wanting to do the "natural" or

My appologies then, and I must admit I've not really kept track of what
RISC-V ended up doing :/

> "expected" thing: use RCsc atomics where we have them available in the
> ISA, and use "fence r,rw" and "fence rw,w" where we don't.
> 
> I would argue that the idea of having data races on variables that are
> also protected by locks is equally if not more counterintuitive and
> unexpected than the "natural" mapping we had originally proposed to use.
> 
> All the discussion here[1] for example is about having ordering and
> doing an smp_cond_load_acquire() on a variable which is sometimes
> protected by a CPU's rq->lock and sometimes not?  Isn't that one of the
> key use cases for this whole discussion?

Well, the scheduler locks are on place where I know we rely on stuff
like this. RCU is another place where we know we rely on locks being
RCsc.

The big problem of course is all the places we do not know about. This
kernel thing is terribly big and there's an awful lot of clever people
involved.

Now, PPC seems to have build RCpc locks before we fully understood these
things and has since (understandably) 'refused' to go RCsc because
performance regressions.

But the fact is that stronger ordering is easier on these pesky humans.

Also:

  https://lkml.org/lkml/2016/2/2/80
