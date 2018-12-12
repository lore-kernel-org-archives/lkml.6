Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4D3C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9011B20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cZLpuX2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9011B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeLLRLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:11:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36192 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbeLLRLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:11:39 -0500
Received: from zn.tnic (p200300EC2BCDD800846D0A96F290A465.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:d800:846d:a96:f290:a465])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BCB2F1EC0B39;
        Wed, 12 Dec 2018 18:11:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544634697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KE0LWdpLqCLFWs9wAIeFXWVm4rPOl7dno2knwk2pHeQ=;
        b=cZLpuX2o1ile8KPlpyBmb8hKjAwpKO9kKeMbpxBf+PihmnyHSYtr8SzsRRvbq4uIwd5Br/
        DSiiisq6RTehV5KlFnt4OUy0YJ4Rn13oDhx/eWzOzENsRW0xvIj7Iz48pVQIPtXePcye/Z
        vj/OvYCcb8khCywXVlgUdsam74x993k=
Date:   Wed, 12 Dec 2018 18:11:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 11/29] x86/fpu: Always init the `state' in fpu__clear()
Message-ID: <20181212171129.GD6653@zn.tnic>
References: <20181128222035.2996-1-bigeasy@linutronix.de>
 <20181128222035.2996-12-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181128222035.2996-12-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:20:17PM +0100, Sebastian Andrzej Siewior wrote:
> fpu__clear() only initializes the `state' if the FPU is present. This
> initialisation is also required for the FPU-less system and takes place
> math_emulate(). Since fpu__initialize() only performs the initialization
> if ->initialized is zero it does not matter that it is invoked each time
> an opcode is emulated. It makes the removal of ->initialized easier if
> the struct is also initialized in FPU-less case at the same time.
> 
> Move fpu__initialize() before the FPU check so it is also performed in
> FPU-less case.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/include/asm/fpu/internal.h | 1 -
>  arch/x86/kernel/fpu/core.c          | 5 ++---
>  arch/x86/math-emu/fpu_entry.c       | 3 ---
>  3 files changed, 2 insertions(+), 7 deletions(-)

...

> diff --git a/arch/x86/math-emu/fpu_entry.c b/arch/x86/math-emu/fpu_entry.c
> index 9e2ba7e667f61..a873da6b46d6b 100644
> --- a/arch/x86/math-emu/fpu_entry.c
> +++ b/arch/x86/math-emu/fpu_entry.c
> @@ -113,9 +113,6 @@ void math_emulate(struct math_emu_info *info)
>  	unsigned long code_base = 0;
>  	unsigned long code_limit = 0;	/* Initialized to stop compiler warnings */
>  	struct desc_struct code_descriptor;
> -	struct fpu *fpu = &current->thread.fpu;
> -
> -	fpu__initialize(fpu);

Ok, you're removing it here but where is the FPU going to be initialized
now in the FPU-less case?

IOW, it is not clear to me where fpu__clear() get called for the FPU
emulation case now...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
