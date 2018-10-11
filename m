Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BD2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F5120835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 04:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ztJPm8N8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F5120835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeJKLwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 07:52:40 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:57852 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJKLwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 07:52:39 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9B4R0Uo020431;
        Thu, 11 Oct 2018 13:27:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9B4R0Uo020431
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539232021;
        bh=xx3SjGOq88dVhXr42oImZfxipl5eTkXnWth3XRhe7vc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ztJPm8N8dOMo5b+fzFu9SKBaz7Cpu+bx50q7qHDDqZRoE3dRCchuL1AcOg28J+2Qw
         uNk3R8iPU+lmQau5O9BhE43A/FHNjTIPH+x920DB68KLRFyivzRs/iLe/OHRZzr+hr
         qzs385NSxEYi6ExFAEGi7dlzxbT8xtQBv61J6ncgotZmA1Wglo+M5xy0BGZZIbIU5w
         nC4O7MGo1WoDFetLYbJdYUNtXSSRGrGeb73FMI+zwDB0avuGG+3tqHQWEXqkHb8SZS
         NHseOouiCoGBuvF32I+uwqSXMo4dBpGcvJfZFvXgXsA9os0Bl2OaDmWiwgxeKu5zT4
         T479o4XQs/K/w==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id z130-v6so7256430vsc.7;
        Wed, 10 Oct 2018 21:27:00 -0700 (PDT)
X-Gm-Message-State: ABuFfogsrT6tyECkxYl2qoamNM87FazXEymJNnrs4winjajQ0Syhmh6b
        REYeQNUjOgIrpHRepml/Kfnkx06itVP/ky5p9N0=
X-Google-Smtp-Source: ACcGV60RjzJ0Uw3+Qjrh8lDOVTEVKoAgLJ77E9OW5Na/XhhSsrp58oUb3ur5hF0Rg+i8KSeHJY1sUrpF6G400SKKFS4=
X-Received: by 2002:a67:5fc7:: with SMTP id t190mr11825259vsb.155.1539232019652;
 Wed, 10 Oct 2018 21:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181010222333.17794-1-bp@alien8.de>
In-Reply-To: <20181010222333.17794-1-bp@alien8.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Oct 2018 13:26:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2KpYkn=hj=h1XmbMJRdtgCQ__xP0X+Rpwm3e_Xs1brQ@mail.gmail.com>
Message-ID: <CAK7LNAT2KpYkn=hj=h1XmbMJRdtgCQ__xP0X+Rpwm3e_Xs1brQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fail the build early when no lz4 present
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Thu, Oct 11, 2018 at 7:23 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> When building randconfigs, the build fails at kernel compression stage
> due to missing lz4 on the system but CONFIG_KERNEL_LZ4 has been selected
> by randconfig. The result looks somethins like this:
>
>     (cat arch/x86/boot/compressed/vmlinux.bin arch/x86/boot/compressed/vmlinux.relocs | lz4c -l -c1 stdin stdout && printf \334\141\301\001) > arch/x86/boot/compressed/vmlinux.bin.lz4 || (rm -f arch/x86/boot/compressed/vmlinux.bin.lz4 ; false)
>   /bin/sh: 1: lz4c: not found


So, the cause of the failure is clear enough
from the build log.



It is weird to check only lz4c.
If CONFIG_KERNEL_LZO is enabled, but lzop is not installed,
I see this log

  LZO     arch/x86/boot/compressed/vmlinux.bin.lzo
/bin/sh: 1: lzop: not found

It is still clear what to do, though.




>   make[2]: *** [arch/x86/boot/compressed/Makefile:143: arch/x86/boot/compressed/vmlinux.bin.lz4] Error 1
>   make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
>   make: *** [arch/x86/Makefile:290: bzImage] Error 2
>
> Fail the build much earlier by checking for lz4c presence before doing
> anything else.


Is it necessary to check this earlier?

If you get this error, you just need to install the tool.
Then, you can re-run the incremental build.


BTW, this patch has a drawback.

[1] Enable CONFIG_KERNEL_LZ4 on the system
    without lz4c installed

[2] Run 'make' and you will get the error
    "lz4 tool not found on this system but CONFIG_KERNEL_LZ4 enabled"

[3] Run 'make menuconfig' and
    switch from CONFIG_KERNEL_LZ4 to CONFIG_KERNEL_GZIP

[4] Run 'make' and you will still get the same error
    even after you have chosen to use GZIP instead of LZ4.




> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-kbuild@vger.kernel.org
> ---
>  Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index a0c32de80482..f91de649234b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -788,6 +788,12 @@ KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
>  LDFLAGS_vmlinux += --gc-sections
>  endif
>
> +ifdef CONFIG_KERNEL_LZ4
> +ifeq ($(CONFIG_SHELL which lz4c),)
> +$(error "lz4 tool not found on this system but CONFIG_KERNEL_LZ4 enabled")
> +endif
> +endif
> +
>  # arch Makefile may override CC so keep this after arch Makefile is included
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>
> --
> 2.19.0.271.gfe8321ec057f
>


-- 
Best Regards
Masahiro Yamada
