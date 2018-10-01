Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C76C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD172082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD172082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeJBALR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:11:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbeJBALR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:11:17 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hr4X-WC6hq6l; Mon,  1 Oct 2018 19:32:26 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E1F4A1EC00B9;
        Mon,  1 Oct 2018 19:32:25 +0200 (CEST)
Date:   Mon, 1 Oct 2018 19:32:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        hpa@zytor.com, x86@kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: define CC_HAVE_ASM_GOTO
Message-ID: <20181001173227.GE7269@zn.tnic>
References: <20180927204800.32210-1-ndesaulniers@google.com>
 <20180927215148.GE19687@zn.tnic>
 <CAKwvOdmXcztP542kADhyJYN2=Fk3qyXif_MCs=kqPGE8QtTjvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmXcztP542kADhyJYN2=Fk3qyXif_MCs=kqPGE8QtTjvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:17:41PM -0700, Nick Desaulniers wrote:
> That's another case that I look at and wonder "why does this exist?"
> The _SETUP guard exists in only one place:
> $ grep -rP 'ifdef\s+_SETUP'
> arch/x86/boot/cpucheck.c:#ifdef _SETUP
> 
> which is already under arch/x86/boot/. arch/x86/boot/Makefile
> unconditionally sets -D_SETUP, so what/who are we guarding against?
> Looks like a guard that's ALWAYS true (and thus could be removed).

Looks like cpucheck.c was used somewhere else before and that guard was
for when it is being built in arch/x86/boot/...

Also, hpa says the override is because some 64-bit flags fail the 32-bit
compile:

https://lkml.kernel.org/r/56442061-7f55-878d-5b26-7cdd14e901d2@zytor.com

> Or, or... we don't redefine KBUILD_CFLAGS in arch/x86/boot/Makefile
> (or any Makefile other than the top level one), and simply filter out
> the flags we DONT want, a la:
> 
> drivers/firmware/efi/libstub/Makefile:
>  16 cflags-$(CONFIG_ARM64)    := $(subst -pg,,$(KBUILD_CFLAGS)) ...
> 
> ie, using Make's subst function to copy KBUILD_CFLAGS, filter out
> results, then use that for cflags-y.
> https://www.gnu.org/software/make/manual/html_node/Text-Functions.html

Hmm, definitely sounds like an interesting idea to try...

> I'm curious to know Masahiro's thoughts on this?  I can't help but
> shake the feeling that reassigning KBUILD_CFLAGS should be considered
> an anti-pattern and warned from checkpatch.pl.  For the reasons
> enumerated above AND in v1:
> https://lore.kernel.org/lkml/CAKwvOdmLSVH7EVGY1ExU1Fh_hvL=FUzhq-80snDfZ+QhCT2FOA@mail.gmail.com/
> (though there may be additional context from hpa answering
> https://lore.kernel.org/lkml/20180926090841.GC5745@zn.tnic/).
> 
> Relying on the compiler's default/implicit C standard (which changed
> in gcc 5) for parts of the kernel but not others I feel like should be
> a big red flag.

I sure see your point. But then there's also the opposing argument where
having stuff leak from kernel proper into .../boot/ is simply breaking
the build.

But then we have headers including stuff from kernel proper so I guess
*that* last fact kinda wants us to not redefine KBUILD_CFLAGS ...

Oh boy.

> Shall I prototype up what such a change might look like (not
> reassigning KBUILD_CFLAGS in arch/x86/boot/Makefile)?  Maybe it's
> harder/uglier than I imagine?

Sounds to me like a good thing to try. If anything, we'll know more
whether it makes sense at all.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
