Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED586C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67FE20866
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Jv7oQkw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67FE20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389383AbeKPR5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:57:54 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:33344 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeKPR5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:57:54 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wAG7kLIW001911;
        Fri, 16 Nov 2018 16:46:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wAG7kLIW001911
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542354382;
        bh=mSIaM80lKQM6WnIT8smcqcoEF4UdZo3JtBe9nCPAxlg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jv7oQkw8yx9Niwx/vTUumZb5e6uxNfxPcNfOmdwu/M2ZEb3Bd2HvQst8nkWScLEeb
         2E9GG204z/ZTpri4gH8wRw/rUgWG8lW+dsl56iqEOp5mPpl7UzyZhM3+7zyou46C/Z
         1oNG5vN72QglgazWqm8ixKp05nV19q6yTeyrT9Lds5j4ksZkgir5U+W5/Ib4ZqEjHs
         81qKD+y8iaOwTvmXyblZHbxHS8t3SdQHvjEZ+Y48Uyb3DWceoBhTQoUYIMA+ihBscG
         7dv2fk7bE75fR6wvgp4PbhBxNK2Ly4fms8cTlrI2EHCn/T6qHuo8l/D0km08lxBpU5
         xLuXJrklJezGQ==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id g68so13221159vsd.11;
        Thu, 15 Nov 2018 23:46:22 -0800 (PST)
X-Gm-Message-State: AGRZ1gJSEIXFV8++l796UVRKZA8RM1Fqr812ouIJQFMVvF8+Ulv5BMSO
        cP37DtuSZjPDDzwqBjkzLBXlQABa8TrE2zS3ZA4=
X-Google-Smtp-Source: AJdET5ft5S8gv3wUzvLlM1jiuifp4YkkTAuEyLH0tvHt6QSgLHkVm1NvSCdp+7coO7FKsiDIuEYJNgJKmfJ+3l/uVtE=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr4170539vsb.155.1542354381242;
 Thu, 15 Nov 2018 23:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20181114204309.18645-1-namit@vmware.com> <20181114204309.18645-2-namit@vmware.com>
In-Reply-To: <20181114204309.18645-2-namit@vmware.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 16 Nov 2018 16:45:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREF_Pcejq1LJ=3K7h0M4o4oSRLfbeJc73O+8HV420Ziw@mail.gmail.com>
Message-ID: <CAK7LNAREF_Pcejq1LJ=3K7h0M4o4oSRLfbeJc73O+8HV420Ziw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Makefile: Fix distcc compilation with x86 macros
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 1:01 PM Nadav Amit <namit@vmware.com> wrote:
>
> Introducing the use of asm macros in c-code broke distcc, since it only
> sends the preprocessed source file. The solution is to break the
> compilation into two separate phases of compilation and assembly, and
> between the two concatenate the assembly macros and the compiled (yet
> not assembled) source file. Since this is less efficient, this
> compilation mode is only used when distcc or icecc are used.
>
> Note that the assembly stage should also be distributed, if distcc is
> configured using "CFLAGS=-DENABLE_REMOTE_ASSEMBLE".
>
> Reported-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Nadav Amit <namit@vmware.com>


Wow, this is so ugly.
I realized how much I hated this by now.

My question is, how long do we need to carry this?


As far as I understood from the long discussion
https://lkml.org/lkml/2018/10/7/92
people are trying to deal with it on the compiler side.
Is it right?


https://gcc.gnu.org/ml/gcc-patches/2018-10/msg01932.html

Once it is supported, what would happen on the kernel side?





