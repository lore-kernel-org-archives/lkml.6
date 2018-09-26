Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2A6ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1486E2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1486E2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeIZPUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:20:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:42302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727189AbeIZPUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF1C6AEB4;
        Wed, 26 Sep 2018 09:08:38 +0000 (UTC)
Date:   Wed, 26 Sep 2018 11:08:41 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/boot: define CC_HAVE_ASM_GOTO
Message-ID: <20180926090841.GC5745@zn.tnic>
References: <20180907202618.258569-1-ndesaulniers@google.com>
 <CAKwvOdn4BcKUjGnGgFfbGxbwvSh9mYLT1gJ_ozDHua1LcjJ1rw@mail.gmail.com>
 <20180925190829.GC15464@zn.tnic>
 <CAKwvOdmaUMmLAv-529A0ShW7et3Jnnmc4Agjody+VReN5feTeg@mail.gmail.com>
 <CAKwvOdmLSVH7EVGY1ExU1Fh_hvL=FUzhq-80snDfZ+QhCT2FOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmLSVH7EVGY1ExU1Fh_hvL=FUzhq-80snDfZ+QhCT2FOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 02:13:16PM -0700, Nick Desaulniers wrote:
> Orthogonally, do you know *why* this Makefile overwrites
> KBUILD_CFLAGS?  We take great care to set various compiler flags in
> the top level Makefile, so to reset them lower in the tree seems
> troublesome on first glance.  Take for instance the fact that GCC
> changed the default C standard from gnu89 to gnu11 in GCC 5.  So a
> kernel dev with gcc 5+ is now building a kernel with some translation
> units built as gnu89, and some as gnu11.

Right, so I'd defer to hpa for a definitive answer here but AFAICT, the
reasoning is that because this is the special relocatable compressed
kernel and as such, it is redefining build flags completely so that
nothing leaks from kernel proper.

Which is funny because what happens is, that something *does* leak,
and what you're trying to fix is one incarnation. Because we do use
facilities from include/linux/. And looking at your error:

#warning "Compiler lacks ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"

I don't think it does matter to the compressed kernel whether the
compiler has asm goto or not.

And looking at arch/x86/boot/Makefile, it does:

KBUILD_CFLAGS   := $(REALMODE_CFLAGS) -D_SETUP

and that _SETUP guard is kinda used to separate that early boot code
from kernel proper.

And I wonder if adding such guard to arch/x86/boot/compressed/Makefile
and then protect the asm goto check in arch/x86/include/asm/cpufeature.h
with it, would be more in line with how this whole machinery should
work...

hpa?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
