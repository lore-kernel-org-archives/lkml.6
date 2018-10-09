Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BD9C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194F0214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bTGsRo4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194F0214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbeJIWQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:16:53 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:44194 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeJIWQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:16:52 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w99ExC7s027511;
        Tue, 9 Oct 2018 23:59:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w99ExC7s027511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539097153;
        bh=gnh04JjskXFgZhmgx1hHbCvwoC7PSCAql8o84sWQQww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bTGsRo4eFGAxh6+MdMh+HRfFxJH81NQy2jt54F+cC9qr23KtIOo85GCpet7Nq6Aei
         6ev93204Bd+cI8UVrZEVaq7dyMFU1j5uAht+/xMd5IKr88/A2lvooXlldCSg+pyW/4
         7xO5DxUoJyfsbNCOkaEm0v7DOMHeaqgB49aEqmCdhpZRZW1NQRyudO6d28W8kWCza7
         0y9H3uENkze33PeC3JMWyMtP+JV0QoEis6EOmO5nrfAImQDX724BJOeqyk9WmkQk/Q
         p8FeVBIQ5m//iFNDBGVHEJqv4sd8CaFjn1kEGWiDvGiWbYQ+kfpOeffYFxzgHwPlmM
         axhDmC3UFsN6Q==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id r83so1804609vsc.4;
        Tue, 09 Oct 2018 07:59:13 -0700 (PDT)
X-Gm-Message-State: ABuFfogs3xaxeTXVRRKRdttO8U87vNb/8YNzL91QU7URA77yU9arJgHr
        kixUw1/8Uia769ThInnolnn2E6+Nm1phDW1/Qms=
X-Google-Smtp-Source: ACcGV63e2uON1la28J6yxa3HoRHKaF0XUYwZHbcxrLfx9PlqZwyszmtRcKAgg0eiFWkC89xuSZig8aCcQWdWXYcHWa4=
X-Received: by 2002:ab0:6607:: with SMTP id r7mr10367402uam.6.1539097152139;
 Tue, 09 Oct 2018 07:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <1538387078-21892-1-git-send-email-yamada.masahiro@socionext.com> <1538387078-21892-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538387078-21892-2-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 9 Oct 2018 23:58:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNATCypymzyYYEsZVHkKRkZgZ6HkQUhuA3WADU2sNLzRW=w@mail.gmail.com>
Message-ID: <CAK7LNATCypymzyYYEsZVHkKRkZgZ6HkQUhuA3WADU2sNLzRW=w@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: add -Wdeclaration-after-statement flag unconditionally
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 6:45 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> We have raised the compiler requirement from time to time.
> With commit cafa0010cd51 ("Raise the minimum required gcc version
> to 4.6"), the minimum for GCC is 4.6 now.
>
> This flag has been here since the pre-git era.  It is documented in
> the GCC 4.6 manual, and it is recognized by Clang and ICC as well.
>
> Let's rip off the cc-option switch, and see if somebody complains
> about it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 505a324..8a23fee 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -797,7 +797,7 @@ endif
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>
>  # warn about C99 declaration after statement
> -KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
> +KBUILD_CFLAGS += -Wdeclaration-after-statement
>
>  # disable pointer signed / unsigned warnings in gcc 4.0
>  KBUILD_CFLAGS += -Wno-pointer-sign
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
