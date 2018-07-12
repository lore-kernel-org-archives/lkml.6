Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4207BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCF6213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pzukHsvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCF6213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeGLHtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:49:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeGLHtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CbLpby2m9coIhrmKkcl0LDnniMhy25bj5JxhOkHx+iE=; b=pzukHsvqmxWCrSUCMDIy5syBu
        4vpc9B8Iewbq7r/bRU5WWaGRjIBk7mDQp5sp/15rD8bXbmomn3ORQydkAimFD2eir4RWRK2kmGRbH
        USMILKwPSgcNL2ZcJWyGsamThesCv14oYSE0Q7NOxdMr9pGUJNmNuBWk+ereoT2UFDmo7bsiiR9v1
        ULX0Hn2NKXCh4dOqc5QgFN1L8Id2ZENLs33t8zviDBHYyEad3XV3vTus2IZE/dcJ1eo9tfcMOvfWL
        1eT3WHFcF9hsxAYk67TWlbCKJyj78CcjY6EnXaI6VBoQUx3H7L3SpDmcVk51NcrgyeG9QiRSk/mDS
        FoMCqCzpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdWDS-0000rP-ME; Thu, 12 Jul 2018 07:40:42 +0000
Received: by worktop (Postfix, from userid 1000)
        id 121FE6E093E; Thu, 12 Jul 2018 09:40:40 +0200 (CEST)
Date:   Thu, 12 Jul 2018 09:40:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712074040.GA4920@worktop.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711123421.GA9673@andrea>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 02:34:21PM +0200, Andrea Parri wrote:
> Simplicity is the eye of the beholder.  From my POV (LKMM maintainer), the
> simplest solution would be to get rid of rfi-rel-acq and unlock-rf-lock-po
> (or its analogous in v3) all together:

<snip>

> Among other things, this would immediately:
> 
>   1) Enable RISC-V to use their .aq/.rl annotations _without_ having to
>      "worry" about tso or release/acquire fences; IOW, this will permit
>      a partial revert of:
> 
>        0123f4d76ca6 ("riscv/spinlock: Strengthen implementations with fences")
>        5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")

But I feel this goes in the wrong direction. This weakens the effective
memory model, where I feel we should strengthen it.

Currently PowerPC is the weakest here, and the above RISC-V changes
(reverts) would make RISC-V weaker still.

Any any effective weakening makes me very uncomfortable -- who knows
what will come apart this time. This memory ordering stuff causes
horrible subtle bugs at best.

>   2) Resolve the above mentioned controversy (the inconsistency between
>      - locking operations and atomic RMWs on one side, and their actual
>      implementation in generic code on the other), thus enabling the use
>      of LKMM _and_ its tools for the analysis/reviewing of the latter.

This is a good point; so lets see if there is something we can do to
strengthen the model so it all works again.

And I think if we raise atomic*_acquire() to require TSO (but ideally
raise it to RCsc) we're there.

The TSO archs have RCpc load-acquire and store-release, but fully
ordered atomics. Most of the other archs have smp_mb() everything, with
the exception of PPC, ARM64 and now RISC-V.

PPC has the RCpc TSO fence LWSYNC, ARM64 has the RCsc
load-acquire/store-release. And RISC-V has a gazillion of options IIRC.


So ideally atomic*_acquire() + smp_store_release() will be RCsc, and is
with the notable exception of PPC, and ideally RISC-V would be RCsc
here. But at the very least it should not be weaker than PPC.

By increasing atomic*_acquire() to TSO we also immediately get the
proposed:

  P0()
  {
	  WRITE_ONCE(X, 1);
	  spin_unlock(&s);
	  spin_lock(&s);
	  WRITE_ONCE(Y, 1);
  }

  P1()
  {
	  r1 = READ_ONCE(Y);
	  smp_rmb();
	  r2 = READ_ONCE(X);
  }

behaviour under discussion; because the spin_lock() will imply the TSO
ordering.

And note that this retains regular RCpc ACQUIRE for smp_load_acquire()
and associated primitives -- as they have had since their introduction
not too long ago.
