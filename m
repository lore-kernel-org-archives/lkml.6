Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E81C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11CE72083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CE72083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbeGKJqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:46:31 -0400
Received: from foss.arm.com ([217.140.101.70]:60358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbeGKJqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:46:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AE78ED1;
        Wed, 11 Jul 2018 02:43:03 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D05D3F318;
        Wed, 11 Jul 2018 02:43:03 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 53DCA1AE3828; Wed, 11 Jul 2018 10:43:45 +0100 (BST)
Date:   Wed, 11 Jul 2018 10:43:45 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180711094344.GE13963@arm.com>
References: <20180710162555.GV3593@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1807101416390.1449-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807101416390.1449-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, Jul 10, 2018 at 02:18:13PM -0400, Alan Stern wrote:
> More than one kernel developer has expressed the opinion that the LKMM
> should enforce ordering of writes by locking.  In other words, given
> the following code:
> 
> 	WRITE_ONCE(x, 1);
> 	spin_unlock(&s):
> 	spin_lock(&s);
> 	WRITE_ONCE(y, 1);
> 
> the stores to x and y should be propagated in order to all other CPUs,
> even though those other CPUs might not access the lock s.  In terms of
> the memory model, this means expanding the cumul-fence relation.
> 
> Locks should also provide read-read (and read-write) ordering in a
> similar way.  Given:
> 
> 	READ_ONCE(x);
> 	spin_unlock(&s);
> 	spin_lock(&s);
> 	READ_ONCE(y);		// or WRITE_ONCE(y, 1);
> 
> the load of x should be executed before the load of (or store to) y.
> The LKMM already provides this ordering, but it provides it even in
> the case where the two accesses are separated by a release/acquire
> pair of fences rather than unlock/lock.  This would prevent
> architectures from using weakly ordered implementations of release and
> acquire, which seems like an unnecessary restriction.  The patch
> therefore removes the ordering requirement from the LKMM for that
> case.
> 
> All the architectures supported by the Linux kernel (including RISC-V)
> do provide this ordering for locks, albeit for varying reasons.
> Therefore this patch changes the model in accordance with the
> developers' wishes.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Thanks, I'm happy with this version of the patch:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
