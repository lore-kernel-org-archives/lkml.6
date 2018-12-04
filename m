Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFCEC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5100E20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5100E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeLDMPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:15:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44691 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeLDMPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:15:47 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gU9ba-0005AU-If; Tue, 04 Dec 2018 13:15:10 +0100
Date:   Tue, 4 Dec 2018 13:15:10 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20181204121510.ebw4vb265lcepa2m@linutronix.de>
References: <20181129150210.2k4mawt37ow6c2vq@linutronix.de>
 <tip-7d79adb87fa79e4a4c59424fd5b5a922861fc5f6@git.kernel.org>
 <CAKv+Gu-s59fSWrMevmbJWyBtNVYLkF7FATALGBD470CWsN9C1Q@mail.gmail.com>
 <20181203220841.GB4794@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181203220841.GB4794@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-03 23:08:41 [+0100], Borislav Petkov wrote:
> On Mon, Dec 03, 2018 at 10:12:19PM +0100, Ard Biesheuvel wrote:
> > > + * Using the FPU in hardirq is not allowed.
> > 
> > According to the documentation in x86/kernel/fpu/core.c, this is not
> > true. So which one is accurate?
> 
> I think you mean the irq from user mode... Yap, we do allow that.
> 
> Sebastian?

Do you refer to
| *   - by IRQ context code to potentially use the FPU
| *     if it's unused.
  
? It is possible to use the FPU in IRQ context.
The FPU could be used in user-context surrounded by kernel_fpu_begin().
This only disables preemption so an IRQ could interrupt it. This IRQ
could then use the FPU or raise a SoftIRQ which would use it.
Therefore on x86 it is required to check with irq_fpu_usable() if the
FPU can be used. If the FPU can not be used, you have to implement
fallback code.

With the "restore FPU on return to userland" series we need to modify
the FPU in a few places. The softirq and preemption is disabled. I
didn't find any in-IRQ users.
Going forward I would like to remove the in-IRQ part and
irq_fpu_usable() and disable softirq as part of kernel_fpu_begin().

> Thx.

Sebastian
