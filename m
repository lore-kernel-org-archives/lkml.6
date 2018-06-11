Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EZ6BNZosHls/LwAAmS7hNA
	; Mon, 11 Jun 2018 08:03:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 776BD607A4; Mon, 11 Jun 2018 08:03:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NlomuiHh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E71E0605A5;
	Mon, 11 Jun 2018 08:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E71E0605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754105AbeFKIDZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:03:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56646 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754006AbeFKIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bMXnNspF5Gk43P2gBj9H+wdBFnuHypSdx9J8R5BsdC8=; b=NlomuiHhh4GvWWXbc3fKzQRwa
        sTayBPFCqBw2CoRIGljAx8S87xOCwbV0pGtcT1/JguolfFfhWSRYxifEVzCNm3MApzIQsWNOxCXxD
        Pr/apo92C1Xftmy1otnfWT9A8RtESgvNBxP/BJW241gtCV0hKaGkxKL1Dij9svI8uxeodN6eKGDm3
        Tecsi1Iy4o7uDufdlEjR3aTl1dyJdqg13RPdmFmjNsJlQvW2JgQHm56xc1QSpRik8+/YAVsw2vhd+
        r7PpXVolHezwjloeZfJBopMAXgqhBkollG8rb3eCoWz113Af/ttE+AmC+OtglhV9SGXx4ToN4wJov
        3z8fq5I4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSHnK-0004ou-LG; Mon, 11 Jun 2018 08:03:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF832201EA7B1; Mon, 11 Jun 2018 10:03:14 +0200 (CEST)
Date: Mon, 11 Jun 2018 10:03:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nadav Amit <namit@vmware.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 4/9] x86: alternatives: macrofy locks for better
 inlining
Message-ID: <20180611080314.GR12258@hirez.programming.kicks-ass.net>
References: <20180610141911.52948-1-namit@vmware.com>
 <20180610141911.52948-5-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180610141911.52948-5-namit@vmware.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 07:19:06AM -0700, Nadav Amit wrote:
>  #ifdef CONFIG_SMP
> +.macro LOCK_PREFIX_HERE
>  	.pushsection .smp_locks,"a"
>  	.balign 4
> +	.long 671f - .		# offset
>  	.popsection
> +671:
> +.endm
> +
> +.macro LOCK_PREFIX insn:vararg
> +	LOCK_PREFIX_HERE
> +	lock \insn
> +.endm

Hurmph, the only reason we need to preserve that LOCK_PREFIX_HERE thing
is arch_cmpxchg64 in cmpxchg_32.h. Is there really no other way we can
write that one?

I suppose the problem with using LOCK_PREFIX inside the alternative is
that the .smp_locks fixup address gets computed wrong (inside the
alternative_text section instead of in the regular text)?

Oh well..
