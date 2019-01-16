Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86114C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36ADC20866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfAPVyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:54:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45907 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbfAPVyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:54:43 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjt8r-0000Um-Ia; Wed, 16 Jan 2019 22:54:33 +0100
Date:   Wed, 16 Jan 2019 22:54:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] x86/pgtable: Always inline p4d_index
In-Reply-To: <20190116134158.344-1-natechancellor@gmail.com>
Message-ID: <alpine.DEB.2.21.1901161848560.1642@nanos.tec.linutronix.de>
References: <20181210234538.5405-1-natechancellor@gmail.com> <20190116134158.344-1-natechancellor@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019, Nathan Chancellor wrote:

> When building an allyesconfig build with Clang, the kernel fails to link
> arch/x86/platform/efi/efi_64.o because of a failed BUILD_BUG_ON:
> 
> ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
> (.text+0x8e5): undefined reference to `__compiletime_assert_277'
> 
> Since there are several BUILD_BUG_ONs in efi_64.c, I isolated it down to
> the following:
> 
>     BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> 
> After some research, it turns out that there is a new config option
> called NO_AUTO_INLINE, which adds '-fno-inline-functions' to
> KBUILD_CFLAGS so that the compiler does not auto inline small functions,
> which causes this BUILD_BUG_ON to fail because p4d_index is no longer an
> integer constant expression.

There is no tree where this config option exists.

> According to the help text of the config, functions explicitly marked
> inline should still be inlined. As it turns out, GCC and Clang both
> support '-fno-inline-functions' but Clang only inlines functions when
> they are marked with an always inline annotation[1].
> 
> Since it's expected that p4d_index should always be inlined so that its
> value can be evaluated at build time, mark it as __always_inline.

Sorry no, that's just papering over the problem.

The point is that NO_AUTO_INLINE is/was meant to prevent the compiler from
automatically inlining functions, which are NOT marked inline in any form
in order to expand the traceability.

With GCC this makes sense, because it still inlines functions which are
solely marked inline and even if it decides not to inline them it will
evaluate them if they expand to a build time constant expression.

Now Clang decided to give -fno-inline-functions a different meaning,
i.e. the same as GCC has for -fno-inline, which prevents inlining for
everything except functions which are marked __always_inline.

So just "fixing" the build wreckage by duct taping one single instance of
inline functions is really a bad idea. The resulting kernel will be
bloatware because all regular inlines and we have tons of them will turn
into function calls even if the function overhead is larger than the
resulting inline code. Not to talk about the performance impact.

Anyway, as this option is found to be nowhere there is no point to apply
this patch.

Thanks,

	tglx




