Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCB7C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFA120658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3lm8Nkx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFA120658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeH3VPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:15:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38328 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbeH3VPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZNJO3T/h5b5qb8DXsewbIDkrzIy/b13sBwUmvblin9Q=; b=3lm8Nkx3cIk5fyb47+RTPcF5I
        zcXqJF+IWsnhUTiClBWROsWamGJTKTvxSU3oUkq9WrwQ4eJdVmve7aDPwseWqKBM9AV3ZVjMF8BuL
        emNzHWciSZs5e30WJ51CwQVfifEAUx+d27K+yTtzHT0pBt5ECk7X5JsRjXet0As0i/7CsrRA/91r1
        irQ/W37jjewuJdRiGJ/QatuUwypkeSPaR2p8pA7lneuyge/qP0fWvBhMbNySRs+Tj8xGuPDAWxdCw
        vQYgVgjpp7wRFDadNkEd+n1ns7hTY9IDXeX/Z1y2z09Ke5hbpx9dFpy/1skF9/scrrtJVfFOwt/U2
        pMLzFIa7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvQU3-0001xp-N0; Thu, 30 Aug 2018 17:11:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E0BB2024EB08; Thu, 30 Aug 2018 19:11:47 +0200 (CEST)
Date:   Thu, 30 Aug 2018 19:11:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/12] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
Message-ID: <20180830171147.GP24082@hirez.programming.kicks-ass.net>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 05:15:34PM +0100, Will Deacon wrote:
> Peter Zijlstra (1):
>   asm-generic/tlb: Track freeing of page-table directories in struct
>     mmu_gather
> 
> Will Deacon (11):
>   arm64: tlb: Use last-level invalidation in flush_tlb_kernel_range()
>   arm64: tlb: Add DSB ISHST prior to TLBI in
>     __flush_tlb_[kernel_]pgtable()
>   arm64: pgtable: Implement p[mu]d_valid() and check in set_p[mu]d()
>   arm64: tlb: Justify non-leaf invalidation in flush_tlb_range()
>   arm64: tlbflush: Allow stride to be specified for __flush_tlb_range()
>   arm64: tlb: Remove redundant !CONFIG_HAVE_RCU_TABLE_FREE code
>   asm-generic/tlb: Guard with #ifdef CONFIG_MMU
>   asm-generic/tlb: Track which levels of the page tables have been
>     cleared
>   arm64: tlb: Adjust stride and type of TLBI according to mmu_gather
>   arm64: tlb: Avoid synchronous TLBIs when freeing page tables
>   arm64: tlb: Rewrite stale comment in asm/tlbflush.h
> 
>  arch/arm64/Kconfig                |   1 +
>  arch/arm64/include/asm/pgtable.h  |  10 +++-
>  arch/arm64/include/asm/tlb.h      |  34 +++++-------
>  arch/arm64/include/asm/tlbflush.h | 112 ++++++++++++++++++++++++--------------
>  include/asm-generic/tlb.h         |  85 +++++++++++++++++++++++++----
>  mm/memory.c                       |   4 +-
>  6 files changed, 168 insertions(+), 78 deletions(-)

These patches look good to me, thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
