Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E292C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE41208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kRvyO25j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE41208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeKHUlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:41:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55978 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHUlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VzX5Ck/FYxZrA5648+/MQI2Rsj/kE2LDDnXvutazdW4=; b=kRvyO25j7dP9F2OiKbgPJA0D2
        fx5iy9HQ2qpkbYJ7ZbrFH7CL5JQ7SF2EgogXzZ8A130yhGAB42cszbdhnGH7Ig/8WyFZFT8wIe5AG
        6yVT1StFNEeSymM6A/tcnqqMrbaZOr7Q29vXALv88dLEEAFIps3Y/+52pHKVaIU5B081g0jvmf4eQ
        P6I/vtlFJR2K9wva348T9GZLvncEPcMiH0IriKhE0fkdfAp3Nkksk21jKTwUag2k+QV1YngFZ7WuX
        h61HmRJcBOHo8HLq7vJYEBK8Pk3WxeKbGrVIJYFqnR8I9Ri/a9iDFIIPzbdadMt6nMpNkI1SAfTij
        WtlYTFrzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKhkt-00078r-KQ; Thu, 08 Nov 2018 10:41:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3FAD2029F883; Thu,  8 Nov 2018 11:41:41 +0100 (CET)
Date:   Thu, 8 Nov 2018 11:41:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
Message-ID: <20181108104141.GR9761@hirez.programming.kicks-ass.net>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-3-namit@vmware.com>
 <20181105140925.GD22467@hirez.programming.kicks-ass.net>
 <9A69025F-5B49-4A26-AB95-F6D36908983B@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9A69025F-5B49-4A26-AB95-F6D36908983B@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2018 at 07:13:03PM +0000, Nadav Amit wrote:
> > diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> > index aac0c1f7e354..ed5fe274a7d8 100644
> > --- a/arch/x86/kernel/jump_label.c
> > +++ b/arch/x86/kernel/jump_label.c
> > @@ -52,7 +52,12 @@ static void __ref __jump_label_transform(struct jump_entry *entry,
> > 	jmp.offset = jump_entry_target(entry) -
> > 		     (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
> > 
> > -	if (early_boot_irqs_disabled)
> > +	/*
> > +	 * As long as we're UP and not yet marked RO, we can use
> > +	 * text_poke_early; SYSTEM_BOOTING guarantees both, as we switch to
> > +	 * SYSTEM_SCHEDULING before going either.
> > +	 */
> > +	if (system_state == SYSTEM_BOOTING)
> > 		poker = text_poke_early;
> > 
> > 	if (type == JUMP_LABEL_JMP) {
> 
> Thanks for this change, I will incorporate it.
> 
> I wanted to point a small difference from my version. Although this version
> ensures we are UP and the kernel is still RW, preemption is possible with
> this version. I presume that it should not affect jump-labels, since it
> switches between JMP and multi-byte NOPs.

Right, we're never running the code we're going to change on UP.
