Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F221BC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFFD2183F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfBSMrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:47:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44872 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfBSMrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:47:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 490F615AB;
        Tue, 19 Feb 2019 04:47:42 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C23B3F720;
        Tue, 19 Feb 2019 04:47:40 -0800 (PST)
Date:   Tue, 19 Feb 2019 12:47:38 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        heiko.carstens@de.ibm.com, riel@surriel.com
Subject: Re: [PATCH v6 06/18] asm-generic/tlb: Conditionally provide
 tlb_migrate_finish()
Message-ID: <20190219124738.GD8501@fuggles.cambridge.arm.com>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.207580251@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219103233.207580251@infradead.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 11:31:54AM +0100, Peter Zijlstra wrote:
> Needed for ia64 -- alternatively we drop the entire hook.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/asm-generic/tlb.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -539,6 +539,8 @@ static inline void tlb_end_vma(struct mm
>  
>  #endif /* CONFIG_MMU */
>  
> +#ifndef tlb_migrate_finish
>  #define tlb_migrate_finish(mm) do {} while (0)
> +#endif

Fine for now, but I agree that we should drop the hook altogether. AFAICT,
this only exists to help an ia64 optimisation which looks suspicious to
me since it uses:

    mm == current->active_mm && atomic_read(&mm->mm_users) == 1

to identify a "single-threaded fork()" and therefore perform only local TLB
invalidation. Even if this was the right thing to do, it's not clear to me
that tlb_migrate_finish() is called on the right CPU anyway.

So I'd be keen to remove this hook before it spreads, but in the meantime:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
