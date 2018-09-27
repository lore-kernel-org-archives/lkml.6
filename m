Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDAEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7774D2170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kSooQyuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7774D2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbeI1EBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:01:13 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46158 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeI1EBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:01:13 -0400
Received: by mail-yw1-f65.google.com with SMTP id j131-v6so1725985ywc.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wfwDpfOTv54migrv0pQxbRWBfV25dkIJAXoW94zHESs=;
        b=kSooQyucwqmFofBptmwdrPuvTP6qUUhQ/3GST9cHgwCYIgSVhSnX9fXzmwpAMTnSIz
         utypt/qb6AkG+FSki25K3AiyUFYfm8fHQ6TP/jEf6h8I8XgnPNloRUG2FZSARZshiJXv
         9PeOrwVvpr9uj5LP9A5RmVUDeRO+ZC8XougIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wfwDpfOTv54migrv0pQxbRWBfV25dkIJAXoW94zHESs=;
        b=a3PEqJY/fz9qgqjs+ltXw/vyq7V7VNWKa8tiZVzSJKGEyWZadBRq40GSRwOPquLlTP
         6QsVeOoVl2GGq+MPIe1zfUIgx7Z0ww0ix0M1WwBJNIpFRyKA1Vu/3iVzQ/PRLOpeK3Ml
         m198Ax/bVqnxssX2v0kLPuyS06JxdWJkrD4B2Z3RmXdxCINE4V2akJx/rX/WLmumXG4I
         4ROzZJPVqE/55pK4PZgsSYHpzv2nIxtKlizldAcXtfbz/y0XesNlB0bjL/UiyJDX06cu
         XVUiDvLoKk656NdFWfxo0tS2Kcm+1AqXTLDStou9ZFrFt9h+7JUQY2fA6LzmYLe482fa
         yP9A==
X-Gm-Message-State: ABuFfogKUvj8VbKcQ0ceBohcP64UgS/LGmZTpbS3AtQ69aavzHjE0lS4
        10AZxFbN6PyLIr2n1hGXwBL0yWzph8c=
X-Google-Smtp-Source: ACcGV63EgpSZVUadzG7/sg64cRzK1pFr5/wtbfu1oky3E7YcOfwvSNy3kDvs6ndoDQfK5zDz1818WQ==
X-Received: by 2002:a0d:cd01:: with SMTP id p1-v6mr7026040ywd.74.1538084453090;
        Thu, 27 Sep 2018 14:40:53 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 193-v6sm1621549ywd.40.2018.09.27.14.40.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 14:40:50 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id o63-v6so1788596yba.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 14:40:49 -0700 (PDT)
X-Received: by 2002:a25:396:: with SMTP id 144-v6mr7162234ybd.403.1538084449343;
 Thu, 27 Sep 2018 14:40:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 27 Sep 2018 14:40:48
 -0700 (PDT)
In-Reply-To: <20180927204800.32210-1-ndesaulniers@google.com>
References: <20180927204800.32210-1-ndesaulniers@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 27 Sep 2018 14:40:48 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJcPm+xDuCDeMzimWto4ThpHG5+fMnmQxLbmaf8RL7EUw@mail.gmail.com>
Message-ID: <CAGXu5jJcPm+xDuCDeMzimWto4ThpHG5+fMnmQxLbmaf8RL7EUw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/boot: define CC_HAVE_ASM_GOTO
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 1:47 PM,  <ndesaulniers@google.com> wrote:
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
> +
>  hostprogs-y    := mkpiggy
>  HOST_EXTRACFLAGS += -I$(srctree)/tools/include
>
> --
> 2.19.0.605.g01d371f741-goog
>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
