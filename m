Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF4DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0120B20661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tOziCXzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfB0KQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:16:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfB0KQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/uPDothb1QoOhyckARGe69xLQ8bY8doHRVyEXjjcuIU=; b=tOziCXzBKe1wCBSXkBm7zoXgo
        N+M334WkHWg80wCad2UPq1gHVEtfg2tJGp0g5+f2L4NkmMIWDfNDDEUGKHHczZ4idQo56E0Ah37Ae
        W4dv9QvXh3pyAc8mFZYJ2nPXGWqBS+hiOVpFI1Q0dTQHE28jmKSEwcC0knrGOzDhN6bczfbCW40te
        0AricRYP7wiglJMujPb/3UEalNXJ3YbP5azC+/moEHJJKhFzGfXen7QBEnXyY2OCKijobaAGydRMU
        o18GZPp31Rj6tJVMVUpcLABNMJy6MHtSd+PtqbK9kD3KulqdFnIQEVNr+kvZzvgrOO/OKt7bbc3tg
        vEnFTOzcw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gywGN-0007RQ-LA; Wed, 27 Feb 2019 10:16:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0084F2852476E; Wed, 27 Feb 2019 11:16:28 +0100 (CET)
Message-Id: <20190227101252.413192716@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 27 Feb 2019 11:12:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, luto@kernel.org, namit@vmware.com,
        peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] x86/percpu semantics and fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a collection of x86/percpu changes that I had pending and got reminded
of by Linus' comment yesterday about __this_cpu_xchg().

This tidies up the x86/percpu primitives and fixes a bunch of 'fallout'.

Built and boot tested with CONFIG_DEBUG_PREEMPT=y.

---
 arch/x86/include/asm/irq_regs.h |   4 +-
 arch/x86/include/asm/percpu.h   | 236 +++++++++++++++++++++-------------------
 arch/x86/include/asm/smp.h      |   3 +-
 arch/x86/mm/tlb.c               |  62 +++++------
 include/linux/smp.h             |  45 +++++---
 kernel/sched/fair.c             |   5 +-
 6 files changed, 193 insertions(+), 162 deletions(-)

