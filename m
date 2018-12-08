Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5534EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1502020868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 06:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mZf+U1Xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1502020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeLHGgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 01:36:51 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23479 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHGgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 01:36:50 -0500
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wB86aOit026801
        for <linux-kernel@vger.kernel.org>; Sat, 8 Dec 2018 15:36:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wB86aOit026801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544250984;
        bh=6fX3xVjwCchO1nhpz25rURfoq1T4iKEXomymFDqmhO8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mZf+U1XtZqK6GLyIJv8H4y8qALP9wLHggjbapGBaM+EhhKHg3mv4XAFhYdyY5IXRJ
         YkEJjz3N3GsVl8BkzSweBRjGpLEewLVop9BK5z2l4Au6thxHJl80aZDiNhS1ogt9u1
         EbxvZw2NtHni0XN31udJeqGeSr1/Erg/6m2Hoc/5nlxLTpEGEN1fhDDQO4vWmtheNv
         NicGz6Isb/t1ghAWXLYDgVYQ0Qng/DGnzg/3nGxk/k2bY9yJnxFjd6lWl6UifZvaR7
         wp5ENVOzquNN50W/a+mhFgKoUZEbnl/RvoWOYvo963hFW1wNaCTD/ULzGSJY23h8D3
         Uy0J0u3ZQrHmA==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id t132so1457211vkc.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 22:36:24 -0800 (PST)
X-Gm-Message-State: AA+aEWYCsWE5x/zPN7x9DM3pKm5Swb5/TzWt6vORBZnybxBSji1KqEnr
        V1QooD0c4CKPEQEryI5UlSFBNkPgA1os4b78Djk=
X-Google-Smtp-Source: AFSGD/X+m7N/Mg+EFKExbJTUTujo3qCKF2DZB9DBxFPnRC7lLZjJunWqzYJVM5n1WNHvp5d1WWXERiVqwv4n9VfLAYI=
X-Received: by 2002:a1f:6bc8:: with SMTP id k69mr2067083vki.84.1544250983350;
 Fri, 07 Dec 2018 22:36:23 -0800 (PST)
MIME-Version: 1.0
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <1541990120-9643-2-git-send-email-yamada.masahiro@socionext.com> <2624257.jg98z2FPBI@blindfold>
In-Reply-To: <2624257.jg98z2FPBI@blindfold>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 8 Dec 2018 15:35:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjyWgpnu=qv-55gTL2DWpE93muu3Ksey8wFnWtLOzpbA@mail.gmail.com>
Message-ID: <CAK7LNAQjyWgpnu=qv-55gTL2DWpE93muu3Ksey8wFnWtLOzpbA@mail.gmail.com>
Subject: Re: [PATCH 1/2] um: remove -fno-unit-at-a-time workaround for pre-4.0 GCC
To:     Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 maintainers,


Ping.



On Tue, Nov 13, 2018 at 6:48 PM Richard Weinberger <richard@nod.at> wrote:
>
> Am Montag, 12. November 2018, 03:35:19 CET schrieb Masahiro Yamada:
> > Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> > bumped the minimum GCC version to 4.6 for all architectures.
> >
> > '$(call cc-option,-fno-unit-at-a-time)' is now dead code since
> > '$(cc-version) -lt 0400' is always false.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/x86/Makefile.um | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> > index 91085a0..577976b 100644
> > --- a/arch/x86/Makefile.um
> > +++ b/arch/x86/Makefile.um
> > @@ -26,12 +26,8 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
> >  # an unresolved reference.
> >  cflags-y += -ffreestanding
> >
> > -# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
> > -# a lot more stack due to the lack of sharing of stacklots.  Also, gcc
> > -# 4.3.0 needs -funit-at-a-time for extern inline functions.
> > -KBUILD_CFLAGS += $(shell if [ $(cc-version) -lt 0400 ] ; then \
> > -                     echo $(call cc-option,-fno-unit-at-a-time); \
> > -                     else echo $(call cc-option,-funit-at-a-time); fi ;)
> > +# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
> > +KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
>
> Acked-by: Richard Weinberger <richard@nod.at>
>
> Thanks,
> //richard
>
>
>


-- 
Best Regards
Masahiro Yamada
