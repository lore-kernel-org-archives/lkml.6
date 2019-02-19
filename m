Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B86C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51C121736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="nxVO9fxj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfBSX4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:56:06 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:62278 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfBSX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:56:05 -0500
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x1JNtq3A018023;
        Wed, 20 Feb 2019 08:55:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x1JNtq3A018023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550620553;
        bh=m4XnWWS5K/BLi5lyScYNydViveYxZ2kk8e1PNzfqbB0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nxVO9fxjltnZhZjIo+lAqxARgKGKoyP2poSZbP5RhWH4sNT0CbZkDRZTak7kXXg6q
         OCv18KyRzcgzyslIQjokR5FvdiQ+2XuUFFL5YzeCKUnC9Dx2PduRHtWkSvxhaQj3Xa
         E9FFVgljZtahTwMaSSzB+5GKj3LPbpuB6jbNdswqNaahcvDfUy9xyVS+8Gy6DdngB4
         eFtcO20ypP6fg2x2n4xkF7yE8nP/Xeah58u3Jo6rif2kXFp/WsL69jkwjCC3YdOyiX
         Bw6Gau7ocVWFjGKfUHH3mGt50sOjxy13ywVatNtkRm0e6/j2b1ywHAIQbOpGGyD8s7
         S6J0dxpcKGRIA==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id 89so652389vkq.7;
        Tue, 19 Feb 2019 15:55:53 -0800 (PST)
X-Gm-Message-State: AHQUAubqr39AMuX0xRMCcUbGH+wI0s2N9Pg9xBHEKl+9dgO4RpyIyqxs
        /gOZT28V31/3lxk001fBAkWKn/SM5tZT4cWD1Xs=
X-Google-Smtp-Source: AHgI3IZrxUmE6BokIPR7cq+gpV8N4sh97DG+GXIp8ckzJZNHO/Pg3qLWTvCEPqTpQjCV7OSFl9EoAUp2tghUE6456nE=
X-Received: by 2002:a1f:5e96:: with SMTP id s144mr1686365vkb.74.1550620551997;
 Tue, 19 Feb 2019 15:55:51 -0800 (PST)
MIME-Version: 1.0
References: <20190201103648.GF31854@zn.tnic> <CAK7LNAQ4juLxrdMoPumQQ-96fMorf+wfAqkNxq1X1k=0i_R4vQ@mail.gmail.com>
 <20190201151139.GK31854@zn.tnic> <CAK7LNATVeX=6Mmn6A4+EGmZ9OSf=ePwbQWV1m1c=e=_LiebdNQ@mail.gmail.com>
 <20190202144227.GC27822@zn.tnic> <20190206104729.GC7314@zn.tnic>
 <CAK7LNAT+GhbEwP7v7NWd2kqW76qbXM1mtKhc21YXkp7BUJjzKQ@mail.gmail.com>
 <20190210123923.GA14948@zn.tnic> <20190218083008.GB4265@zn.tnic>
 <CAK7LNAQ_UfHcin1G_fqEX0qZ-AFe7=GHfnHZ2QZu1oe=dZW-aA@mail.gmail.com> <20190218143145.GF4265@zn.tnic>
In-Reply-To: <20190218143145.GF4265@zn.tnic>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 20 Feb 2019 08:55:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNATUcHwiy1btn7sgLmP0jx_OghRn4VNrK_A+4RcQNP4WmQ@mail.gmail.com>
Message-ID: <CAK7LNATUcHwiy1btn7sgLmP0jx_OghRn4VNrK_A+4RcQNP4WmQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Disable extra debugging info in .s output
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:32 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Feb 18, 2019 at 06:10:57PM +0900, Masahiro Yamada wrote:
> > Could you send v2 as I suggested?
> > Your commit log describes your motivation perfectly.
> >
> > (I lost the applicable patch because
> > I just modified the code locally and pasted it
> > into the previous email.)
>
> Sure, here it is.
>
> Thx.


Applied to linux-kbuild.

Thanks.


