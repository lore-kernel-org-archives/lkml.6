Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9345AFC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5DC20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5DC20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeINWLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:11:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36614 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeINWLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:11:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23C26ED1;
        Fri, 14 Sep 2018 09:56:31 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8BF53F557;
        Fri, 14 Sep 2018 09:56:30 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 87C821AE2F82; Fri, 14 Sep 2018 17:56:48 +0100 (BST)
Date:   Fri, 14 Sep 2018 17:56:48 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com, David Miller <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: Re: [RFC][PATCH 04/11] asm-generic/tlb: Provide generic VIPT cache
 flush
Message-ID: <20180914165648.GI6236@arm.com>
References: <20180913092110.817204997@infradead.org>
 <20180913092812.071989585@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913092812.071989585@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:21:14AM +0200, Peter Zijlstra wrote:
> The one obvious thing SH and ARM want is a sensible default for
> tlb_start_vma(). (also: https://lkml.org/lkml/2004/1/15/6 )
> 
> Avoid all VIPT architectures providing their own tlb_start_vma()
> implementation and rely on architectures to provide a no-op
> flush_cache_range() when it is not relevant.
> 
> The below makes tlb_start_vma() default to flush_cache_range(), which
> should be right and sufficient. The only exceptions that I found where
> (oddly):
> 
>   - m68k-mmu
>   - sparc64
>   - unicore
> 
> Those architectures appear to have flush_cache_range(), but their
> current tlb_start_vma() does not call it.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arc/include/asm/tlb.h      |    9 ---------
>  arch/mips/include/asm/tlb.h     |    9 ---------
>  arch/nds32/include/asm/tlb.h    |    6 ------
>  arch/nios2/include/asm/tlb.h    |   10 ----------
>  arch/parisc/include/asm/tlb.h   |    5 -----
>  arch/sparc/include/asm/tlb_32.h |    5 -----
>  arch/xtensa/include/asm/tlb.h   |    9 ---------
>  include/asm-generic/tlb.h       |   19 +++++++++++--------
>  8 files changed, 11 insertions(+), 61 deletions(-)

LGTM and makes no difference to arm/arm64:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
