Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ECDECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1E6206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ENTInC70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1E6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeIRPWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:22:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48506 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbeIRPWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xOhm0LaIHslYqMKqZt9OBU+2V2ssXX8gMA5DbBV6FiU=; b=ENTInC705CRys2e31H4kUlaqj
        2wubRu6Uh+knDeG0YzH9bpjN8lKmoFE3pmkCVVz57DGnHpR0zbYW49hm3+qfl64oKgh1nOPH+vkWR
        Jo+w5ZpedlSzGtvqwf0Ay/vsDTEvdRyvZu9i3Fgs+NxDX9ItlJQFPD9s2wulL856Dl/+VEVk++udE
        ejNsd8p2oPM43rSzy2yrnrx3belCDcJal6EESAJzQ2rXTkd4VA+8krocC+DC4ZOCC9zPgb3bXbfNv
        TWeArNHeObcuRehcKctA+qR1SVAfIcSjJQyt4MfN9a2qZl5YvoYc2/9XGgCXn37BEmzF4CpuF3iVO
        b3e2hqZdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g2CeA-0001Fh-E9; Tue, 18 Sep 2018 09:50:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9DCB202C1A09; Tue, 18 Sep 2018 11:50:15 +0200 (CEST)
Date:   Tue, 18 Sep 2018 11:50:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        konrad.wilk@oracle.com, x86@kernel.org, dwmw@amazon.co.uk,
        tglx@linutronix.de, Srinivas REDDY Eeda <srinivas.eeda@oracle.com>,
        bp@suse.de, hpa@zytor.com, dhaval.giani@oracle.com
Subject: Re: [PATCH] x86/speculation: Use AMD specific retpoline for inline
 asm on AMD
Message-ID: <20180918095015.GE19234@hirez.programming.kicks-ass.net>
References: <87411705-893f-46d3-b899-b09ed9fa8d1b@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87411705-893f-46d3-b899-b09ed9fa8d1b@default>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 10:17:30PM -0700, Zhenzhong Duan wrote:
> Lfence is preferred than general retpoline on AMD, add this option
> in C / inline asm just as the ASM code does.
> 
> For x86_64, it still help to have minimal retpoline for kernel even
> if gcc doesn't support it, change the inline asm for x86 so that it
> could also be used by x86_64.
> Add ANNOTATE_NOSPEC_ALTERNATIVE for i386 to avoid below warning:
> "warning: objtool: .altinstr_replacement+0x10: unsupported
> intra-function call"
> "warning: objtool: If this is a retpoline, please patch it
> in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE."

This Changelog is almost unreadable, please rewrite.

Reverse engineering the patch you add RETPOLINE_AMD support to the
inline-asm CALL_NOSPEC so that they match the asm CALL_NOSPEC.

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> ---
>  arch/x86/include/asm/nospec-branch.h |   23 ++++++++++++++++-------
>  1 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index fd2a8c1..2d49eab 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -170,21 +170,26 @@
>   */
>  # define CALL_NOSPEC						\
>  	ANNOTATE_NOSPEC_ALTERNATIVE				\
> -	ALTERNATIVE(						\
> +	ALTERNATIVE_2(						\
>  	ANNOTATE_RETPOLINE_SAFE					\
>  	"call *%[thunk_target]\n",				\
>  	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
> -	X86_FEATURE_RETPOLINE)
> +	X86_FEATURE_RETPOLINE,					\
> +	"lfence;\n"						\
> +	ANNOTATE_RETPOLINE_SAFE					\
> +	"call *%[thunk_target]\n",				\
> +	X86_FEATURE_RETPOLINE_AMD)
>  # define THUNK_TARGET(addr) [thunk_target] "r" (addr)

That's OK.

>  
> -#elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
> +#elif defined(CONFIG_RETPOLINE)

This doesn't make any sense..

>  /*
>   * For i386 we use the original ret-equivalent retpoline, because
>   * otherwise we'll run out of registers. We don't care about CET
>   * here, anyway.
>   */
>  # define CALL_NOSPEC						\
> -	ALTERNATIVE(						\
> +	ANNOTATE_NOSPEC_ALTERNATIVE				\
> +	ALTERNATIVE_2(						\
>  	ANNOTATE_RETPOLINE_SAFE					\
>  	"call *%[thunk_target]\n",				\
>  	"       jmp    904f;\n"					\
> @@ -194,12 +199,16 @@
>  	"    	lfence;\n"					\
>  	"       jmp    902b;\n"					\
>  	"       .align 16\n"					\
> -	"903:	addl   $4, %%esp;\n"				\
> -	"       pushl  %[thunk_target];\n"			\
> +	"903:	add   $4, %%" _ASM_SP ";\n"			\
> +	"       push  %[thunk_target];\n"			\

Yeah, don't do that.

>  	"       ret;\n"						\
>  	"       .align 16\n"					\
>  	"904:	call   901b;\n",				\
> -	X86_FEATURE_RETPOLINE)
> +	X86_FEATURE_RETPOLINE,					\
> +	"lfence;\n"						\
> +	ANNOTATE_RETPOLINE_SAFE					\
> +	"call *%[thunk_target]\n",				\
> +	X86_FEATURE_RETPOLINE_AMD)

And that's OK again.
