Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B33EECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A1121525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IdhdYQfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A1121525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388134AbeIUBiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:38:09 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34952 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeIUBiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:38:09 -0400
Received: by mail-yw1-f66.google.com with SMTP id 14-v6so4268639ywe.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BDdK5dFa0GPHKQm4ROhmvYUVaw/KLMEFxVHY7XLMKg8=;
        b=IdhdYQfyQqVgTfBjhJwz9ISgdv9PjnYE5AEVk/tOP7YYKoOEAIpWRZ07wp/U8hQsZD
         54+E47tEL7C6vgkZPDs19Nog5b3MYrVcm8Ilu0lJr5ncBPd2JpYjtCKr1ZZrW9LdbZhF
         4bnTVgEPymHjaOMpB5BqIajngAvHBpmrqsnVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BDdK5dFa0GPHKQm4ROhmvYUVaw/KLMEFxVHY7XLMKg8=;
        b=qI6r8iUT1Flg0RKActW76WOY9S0KrlGOMuspf9R9GfOxI0h5l7AZ6IrZOV9MJRoBwS
         kCIJtLe/0Co8ayNG1mfpH+NFQYhpcfhOM4PPHkWMjfM/W5CR5R1hCrsD0rwen7fkC0cP
         dPHhBOUJOK9d3gdmehWQgih0bYLzsB9c2QBkDsZgjxw/emVVLvDIkIObtSPPdduMdLgF
         Q15Niv7vA+T6s/qSDouKh26TEgHVtqpKqCIcZi1wTmMDjBbx5ULX5UVdd5AoewEZneMT
         1LMnsKj00V78d4bFW5DqLayMNkuxMjh7G+uCcrQJ6y466qQzbmPr1VJ+ApC9Jh2R+JOZ
         0Z5A==
X-Gm-Message-State: APzg51B36mrhvXll1XoeNbZqvUTVE0dwVNAJA/JB4guF+VzK+rCHgUf5
        Ijs9DDQqjsxg9zvckPe+TcbiKz0JiiM=
X-Google-Smtp-Source: ANB0VdYplnabHXHOn2T6auU2CHdMehaMMCVzTpn+QYvLwtG3ksrSHNqY+xySzOL566Rmz68fB2KMTw==
X-Received: by 2002:a81:3c13:: with SMTP id j19-v6mr18338934ywa.448.1537473182028;
        Thu, 20 Sep 2018 12:53:02 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id f82-v6sm5419067ywf.58.2018.09.20.12.52.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 12:52:59 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id 14-v6so4268551ywe.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:52:58 -0700 (PDT)
X-Received: by 2002:a81:2288:: with SMTP id i130-v6mr3004918ywi.288.1537473178439;
 Thu, 20 Sep 2018 12:52:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 12:52:57
 -0700 (PDT)
In-Reply-To: <20180920172301.21868-14-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com> <20180920172301.21868-14-miguel.ojeda.sandonis@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 20 Sep 2018 12:52:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKZYEK7Asy4KwtfVVxHLFbpeqpWWEOM-60h7h4gj3JZrw@mail.gmail.com>
Message-ID: <CAGXu5jKZYEK7Asy4KwtfVVxHLFbpeqpWWEOM-60h7h4gj3JZrw@mail.gmail.com>
Subject: Re: [PATCH v5 13/15] Compiler Attributes: enable -Wstringop-truncation
 on W=1 (gcc >= 8)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 10:22 AM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> Commit 217c3e019675 ("disable stringop truncation warnings for now")
> disabled -Wstringop-truncation since it was too noisy.
>
> Having __nonstring available allows us to let GCC know that a string
> is not meant to be NUL-terminated, which helps suppressing some
> -Wstringop-truncation warnings.
>
> Note that using __nonstring actually triggers other warnings
> (-Wstringop-overflow, which is on by default) which may be real
> problems. Therefore, cleaning up -Wstringop-truncation warnings
> also buys us the ability to uncover further potential problems.
>
> To encourage the use of __nonstring, we put the warning back at W=1.
> In the future, if we end up with a fairly warning-free tree,
> we might want to enable it by default.
>
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Yessss. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  scripts/Makefile.extrawarn | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 8d5357053f86..b8f36f5f43f2 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -29,6 +29,7 @@ warning-1 += $(call cc-option, -Wmissing-include-dirs)
>  warning-1 += $(call cc-option, -Wunused-but-set-variable)
>  warning-1 += $(call cc-option, -Wunused-const-variable)
>  warning-1 += $(call cc-option, -Wpacked-not-aligned)
> +warning-1 += $(call cc-option, -Wstringop-truncation)
>  warning-1 += $(call cc-disable-warning, missing-field-initializers)
>  warning-1 += $(call cc-disable-warning, sign-compare)
>
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
