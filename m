Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37541C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E1720850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H8atqT5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E1720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbeLFIlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:41:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFIlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:41:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yK67o+3adp3nUlF6SqR7I48Ami8E6e6XDClA4A7ZbU8=; b=H8atqT5YNACmsoeXJRSB/WoNm
        2UsoZlvTMs2wHyWza3YTx7fcUXKAi++l09x69nNFI+xzQvsy+b/f1LVbIeINhVyNo53e+fKFoF3OF
        8ta34C2xV+mF0asQzS8qNqNeE9dStosAJ8D67w0AcgxL9p3DtvJtXqK2q7pM4HlFLG8l+qtSHT8Jv
        sATjVdddFMpWU1PQZd/0DVm4h0PpJ04oPghCl7hAnQwi4+BkiMilRqBNyIib1mnHYWqwnd88+bfOF
        bqFIv+p/nzItEKsnYE5CP0UPl2M+2ruE3GuRend7dwXjs48OAgRZ5pfgcVVVdOmm8M1Z+B28835UP
        itszVvFww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUpE7-00088X-AQ; Thu, 06 Dec 2018 08:41:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 83514200FB7D8; Thu,  6 Dec 2018 09:41:41 +0100 (CET)
Date:   Thu, 6 Dec 2018 09:41:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 2/2] x86/speculation: switch_to_cond_stibp on is the
 likely case
Message-ID: <20181206084141.GA13538@hirez.programming.kicks-ass.net>
References: <1544039368-9009-1-git-send-email-longman@redhat.com>
 <1544039368-9009-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544039368-9009-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 02:49:28PM -0500, Waiman Long wrote:
> Since conditional STIBP is the default, it should be treated as
> the likely case. Changes the use of static_branch_unlikely() to
> static_branch_likely() for switch_to_cond_stibp.

So now you're making kernels on 'fixed' or unaffected hardware slower.

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 2 +-
>  arch/x86/kernel/process.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index a68b32c..bd11119 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -153,7 +153,7 @@ void __init check_bugs(void)
>  			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
>  
>  		/* Conditional STIBP enabled? */
> -		if (static_branch_unlikely(&switch_to_cond_stibp))
> +		if (static_branch_likely(&switch_to_cond_stibp))
>  			hostval |= stibp_tif_to_spec_ctrl(ti->flags);
>  
>  		if (hostval != guestval) {
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 7d31192..39a21ae 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -434,7 +434,7 @@ static __always_inline void __speculation_ctrl_update(unsigned long tifp,
>  	 * otherwise avoid the MSR write.
>  	 */
>  	if (IS_ENABLED(CONFIG_SMP) &&
> -	    static_branch_unlikely(&switch_to_cond_stibp)) {
> +	    static_branch_likely(&switch_to_cond_stibp)) {
>  		updmsr |= !!(tif_diff & _TIF_SPEC_IB);
>  		msr |= stibp_tif_to_spec_ctrl(tifn);
>  	}
> -- 
> 1.8.3.1
> 
