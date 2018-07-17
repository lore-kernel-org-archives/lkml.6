Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869CBECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3042220C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aFTs6OZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3042220C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbeGQMTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:19:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40264 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbeGQMTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AokKbi9g2IwII5/rkW0akHHOVhjABwC9CgfOqBM5VAE=; b=aFTs6OZOTgJ0pTBbCgkIrfcdB
        1YZzFdQfdYx0UFiCBIlgccut08bS/f9VJVZ7c/PGabR8U/Y2/+yZCuPMoTV7gfogbttLLJsgLg7H6
        6nAb/fxA1JUfUTr5XA0aHqhKdexehonvxb5w/cjmt8f7OGMBljl6+VnwvFxSjDuIjCIW8ZymUYuec
        z5AWY9vKTNXDyjyQ8BmrgARRulXOb1VA8gakfV/gLuHfMyyf6f/0Up+QvEnrL+3IRHDdBgztnuvqc
        YN75yQOy2fJR+QGJPFXbJzptzHmUenRnXnB/Uaq58QNgWXneOsPeQTYKMCoMmRdkQCF3i9gYOPbYA
        pC7JIEBZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffORM-0008SY-Us; Tue, 17 Jul 2018 11:46:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA6B520275F36; Tue, 17 Jul 2018 13:46:47 +0200 (CEST)
Date:   Tue, 17 Jul 2018 13:46:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org, songliubraving@fb.com,
        torvalds@linux-foundation.org, riel@surriel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/mm] x86/mm/tlb: Leave lazy TLB mode at page table free
 time
Message-ID: <20180717114647.GW2476@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-3-riel@surriel.com>
 <tip-2ff6ddf19c0ec40633bd14d8fe28a289816bd98d@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-2ff6ddf19c0ec40633bd14d8fe28a289816bd98d@git.kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 02:34:07AM -0700, tip-bot for Rik van Riel wrote:
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 3063125197ad..e811ef7b8350 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -303,4 +303,14 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
>  
>  #define tlb_migrate_finish(mm) do {} while (0)
>  
> +/*
> + * Used to flush the TLB when page tables are removed, when lazy
> + * TLB mode may cause a CPU to retain intermediate translations
> + * pointing to about-to-be-freed page table memory.
> + */
> +#ifndef HAVE_TLB_FLUSH_REMOVE_TABLES
> +#define tlb_flush_remove_tables(mm) do {} while (0)
> +#define tlb_flush_remove_tables_local(mm) do {} while (0)
> +#endif

Is there a reason these are not inline functions, which gets us type
checking and the like?
