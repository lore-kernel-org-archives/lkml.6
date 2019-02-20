Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2380DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E528A21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VRW7HE8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfBTJ0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:26:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBTJ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ock4JVsJZ6WdESJ6Y69BtgqON8D202BnUx8NsMEef2k=; b=VRW7HE8AQh+c2xjtoZj0BcwDe
        gF+YaushMZJECBkLsbAiiEjehYyZ8KTzDtcdx3HSmetf1+6rg16YgDa5zXC8gOPHvEu+g50FoPjpQ
        SUj5MJEKluwfzBdiApI6M0ePymOIqXRDHCXlVW5QJN6Vmqo3KamYThSzQlqxc/gmN5x8xFMY84BDE
        eqo0/KqX3ZGw2NDrx7rGtrDd22Mgkb7E2utsNqvYooMPwuMP+dqFBJ4dqaQfJa76bJdMowk3om+84
        XhzfyUmSZvhvuhXhdkcCAT2XC0vZKmx0AL6127gJokVbsOcCzm9AH/C93gQlUxZMNWjNR8nKd+YGA
        UAbBzJNBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwO8k-0005lG-ES; Wed, 20 Feb 2019 09:26:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFF7228B675A0; Wed, 20 Feb 2019 10:26:04 +0100 (CET)
Date:   Wed, 20 Feb 2019 10:26:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190220092604.GD32494@hirez.programming.kicks-ass.net>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220020117.GD11787@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 06:01:17PM -0800, Paul E. McKenney wrote:
> On Tue, Feb 19, 2019 at 11:57:37PM +0100, Andrea Parri wrote:
> > Remove this subtle (and, AFAICT, unused) ordering: we can add it back,
> > if necessary, but let us not encourage people to rely on this thing.
> > 
> > For example, the following "exists" clause can be satisfied with this
> > change:
> > 
> > C dep-rfi
> > 
> > { }
> > 
> > P0(int *x, int *y)
> > {
> > 	WRITE_ONCE(*x, 1);
> > 	smp_store_release(y, 1);
> > }
> > 
> > P1(int *x, int *y, int *z)
> > {
> > 	int r0;
> > 	int r1;
> > 	int r2;
> > 
> > 	r0 = READ_ONCE(*y);
> > 	WRITE_ONCE(*z, r0);
> > 	r1 = smp_load_acquire(z);
> > 	r2 = READ_ONCE(*x);
> > }
> > 
> > exists (1:r0=1 /\ 1:r2=0)
> 
> Any objections?  If I don't hear any in a couple days, I will apply this.

IIUC you cannot build hardware that allows the above, so why would we
allow it?
