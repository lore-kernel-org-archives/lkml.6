Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24241C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59FA21712
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59FA21712
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeI1EMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:12:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42222 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbeI1EMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:12:09 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PBGDfYIejeeS; Thu, 27 Sep 2018 23:51:45 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC7FB00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:fb00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B24A1EC07DB;
        Thu, 27 Sep 2018 23:51:45 +0200 (CEST)
Date:   Thu, 27 Sep 2018 23:51:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     ndesaulniers@google.com
Cc:     mingo@redhat.com, tglx@linutronix.de,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/boot: define CC_HAVE_ASM_GOTO
Message-ID: <20180927215148.GE19687@zn.tnic>
References: <20180927204800.32210-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927204800.32210-1-ndesaulniers@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 01:47:58PM -0700, ndesaulniers@google.com wrote:
> Early prototypes of Clang with asm goto support produce 6 instances of
> the following warning:
> 
> In file included from arch/x86/boot/compressed/misc.h:20:
> In file included from ./include/linux/elf.h:5:
> In file included from ./arch/x86/include/asm/elf.h:8:
> In file included from ./include/linux/thread_info.h:38:
> In file included from ./arch/x86/include/asm/thread_info.h:53:
> ./arch/x86/include/asm/cpufeature.h:150:2: warning: "Compiler lacks
> ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
> [-W#warnings]
> your compiler arguments"
>  ^
> 
> Since 6 files under arch/x86/boot/compressed/ include
> arch/x86/boot/compressed/misc.h AND
> arch/x86/boot/compressed/Makefile happens to redefine KBUILD_CFLAGS,
> which set these variables in the top level MAKEFILE.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> v1 -> v2:
>   Updated commit message to provide more context as per Borislav.
> 
>  arch/x86/boot/compressed/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 28764dacf018..158c0b4e178a 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -56,6 +56,13 @@ KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
>  endif
>  LDFLAGS_vmlinux := -T
>  
> +# check for 'asm goto'
> +ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
> +  CC_HAVE_ASM_GOTO := 1
> +  KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
> +  KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
> +endif

I would still like to know why can't we do the -D_SETUP thing here:
https://lkml.kernel.org/r/20180926090841.GC5745@zn.tnic

instead of polluting this Makefile with defines which are not really
needed in the compressed kernel build, except to silence build warnings.

I mean, we can perpetuate that ugly hack and do:

#define __BPF_TRACING__

here in arch/x86/boot/compressed/misc.h which we could kill once clang
can do asm goto...

Hmm.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
