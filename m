Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0122EC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEAB2054F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oaVBFGWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAEAB2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeLAVfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:35:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47534 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeLAVfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1FFgPVAO7Lt9Fh8J3PvOFj46zw8MbZmEcShngNchViY=; b=oaVBFGWUpH9s2IMuDXcCntD95
        Yq65Kq26e+CXiQpRY+mNrVEHE2BqEuF7dQQowk86365BHNJ07oh1me625Kx7eSa7MdXjtzenWNb5y
        kg/olW5jCo8KNc4E5X9M9TDVkOvmtc2ktem2MuecKS8H9s2Rkf4iTPP07VZlTqtYdbRBhp0z0vD2d
        PApvKSRV6veog1DgZuTXWOOR9lGvQ0t/StRrnO28ho1XgUPKEvNwc57O1tQnDyGG5As6P8nxToB5B
        f7gnVct3r0yOOnkRYlLfd+pbXSeJ0xxaHEKWrQ2g/VRlLY11VDfAEBcw+RT2bZOxJEo3blaG44UJx
        WKHxPQG/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gT2Qu-00023O-Fo; Sat, 01 Dec 2018 10:23:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 476512029FD58; Sat,  1 Dec 2018 11:23:29 +0100 (CET)
Date:   Sat, 1 Dec 2018 11:23:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] riscv, atomic: Add #define's for the
 atomic_{cmp,}xchg_*() variants
Message-ID: <20181201102329.GD11614@hirez.programming.kicks-ass.net>
References: <20181201000156.5366-1-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181201000156.5366-1-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 01:01:56AM +0100, Andrea Parri wrote:
> If an architecture does not define the atomic_{cmp,}xchg_*() variants,
> the generic implementation defaults them to the fully-ordered version.
> 
> riscv's had its own variants since "the beginning", but it never told
> (#define-d these for) the generic implementation: it is time to do so.
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/riscv/include/asm/atomic.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index c452359c9cb8a..93826771b616a 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -303,6 +303,15 @@ c_t atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
>  
>  ATOMIC_OPS()
>  
> +#define atomic_xchg_relaxed atomic_xchg_relaxed
> +#define atomic_xchg_acquire atomic_xchg_acquire
> +#define atomic_xchg_release atomic_xchg_release
> +#define atomic_xchg atomic_xchg
> +#define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
> +#define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
> +#define atomic_cmpxchg_release atomic_cmpxchg_release
> +#define atomic_cmpxchg atomic_cmpxchg
> +
>  #undef ATOMIC_OPS
>  #undef ATOMIC_OP
>  
> -- 
> 2.17.1
> 