> ---
> From: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date: Sun, 25 Nov 2018 23:58:00 +0100
> Subject: [PATCH] kbuild: Disable extra debugging info in .s output
>
> Modern gcc adds view assignments, reset assertion checking in .loc
> directives and a couple more additional debug markers, which clutters
> the asm output unnecessarily:
>
> For example:
>
>   bsp_resume:
>   .LFB3466:
>           .loc 1 1868 1 is_stmt 1 view -0
>           .cfi_startproc
>           .loc 1 1869 2 view .LVU73
>   # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
>           .loc 1 1869 14 is_stmt 0 view .LVU74
>           movq    this_cpu(%rip), %rax    # this_cpu, this_cpu
>           movq    64(%rax), %rax  # this_cpu.94_1->c_bsp_resume, _2
>   # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
>           .loc 1 1869 5 view .LVU75
>           testq   %rax, %rax      # _2
>           je      .L8     #,
>           .loc 1 1870 3 is_stmt 1 view .LVU76
>           movq    $boot_cpu_data, %rdi    #,
>           jmp     __x86_indirect_thunk_rax
>
> or
>         .loc 2 57 9 view .LVU478
>         .loc 2 57 9 view .LVU479
>         .loc 2 57 9 view .LVU480
>         .loc 2 57 9 view .LVU481
>   .LBB1385:
>   .LBB1383:
>   .LBB1379:
>   .LBB1377:
>   .LBB1375:
>         .loc 2 57 9 view .LVU482
>         .loc 2 57 9 view .LVU483
>         movl    %edi, %edx      # cpu, cpu
>   .LVL87:
>         .loc 2 57 9 is_stmt 0 view .LVU484
>
> That MOV in there is drowned in debugging information and latter makes
> it hard to follow the asm. And that DWARF info is not really needed for
> asm output staring.
>
> Disable the debug information generation which clutters the asm output
> unnecessarily:
>
>   bsp_resume:
>   # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
>           movq    this_cpu(%rip), %rax    # this_cpu, this_cpu
>           movq    64(%rax), %rax  # this_cpu.94_1->c_bsp_resume, _2
>   # arch/x86/kernel/cpu/common.c:1869:    if (this_cpu->c_bsp_resume)
>           testq   %rax, %rax      # _2
>           je      .L8     #,
>   # arch/x86/kernel/cpu/common.c:1870:            this_cpu->c_bsp_resume(&boot_cpu_data);
>           movq    $boot_cpu_data, %rdi    #,
>           jmp     __x86_indirect_thunk_rax
>   .L8:
>   # arch/x86/kernel/cpu/common.c:1871: }
>           rep ret
>           .size   bsp_resume, .-bsp_resume
>
>   [ bp: write commit message. ]
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-kbuild@vger.kernel.org
> ---
>  Makefile               | 13 ++++++++-----
>  scripts/Makefile.build |  2 +-
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 96c5335e7ee4..c5e7d3ac8bd2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -729,25 +729,28 @@ KBUILD_CFLAGS     += -fomit-frame-pointer
>  endif
>  endif
>
> -KBUILD_CFLAGS   += $(call cc-option, -fno-var-tracking-assignments)
> +DEBUG_CFLAGS   := $(call cc-option, -fno-var-tracking-assignments)
>
>  ifdef CONFIG_DEBUG_INFO
>  ifdef CONFIG_DEBUG_INFO_SPLIT
> -KBUILD_CFLAGS   += $(call cc-option, -gsplit-dwarf, -g)
> +DEBUG_CFLAGS   += $(call cc-option, -gsplit-dwarf, -g)
>  else
> -KBUILD_CFLAGS  += -g
> +DEBUG_CFLAGS   += -g
>  endif
>  KBUILD_AFLAGS  += -Wa,-gdwarf-2
>  endif
>  ifdef CONFIG_DEBUG_INFO_DWARF4
> -KBUILD_CFLAGS  += $(call cc-option, -gdwarf-4,)
> +DEBUG_CFLAGS   += $(call cc-option, -gdwarf-4,)
>  endif
>
>  ifdef CONFIG_DEBUG_INFO_REDUCED
> -KBUILD_CFLAGS  += $(call cc-option, -femit-struct-debug-baseonly) \
> +DEBUG_CFLAGS   += $(call cc-option, -femit-struct-debug-baseonly) \
>                    $(call cc-option,-fno-var-tracking)
>  endif
>
> +KBUILD_CFLAGS += $(DEBUG_CFLAGS)
> +export DEBUG_CFLAGS
> +
>  ifdef CONFIG_FUNCTION_TRACER
>  ifdef CONFIG_FTRACE_MCOUNT_RECORD
>    # gcc 5 supports generating the mcount tables directly
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index fd03d60f6c5a..8f5c86da77b1 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -104,7 +104,7 @@ modkern_cflags =                                          \
>  quiet_modtag = $(if $(part-of-module),[M],   )
>
>  quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
> -cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
> +cmd_cc_s_c       = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
>
>  $(obj)/%.s: $(src)/%.c FORCE
>         $(call if_changed_dep,cc_s_c)
> --
> 2.19.1
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
Best Regards
Masahiro Yamada
