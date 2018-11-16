Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B5EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5B22086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 15:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5B22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeKQBr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 20:47:26 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34450 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728169AbeKQBrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 20:47:25 -0500
Received: (qmail 1692 invoked by uid 2102); 16 Nov 2018 10:34:34 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Nov 2018 10:34:34 -0500
Date:   Fri, 16 Nov 2018 10:34:34 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tools/memory-model: Add SRCU support
In-Reply-To: <20181116064310.GU4170@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1811161029550.1487-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018, Paul E. McKenney wrote:

> On Thu, Nov 15, 2018 at 11:19:24AM -0500, Alan Stern wrote:
> > Paul and other LKMM maintainers:
> > 
> > The following series of patches adds support for SRCU to the Linux
> > Kernel Memory Model.  That is, it adds the srcu_read_lock(),
> > srcu_read_unlock(), and synchronize_srcu() primitives to the model.
> > 
> > 	Patch 1/3 does some renaming of the RCU parts of the
> > 	memory model's existing CAT code, to help distinguish them
> > 	from the upcoming SRCU parts.
> > 
> > 	Patch 2/3 refactors the definitions of some RCU relations
> > 	in the CAT code, in a way that the SRCU portions will need.
> > 
> > 	Patch 3/3 actually adds the SRCU support.
> > 
> > This new code requires herd7 version 7.51+4(dev) or later (now 
> > available in the herdtools7 github repository) to run.  Thanks to Luc 
> > for making the necessary changes to support SRCU.
> 
> These patches pass the tests that I have constructed, and also regression
> tests, very nice!  Applied and pushed, thank you.
> 
> > The code does not check that the index argument passed to 
> > srcu_read_unlock() is the same as the value returned by the 
> > corresponding srcu_read_lock() call.  This is deemed to be a semantic 
> > issue, not directly relevant to the memory model.
> 
> Agreed.
> 
> If I understand correctly, there are in theory some use cases that these
> patches do not support, for example:
> 
> 	r1 = srcu_read_lock(a);
> 	do_1();
> 	r2 = srcu_read_lock(a);
> 	do_2();
> 	srcu_read_unlock(a, r1);
> 	do_3();
> 	srcu_read_unlock(a, r2);

Yes, this sort of thing will be misinterpreted as two nested critical 
sections rather than two overlapping critical sections.

> In practice, I would be more worried about this had I ever managed to
> find a non-bogus use case for this pattern.  ;-)

The example is also a little difficult for humans to follow, at least 
without an explanatory comment.

Alan

