Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D2EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3DB20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3DB20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbeGKRlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:41:37 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43854 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1732860AbeGKRlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:41:37 -0400
Received: (qmail 6754 invoked by uid 2102); 11 Jul 2018 13:36:14 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jul 2018 13:36:14 -0400
Date:   Wed, 11 Jul 2018 13:36:14 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     David Laight <David.Laight@ACULAB.COM>
cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
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
Subject: RE: [PATCH v3] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
In-Reply-To: <3344e7aeb09644758860ac343bd757a1@AcuMS.aculab.com>
Message-ID: <Pine.LNX.4.44L0.1807111333030.1436-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018, David Laight wrote:

> > From: Alan Stern
> > Sent: 10 July 2018 19:18
> > More than one kernel developer has expressed the opinion that the LKMM
> > should enforce ordering of writes by locking. In other words, given
> > the following code:
> >
> > WRITE_ONCE(x, 1);
> > spin_unlock(&s):
> > spin_lock(&s);
> > WRITE_ONCE(y, 1);
> >
> > the stores to x and y should be propagated in order to all other CPUs,
> > even though those other CPUs might not access the lock s. In terms of
> > the memory model, this means expanding the cumul-fence relation.
> 
> The usual 'elephant in the room' is Alpha.
> I don't claim to understand the alpha memory model but it wouldn't
> surprise me if the above is impossible to implement on alpha.

It's not impossible, since Alpha does have a full memory barrier 
instruction (and the implementation uses it).

Alan

