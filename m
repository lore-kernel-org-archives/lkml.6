Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F346EAA899
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248CD208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q/VUDUBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248CD208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeGLSQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:16:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeGLSQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nfspCBSPNkp7AFlPObQwbxQ9nI7MwCFsjprgoBrrrD8=; b=q/VUDUBe7Cz55Qip/EB9UzcGn
        l/5PvJx6q6BxwtdTvnB2SBFIRO7XNVhWApqdBtA0ebDnNB14UtEQeCvg3+tjaoy6PImoBhOqRXwR+
        4m7lKMCtlg31FEqdVCjFyYbAEZ25ZAEHOZamxTPqLEmlkM4ewILdlm63wBvn23/hS9SfUkHvnR6EG
        Y1qvle8bdgLPn1/iorOHzmFp8F5Y5lHFTGF7mlBof0MlCUNfF+bT78FiauAogmFfe7YYtbd8tS5EM
        +Me3xxjqUV10GOT0mteGS7pdV/66MGTQdvOM75nGJ+39w8lHLTapWTeXJg2ba74FgyWWhIDZN7iNt
        E8x6De89w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdfxp-0003eV-Ue; Thu, 12 Jul 2018 18:05:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C85C220289331; Thu, 12 Jul 2018 20:05:11 +0200 (CEST)
Date:   Thu, 12 Jul 2018 20:05:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Message-ID: <20180712180511.GP2476@hirez.programming.kicks-ass.net>
References: <20180712134821.GT2494@hirez.programming.kicks-ass.net>
 <Pine.LNX.4.44L0.1807121236470.1306-100000@iolanthe.rowland.org>
 <20180712172838.GU3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712172838.GU3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 10:28:38AM -0700, Paul E. McKenney wrote:
> Look for the uses of raw_spin_lock_irq_rcu_node() and friends in
> kernel/rcu and include/linux/*rcu*, along with the explanation in
> Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> 
> I must confess that I am not following exactly what Peter is calling
> out as the failure.  My best guess is that he is leading up to his
> call for RCsc locks, but I might have missed a turn.

Yes, it is part of my call for RCsc locks.

The locking pattern is fairly simple and shows where RCpc comes apart
from expectation real nice.

Yes I helped clean up the barrier usage, but as always it'd be even
cleaner if we could just do away with the special barrier entirely.
