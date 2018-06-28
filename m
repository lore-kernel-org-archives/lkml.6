Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F942C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C665027474
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 13:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C665027474
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966303AbeF1NuA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 09:50:00 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:32800 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S965772AbeF1Nt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 09:49:59 -0400
Received: (qmail 2108 invoked by uid 2102); 28 Jun 2018 09:49:58 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Jun 2018 09:49:58 -0400
Date:   Thu, 28 Jun 2018 09:49:58 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     linux-kernel@vger.kernel.org, <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/3] locking: Clarify requirements for smp_mb__after_spinlock()
In-Reply-To: <1530182480-13205-3-git-send-email-andrea.parri@amarulasolutions.com>
Message-ID: <Pine.LNX.4.44L0.1806280947080.1812-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018, Andrea Parri wrote:

> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -114,29 +114,8 @@ do {								\
>  #endif /*arch_spin_is_contended*/
>  
>  /*
> - * This barrier must provide two things:
> - *
> - *   - it must guarantee a STORE before the spin_lock() is ordered against a
> - *     LOAD after it, see the comments at its two usage sites.
> - *
> - *   - it must ensure the critical section is RCsc.
> - *
> - * The latter is important for cases where we observe values written by other
> - * CPUs in spin-loops, without barriers, while being subject to scheduling.
> - *
> - * CPU0			CPU1			CPU2
> - *
> - *			for (;;) {
> - *			  if (READ_ONCE(X))
> - *			    break;
> - *			}
> - * X=1
> - *			<sched-out>
> - *						<sched-in>
> - *						r = X;
> - *
> - * without transitivity it could be that CPU1 observes X!=0 breaks the loop,
> - * we get migrated and CPU2 sees X==0.
> + * smp_mb__after_spinlock() provides a full memory barrier between po-earlier
> + * lock acquisitions and po-later memory accesses.

How about saying "provides the equivalent of a full memory barrier"?

The point being that smp_mb__after_spinlock doesn't have to provide an
actual barrier; it just has to ensure the behavior is the same as if a
full barrier were present.

Alan

