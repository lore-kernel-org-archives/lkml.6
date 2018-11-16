Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A99AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E595520818
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Rrs8oWZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E595520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389284AbeKPRtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:49:51 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:46812 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPRtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:49:51 -0500
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id wAG7cNpu001021;
        Fri, 16 Nov 2018 16:38:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wAG7cNpu001021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542353904;
        bh=1TLwEU6M1C5QZk1QV9eDsZ38WuaWZ1LkgLYkWWB5tGk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rrs8oWZ5q4Q5INtJZcFdENU9GCHbxljP0tQJZOb5IuxAIvdETcW0FsRfy9acTWRVm
         aAiDmkgbtIaDWAIUJM2tGPbojVVa/oqXZczzwXa5nXZNclSCD79vuQhBRFxFWvZFx5
         zDySQ2ZTk7WdMi+BwoH3vLPuMOF2Z2bMUsqACQuegweaIcNCm5YoMblbq4gf2uZkCd
         PHwDNGlZurz4qjpunnDhCwCm5ELOXKdDkX/gOXOdHwiHFKu5pLCCOdiusnq2MHxwaR
         fjCB7hkDavv1vt2a1b/mG7JqY1lHqZrIDLgiZrETeVsKH2Y7qUyO3/xUtN7OReRgA8
         +5zAcBHgkCwsA==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id v24so7924962uap.13;
        Thu, 15 Nov 2018 23:38:23 -0800 (PST)
X-Gm-Message-State: AGRZ1gKeOz0L3pApN1NNDdou15zbj4KbER7jmdoSMcCwsxJLmdwm4y94
        34LccMmH5FmZ8H0US87s4CBje9sCmcT0RXHvwoA=
X-Google-Smtp-Source: AJdET5c1jB6KqsLZkJEMTKXA32H8Wfr+7jg730uM7I18f5MBQirf8ay4RCvgLKTqmsUB/bOv9XA7UdK00R6CgCOp3ZA=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr4376929uap.6.1542353902576;
 Thu, 15 Nov 2018 23:38:22 -0800 (PST)
MIME-Version: 1.0
References: <20181114204309.18645-1-namit@vmware.com> <20181114204309.18645-3-namit@vmware.com>
In-Reply-To: <20181114204309.18645-3-namit@vmware.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 16 Nov 2018 16:37:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR30CVQHBTXzY-cFcpa-mw2QSpqUZHEAs7n0Jn64dLBFw@mail.gmail.com>
Message-ID: <CAK7LNAR30CVQHBTXzY-cFcpa-mw2QSpqUZHEAs7n0Jn64dLBFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86: set a dependency on macros.S
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
> Changes in macros.S should trigger the recompilation of all C files, as
> the macros might need to affect their compilation.
>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---

When we talked about this last time,
we agreed to not do this
because a single line change in asm headers
would cause global rebuilding.

Did you change your mind?




>  scripts/Makefile.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index b8d26bdf48b0..efec77991c2b 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -313,13 +313,13 @@ cmd_undef_syms = echo
>  endif
>
>  # Built-in and composite module parts
> -$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
> +$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) $(ASM_MACRO_FILE:.s=.S) FORCE
>         $(call cmd,force_checksrc)
>         $(call if_changed_rule,cc_o_c)
>
>  # Single-part modules are special since we need to mark them in $(MODVERDIR)
>
> -$(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
> +$(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) $(ASM_MACRO_FILE:.s=.S) FORCE
>         $(call cmd,force_checksrc)
>         $(call if_changed_rule,cc_o_c)
>         @{ echo $(@:.o=.ko); echo $@; \
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
