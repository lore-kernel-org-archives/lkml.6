Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D910C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31B92075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31B92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbeIGSYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:24:47 -0400
Received: from foss.arm.com ([217.140.101.70]:60610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbeIGSYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:24:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8138F7A9;
        Fri,  7 Sep 2018 06:43:45 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 517D83F575;
        Fri,  7 Sep 2018 06:43:45 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 754C11AE37BD; Fri,  7 Sep 2018 14:44:00 +0100 (BST)
Date:   Fri, 7 Sep 2018 14:44:00 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, jannh@google.com, ascannell@google.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] mm: move tlb_table_flush to tlb_flush_mmu_free
Message-ID: <20180907134359.GA12187@arm.com>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-2-npiggin@gmail.com>
 <fa7c625dfbbe103b37bc3ab5ea4b7283fd13b998.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa7c625dfbbe103b37bc3ab5ea4b7283fd13b998.camel@surriel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 04:29:59PM -0400, Rik van Riel wrote:
> On Thu, 2018-08-23 at 18:47 +1000, Nicholas Piggin wrote:
> > There is no need to call this from tlb_flush_mmu_tlbonly, it
> > logically belongs with tlb_flush_mmu_free. This allows some
> > code consolidation with a subsequent fix.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Reviewed-by: Rik van Riel <riel@surriel.com>
> 
> This patch also fixes an infinite recursion bug
> with CONFIG_HAVE_RCU_TABLE_FREE enabled, which
> has this call trace:
> 
> tlb_table_flush
>   -> tlb_table_invalidate
>      -> tlb_flush_mmu_tlbonly
>         -> tlb_table_flush
>            -> ... (infinite recursion)
> 
> This should probably be applied sooner rather than
> later.

It's already in mainline with a cc stable afaict.

Will
