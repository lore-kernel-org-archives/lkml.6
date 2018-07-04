Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF55EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B44D21532
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B44D21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934235AbeGDLwx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:52:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36174 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933269AbeGDLww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:52:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FBD718A;
        Wed,  4 Jul 2018 04:52:52 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1005A3F5AD;
        Wed,  4 Jul 2018 04:52:52 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id F20401AE189D; Wed,  4 Jul 2018 12:53:31 +0100 (BST)
Date:   Wed, 4 Jul 2018 12:53:31 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180704115331.GA26941@arm.com>
References: <20180622183007.GD1802@arm.com>
 <Pine.LNX.4.44L0.1806221458480.1454-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1806221458480.1454-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Fri, Jun 22, 2018 at 03:11:37PM -0400, Alan Stern wrote:
> On Fri, 22 Jun 2018, Will Deacon wrote:
> > On Fri, Jun 22, 2018 at 02:09:04PM -0400, Alan Stern wrote:
> > > On Fri, 22 Jun 2018, Will Deacon wrote:
> > > > Could we drop the acquire/release stuff from the patch and limit this change
> > > > to locking instead?
> > > 
> > > The LKMM uses the same CAT code for acquire/release and lock/unlock.  
> > > (In essence, it considers a lock to be an acquire and an unlock to be a
> > > release; everything else follows from that.)  Treating one differently
> > > from the other in these tests would require some significant changes.
> > > It wouldn't be easy.
> > 
> > It would be boring if it was easy ;) I think this is a case of the tail
> > wagging the dog.
> > 
> > Paul -- please can you drop this patch until we've resolved this discussion?
> 
> Agreed.  It sounds like we'll need two versions of the Rel and Acq sets
> in the memory model; one for RCpc and one for RCsc.  smp_load_acquire
> and smp_store_release will use the former, and locking will use the
> latter.
> 
> Would it suffice to have this duplication just for release, using a
> single version of acquire?  What would happen on ARMv8 or RISC-V if an
> RCsc release was read by an RCpc acquire?  Or vice versa?

On Arm, RCsc release can forward to an RCpc acquire. We don't have an RCpc
release instruction.

Will
