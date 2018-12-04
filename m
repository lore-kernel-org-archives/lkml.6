Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6906A2146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IZVBs8q9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6906A2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeLDMeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:34:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46094 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbeLDMeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:34:04 -0500
Received: from zn.tnic (p200300EC2BC7BF0029609E2C84DD7E59.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:bf00:2960:9e2c:84dd:7e59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC6C91EC0B90;
        Tue,  4 Dec 2018 13:34:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543926843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UmkhXGx1Qd+uWuUU2htaSuaLRSm1dRqdfZXg6G1UUYE=;
        b=IZVBs8q9OsH+0niWFicuGOqhGPy7gAZ7QfKlSuYtCEw0/1vYW4cIf94XbbCilmH0n8Z8i9
        Q8BfQDOZ/74gnS6fP43yVfi4EEcvi6xqXyPNcvkF1hjsO23Qetmnlsqwx0O5FOmrIgK1+/
        arzqPwDJI/s371uT/o0anJIHMozMchk=
Date:   Tue, 4 Dec 2018 13:33:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        the arch/x86 maintainers <x86@kernel.org>, nstange@suse.de,
        Rik van Riel <riel@surriel.com>,
        KVM devel mailing list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/fpu] x86/fpu: Don't export __kernel_fpu_{begin,end}()
Message-ID: <20181204123355.GD11803@zn.tnic>
References: <20181129150210.2k4mawt37ow6c2vq@linutronix.de>
 <tip-7d79adb87fa79e4a4c59424fd5b5a922861fc5f6@git.kernel.org>
 <CAKv+Gu-s59fSWrMevmbJWyBtNVYLkF7FATALGBD470CWsN9C1Q@mail.gmail.com>
 <20181203220841.GB4794@zn.tnic>
 <20181204121510.ebw4vb265lcepa2m@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181204121510.ebw4vb265lcepa2m@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:15:10PM +0100, Sebastian Andrzej Siewior wrote:
> Do you refer to
> | *   - by IRQ context code to potentially use the FPU
> | *     if it's unused.
>   
> ? It is possible to use the FPU in IRQ context.

I mean interrupted_user_mode() where we apparently can use the FPU when
handling an IRQ from user mode.

> The FPU could be used in user-context surrounded by kernel_fpu_begin().

Right, that.

> This only disables preemption so an IRQ could interrupt it. This IRQ
> could then use the FPU or raise a SoftIRQ which would use it.
> Therefore on x86 it is required to check with irq_fpu_usable() if the

Yes, and the check that thing does is:

        return !in_interrupt() ||
                interrupted_user_mode() || ...

so you're either *not* in interrupt, or you've gotten the IRQ while in
user mode.

> FPU can be used. If the FPU can not be used, you have to implement
> fallback code.
> 
> With the "restore FPU on return to userland" series we need to modify
> the FPU in a few places. The softirq and preemption is disabled. I
> didn't find any in-IRQ users.
> Going forward I would like to remove the in-IRQ part and
> irq_fpu_usable() and disable softirq as part of kernel_fpu_begin().

Right, and we should document all those new conditions prominently so
that people are aware.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
