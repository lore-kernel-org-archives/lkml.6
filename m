Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB105C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903E420C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aMMBqbFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903E420C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388648AbeGKRG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:06:28 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55548 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeGKRG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u3ddxNs9NdvaDqomWC07aM/o1rUlf2A9SwOsqRd5acI=; b=aMMBqbFFjzRw3UPwzIsayYlxV
        68CCeZQaIPqLebyXIjX9kKRgB5jFjEvpp4/vUDnDeDzhchrbrKPL6GGB/r7mnNb8B/1Qce364JSZm
        j3Ou34wIB4X/x32m5zgfA5gqGk6EPQfJWDcu2DoZEqlg/JkMeDP6xB8LghpNHH83M6V8kJ3T/FJsW
        3oBoX1VdP8+GjEo4yy6yTbfCb6aI2sOj6ldbzx3fX92ZRqwe9YFelrZ8mFsCr341QylUQqrFP6oOv
        Dd2P30DpgcGci7UeR8DrYoJIDEm5EVmzmSJDmElnw9ShLSz0x+Slhyt4siR9cut5bI0Ssnem58Djv
        riUBPRiTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdIU3-0004xT-MO; Wed, 11 Jul 2018 17:00:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B6EA20289CB4; Wed, 11 Jul 2018 19:00:53 +0200 (CEST)
Date:   Wed, 11 Jul 2018 19:00:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180711170053.GM2476@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
 <20180711155751.GC18477@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711155751.GC18477@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:57:51PM +0100, Will Deacon wrote:

> It might be simple to model, but I worry this weakens our locking
> implementations to a point where they will not be understood by the average
> kernel developer. As I've said before, I would prefer "full" RCsc locking,

Another vote for RCsc locks. The (in)famous hold-out is of course
PowerPC, but it now looks like RISC-V is following where they I really
rather wish they didn't.

