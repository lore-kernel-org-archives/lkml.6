Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E476C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FA121901
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="X50LubJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbfBMJf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:35:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39374 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbfBMJf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:35:56 -0500
Received: from zn.tnic (p200300EC2BCDE800B80E9BCAB03A01F8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:e800:b80e:9bca:b03a:1f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 345C41EC023E;
        Wed, 13 Feb 2019 10:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550050554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=N5/toTELGAqlZtYf4FeiaGSNLAzH4vpz7vTIi12M5Ao=;
        b=X50LubJu5vnYaSAmILCiUO4ilOhTxJ2fLBRG202VLw2v7g0v5yBRV6TXAYypxpgae6b+F6
        HU/p+a2TxPOcV6qQU8K1qRwZqanSy34+63lW2qJCuauUvnISsL5LGosEXg5s1nwrNIQE/K
        MdN/RJnIixwTi97mA+2ibHBklVdOrcM=
Date:   Wed, 13 Feb 2019 10:35:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 15/22] x86/entry: Add TIF_NEED_FPU_LOAD
Message-ID: <20190213093553.GC9683@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-16-bigeasy@linutronix.de>
 <20190130115507.GE18383@zn.tnic>
 <20190207114941.jzydrry5xpjngyiv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190207114941.jzydrry5xpjngyiv@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 12:49:42PM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-01-30 12:55:07 [+0100], Borislav Petkov wrote:
> > This definitely needs to be written somewhere in
> > 
> > arch/x86/include/asm/fpu/internal.h
> > 
> > or where we decide to put the FPU handling rules.
> 
> Added:
> 
> Index: staging/arch/x86/include/asm/fpu/internal.h
> ===================================================================
> --- staging.orig/arch/x86/include/asm/fpu/internal.h
> +++ staging/arch/x86/include/asm/fpu/internal.h
> @@ -537,6 +537,12 @@ static inline void __fpregs_load_activat
>   *
>   * The FPU context is only stored/restore for user task and ->mm is used to
>   * distinguish between kernel and user threads.
> + *
> + * If TIF_NEED_FPU_LOAD is cleared then CPU's FPU registers are holding the
> + * current content of current()'s FPU register state.

"current content of current" - that's a lot of c...

Make that

"... then the CPU's FPU registers are mirrored in the current thread's
FPU registers state."

> + * If TIF_NEED_FPU_LOAD is set then CPU's FPU registers may not hold current()'s
> + * FPU registers. It is required to load the register before returning to
						^^^^^^^^

s/register/registers/ - plural.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
