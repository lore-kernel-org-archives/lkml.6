Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6879C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9528821756
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XmRPTK8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9528821756
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbeHNBQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:16:33 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43301 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNBQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:16:33 -0400
Received: by mail-yw1-f66.google.com with SMTP id l189-v6so14807599ywb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pt3usa5HG6TrF0N36k/h1P0nPXbE/a669e70LBGYGNY=;
        b=XmRPTK8K/+QzH1fZkk9odG0kPaNW2xTMBAnVKANGn0hhJIA1hwJKmSja76e6KG4Owr
         /EJQGV8M4aQrQzocCw03dUKdAtE1ru8UzXm3Vb3IZu4/xcg26FotGOTwaGyEvswizxKL
         Obiuq+0l8jeFB7U4fBV9RKb+6Al8HgzG+udek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pt3usa5HG6TrF0N36k/h1P0nPXbE/a669e70LBGYGNY=;
        b=mTt4OcsbrFxFB8jXHjrIunNMhIC07z42QtaaU2fwBSmSHeWoKoiv0+h172dfofErXG
         PygSt4MkRmNyUO5ndVNsGYdyxOvfPwccczX9cGfAlpqglc19XtXzMx+wJ4f8jU/AIZ/Q
         jZzwWGVotcEzMdI9tb8xLqMGcrhazc2Rv3RcDkjL3hiZlNUZwilomgQUia2WgAw2TZ0x
         zUBvGRCVpXo5GJt3rl11qEbG9+Uo9nEPklIo+RJMY8gAlqVjZR4KvjQ6JWnjAqVMcV1b
         gmD3pKHRb4SUmD/37G3UkJviNP1Sc/SO865yyTnAUxXBfYgynO73xltxwTszkxkuxMTu
         POug==
X-Gm-Message-State: AOUpUlGVzaWxsSLgoZJviTFPEEXIET6C9lGfyH9Tt4+Z2dJgyECdtrJC
        hvDxxMHR0IWuPKYzSEC8dq0WnRLNpIc=
X-Google-Smtp-Source: AA+uWPyDxuVqBf/1IF09PsOGuXQgUt9MBrXdTtnWlZnHBBMx1K5rjCU2WjtDygX44UMcKjZiur2v6g==
X-Received: by 2002:a25:d44:: with SMTP id 65-v6mr10153656ybn.143.1534199538746;
        Mon, 13 Aug 2018 15:32:18 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id o204-v6sm9850296ywd.16.2018.08.13.15.32.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 15:32:17 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id v197-v6so14823116ywg.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 15:32:17 -0700 (PDT)
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr9803109ybj.343.1534199536750;
 Mon, 13 Aug 2018 15:32:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2316:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 15:32:16
 -0700 (PDT)
In-Reply-To: <20180813101435.17016-1-arekm@maven.pl>
References: <20180813101435.17016-1-arekm@maven.pl>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 13 Aug 2018 15:32:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLMr1+M7Xnt5HFi73fkhgh2YEwJyaPrFb0tQ2i8T0-i-Q@mail.gmail.com>
Message-ID: <CAGXu5jLMr1+M7Xnt5HFi73fkhgh2YEwJyaPrFb0tQ2i8T0-i-Q@mail.gmail.com>
Subject: Re: [PATCH] Support mksh as /bin/sh.
To:     arekm@maven.pl
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 3:14 AM,  <arekm@maven.pl> wrote:
> From: Arkadiusz Mi=C5=9Bkiewicz <arekm@maven.pl>
>
> mksh needs space between ! and ( to work properly. Otherwise this
> happens:
>
> + make oldconfig
> scripts/kconfig/conf  --oldconfig Kconfig
> ./scripts/clang-version.sh[18]: COPYING: not found
> printf: =E2=80=98__clang_major__=E2=80=99: expected a numeric value
> printf: =E2=80=98__clang_minor__=E2=80=99: expected a numeric value
> printf: =E2=80=98__clang_patchlevel__=E2=80=99: expected a numeric value
> init/Kconfig:24:warning: 'CLANG_VERSION': number is invalid
>
> Signed-off-by: Arkadiusz Mi=C5=9Bkiewicz <arekm@maven.pl>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  scripts/clang-version.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/clang-version.sh b/scripts/clang-version.sh
> index dbf0a31eb111..e65fbc3079d4 100755
> --- a/scripts/clang-version.sh
> +++ b/scripts/clang-version.sh
> @@ -12,7 +12,7 @@
>
>  compiler=3D"$*"
>
> -if !( $compiler --version | grep -q clang) ; then
> +if ! ( $compiler --version | grep -q clang) ; then
>         echo 0
>         exit 1
>  fi
> --
> 2.18.0
>



--=20
Kees Cook
Pixel Security
