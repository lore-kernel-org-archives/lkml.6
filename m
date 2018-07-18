Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0C5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5E3206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nMTgoXZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5E3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbeGRQi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:38:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44410 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730986AbeGRQi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9RsJjtjGOQbPAeWqHkmOuAlM10q3JCNK2QLUNQ4zqFw=; b=nMTgoXZ/OgsZa+ZlQ5Ty975K2
        8dOSywdX6NGYpXvhi+v+OcrVsTX7p/X7xToen2HHhaH8aGXu8/+ALrdB2uXwqdHYubuQqzL1CD18d
        xIKbkYi+FmK767ARz+6MFWwBJCT2tw4jy0pnTsSGRY+PE85zJx8KlsYgNrA91Bg7Jj9P8svjpVNpz
        wAl4Mc/rVheKXQuq4mlkF0N3EPkiLFZfNUJOQhoDPNIzu8BzpkXh3PVjwHtPyl0BMx0tdU6rRFjjI
        HBblYXjk26bXGVhhbGyGikKcsea29ne/H32gNxWomr3GnX43Ax9PCXrn8aKchHsIfRok9Btp0qeLz
        HbCTmKf8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffos6-0007Wx-5y; Wed, 18 Jul 2018 16:00:10 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66F5620289330; Wed, 18 Jul 2018 18:00:07 +0200 (CEST)
Date:   Wed, 18 Jul 2018 18:00:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     songliubraving@fb.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, torvalds@linux-foundation.org,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/mm/tlb: Make lazy TLB mode lazier
Message-ID: <20180718160007.GS2494@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-5-riel@surriel.com>
 <tip-ac0315896970d8589291e9d8a1569fc65967b7f1@git.kernel.org>
 <20180717113330.GU2476@hirez.programming.kicks-ass.net>
 <08AC2AF2-17DE-4416-BBBD-B6B950D20906@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08AC2AF2-17DE-4416-BBBD-B6B950D20906@surriel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 11:33:02AM -0400, Rik van Riel wrote:
> The tlb flush code first increments mm->context.tlb_gen, and then sends

> shootdown IPIs to CPUs that have this mm loaded and are not in lazy
> TLB mode.
> 
> At context switch time, we have to ensure that we check the tlb_gen after
> we load the old is_lazy state.
> 
> Maybe something like this?
>  
>                 /*
>                  * Read the tlb_gen to check whether a flush is needed.
>                  * If the TLB is up to date, just use it.
>                  * The TLB shootdown code first increments tlb_gen, and then
>                  * sends IPIs to CPUs that have this CPU loaded and are not
>                  * in lazy TLB mode. The barrier ensures we handle
>                  * cpu_tlbstate.is_lazy before tlb_gen, keeping this code
>                  * synchronized with the TLB flush code.
>                  */

Let me try and draw a diagram; that always works better for me that
text. So the relevant ordering is something like:

  CPU0 - switch_mm()			CPU1 - flush_tlb_mm_range()

  [W]	cpu_tlbstate.is_lazy = false;	[RmW]	next->tlb_gen++
	smp_mb()				MB (implied)
  [R]	tlb_gen = next->tlb_gen			native_flush_tlb_others()
					[R]	  cpu_tlbstate.is_lazy


Such that CPU1 either observes !lazy and flushes and/or CPU0 observes
the generation increment and forces a flush itself.

Either way, CPU0 gets flushed.


Also, I don't suppose you've looked at the paravirt instances of
flush_tlb_other() ? They don't elide the flushes because of lazy.
