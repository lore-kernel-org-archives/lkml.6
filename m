Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227D5C0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBFD2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cWd0Z9tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBFD2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbeKDL54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 06:57:56 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:27120 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeKDL54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 06:57:56 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wA42iLil032095;
        Sun, 4 Nov 2018 11:44:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wA42iLil032095
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541299462;
        bh=ZAWG8rxVYBSh2UEdxvI9e/4V7tUFv1tG14qsMy3PGb0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cWd0Z9tjzCIuxA+PNZD+3Az+NmeDdoDg5q4MXA/Snfj4fS2A+avQXqjpe/dJVyTA3
         7jGTN7W+cbDZPI6VROB6JG3HxVm4KakiXqVma8LJYj9O6IWA8HdCnPwLWDFk7+gvj3
         Kfz5zqY76QCjCWoTfo/gMp9+2Jc1b9J/d8Wox3BiuNqvscPhFy1heXoDh3iem5Yg7J
         gXBVq7sxSggzVIPDrhOzTIt/D7cCloeb13De0TVNlMae5EN0aYzBn7Fw/F35xpUXA1
         lojB5mLrXNRmrkhNWF/beaNmsewhLO8Oz2u8LUeu5v40LW4+gafWsG/zJV/OY4EhRi
         j+2ryKsajhupw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id y27so1386749vsi.1;
        Sat, 03 Nov 2018 19:44:22 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIEp3TiTcpYDlih0fRo6ckEPdogqXfs0qpqdia0kf/ow1ekJ0s5
        qI/nfvhi9i5o4Rl03ILaKJ3TfVpy+4CR3nlTqhA=
X-Google-Smtp-Source: AJdET5dgB5JqJqvjQRlQg41qIKcZOhwy9cOxlkY0SzPmH3kAvdz8l0q7p4qh+Iob+bfTUfGGT/+qNQCuA8ZdCw97FF8=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr7203788vsm.181.1541299460797;
 Sat, 03 Nov 2018 19:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181031145907.1ee2e866@canb.auug.org.au> <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
 <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
 <CAK7LNATirQwke8tqk5XukhkwKra6mWEXZ3AHcywNcwGFD2-voA@mail.gmail.com>
 <20181101142946.u5luuctqav6fec6k@mail.google.com> <CAK7LNAQbBG=KV5Q8o5-JiNCswuse94jECoqT+T+UEY7bLCRPNw@mail.gmail.com>
 <CAK8P3a1w8p8OC-9_0mtMUxEojvyVfXvF8Ka4J7TnoyZ=gr2Fow@mail.gmail.com>
In-Reply-To: <CAK8P3a1w8p8OC-9_0mtMUxEojvyVfXvF8Ka4J7TnoyZ=gr2Fow@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 4 Nov 2018 11:43:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQp2xU_ThE_q3TmoT16cwUjKx=rB9msVB12+Y9FkaQVmw@mail.gmail.com>
Message-ID: <CAK7LNAQp2xU_ThE_q3TmoT16cwUjKx=rB9msVB12+Y9FkaQVmw@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 12:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 11/2/18, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> > On Thu, Nov 1, 2018 at 11:32 PM Changbin Du <changbin.du@gmail.com> wrote:
> >> On Thu, Nov 01, 2018 at 12:32:48PM +0900, Masahiro Yamada wrote:
> >
> > How about clang?
> >
> > For clang, -Og might be equivalent to -O1 at this moment, but I am not
> > sure.
> >
> > In my understanding, Clang does not inline functions marked with 'static
> > inline'
> > for -Og (or -O1) optimization level.
> >
> > Theoretically, 'inline' keyword is a just hint for the compiler, after all.
>
> I think this means that we cannot build the kernel in that configuration,
> at least with CONFIG_OPTIMIZE_INLINING=y. Without that option,
> every 'inline' becomes 'always_inline'.
>

Sorry, I missed that fact.


At this moment of time, it is OK given the following:

 - CONFIG_OPTIMIZE_INLINING is defined only for x86
 - Clang cannot build x86 due to missing asm-goto


However, Clang with -Og
does not inline even such simple code like this:


-----test code------
static inline int foo(int x)
{
        return x;
}

int bar(int x)
{
        return foo(x);
}
-------------------



$ clang -Og -c -o bar.o  bar.c
$ objdump -d  bar.o
bar.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <bar>:
   0: eb 0e                jmp    10 <foo>
   2: 66 2e 0f 1f 84 00 00 nopw   %cs:0x0(%rax,%rax,1)
   9: 00 00 00
   c: 0f 1f 40 00          nopl   0x0(%rax)

0000000000000010 <foo>:
  10: 89 f8                mov    %edi,%eax
  12: c3                    retq



-- 
Best Regards
Masahiro Yamada
