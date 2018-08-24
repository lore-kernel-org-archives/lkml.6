Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A75AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2489B2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lPokPJJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2489B2157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeHXLkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:40:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37780 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeHXLkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1JC1bHQwi3+STKMp9adRARK5a5M6z6krhH+ulzlImns=; b=lPokPJJwL6ZyM3vw4TPdnmX55
        e7c4VglCXxgTNKspWhtGHhSqid1mr6m5kZehR0OYGZz8hTEvFF4oAazTfWjuFo5rppzvCHFGbisQi
        V2HM8aNf07zJ/MkN2Yr5PiD6hxf5MGhNr+DfrcvpOaPDcLtMQt3mXXsMHGtyAuf79uuc1H1Tnagnb
        tkxwe80N5/wG8aWpG8/plznoPn3UjWr5B9F8gN+8700j2FIkooJmqXZjOjGj9SDevdKIrydkWynUX
        PIe0ffNFohGYe2JJSZwqJgyuxZryQn07AjR47buWveSMHACE/EmyL5GGRhBE/7d9BJYiTkvaUxbcU
        tJVgpxv3Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ft76P-0006uz-Ot; Fri, 24 Aug 2018 08:05:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E259202E65E0; Fri, 24 Aug 2018 10:05:48 +0200 (CEST)
Date:   Fri, 24 Aug 2018 10:05:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Piggin <npiggin@gmail.com>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] minor mmu_gather patches
Message-ID: <20180824080548.GH24124@hirez.programming.kicks-ass.net>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxaiv3SMvFUSEnd_p6nuGttUnv2_O3v_G2zCnnc0pV2pA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 12:15:37PM -0700, Linus Torvalds wrote:
> PeterZ - your "mm/tlb, x86/mm: Support invalidating TLB caches for
> RCU_TABLE_FREE" patch looks exactly the same, but it now no longer has
> the split of tlb_flush_mmu_tlbonly(), since with Nick's patch to move
> the call to tlb_table_flush(tlb) into tlb_flush_mmu_free, there's no
> need for the separate double-underscore version.
> 
> I hope nothing I did screwed things up. It all looks sane to me.
> Famous last words.

Sorry; I got distracted by building a bunk bed for the kids -- and
somehow these things always take way more time than expected.

Anyway, the code looks good to me. Thanks all!
