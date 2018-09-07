Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AAFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4987E2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4987E2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeIGUvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:51:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34212 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbeIGUvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:51:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A084E18A;
        Fri,  7 Sep 2018 09:09:35 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 703F73F5BC;
        Fri,  7 Sep 2018 09:09:35 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 9E4611AE37BD; Fri,  7 Sep 2018 17:09:50 +0100 (BST)
Date:   Fri, 7 Sep 2018 17:09:50 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180907160950.GH12788@arm.com>
References: <20180906093655.GA9653@andrea>
 <Pine.LNX.4.44L0.1809071145260.1547-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809071145260.1547-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:00:19PM -0400, Alan Stern wrote:
> On Thu, 6 Sep 2018, Andrea Parri wrote:
> 
> > > Have you noticed any part of the generic code that relies on ordinary 
> > > acquire-release (rather than atomic RMW acquire-release) in order to 
> > > implement locking constructs?
> > 
> > There are several places in code where the "lock-acquire" seems to be
> > provided by an atomic_cond_read_acquire/smp_cond_load_acquire: I have
> > mentioned one in qspinlock in this thread; qrwlock and mcs_spinlock
> > provide other examples (grep for the primitives...).
> > 
> > As long as we don't consider these primitive as RMW (which would seem
> > odd...) or as acquire for which "most people expect strong ordering"
> > (see above), these provides other examples for the _gap_ I mentioned.
> 
> Okay, now I understand your objection.  It does appear that on RISC-V,
> if nowhere else, the current implementations of qspinlock, qrwlock,
> etc. will not provide "RCtso" ordering.
> 
> The discussions surrounding this topic have been so lengthy and 
> confusing that I have lost track of any comments Palmer or Daniel may 
> have made concerning this potential problem.
> 
> One possible resolution would be to define smp_cond_load_acquire() 
> specially on RISC-V so that it provided the same ordering guarantees as 
> RMW-acquire.  (Plus adding a comment in the asm-generic/barrier.h 
> pointing out the necessity for the stronger guarantee on all 
> architectures.)
> 
> Another would be to replace the usages of atomic/smp_cond_load_acquire 
> in the locking constructs with a new function that would otherwise be 
> the same but would provide the ordering guarantee we want.
> 
> Do you think either of these would be an adequate fix?

I didn't think RISC-V used qspinlock or qrwlock, so I'm not sure there's
actually anything to fix, is there?

Will
