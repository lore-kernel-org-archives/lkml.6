Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Ai17KdMpHltzIgAAmS7hNA
	; Mon, 11 Jun 2018 07:50:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 850FD607A4; Mon, 11 Jun 2018 07:50:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jopemXtv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 119B5602FC;
	Mon, 11 Jun 2018 07:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 119B5602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeFKHuk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 03:50:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753956AbeFKHuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 03:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3Gr5tuW1fI5oajwJqnBT9KrIPDpaRC22v6DxxfcNfO0=; b=jopemXtv/8ufB5MCGttR5up9s
        nZ5rRGMyX3X4H7pKDmEmGGLMJjk9xGW0PxSlnssQnBrzzS50xN7+ENKjbfGhYIVxiyxYiJCt+FPLB
        AFw2VpCm6dFaio5rliF0zU3IOqnsefrDASFbDX7L5JiVJhq/BdrIGAZWot68bEZTxADTOICCgkp4u
        50CADCz7v5P9HiGoMpuE3fJrkXcP8yhUGjwTBAgLk1dUYTRf0Kd+pAR6gIm8S/5irsQ3jBdfZdCUE
        HHE9/GV2/GPj0EvXVdrRXlhldS86tDKcQuX5Jpuqf4sp4D091seci8bYhb9eJgAs2SSIpOx3NlvlO
        3+X+aq91Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSHb3-0001d8-6H; Mon, 11 Jun 2018 07:50:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67E88201EA7B1; Mon, 11 Jun 2018 09:50:35 +0200 (CEST)
Date: Mon, 11 Jun 2018 09:50:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nadav Amit <namit@vmware.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>
Subject: Re: [PATCH v3 9/9] x86: jump-labels: use macros instead of inline
 assembly
Message-ID: <20180611075035.GQ12258@hirez.programming.kicks-ass.net>
References: <20180610141911.52948-1-namit@vmware.com>
 <20180610141911.52948-10-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610141911.52948-10-namit@vmware.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 07:19:11AM -0700, Nadav Amit wrote:
>  static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
>  {
> +	asm_volatile_goto("STATIC_BRANCH_GOTO l_yes=\"%l[l_yes]\" key=\"%c0\" "
> +			  "branch=\"%c1\""
> +			: :  "i" (key), "i" (branch) : : l_yes);
>  
>  	return false;
>  l_yes:
> @@ -48,13 +44,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
>  
>  static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
>  {
> +	asm_volatile_goto("STATIC_BRANCH_JUMP_GOTO l_yes=\"%l[l_yes]\" key=\"%c0\" "
> +			  "branch=\"%c1\""
>  		: :  "i" (key), "i" (branch) : : l_yes);
>  
>  	return false;
> @@ -108,6 +99,26 @@ struct jump_entry {
>  	.popsection
>  .endm
>  
> +.macro STATIC_BRANCH_GOTO l_yes:req key:req branch:req

STATIC_BRANCH_NOP

> +1:
> +	.byte STATIC_KEY_INIT_NOP
> +	.pushsection __jump_table, "aw"
> +	_ASM_ALIGN
> +	_ASM_PTR 1b, \l_yes, \key + \branch
> +	.popsection
> +.endm
> +
> +.macro STATIC_BRANCH_JUMP_GOTO l_yes:req key:req branch:req

STATIC_BRANCH_JMP

> +1:
> +	.byte 0xe9
> +	.long \l_yes - 2f
> +2:
> +	.pushsection __jump_table, "aw"
> +	_ASM_ALIGN
> +	_ASM_PTR 1b, \l_yes, \key + \branch
> +	.popsection
> +.endm
> +
>  #endif	/* __ASSEMBLY__ */