> ---
>  Makefile               |  4 +++-
>  arch/x86/Makefile      |  7 +++++--
>  scripts/Makefile.build | 30 ++++++++++++++++++++++++++++--
>  3 files changed, 36 insertions(+), 5 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9fce8b91c15f..c07349fc38c7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -743,7 +743,9 @@ KBUILD_CFLAGS   += $(call cc-option, -gsplit-dwarf, -g)
>  else
>  KBUILD_CFLAGS  += -g
>  endif
> -KBUILD_AFLAGS  += -Wa,-gdwarf-2
> +AFLAGS_DEBUG_INFO = -Wa,-gdwarf-2
> +export AFLAGS_DEBUG_INFO
> +KBUILD_AFLAGS  += $(AFLAGS_DEBUG_INFO)
>  endif
>  ifdef CONFIG_DEBUG_INFO_DWARF4
>  KBUILD_CFLAGS  += $(call cc-option, -gdwarf-4,)
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index f5d7f4134524..b5953cbcc9c8 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -235,10 +235,13 @@ archscripts: scripts_basic
>  archheaders:
>         $(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
>
> +ASM_MACRO_FILE = arch/x86/kernel/macros.s
> +export ASM_MACRO_FILE
> +
>  archmacros:
> -       $(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
> +       $(Q)$(MAKE) $(build)=arch/x86/kernel $(ASM_MACRO_FILE)
>
> -ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
> +ASM_MACRO_FLAGS = -Wa,$(ASM_MACRO_FILE)
>  export ASM_MACRO_FLAGS
>  KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 6a6be9f440cf..b8d26bdf48b0 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -155,8 +155,34 @@ $(obj)/%.ll: $(src)/%.c FORCE
>
>  quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
>
> +# If distcc (or icecc) are used, and when assembly macro files are needed, the
> +# compilation stage and the assembly stage needs to be separated. Providing the
> +# "IGNORE_DISTCC=y" option disables separate compilation and assembly.
> +
> +cmd_cc_o_c_direct = $(CC) $(c_flags) -c -o $(1) $<
> +
> +ifneq ($(if $(IGNORE_DISTCC),,$(shell $(CC) --version 2>&1 | head -n 1 | grep -E 'distcc|ICECC')),)
> +a_flags_no_debug = $(filter-out $(AFLAGS_DEBUG_INFO), $(a_flags))
> +c_flags_no_macros = $(filter-out $(ASM_MACRO_FLAGS), $(c_flags))
> +
> +cmd_cc_o_c_two_steps =                                                 \
> +       $(CC) $(c_flags_no_macros) $(DISABLE_LTO) -fverbose-asm -S      \
> +               -o $(@D)/.$(@F:.o=.s) $<;                               \
> +       cat $(ASM_MACRO_FILE) $(@D)/.$(@F:.o=.s) >                      \
> +               $(@D)/.tmp_$(@F:.o=.s);                                 \
> +       $(CC) $(a_flags_no_debug) -c -o $(1) $(@D)/.tmp_$(@F:.o=.s);    \
> +       rm -f $(@D)/.$(@F:.o=.s) $(@D)/.tmp_$(@F:.o=.s)                 \
> +
> +cmd_cc_o_c_helper =                                                    \
> +       $(if $(findstring $(ASM_MACRO_FLAGS),$(c_flags)),               \
> +               $(call cmd_cc_o_c_two_steps, $(1)),                     \
> +               $(call cmd_cc_o_c_direct, $(1)))
> +else
> +cmd_cc_o_c_helper = $(call cmd_cc_o_c_direct, $(1))
> +endif
> +
>  ifndef CONFIG_MODVERSIONS
> -cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
> +cmd_cc_o_c = $(call cmd_cc_o_c_helper,$@)
>
>  else
>  # When module versioning is enabled the following steps are executed:
> @@ -171,7 +197,7 @@ else
>  #   replace the unresolved symbols __crc_exported_symbol with
>  #   the actual value of the checksum generated by genksyms
>
> -cmd_cc_o_c = $(CC) $(c_flags) -c -o $(@D)/.tmp_$(@F) $<
> +cmd_cc_o_c = $(call cmd_cc_o_c_helper,$(@D)/.tmp_$(@F))
>
>  cmd_modversions_c =                                                            \
>         if $(OBJDUMP) -h $(@D)/.tmp_$(@F) | grep -q __ksymtab; then             \
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
