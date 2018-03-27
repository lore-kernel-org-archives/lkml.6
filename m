Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751253AbeC0GJR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 02:09:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52292 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeC0GJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 02:09:16 -0400
X-Google-Smtp-Source: AG47ELubTqh9NTQM3n9SHHteIxiIT9GcrlLtIm2fJ2YlNcdkSXJC4bqflKWX0VR8axZTWCLesbiLzg==
Date: Tue, 27 Mar 2018 08:09:11 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2,10/10] kbuild: mark $(targets) as .SECONDARY and
 remove .PRECIOUS markers
Message-ID: <20180327060911.iljk66zfuqnl472e@gmail.com>
References: <1522079634-5947-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522079634-5947-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> GNU Make automatically deletes intermediate files that are updated
> in a chain of pattern rules.
> 
> Example 1) %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
> Example 2) %.o <- %.c <- %.c_shipped
> 
> A couple of makefiles mark such targets as .PRECIOUS to prevent Make
> from deleting them, but the correct way is to use .SECONDARY.
> 
>   .SECONDARY
>     Prerequisites of this special target are treated as intermediate
>     files but are never automatically deleted.
> 
>   .PRECIOUS
>     When make is interrupted during execution, it may delete the target
>     file it is updating if the file was modified since make started.
>     If you mark the file as precious, make will never delete the file
>     if interrupted.
> 
> Both can avoid deletion of intermediate files, but the difference is
> the behavior when Make is interrupted; .SECONDARY deletes the target,
> but .PRECIOUS does not.
> 
> The use of .PRECIOUS is relatively rare since we do not want to keep
> partially constructed (possibly corrupted) targets.
> 
> Another difference is that .PRECIOUS works with pattern rules whereas
> .SECONDARY does not.
> 
>   .PRECIOUS: $(obj)/%.lex.c
> 
> works, but
> 
>   .SECONDARY: $(obj)/%.lex.c
> 
> has no effect.  However, for the reason above, I do not want to use
> .PRECIOUS which could cause obscure build breakage.
> 
> The targets specified as .SECONDARY must be explicit.  $(targets)
> contains all targets that need to include .*.cmd files.  So, the
> intermediates you want to keep are mostly in there.  Therefore, mark
> $(targets) as .SECONDARY.  It means primary targets are also marked
> as .SECONDARY, but I do not see any drawback for this.
> 
> I replaced some .SECONDARY / .PRECIOUS markers with 'targets'.  This
> will make Kbuild search for non-existing .*.cmd files, but this is
> not a noticeable performance issue.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Frank Rowand <frowand.list@gmail.com>
> ---
>  arch/arc/boot/dts/Makefile        |  2 --
>  arch/arm/crypto/Makefile          |  2 +-
>  arch/arm64/crypto/Makefile        |  2 +-
>  arch/metag/boot/dts/Makefile      |  2 --
>  arch/sparc/vdso/Makefile          |  4 +---
>  arch/x86/entry/vdso/Makefile      |  4 +---

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
