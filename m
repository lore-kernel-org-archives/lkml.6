Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADE6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEC320856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf/Xw1Zy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEC320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeGVAXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 20:23:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbeGVAXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 20:23:47 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD69520856
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 23:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532215758;
        bh=GmpP38JKyuO2NM1CDT/Loh2aFcVZegE/jFmJbIL5YDA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=gf/Xw1ZyfRUxHrFIjF2GS6SZATYAyHvqA3NDi5VxsSNfGGGBj9bxjf9PiylR8Fhim
         AKTcK9mJrxBL9J3/wBsn1v9h0XHQBbk2S5pQI4lxezdtOSzcU4a9iCYODpa0ixPgji
         HJp+HWmKuZlM8EkjwnZTemclazhdH3W7VfI+AlRQ=
Received: by mail-wr1-f44.google.com with SMTP id g6-v6so14438619wrp.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 16:29:17 -0700 (PDT)
X-Gm-Message-State: AOUpUlH7fchcMk9+hiDilXRoMMF30FUt24Zqu8otjoc3N9akCbYuajrT
        WUuy3V0xXAp+ESHjip5bKEnTDcyTkM4WD8vfc9RlPw==
X-Google-Smtp-Source: AAOMgpfdzd6XdmNu79GlJjPNFX0afI4VENZ3q1/hWVHJ5VjJwdK2mzT6UjXt1ozb0khM6Q9zvW71nP1iI/sOF2Vs7ys=
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr4675246wrd.67.1532215756363;
 Sat, 21 Jul 2018 16:29:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 16:28:55
 -0700 (PDT)
In-Reply-To: <20180718224159.18236-1-astrachan@google.com>
References: <20180718224159.18236-1-astrachan@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 21 Jul 2018 16:28:55 -0700
X-Gmail-Original-Message-ID: <CALCETrW9tha_CedoCPWfkXRjOWmb5HeT3D3Nh3-fq33yJb9VfQ@mail.gmail.com>
Message-ID: <CALCETrW9tha_CedoCPWfkXRjOWmb5HeT3D3Nh3-fq33yJb9VfQ@mail.gmail.com>
Subject: Re: [PATCH] x86: vdso: Use $LD instead of $CC to link
To:     Alistair Strachan <astrachan@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        joel@joelfernandes.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 3:41 PM, Alistair Strachan <astrachan@google.com> wrote:
> The vdso{32,64}.so can fail to link with CC=clang when clang tries to
> find a suitable GCC toolchain to link these libraries with.
>
> /usr/bin/ld: arch/x86/entry/vdso/vclock_gettime.o:
>   access beyond end of merged section (782)
>
> This happens because the host environment leaked into the cross
> compiler environment due to the way clang searches for suitable GCC
> toolchains.
>
> Clang is a retargetable compiler, and each invocation of it must
> provide --target=<something> --gcc-toolchain=<something> to allow it
> to find the correct binutils for cross compilation. These flags had
> been added to KBUILD_CFLAGS, but the vdso code uses CC and not
> KBUILD_CFLAGS (for various reasons) which breaks clang's ability to
> find the correct linker when cross compiling.
>
> Most of the time this goes unnoticed because the host linker is new
> enough to work anyway, or is incompatible and skipped, but this cannot
> be reliably assumed.
>
> This change alters the vdso makefile to just use LD directly, which
> bypasses clang and thus the searching problem. The makefile will just
> use ${CROSS_COMPILE}ld instead, which is always what we want. This
> matches the method used to link vmlinux.

Acked-by: Andy Lutomirski <luto@kernel.org>



>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: x86@kernel.org
> Cc: kernel-team@android.com
> Cc: joel@joelfernandes.com
> Signed-off-by: Alistair Strachan <astrachan@google.com>
> ---
> Supersedes "x86: vdso: Fix leaky vdso link with CC=clang"
>  arch/x86/entry/vdso/Makefile | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 1943aebadede..896a55204386 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -48,10 +48,8 @@ targets += $(vdso_img_sodbg)
>
>  export CPPFLAGS_vdso.lds += -P -C
>
> -VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
> -                       -Wl,--no-undefined \
> -                       -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096 \
> -                       $(DISABLE_LTO)
> +VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
> +                       -z max-page-size=4096 -z common-page-size=4096
>
>  $(obj)/vdso64.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
>         $(call if_changed,vdso)
> @@ -97,10 +95,8 @@ CFLAGS_REMOVE_vvar.o = -pg
>  #
>
>  CPPFLAGS_vdsox32.lds = $(CPPFLAGS_vdso.lds)
> -VDSO_LDFLAGS_vdsox32.lds = -Wl,-m,elf32_x86_64 \
> -                          -Wl,-soname=linux-vdso.so.1 \
> -                          -Wl,-z,max-page-size=4096 \
> -                          -Wl,-z,common-page-size=4096
> +VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-vdso.so.1 \
> +                          -z max-page-size=4096 -z common-page-size=4096
>
>  # 64-bit objects to re-brand as x32
>  vobjs64-for-x32 := $(filter-out $(vobjs-nox32),$(vobjs-y))
> @@ -128,7 +124,7 @@ $(obj)/vdsox32.so.dbg: $(src)/vdsox32.lds $(vobjx32s) FORCE
>         $(call if_changed,vdso)
>
>  CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
> -VDSO_LDFLAGS_vdso32.lds = -m32 -Wl,-m,elf_i386 -Wl,-soname=linux-gate.so.1
> +VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
>
>  targets += vdso32/vdso32.lds
>  targets += vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
> @@ -162,13 +158,13 @@ $(obj)/vdso32.so.dbg: FORCE \
>  # The DSO images are built using a special linker script.
>  #
>  quiet_cmd_vdso = VDSO    $@
> -      cmd_vdso = $(CC) -nostdlib -o $@ \
> +      cmd_vdso = $(LD) -nostdlib -o $@ \
>                        $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
> -                      -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
> +                      -T $(filter %.lds,$^) $(filter %.o,$^) && \
>                  sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
>
> -VDSO_LDFLAGS = -fPIC -shared $(call cc-ldoption, -Wl$(comma)--hash-style=both) \
> -       $(call cc-ldoption, -Wl$(comma)--build-id) -Wl,-Bsymbolic $(LTO_CFLAGS)
> +VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
> +       $(call ld-option, --build-id) -Bsymbolic
>  GCOV_PROFILE := n
>
>  #
