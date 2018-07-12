Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFDC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEC020C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eBnuJkkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEC020C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeGLJnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:43:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeGLJnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K9kHwCrkZuarUV9PLn+jwerAcV8U/pvZCk4ekwKm6D0=; b=eBnuJkkhwnN/qR4Mho72aN9xX
        INr6LoJIH5nhOrYL/t033OrA3ZrFfEUhBW4NXB3yVSFJhYEbbM8YaMGXTuVaZyBXbHQdeVRer8CEX
        80DGygTCDfRK2sXt5q05Wy0256SxQuUuWXp/gL2bR+DM+XDYN55A8JRqRCqqn08dY3MFGo9EErCbn
        HVEXoFiovh/SpwLOiXG20Nsky23Qe2gRY+ghKWxN6yW7EfxlogGPKYwp6tMyU1SxuV29NFurcEbwd
        PpTtD7HURaI59VrY5d2TRHUbvQSSkTruhxMmOZ5E1xs+RtWe1cEwljz+tMJuzPfYbkkZQNuFRJDja
        GpIS+KfFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdXzd-00068B-W5; Thu, 12 Jul 2018 09:34:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 232A820291063; Thu, 12 Jul 2018 11:34:32 +0200 (CEST)
Date:   Thu, 12 Jul 2018 11:34:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20180712093432.GV2512@hirez.programming.kicks-ass.net>
References: <Pine.LNX.4.44L0.1807091519180.2462-100000@iolanthe.rowland.org>
 <20180710093821.GA5414@andrea>
 <20180711094310.GA13963@arm.com>
 <20180711123421.GA9673@andrea>
 <20180712074040.GA4920@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712074040.GA4920@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 09:40:40AM +0200, Peter Zijlstra wrote:
> And I think if we raise atomic*_acquire() to require TSO (but ideally
> raise it to RCsc) we're there.

To clarify, just the RmW-acquire. Things like atomic_read_acquire() can
stay smp_load_acquire() and be RCpc.
