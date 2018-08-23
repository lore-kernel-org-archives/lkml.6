Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCB9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC63E208FA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC63E208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbeHWRKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:10:31 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46588 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730895AbeHWRKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:10:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ABA1ED1;
        Thu, 23 Aug 2018 06:40:45 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F340A3F675;
        Thu, 23 Aug 2018 06:40:43 -0700 (PDT)
Date:   Thu, 23 Aug 2018 14:40:41 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, riel@surriel.com, jannh@google.com,
        ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nicholas Piggin <npiggin@gmail.com>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/4] mm/tlb: Remove tlb_remove_table() non-concurrent
 condition
Message-ID: <20180823134041.GB1496@brain-police>
References: <20180822153012.173508681@infradead.org>
 <20180822154046.772017055@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822154046.772017055@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 05:30:14PM +0200, Peter Zijlstra wrote:
> Will noted that only checking mm_users is incorrect; we should also
> check mm_count in order to cover CPUs that have a lazy reference to
> this mm (and could do speculative TLB operations).
> 
> If removing this turns out to be a performance issue, we can
> re-instate a more complete check, but in tlb_table_flush() eliding the
> call_rcu_sched().
> 
> Cc: stable@kernel.org
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Fixes: 267239116987 ("mm, powerpc: move the RCU page-table freeing into generic code")
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  mm/memory.c |    9 ---------
>  1 file changed, 9 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
