Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502D4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FF720652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FF720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeIGUly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 16:41:54 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56528 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726598AbeIGUlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 16:41:53 -0400
Received: (qmail 4424 invoked by uid 2102); 7 Sep 2018 12:00:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Sep 2018 12:00:19 -0400
Date:   Fri, 7 Sep 2018 12:00:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
cc:     Will Deacon <will.deacon@arm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <mingo@kernel.org>,
        <peterz@infradead.org>, <boqun.feng@gmail.com>,
        <npiggin@gmail.com>, <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>, <akiyks@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
In-Reply-To: <20180906093655.GA9653@andrea>
Message-ID: <Pine.LNX.4.44L0.1809071145260.1547-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018, Andrea Parri wrote:

> > Have you noticed any part of the generic code that relies on ordinary 
> > acquire-release (rather than atomic RMW acquire-release) in order to 
> > implement locking constructs?
> 
> There are several places in code where the "lock-acquire" seems to be
> provided by an atomic_cond_read_acquire/smp_cond_load_acquire: I have
> mentioned one in qspinlock in this thread; qrwlock and mcs_spinlock
> provide other examples (grep for the primitives...).
> 
> As long as we don't consider these primitive as RMW (which would seem
> odd...) or as acquire for which "most people expect strong ordering"
> (see above), these provides other examples for the _gap_ I mentioned.

Okay, now I understand your objection.  It does appear that on RISC-V,
if nowhere else, the current implementations of qspinlock, qrwlock,
etc. will not provide "RCtso" ordering.

The discussions surrounding this topic have been so lengthy and 
confusing that I have lost track of any comments Palmer or Daniel may 
have made concerning this potential problem.

One possible resolution would be to define smp_cond_load_acquire() 
specially on RISC-V so that it provided the same ordering guarantees as 
RMW-acquire.  (Plus adding a comment in the asm-generic/barrier.h 
pointing out the necessity for the stronger guarantee on all 
architectures.)

Another would be to replace the usages of atomic/smp_cond_load_acquire 
in the locking constructs with a new function that would otherwise be 
the same but would provide the ordering guarantee we want.

Do you think either of these would be an adequate fix?

Alan

