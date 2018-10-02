Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9659BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2E12089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zIR5ys01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2E12089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJBOPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:15:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46802 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeJBOPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g30chNroOsCcTq0XM/87mT8sVrXJqZNSEg5Z+ph/xR0=; b=zIR5ys01W6eqWQ/wmZ7NQHs/ms
        pYiYOoopXA/YfJRWehDK2C0y1GdByyJLti4BEWQg80rCcCn7Xz8KyyLScTHXEnYSy5lIzJLDaEmF0
        dNjGKQRz0GOhvavJzWO6l0FQMtlioPSteRkTZTyhjyEjvd+Pc+G1wnoz4FwDpwbdIGjsigy++VprC
        rSZpQPdWzbjt8kLRiJPi4kPSEEMfz/HovM4ptDLd/oxj3SDW/qn8foCXUnZicoBR7t4Akf2cQ/QT+
        qeg8evgAdE+Rnnq5wWs5OgMfOg6YDB8NL2/i2Mh15A27CaFopB3dnoxAMzi/eVtnR7he5hoo03NCA
        gD3cMjAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7FAv-00039C-Sb; Tue, 02 Oct 2018 07:32:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 347CE20255986; Tue,  2 Oct 2018 09:32:54 +0200 (CEST)
Date:   Tue, 2 Oct 2018 09:32:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        will.deacon@arm.com, songliubraving@fb.com, mingo@kernel.org,
        luto@kernel.org, hpa@zytor.com, npiggin@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de
Subject: Re: [PATCH 2/7] x86/mm/tlb: Restructure switch_mm_irqs_off()
Message-ID: <20181002073254.GP3439@hirez.programming.kicks-ass.net>
References: <20180926035844.1420-1-riel@surriel.com>
 <20180926035844.1420-3-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180926035844.1420-3-riel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 11:58:39PM -0400, Rik van Riel wrote:
> Move some code that will be needed for the lazy -> !lazy state
> transition when a lazy TLB CPU has gotten out of date.
> 
> No functional changes, since the if (real_prev == next) branch
> always returns.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: efault@gmx.de
> Cc: kernel-team@fb.com
> Link: http://lkml.kernel.org/r/20180716190337.26133-4-riel@surriel.com
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> (cherry picked from commit 61d0beb5796ab11f7f3bf38cb2eccc6579aaa70b)
> ---
>  arch/x86/mm/tlb.c | 64 ++++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 54a5870190a6..1224f7fb1311 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -187,6 +187,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
>  	unsigned cpu = smp_processor_id();
>  	u64 next_tlb_gen;
> +	bool need_flush;
> +	u16 new_asid;
>  
>  	/*
>  	 * NB: The scheduler will call us with prev == next when switching
> @@ -308,44 +310,44 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  		/* Let nmi_uaccess_okay() know that we're changing CR3. */
>  		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
>  		barrier();
> +	}

Compiling this gives me:

CC      arch/x86/mm/tlb.o
../arch/x86/mm/tlb.c: In function ‘switch_mm_irqs_off’:
../arch/x86/mm/tlb.c:315:5: warning: ‘need_flush’ may be used uninitialized in this function [-Wmaybe-uninitialized]
if (need_flush) {
^
../arch/x86/mm/tlb.c:316:45: warning: ‘new_asid’ may be used uninitialized in this function [-Wmaybe-uninitialized]
this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
^

Because you shadow need_flush and new_asid in a branch. I need the below
delta to make it happy again.

---
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -254,8 +254,6 @@ void switch_mm_irqs_off(struct mm_struct
 
 		return;
 	} else {
-		u16 new_asid;
-		bool need_flush;
 		u64 last_ctx_id = this_cpu_read(cpu_tlbstate.last_ctx_id);
 
 		/*
