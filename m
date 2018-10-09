Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F038C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D625A21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1JFzum2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D625A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJIWQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:16:20 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:63055 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIWQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:16:20 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w99EwaRe007607;
        Tue, 9 Oct 2018 23:58:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w99EwaRe007607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539097117;
        bh=wSMAcIh8SYHHoD1gaKFxb5vmR5j13MGePI4bAxk1/ZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1JFzum2nvspitf5XxsQQA/TsJ7YulYGpU6CKrvZFYTm85rF0yZ03IY0iW05W5RkWY
         f/ASfokn0I6KsMroGQquzzY5qQaDsYy8a838hEx/yHVZxNysMbycKSgH7lxYWNT8mx
         wOQpsxcK7NOzaHS+1n1D560AdRGsapVYCge3IxczYs9Uo05ues4jdfbZ1l0GAgQtnT
         eshNsICZH0b3cc8AHa/qQHxOZ73R4d8NJegGOB2hR8/a1hurQNo6jH4yvP7/2ruXdc
         okzD+AzvlxFXoNO85zVw+SEZMajxW9GH/gIZQLhYHYjjkc0cu3fuYojjMylzcqEGor
         GWnece7PAc/LQ==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id c205so1809838vsd.3;
        Tue, 09 Oct 2018 07:58:37 -0700 (PDT)
X-Gm-Message-State: ABuFfoiEMEMEF1LMrukdEzWbnyQewjWKZwwEL4U9eazywj4+XRkpkxpy
        GMbklLcWgcI/Vl+tHeObLd41fCVi7yQc6tXa+yI=
X-Google-Smtp-Source: ACcGV63Xl+HlhFQdeKCvS017jAO+eEn3TKUp5bibTv8X1cXWLKOOhFzomdIpbVR1mHSxsT+f0PtMooDNPQgDO4mXX74=
X-Received: by 2002:a67:65c3:: with SMTP id z186mr9135217vsb.54.1539097116414;
 Tue, 09 Oct 2018 07:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <1538443943-29805-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538443943-29805-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 9 Oct 2018 23:58:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNASykS_y8pA6LUEPasGfVVOEPuiF-q2cygQzWHvHq1mr+A@mail.gmail.com>
Message-ID: <CAK7LNASykS_y8pA6LUEPasGfVVOEPuiF-q2cygQzWHvHq1mr+A@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add -Wno-unused-but-set-variable flag unconditionally
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

On Tue, Oct 2, 2018 at 10:33 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> We have raised the compiler requirement from time to time.
> With commit cafa0010cd51 ("Raise the minimum required gcc version
> to 4.6"), the minimum for GCC is 4.6 now.
>
> This flag was added by GCC 4.6, and it is recognized by ICC as well.
>
> It is true that Clang does not support this flag but this commit is
> just touching the else part of the "ifeq ($(cc-name),clang)" check.
> Hence, Clang build is not affected.
>
> Let's rip off the cc-disable-warning switch, and see if somebody
> complains about it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.

>
> Changes in v2:
>   - Fix commit log
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 8a23fee..2627266 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -716,7 +716,7 @@ else
>
>  # These warnings generated too much noise in a regular build.
>  # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
> +KBUILD_CFLAGS += -Wno-unused-but-set-variable
>  endif
>
>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
