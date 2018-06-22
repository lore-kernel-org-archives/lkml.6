Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_REDIR autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90B2C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666FE247B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 19:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666FE247B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934079AbeFVTLj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 15:11:39 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:36426 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1753275AbeFVTLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 15:11:38 -0400
Received: (qmail 5008 invoked by uid 2102); 22 Jun 2018 15:11:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jun 2018 15:11:37 -0400
Date:   Fri, 22 Jun 2018 15:11:37 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Will Deacon <will.deacon@arm.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by release-acquire
 and by locks
In-Reply-To: <20180622183007.GD1802@arm.com>
Message-ID: <Pine.LNX.4.44L0.1806221458480.1454-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Will Deacon wrote:

> Hi Alan,
> 
> On Fri, Jun 22, 2018 at 02:09:04PM -0400, Alan Stern wrote:
> > On Fri, 22 Jun 2018, Will Deacon wrote:
> > > On Thu, Jun 21, 2018 at 01:27:12PM -0400, Alan Stern wrote:
> > > > More than one kernel developer has expressed the opinion that the LKMM
> > > > should enforce ordering of writes by release-acquire chains and by
> > > > locking.  In other words, given the following code:
> > > > 
> > > > 	WRITE_ONCE(x, 1);
> > > > 	spin_unlock(&s):
> > > > 	spin_lock(&s);
> > > > 	WRITE_ONCE(y, 1);
> > > > 
> > > > or the following:
> > > > 
> > > > 	smp_store_release(&x, 1);
> > > > 	r1 = smp_load_acquire(&x);	// r1 = 1
> > > > 	WRITE_ONCE(y, 1);
> > > > 
> > > > the stores to x and y should be propagated in order to all other CPUs,
> > > > even though those other CPUs might not access the lock s or be part of
> > > > the release-acquire chain.  In terms of the memory model, this means
> > > > that rel-rf-acq-po should be part of the cumul-fence relation.
> > > > 
> > > > All the architectures supported by the Linux kernel (including RISC-V)
> > > > do behave this way, albeit for varying reasons.  Therefore this patch
> > > > changes the model in accordance with the developers' wishes.
> > > 
> > > Interesting...
> > > 
> > > I think the second example would preclude us using LDAPR for load-acquire,
> > 
> > What are the semantics of LDAPR?  That instruction isn't included in my
> > year-old copy of the ARMv8.1 manual; the closest it comes is LDAR and
> > LDAXP.
> 
> It's part of 8.3 and is documented in the latest Arm Arm:
> 
> https://static.docs.arm.com/ddi0487/ca/DDI0487C_a_armv8_arm.pdf
> 
> It's also included in the upstream armv8.cat file using the 'Q' set.

I'll have to look at that.

> > > so I'm surprised that RISC-V is ok with this. For example, the first test
> > > below is allowed on arm64.
> > 
> > Does ARMv8 use LDAPR for smp_load_aquire()?  If it doesn't, this is a 
> > moot point.
> 
> I don't think it's a moot point. We want new architectures to implement
> acquire/release efficiently, and it's not unlikely that they will have
> acquire loads that are similar in semantics to LDAPR. This patch prevents
> them from doing so, and it also breaks Power and RISC-V without any clear
> justification for the stronger semantics.
> 
> > > I also think this would break if we used DMB LD to implement load-acquire
> > > (second test below).
> > 
> > Same question.
> 
> Same answer (and RISC-V is a concrete example of an architecture building
> acquire using a load->load+store fence).
> 
> > > So I'm not a big fan of this change, and I'm surprised this works on all
> > > architectures. What's the justification?
> > 
> > For ARMv8, I've been going by something you wrote in an earlier email
> > to the effect that store-release and load-acquire are fully ordered,
> > and therefore a release can never be forwarded to an acquire.  Is that
> > still true?  But evidently it only justifies patch 1 in this series,
> > not patch 2.
> 
> LDAR and STLR are RCsc, so that remains true. arm64 is not broken by this
> patch, but I'm still objecting to the change in semantics.
> 
> > For RISC-V, I've been going by Andrea's and Luc's comments.
> 
> https://is.gd/WhV1xz
> 
> From that state of rmem, you can propagate the writes out of order on
> RISC-V.
> 
> > > > Reading back some of the old threads [1], it seems the direct
> > > > translation of the first into acquire-release would be:
> > > >
> > > >     WRITE_ONCE(x, 1);
> > > >     smp_store_release(&s, 1);
> > > >     r1 = smp_load_acquire(&s);
> > > >     WRITE_ONCE(y, 1);
> > > >
> > > > Which is I think easier to make happen than the second example you give.
> > > 
> > > It's easier, but it will still break on architectures with native support
> > > for RCpc acquire/release.
> > 
> > Again, do we want the kernel to support that?
> 
> Yes, I think we do. That's the most common interpretation of
> acquire/release, it matches what C11 has done and it facilitates
> construction of acquire using a load->load+store fence.
> 
> > For that matter, what would happen if someone were to try using RCpc 
> > semantics for lock/unlock?  Or to put it another way, why do you 
> > contemplate the possibility of RCpc acquire/release but not RCpc 
> > lock/unlock?
> 
> I think lock/unlock is a higher-level abstraction than acquire/release
> and therefore should be simpler to use and easier to reason about.
> acquire/release are building blocks for more complicated synchronisation
> mechanisms and we shouldn't be penalising their implementation without good
> reason.
> 
> > > Could we drop the acquire/release stuff from the patch and limit this change
> > > to locking instead?
> > 
> > The LKMM uses the same CAT code for acquire/release and lock/unlock.  
> > (In essence, it considers a lock to be an acquire and an unlock to be a
> > release; everything else follows from that.)  Treating one differently
> > from the other in these tests would require some significant changes.
> > It wouldn't be easy.
> 
> It would be boring if it was easy ;) I think this is a case of the tail
> wagging the dog.
> 
> Paul -- please can you drop this patch until we've resolved this discussion?

Agreed.  It sounds like we'll need two versions of the Rel and Acq sets
in the memory model; one for RCpc and one for RCsc.  smp_load_acquire
and smp_store_release will use the former, and locking will use the
latter.

Would it suffice to have this duplication just for release, using a
single version of acquire?  What would happen on ARMv8 or RISC-V if an
RCsc release was read by an RCpc acquire?  Or vice versa?

Alan

