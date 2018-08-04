Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63695C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008D62178D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Ndtuk6SR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008D62178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeHDGwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 02:52:08 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:45896 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHDGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 02:52:08 -0400
Received: from mail-ua0-f181.google.com (mail-ua0-f181.google.com [209.85.217.181]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w744qbDM026432;
        Sat, 4 Aug 2018 13:52:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w744qbDM026432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533358357;
        bh=8s6Gqsy9H/AVCb5MmhfHMujpLArr+HgRw/1t6/7c0oM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Ndtuk6SRdKx7fQqpD65AimBFPrvpHm+HaRj6SyMu96sp5+5DL2oQfY1OwaZr4AzlH
         5Ai+VfCBNY/66Vgj+fAdNlOxzWp0Hv5hf64GIsXF0EvWGu1pxeXCZn+qKuqtauGY5Y
         lCbLqJdj0DTWDTb9xLjU+n7OcMnd6CFV9CK24hk/T73YyWl5N3Sb0OO9RS/h2zB+ce
         lknVS8wLRXMRDbgEtQspwk45dcrCM91KKotXNxkZeLyYqN3UV9Ar0AzaFdCd+1d3kK
         uToRkX9+0edXLS1TPyY4CjTLvlJmF20P/RzgVehh/ylN/o8Vi47tpUIS0npiwH+P7B
         m3P6w9dMvVkgQ==
X-Nifty-SrcIP: [209.85.217.181]
Received: by mail-ua0-f181.google.com with SMTP id i4-v6so6689548uak.0;
        Fri, 03 Aug 2018 21:52:37 -0700 (PDT)
X-Gm-Message-State: AOUpUlEhMYHTSsJm9Ai1kYcoFtNqAQ7DzhcPv2fvqKJv5wJ4TGaQh/8j
        tfNv18D9qlle9GvS+9F0GDKN06/NF2kINv8eyqY=
X-Google-Smtp-Source: AAOMgpcAj9Ol3dqEaOz9YbDGGhChv/SRkYiEQ0FAa3rTGcLjuQXl/QpcRd3E7DDJEp9aNa0qZHuzwYwfs9Lijyxpy2o=
X-Received: by 2002:ab0:52f1:: with SMTP id w46-v6mr4449827uaw.52.1533358356455;
 Fri, 03 Aug 2018 21:52:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 21:51:56 -0700 (PDT)
In-Reply-To: <1533358023-5801-2-git-send-email-yamada.masahiro@socionext.com>
References: <1533358023-5801-1-git-send-email-yamada.masahiro@socionext.com> <1533358023-5801-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 4 Aug 2018 13:51:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-sb0Um_R+jw4ymac+5yaCCW7CkgoR7-HEsND4u4PMxw@mail.gmail.com>
Message-ID: <CAK7LNAS-sb0Um_R+jw4ymac+5yaCCW7CkgoR7-HEsND4u4PMxw@mail.gmail.com>
Subject: Re: [PATCH 1/3] um: fix parallel building with O= option
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-04 13:47 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Randy Dunlap reports UML occasionally fails to build with -j<N> and
> O=<builddir> options.
>
>   make[1]: Entering directory '/home/rdunlap/mmotm-2018-0802-1529/UM64'
>     UPD     include/generated/uapi/linux/version.h
>     WRAP    arch/x86/include/generated/asm/dma-contiguous.h
>     WRAP    arch/x86/include/generated/asm/export.h
>     WRAP    arch/x86/include/generated/asm/early_ioremap.h
>     WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
>     WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
>     WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
>     WRAP    arch/x86/include/generated/uapi/asm/poll.h
>     GEN     ./Makefile
>   make[2]: *** No rule to make target 'archheaders'.  Stop.
>   arch/um/Makefile:119: recipe for target 'archheaders' failed
>   make[1]: *** [archheaders] Error 2
>   make[1]: *** Waiting for unfinished jobs....
>     UPD     include/config/kernel.release
>   make[1]: *** wait: No child processes.  Stop.
>   Makefile:146: recipe for target 'sub-make' failed
>   make: *** [sub-make] Error 2
>
> The cause of the problem is the use of '$(MAKE) KBUILD_SRC=',
> which recurses to the top Makefile via the $(objtree)/Makefile
> generated by scripts/mkmakefile.
>
> When you run "make -j<N> O=<builddir> ARCH=um", Make can execute
> 'archheaders' and 'outputmakefile' targets simultaneously because
> there is no dependency between them.
>
> If it happens,
>
>   $(Q)$(MAKE) KBUILD_SRC= ARCH=$(HEADER_ARCH) archheaders
>
> ... tries to run $(objtree)/Makefile that is being updated.
>
> The correct way for the recursion is
>
>   $(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) archheaders
>
> ..., which does not rely on the generated Makefile.
>



I forgot to add this:

Reported-by: Randy Dunlap <rdunlap@infradead.org>




> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/um/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index e54dda8..de340e4 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -122,8 +122,7 @@ archheaders:
>         $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
>                     kbuild-file=$(HOST_DIR)/include/uapi/asm/Kbuild \
>                     obj=$(HOST_DIR)/include/generated/uapi/asm
> -       $(Q)$(MAKE) KBUILD_SRC= ARCH=$(HEADER_ARCH) archheaders
> -
> +       $(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) archheaders
>
>  archprepare: include/generated/user_constants.h
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
