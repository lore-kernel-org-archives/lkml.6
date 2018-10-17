Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445C4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989BF214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 04:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="xH7DMnoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989BF214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJQMnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 08:43:17 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:34794 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbeJQMnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 08:43:17 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w9H4nMOa027991;
        Wed, 17 Oct 2018 13:49:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w9H4nMOa027991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539751763;
        bh=VupuvPFoB6QKadSow5iiA7vX2Ri+ffu/+Cxr3FQoWBk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xH7DMnoP6HubvKj278UPW8+4DNDYIpWnfEarwH8E7iDSeNwI3XjUkq4jHYyn0+sgH
         QYd07vPZEGuonsfQ4gyUltKvsYtolNRJpmgA5gKCCljrGMP0iHkVMN4yi1P2srNrYl
         EDspMJE4+H0jbgaCbSZq0ukeuJDW0DQlrVluT/T8+Md49mcdlo+lT83TZop480p3YW
         IXJ4IADQMf6tb+fqSJoNKxaHplVUwWlISWUZjAsI2iAhkfvAH06S4xN0LPW8GPIsn+
         OdQEfw4aPiA7yoCh8f0wU9+dvD2JUQUZ+yDjsAKHYHThVqYNb014XQkfY/p1wfkv1D
         E7usRfj2aJDzA==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id b3so4271944uak.3;
        Tue, 16 Oct 2018 21:49:23 -0700 (PDT)
X-Gm-Message-State: ABuFfoh4Rb5lznxmORAaSwqL61pPHLs4ZZK1eVxSSSy605ETkxXgISxU
        P6e2fNe8Vb4rEI7c8rF/9ke5f5t4eCJ2+KV/jaw=
X-Google-Smtp-Source: ACcGV63iHaJOMb51c22FQPvXecnltf5efy/4yc7MA/9SBTEMBMFVCo2R2cEBZ36CiTTt+euzvk5m8DCyF/PAKeWQN3U=
X-Received: by 2002:ab0:6607:: with SMTP id r7mr10568002uam.6.1539751762086;
 Tue, 16 Oct 2018 21:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181016021454.11953-1-natechancellor@gmail.com>
In-Reply-To: <20181016021454.11953-1-natechancellor@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 17 Oct 2018 13:48:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATO+L4-0SpuWrCnYEUVbxmcQkjOQvMB6PEsFv1b-heJOA@mail.gmail.com>
Message-ID: <CAK7LNATO+L4-0SpuWrCnYEUVbxmcQkjOQvMB6PEsFv1b-heJOA@mail.gmail.com>
Subject: Re: [PATCH] Kbuild: Hide Clang's -Wempty-body behind W=1
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,


On Tue, Oct 16, 2018 at 11:15 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> There are only a few instances of this warning in an arm64 allyesconfig
> build but none of them appear useful. I believe the intention of the
> warning is to avoid situations like this:
>
> if (condition);
>         statement;
>
> where the user really intended
>
> if (condition)
>         statement;
>
> However, these instances have already been caught by GCC's warning about
> misleading indentation


Right, the example above is caught by -Wmisleading-indentation.

However, the following is not.

   if (condition)
          ;



So, -Wempty-body is a kind of different thing,
and still useful in my opinion.



> so the remaining warnings are about loops that
> fall into one of three categories:
>
> 1. Execute a function unconditionally (avoiding a useless variable to
>    hold the return value):
>
> drivers/isdn/hisax/hfc_pci.c:131:34: warning: if statement has empty body
> [-Wempty-body]
>         if (Read_hfc(cs, HFCPCI_INT_S1));


I think this is a real bug,
then -Wempty-body finally caught it.
(but -Wmisleading-indentation cannot catch it.)



It is wrong to enclose a non-effective statement with 'if ();'
just for suppressing another warning.



     Read_hfc(cs, HFCPCI_INT_S1);

would emit this warning.


In file included from drivers/isdn/hisax/hfc_pci.c:20:0:
drivers/isdn/hisax/hfc_pci.c: In function =E2=80=98reset_hfcpci=E2=80=99:
drivers/isdn/hisax/hfc_pci.h:232:25: warning: statement with no effect
[-Wunused-value]
 #define Read_hfc(a, b) (*(((u_char *)a->hw.hfcpci.pci_io) + b))
                        ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/isdn/hisax/hfc_pci.c:131:2: note: in expansion of macro =E2=80=98Re=
ad_hfc=E2=80=99
  Read_hfc(cs, HFCPCI_INT_S1);
  ^~~~~~~~



The root cause is missing 'volatile'
while Read_hfc() is supposed to read out a HW register.



#define Read_hfc(a, b) (*(((volatile u_char *)a->hw.hfcpci.pci_io) + b))

will be a correct fix.
(or just use a standard accessor like readb(), ioread8(), etc.)




if (Read_hfc(cs, HFCPCI_INT_S1));

is optimized out by the compiler, so it is not working as expected.



>
> 2. Advancing a value to be used later on in the function like a pointer
>    or a count:
>
> drivers/atm/eni.c:244:48: warning: for loop has empty body
> [-Wempty-body]
>         for (order =3D 0; (1 << order) < *size; order++);
>                                                       ^

As you noted in the commit log,
Clang's -Wempty-body cares the location of a semi-colon,
while GCC's one does not.





   for (order =3D 0; (1 << order) < *size; order++)
             ;

is fine, and more readable in my opinion.




> 3. Busy waiting:
>
> drivers/atm/zatm.c:513:7: warning: while loop has empty body
> [-Wempty-body]
>         zwait;
>              ^


Again, Clang is fine with an empty body in while() loop,
but just picky about the semi-colon location.

For this particular case, how about something like this?


#define zwait  do {} while (zin(CMR) & uPD98401_BUSY)





I think an even better fix is

#define zwait()  do {} while (zin(CMR) & uPD98401_BUSY)



then, fix-up all

   zwait;

to

   zwait();






> None of these uses are problematic or need to be addressed.


The first pattern is really problematic, and need to be addressed.

I want to keep -Wempty-body enabled
to find out potential issues.

Please let me know if you see other patterns difficult to fix.





> Clang
> suggests moving the semi-colon to the next line to silence these
> warnings but that defeats the purpose of the compact nature of these
> constructs so just hide the warning behind W=3D1 so its use can still be
> audited but it won't polute a regular build.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/42
> Link: https://github.com/ClangBuiltLinux/linux/issues/66
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  scripts/Makefile.extrawarn | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index cf6cd0ef6975..8709d9d6faf1 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -11,6 +11,7 @@
>  # are not supported by all versions of the compiler
>  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> +KBUILD_CFLAGS +=3D $(call cc-disable-warning, empty-body)
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, packed-not-aligned)
>
>  ifeq ("$(origin W)", "command line")
> @@ -32,6 +33,7 @@ warning-1 +=3D $(call cc-option, -Wpacked-not-aligned)
>  warning-1 +=3D $(call cc-option, -Wstringop-truncation)
>  warning-1 +=3D $(call cc-disable-warning, missing-field-initializers)
>  warning-1 +=3D $(call cc-disable-warning, sign-compare)
> +warning-1 +=3D $(call cc-option, -Wempty-body)
>
>  warning-2 :=3D -Waggregate-return
>  warning-2 +=3D -Wcast-align
> --
> 2.19.1
>


--=20
Best Regards
Masahiro Yamada
