Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40103C46475
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 01:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40AB207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 01:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wsi8rOiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40AB207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeJ1K20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 06:28:26 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:52235 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbeJ1K2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 06:28:25 -0400
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9S1jMra007751;
        Sun, 28 Oct 2018 10:45:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9S1jMra007751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540691123;
        bh=Tn+rYbGM8cSqr90PRyZrhUUZaBYEcdDuyvmQzynKCoE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wsi8rOiK2z8ZtiGUe4xkGDW2lL5KWo5i+H88/LiOCqK8bEHV0JtnJ0yNd7T0mB1Bz
         kxs9ZACJfOtyv9epeRl5yDU7LdfW+U75LdLb4rdny1lrwB9BrzGlXF4nc77wA+7btJ
         SC7T9x0DzNm7qiMGB1VsqqrwY7jGNak8Vx0OD9sxjHJDOEj/Hf+SRX+vx3IrqywIkJ
         kjneFzzhl4lgONFLio81FCRlM0PpHN+yMUbkIqEgx9pfymbPyaoym4Tc3++SiNDAxt
         Ba//zAlCgViJmJSeZWDC0S6Waxs5tnU1TaEBhFit5MqPfRs4ANl5NruoiXqh0euRix
         CyB98glLxIDVg==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id t127so462681vke.8;
        Sat, 27 Oct 2018 18:45:23 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLLipR0eUjCyvOB3tRG4Vb/zARI59m31hLuHel/AZwcIEOrkZ4/
        jftQIN/+JAJmnMOiThOsqx2vkGVaHJkTq8cx8ng=
X-Google-Smtp-Source: AJdET5c6eCbNc1ujNaasnY7CywXLYpfh0KhZ6Bw2UyXnWDiOWDTN6Mcy96X4btSFCsddOucFI5K1low6CstsEYDX9A0=
X-Received: by 2002:a1f:b215:: with SMTP id b21-v6mr4178822vkf.0.1540691122350;
 Sat, 27 Oct 2018 18:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181019124921.13780-1-changbin.du@gmail.com> <20181019124921.13780-2-changbin.du@gmail.com>
In-Reply-To: <20181019124921.13780-2-changbin.du@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 28 Oct 2018 10:44:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQJxVDWU5GPY4O6x+z_Pkmh4KuHiTpkY_LDJwNYO-eCBw@mail.gmail.com>
Message-ID: <CAK7LNAQJxVDWU5GPY4O6x+z_Pkmh4KuHiTpkY_LDJwNYO-eCBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] x86/mm: surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif
To:     changbin.du@gmail.com
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 9:50 PM Du Changbin <changbin.du@gmail.com> wrote:
>
> The level4_kernel_pgt is only defined when X86_5LEVEL is enabled. So
> surround level4_kernel_pgt with #ifdef CONFIG_X86_5LEVEL...#endif to
> make code correct.

For clarification, is it better to mention
that this is a preparation for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING ?


> Signed-off-by: Du Changbin <changbin.du@gmail.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/x86/include/asm/pgtable_64.h |  2 ++
>  arch/x86/kernel/head64.c          | 13 ++++++-------
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
> index 9c85b54bf03c..9333f7fa5bdb 100644
> --- a/arch/x86/include/asm/pgtable_64.h
> +++ b/arch/x86/include/asm/pgtable_64.h
> @@ -16,7 +16,9 @@
>  #include <linux/threads.h>
>  #include <asm/fixmap.h>
>
> +#ifdef CONFIG_X86_5LEVEL
>  extern p4d_t level4_kernel_pgt[512];
> +#endif


Is this #ifdef  necessary?

It is harmless to declaring unused stuff.



>  extern p4d_t level4_ident_pgt[512];
>  extern pud_t level3_kernel_pgt[512];
>  extern pud_t level3_ident_pgt[512];
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index ddee1f0870c4..4a59ef93c258 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -151,16 +151,15 @@ unsigned long __head __startup_64(unsigned long physaddr,
>
>         pgd = fixup_pointer(&early_top_pgt, physaddr);
>         p = pgd + pgd_index(__START_KERNEL_map);
> -       if (la57)
> -               *p = (unsigned long)level4_kernel_pgt;
> -       else
> -               *p = (unsigned long)level3_kernel_pgt;
> -       *p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
> -
> +#ifdef CONFIG_X86_5LEVEL
>         if (la57) {
> +               *p = (unsigned long)level4_kernel_pgt;
>                 p4d = fixup_pointer(&level4_kernel_pgt, physaddr);
>                 p4d[511] += load_delta;
> -       }
> +       } else
> +#endif
> +               *p = (unsigned long)level3_kernel_pgt;
> +       *p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
>
>         pud = fixup_pointer(&level3_kernel_pgt, physaddr);
>         pud[510] += load_delta;
> --
> 2.17.1
>


Hmm, this code looks a bit ugly...

Does the following one liner work with CONFIG_CC_OPTIMIZE_FOR_DEBUGGING ?


diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 8047379..579847f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -97,7 +97,7 @@ static bool __head check_la57_support(unsigned long physaddr)
        return true;
 }
 #else
-static bool __head check_la57_support(unsigned long physaddr)
+static __always_inline bool __head check_la57_support(unsigned long physaddr)
 {
        return false;
 }




--
Best Regards
Masahiro Yamada
