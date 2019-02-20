Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931E7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5FE2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfBTJ5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:57:11 -0500
Received: from foss.arm.com ([217.140.101.70]:54978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfBTJ5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:57:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF29A78;
        Wed, 20 Feb 2019 01:57:08 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E9A43F575;
        Wed, 20 Feb 2019 01:57:05 -0800 (PST)
Date:   Wed, 20 Feb 2019 09:57:00 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190220095659.GA17578@brain-police>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220092604.GD32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:26:04AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 19, 2019 at 06:01:17PM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 19, 2019 at 11:57:37PM +0100, Andrea Parri wrote:
> > > Remove this subtle (and, AFAICT, unused) ordering: we can add it back,
> > > if necessary, but let us not encourage people to rely on this thing.
> > > 
> > > For example, the following "exists" clause can be satisfied with this
> > > change:
> > > 
> > > C dep-rfi
> > > 
> > > { }
> > > 
> > > P0(int *x, int *y)
> > > {
> > > 	WRITE_ONCE(*x, 1);
> > > 	smp_store_release(y, 1);
> > > }
> > > 
> > > P1(int *x, int *y, int *z)
> > > {
> > > 	int r0;
> > > 	int r1;
> > > 	int r2;
> > > 
> > > 	r0 = READ_ONCE(*y);
> > > 	WRITE_ONCE(*z, r0);
> > > 	r1 = smp_load_acquire(z);
> > > 	r2 = READ_ONCE(*x);
> > > }
> > > 
> > > exists (1:r0=1 /\ 1:r2=0)
> > 
> > Any objections?  If I don't hear any in a couple days, I will apply this.
> 
> IIUC you cannot build hardware that allows the above, so why would we
> allow it?

Agreed. Maybe the intention was to make the dependency between the read of
*y and the write of *z on P1 a control dependency instead? That's certainly
allowed on arm64.

Will
