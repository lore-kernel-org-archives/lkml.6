Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B989DC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7EF213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxn8+4Xd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7EF213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeKTSnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:43:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52758 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeKTSnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z+ZALHaT7pbzTnrHzE+qd0A0vhrf2a3vbq3yyXeFlFg=; b=hxn8+4XdOPFA25GWmeXyznGCt
        xEsskoEXppT2gb0TnmkGsroMCO9j43amaz/eNNrrX1AWl5onURNHpKzhNHVCwVps0NBxDvWklXvRu
        PGTaP75QulLuxgfBBVP5riUSR3DP6DbnV7V5R9iy86FS1RyEtWr86hsNwShRTvJ8aDuTm5B8eIDJI
        HknwWISsTKau1IynOou4JZsAkkgmcLpr3cwXNZXfptjAqdDkcNbCg9+nvmaysuQuPAKJxm0eNkMVp
        WOooY1OT8ewiE8k4VCkcm1Unhe6wRoCFhlTFW1kW6ru8y/d90aKDJx8Sr9FS1QK3yJyZZhC9tTOxs
        c/ASU1NnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gP1CP-0005D6-LH; Tue, 20 Nov 2018 08:15:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 632A92029FD58; Tue, 20 Nov 2018 09:15:54 +0100 (CET)
Date:   Tue, 20 Nov 2018 09:15:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 01/13] x86/fault: Check user_mode(regs) when avoiding an
 mmap_sem deadlock
Message-ID: <20181120081554.GD2131@hirez.programming.kicks-ass.net>
References: <cover.1542667307.git.luto@kernel.org>
 <4b89b542e8ceba9bd6abde2f386afed6d99244a9.1542667307.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b89b542e8ceba9bd6abde2f386afed6d99244a9.1542667307.git.luto@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:45:25PM -0800, Andy Lutomirski wrote:
> The fault-handling code that takes mmap_sem needs to avoid a
> deadlock that could occur if the kernel took a bad (OOPS-worthy)
> page fault on a user address while holding mmap_sem.  This can only
> happen if the faulting instruction was in the kernel
> (i.e. user_mode(regs)).  Rather than checking the sw_error_code

 !user_mode(regs), surely, as the patch actually does.

> (which will have the USER bit set if the fault was a USER-permission
> access *or* if user_mode(regs)), just check user_mode(regs)
> directly.
> 
> The old code would have malfunctioned if the kernel executed a bogus
> WRUSS instruction while holding mmap_sem.  Fortunately, that is
> extremely unlikely in current kernels, which don't use WRUSS.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/mm/fault.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 71d4b9d4d43f..91d4d2722f2e 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1344,13 +1344,10 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	 * Only do the expensive exception table search when we might be at
>  	 * risk of a deadlock.  This happens if we
>  	 * 1. Failed to acquire mmap_sem, and
> -	 * 2. The access did not originate in userspace.  Note: either the
> -	 *    hardware or earlier page fault code may set X86_PF_USER
> -	 *    in sw_error_code.
> +	 * 2. The access did not originate in userspace.
>  	 */
>  	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
> -		if (!(sw_error_code & X86_PF_USER) &&
> -		    !search_exception_tables(regs->ip)) {
> +		if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
>  			/*
>  			 * Fault from code in kernel from
>  			 * which we do not expect faults.
> -- 
> 2.17.2
> 
