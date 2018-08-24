Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C61BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CAE2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 17:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f7omG2Gt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CAE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeHXVcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 17:32:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49422 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeHXVcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 17:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LoDocgFW2joMI+j7awZAkM7FU25dFjm9lPuzWH8J7gA=; b=f7omG2GtNKmtF/fFUL+6QAjI4
        UFJ357Qolwb8oglnkcFEpW9Ue+t6ziC0Hr0VTKqwRhfo6bFEGAFVgou8XOJhfyDHwvqBoP8S0DTEW
        gD8N0H2TCkOm+kFQNeNMeXp96fIkTfvysTZUCMnQWM/t8qaAJURJe+zHuS7vnXpbtcLlqv60J5FR+
        YIfjcAsYrxslWXUUvDR+YyiG4FkhOZw50HV6qKJP/3v7H3ApPgs31qOL0gYeetXJSWb7v1gQP2+Rb
        IvSeiGomXNxfy+oX3zKdZKXwpHXXq/M7+d0+pjKPjqi8cLCQSKzT8gobBYl/QzT1xz8mMhq2j+J5e
        PQoSU9JXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ftGJg-00047d-AK; Fri, 24 Aug 2018 17:56:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 082372024D706; Fri, 24 Aug 2018 19:56:10 +0200 (CEST)
Date:   Fri, 24 Aug 2018 19:56:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 02/11] arm64: tlb: Add DSB ISHST prior to TLBI in
 __flush_tlb_[kernel_]pgtable()
Message-ID: <20180824175609.GR24124@hirez.programming.kicks-ass.net>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <1535125966-7666-3-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535125966-7666-3-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 04:52:37PM +0100, Will Deacon wrote:
> __flush_tlb_[kernel_]pgtable() rely on set_pXd() having a DSB after
> writing the new table entry and therefore avoid the barrier prior to the
> TLBI instruction.
> 
> In preparation for delaying our walk-cache invalidation on the unmap()
> path, move the DSB into the TLB invalidation routines.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/tlbflush.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 7e2a35424ca4..e257f8655b84 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -213,6 +213,7 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
>  {
>  	unsigned long addr = __TLBI_VADDR(uaddr, ASID(mm));
>  
> +	dsb(ishst);
>  	__tlbi(vae1is, addr);
>  	__tlbi_user(vae1is, addr);
>  	dsb(ish);
> @@ -222,6 +223,7 @@ static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
>  {
>  	unsigned long addr = __TLBI_VADDR(kaddr, 0);
>  
> +	dsb(ishst);
>  	__tlbi(vaae1is, addr);
>  	dsb(ish);
>  }

I would suggest these barrier -- like any other barriers, carry a
comment that explain the required ordering.

I think this here reads like:

	STORE: unhook page

	DSB-ishst: wait for all stores to complete
	TLBI: invalidate broadcast
	DSB-ish: wait for TLBI to complete

And the 'newly' placed DSB-ishst ensures the page is observed unlinked
before we issue the invalidate.
