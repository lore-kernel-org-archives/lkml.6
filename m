Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F8C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0825720847
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0825720847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934146AbeGDMNQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:13:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36372 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932997AbeGDMNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:13:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23C6F18A;
        Wed,  4 Jul 2018 05:13:15 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8D183F5BA;
        Wed,  4 Jul 2018 05:13:14 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D82081AE189D; Wed,  4 Jul 2018 13:13:54 +0100 (BST)
Date:   Wed, 4 Jul 2018 13:13:54 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180704121354.GC26941@arm.com>
References: <20180625081920.GA5619@andrea>
 <Pine.LNX.4.44L0.1807031228250.1513-100000@iolanthe.rowland.org>
 <20180704112852.GH3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704112852.GH3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 04:28:52AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 03, 2018 at 01:28:17PM -0400, Alan Stern wrote:
> > PS: Paul, is the patch which introduced rel-rf-acq-po currently present
> > in any of your branches?  I couldn't find it.
> 
> It is not, I will add it back in.  I misinterpreted your "drop this
> patch" on 2/2 as "drop both patches".  Please accept my apologies!
> 
> Just to double-check, the patch below should be added, correct?

Hang on, I'm not sure this patch is quite right either. We need to reach
agreement on whether or not we want to support native RCpc acquire/release
instructions before we work out what to do with this relation.

Will

> ------------------------------------------------------------------------
> 
> Date: Thu, 21 Jun 2018 13:26:49 -0400 (EDT)
> From: Alan Stern <stern@rowland.harvard.edu>
> To: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,        Andrea Parri
>  <andrea.parri@amarulasolutions.com>,        Boqun Feng
>  <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,        
>  Jade Alglave <j.alglave@ucl.ac.uk>,        Luc Maranget <luc.maranget@inria.fr>,
>  Nicholas Piggin <npiggin@gmail.com>,        
>  "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,        Peter Zijlstra <peterz@infradead.org>,
>  Will Deacon <will.deacon@arm.com>
> cc: Kernel development list <linux-kernel@vger.kernel.org>
> Subject: [PATCH 1/2] tools/memory-model: Change rel-rfi-acq ordering to
>  (rel-rf-acq-po & int)
> Message-ID: <Pine.LNX.4.44L0.1806211315550.2381-100000@iolanthe.rowland.org>
> 
> This patch changes the LKMM rule which says that an acquire which
> reads from an earlier release must be executed after that release (in
> other words, the release cannot be forwarded to the acquire).  This is
> not true on PowerPC, for example.
> 
> What is true instead is that any instruction following the acquire
> must be executed after the release.  On some architectures this is
> because a write-release cannot be forwarded to a read-acquire; on
> others (including PowerPC) it is because the implementation of
> smp_load_acquire() places a memory barrier immediately after the
> load.
> 
> This change to the model does not cause any change to the model's
> predictions.  This is because any link starting from a load must be an
> instance of either po or fr.  In the po case, the new rule will still
> provide ordering.  In the fr case, we also have ordering because there
> must be a co link to the same destination starting from the
> write-release.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> 
> [as1870]
> 
> 
>  tools/memory-model/Documentation/explanation.txt |   35 ++++++++++++-----------
>  tools/memory-model/linux-kernel.cat              |    6 +--
>  2 files changed, 22 insertions(+), 19 deletions(-)
> 
> Index: usb-4.x/tools/memory-model/linux-kernel.cat
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/linux-kernel.cat
> +++ usb-4.x/tools/memory-model/linux-kernel.cat
> @@ -38,7 +38,7 @@ let strong-fence = mb | gp
>  (* Release Acquire *)
>  let acq-po = [Acquire] ; po ; [M]
>  let po-rel = [M] ; po ; [Release]
> -let rfi-rel-acq = [Release] ; rfi ; [Acquire]
> +let rel-rf-acq-po = [Release] ; rf ; [Acquire] ; po
> 
>  (**********************************)
>  (* Fundamental coherence ordering *)
> @@ -60,9 +60,9 @@ let dep = addr | data
>  let rwdep = (dep | ctrl) ; [W]
>  let overwrite = co | fr
>  let to-w = rwdep | (overwrite & int)
> -let to-r = addr | (dep ; rfi) | rfi-rel-acq
> +let to-r = addr | (dep ; rfi)
>  let fence = strong-fence | wmb | po-rel | rmb | acq-po
> -let ppo = to-r | to-w | fence
> +let ppo = to-r | to-w | fence | (rel-rf-acq-po & int)
> 
>  (* Propagation: Ordering from release operations and strong fences. *)
>  let A-cumul(r) = rfe? ; r
> Index: usb-4.x/tools/memory-model/Documentation/explanation.txt
> ===================================================================
> --- usb-4.x.orig/tools/memory-model/Documentation/explanation.txt
> +++ usb-4.x/tools/memory-model/Documentation/explanation.txt
> @@ -1067,27 +1067,30 @@ allowing out-of-order writes like this t
>  violating the write-write coherence rule by requiring the CPU not to
>  send the W write to the memory subsystem at all!)
> 
> -There is one last example of preserved program order in the LKMM: when
> -a load-acquire reads from an earlier store-release.  For example:
> +There is one last example of preserved program order in the LKMM; it
> +applies to instructions po-after a load-acquire which reads from an
> +earlier store-release.  For example:
> 
>  	smp_store_release(&x, 123);
>  	r1 = smp_load_acquire(&x);
> +	WRITE_ONCE(&y, 246);
> 
>  If the smp_load_acquire() ends up obtaining the 123 value that was
> -stored by the smp_store_release(), the LKMM says that the load must be
> -executed after the store; the store cannot be forwarded to the load.
> -This requirement does not arise from the operational model, but it
> -yields correct predictions on all architectures supported by the Linux
> -kernel, although for differing reasons.
> -
> -On some architectures, including x86 and ARMv8, it is true that the
> -store cannot be forwarded to the load.  On others, including PowerPC
> -and ARMv7, smp_store_release() generates object code that starts with
> -a fence and smp_load_acquire() generates object code that ends with a
> -fence.  The upshot is that even though the store may be forwarded to
> -the load, it is still true that any instruction preceding the store
> -will be executed before the load or any following instructions, and
> -the store will be executed before any instruction following the load.
> +written by the smp_store_release(), the LKMM says that the store to y
> +must be executed after the store to x.  In fact, the only way this
> +could fail would be if the store-release was forwarded to the
> +load-acquire; the LKMM says it holds even in that case.  This
> +requirement does not arise from the operational model, but it yields
> +correct predictions on all architectures supported by the Linux
> +kernel, although for differing reasons:
> +
> +On some architectures, including x86 and ARMv8, a store-release cannot
> +be forwarded to a load-acquire.  On others, including PowerPC and
> +ARMv7, smp_load_acquire() generates object code that ends with a
> +fence.  The result is that even though the store-release may be
> +forwarded to the load-acquire, it is still true that the store-release
> +(and all preceding instructions) will be executed before any
> +instruction following the load-acquire.
> 
> 
>  AND THEN THERE WAS ALPHA
> 
> 
