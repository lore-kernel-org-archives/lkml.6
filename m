Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34955ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D937C208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 19:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uA/z4DbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D937C208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeGPTa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:30:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56648 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbeGPTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=czifFcJx/CQBYKZTBidg5tH9DBcaKhBxu6yQ6nWtT88=; b=uA/z4DbKEHQbd0pbkGS15Nadi
        dTp/sfq2dREuRFKz9Je5/uc/QGkwAhHwpKdp2A/KwvKf24QVlJXHUcrPcrJb93UeRT9ucpAwIxf/C
        RykpdO77+FAl9swhWUSMK0lEgDET5RI7nnuNS/BcTIU64IUA7YsiYzfIBrJxqb9SaCJTeK/Zwx/Lu
        xDrzkphPP4ciA6u+fTvmh9BuE9Urldx69nj9Gy8PAlVqzFgbM0LmOsmRa4HGKSfOCLNFhNTo4fBhu
        mmnWfrxILfG2xF4bwixHVEruQIsFdA8sK7ELr+VJtGXSqU/tYYptuBel62Mg1FxmmVK58JzXIvaCh
        GfJ6vmwDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ff8ki-00048C-8R; Mon, 16 Jul 2018 19:01:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9091920289330; Mon, 16 Jul 2018 21:01:39 +0200 (CEST)
Date:   Mon, 16 Jul 2018 21:01:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180716190139.GR2476@hirez.programming.kicks-ass.net>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com>
 <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180713110851.GY2494@hirez.programming.kicks-ass.net>
 <87tvp3xonl.fsf@concordia.ellerman.id.au>
 <20180713164239.GZ2494@hirez.programming.kicks-ass.net>
 <87601fz1kc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87601fz1kc.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:40:19AM +1000, Michael Ellerman wrote:
> 
> I guess arguably it's not a very macro benchmark, but we have a
> context_switch benchmark in the tree[1] which we often use to tune
> things, and it degrades badly. It just spins up two threads and has them
> ping-pong using yield.

The one advantage you'd get from putting it in lock() is that you could
do away with smp_mb__after_spinlock().

But yes, I completely forgot about your IO thingy.. those bench results
make me sad :/ a well.
