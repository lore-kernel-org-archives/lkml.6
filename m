Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1EAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C6521523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 14:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n0ywQZz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C6521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbeHXRw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:52:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbeHXRwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vn2Bqi4GG9KMF7nFNidt/f60bbuDI8qY8gVrl8Bv9Aw=; b=n0ywQZz1hNZYyiCfiOOmv6Dwi
        hAaEYm6uPtUL6CAtBPa0SUxbFR48W8vQCXMxsRN5cvv9E6xp0miyz6h0qeIE8hDRbjUqOr52lPmVJ
        oQq2hTL4fh+TK/LANhvYHbrAwQgtYiTffyGE4GN01ZqtCzLcMbQpoC8VGlrCEqgRLrz08eX8VjkIM
        7DAa79MK+AEjm+Y856ng/xT5xIqXGwbmcDT2WgTwkCKNwyVb1kNxbIfTl3H+3lLP5YDFHl4gs9glb
        R2XKwy9vo4+9rxfpDbmZQmwkMUNrm9eG9l2cWb85uIVx0LnlIWLSWMYjXamWHtdiM3PNWLIQV90Xm
        ZTe6UZ1Tw==;
Received: from [24.132.217.100] (helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftBxs-0006Ds-KN; Fri, 24 Aug 2018 13:18:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D740D2024C922; Fri, 24 Aug 2018 15:14:40 +0200 (CEST)
Date:   Fri, 24 Aug 2018 15:14:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
Message-ID: <20180824131440.GN24142@hirez.programming.kicks-ass.net>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.823850812@infradead.org>
 <20180822155527.GF24124@hirez.programming.kicks-ass.net>
 <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
 <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
 <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
 <20180824083556.GI24124@hirez.programming.kicks-ass.net>
 <20180824131332.GM24142@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824131332.GM24142@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 03:13:32PM +0200, Peter Zijlstra wrote:
> + *  HAVE_RCU_TABLE_FREE
> + *
> + *  This provides tlb_remove_table(), to be used instead of tlb_remove_page()
> + *  for page directores (__p*_free_tlb()). This provides separate freeing of
> + *  the page-table pages themselves in a semi-RCU fashion (see comment below).
> + *  Useful if your architecture doesn't use IPIs for remote TLB invalidates
> + *  and therefore doesn't naturally serialize with software page-table walkers.
> + *
> + *  HAVE_RCU_TABLE_INVALIDATE
> + *
> + *  This makes HAVE_RCU_TABLE_FREE call tlb_flush_mmu_tlbonly() before freeing
> + *  the page-table pages. Required if you use HAVE_RCU_TABLE_FREE and your
> + *  architecture uses the Linux page-tables natively.

Writing that also made me think we maybe should've negated that option.

