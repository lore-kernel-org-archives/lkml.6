Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DE4FC6170
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98252178D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98252178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbeIMWSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:18:03 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:50342 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727391AbeIMWSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:18:03 -0400
Received: (qmail 1799 invoked by uid 2102); 13 Sep 2018 13:07:39 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Sep 2018 13:07:39 -0400
Date:   Thu, 13 Sep 2018 13:07:39 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc:     Daniel Lustig <dlustig@nvidia.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <mingo@kernel.org>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>, <akiyks@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
In-Reply-To: <20180911200328.GA4225@linux.vnet.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1809131300370.1382-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not having received any responses to the question about usages of RCtso
locks, I have decided to post the newly updated version of the patch
description for commit c8c5779c854f ("tools/memory-model: Add extra
ordering for locks and remove it for ordinary release/acquire") in
Paul's LKMM branch.  There are no changes to the patch itself.

Hopefully this includes all the important issues that people have 
raised.  (Admittedly, some parts of the discussion have seemed less 
consequential than others, and some parts I didn't understand at all.)

Alan

-----------------------------------------------------------------------------
More than one kernel developer has expressed the opinion that the LKMM
should enforce ordering of writes by locking.  In other words, given
the following code:

	WRITE_ONCE(x, 1);
	spin_unlock(&s):
	spin_lock(&s);
	WRITE_ONCE(y, 1);

the stores to x and y should be propagated in order to all other CPUs,
even though those other CPUs might not access the lock s.  In terms of
the memory model, this means expanding the cumul-fence relation.

Locks should also provide read-read (and read-write) ordering in a
similar way.  Given:

	READ_ONCE(x);
	spin_unlock(&s);
	spin_lock(&s);
	READ_ONCE(y);		// or WRITE_ONCE(y, 1);

the load of x should be executed before the load of (or store to) y.
The LKMM already provides this ordering, but it provides it even in
the case where the two accesses are separated by a release/acquire
pair of fences rather than unlock/lock.  This would prevent
architectures from using weakly ordered implementations of release and
acquire, which seems like an unnecessary restriction.  The patch
therefore removes the ordering requirement from the LKMM for that
case.

There are several arguments both for and against this change.  Let us
refer to these enhanced ordering properties by saying that the LKMM
would require locks to be RCtso (a bit of a misnomer, but analogous to
RCpc and RCsc) and it would require ordinary acquire/release only to
be RCpc.  (Note: In the following, the phrase "all supported
architectures" does not include RISC-V, which is still somewhat in
a state of flux.)

Pros:

	The kernel already provides RCtso ordering for locks on all
	supported architectures, even though this is not stated
	explicitly anywhere.  Therefore the LKMM should formalize it.

	In theory, guaranteeing RCtso ordering would reduce the need
	for additional barrier-like constructs meant to increase the
	ordering strength of locks.

	Will Deacon and Peter Zijlstra are strongly in favor of
	formalizing the RCtso requirement.  Linus Torvalds and Will
	would like to go even further, requiring locks to have RCsc
	behavior (ordering preceding writes against later reads), but
	they recognize that this would incur a noticeable performance
	degradation on the POWER architecture.  Linus also points out
	that people have made the mistake, in the past, of assuming
	that locking has stronger ordering properties than is
	currently guaranteed, and this change would reduce the
	likelihood of such mistakes.

Cons:

	Andrea Parri and Luc Maranget feel that locks should have the
	same ordering properties as ordinary acquire/release (indeed,
	Luc points out that the names "acquire" and "release" derive
	from the usage of locks) and that having different ordering
	properties for different forms of acquires and releases would
	be confusing and unmaintainable.  Will and Linus, on the other
	hand, feel that architectures should be free to implement
	ordinary acquire/release using relatively weak RCpc machine
	instructions.  Linus points out that locks should be easy for
	people to use without worrying about memory consistency
	issues, since they are so pervasive in the kernel, whereas
	acquire/release is much more of an "expertss only" tool.

	Locks are constructed from lower-level primitives, typically
	RMW-acquire (for locking) and ordinary release (for unlock).
	It is illogical to require stronger ordering properties from
	the high-level operations than from the low-level operations
	they comprise.  Thus, this change would make

		while (cmpxchg_acquire(&s, 0, 1) != 0)
			cpu_relax();

	an incorrect implementation of spin_lock(&s).  In theory this
	weakness can be ameliorated by changing the LKMM even further,
	requiring RMW-acquire/release also to be RCtso (which it
	already is on all supported architectures).

	As far as I know, nobody has singled out any examples of code
	in the kernel that actually relies on locks being RCtso.
	(People mumble about RCU and the scheduler, but nobody has
	pointed to any actual code.  If there are any real cases,
	their number is likely quite small.)  If RCtso ordering is not
	needed, why require it?

	A handful of locking constructs (qspinlocks, qrwlocks, and
	mcs_spinlocks) are built on top of smp_cond_load_acquire()
	instead of an RMW-acquire instruction.  It currently provides
	only the ordinary acquire semantics, not the stronger ordering
	this patch would require of locks.  In theory this could be
	ameliorated by requiring smp_cond_load_acquire() in
	combination with ordinary release also to be RCtso (which is
	currently true in all supported architectures).

	On future weakly ordered architectures, people may be able to
	implement locks in a non-RCtso fashion with significant
	performance improvement.  Meeting the RCtso requirement would
	necessarily add run-time overhead.

Overall, the technical aspects of these arguments seem relatively
minor, and it appears mostly to boil down to a matter of opinion.
Since the opinions of long-time kernel developers such as Linus,
Peter, and Will carry more weight than those of Luc and Andrea, this
patch changes the model in accordance with the developers' wishes.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

v.4: Added pros and cons discussion to the Changelog.

v.3: Rebased against the dev branch of Paul's linux-rcu tree.
Changed unlock-rf-lock-po to po-unlock-rf-lock-po, making it more
symmetrical and more in accordance with the use of fence.tso for
the release on RISC-V.

v.2: Restrict the ordering to lock operations, not general release
and acquire fences.

